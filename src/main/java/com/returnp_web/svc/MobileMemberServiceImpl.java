package com.returnp_web.svc;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.RandomStringUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.core.env.Environment;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.ui.ModelMap;

import com.returnp_web.dao.MobileMemberDao;
import com.returnp_web.utils.BASE64Util;
import com.returnp_web.utils.Const;
import com.returnp_web.utils.Converter;
import com.returnp_web.utils.EmailSender;
import com.returnp_web.utils.EmailVO;
import com.returnp_web.utils.MessageUtils;
import com.returnp_web.utils.QRManager;
import com.returnp_web.utils.RPMap;
import com.returnp_web.utils.SessionManager;
import com.returnp_web.utils.Util;

@PropertySource("classpath:/config.properties")
@Service
public class MobileMemberServiceImpl implements MobileMemberService {

	private static final Logger logger = LoggerFactory.getLogger(MobileMemberServiceImpl.class);

	/** The front member dao. */
	@Autowired
	private MobileMemberDao mobileMemberDao;

	@Autowired
	private EmailVO email;

	@Autowired
	private EmailSender emailSender;

	@Autowired
	private MessageSource messageSource;

	@Autowired
	MessageUtils messageUtils;

	@Autowired
	Environment environment;

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Throwable.class })
	public boolean loginAct(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		// 추후 다국어 alert 요청시 아래의 것 활용하세요.(18.07.11)
		String message = messageSource.getMessage("messages.greeting", null, LocaleContextHolder.getLocale());

		RPMap dbparams = new RPMap();
		SessionManager sm = new SessionManager(request, response);
		String id = p.getStr("email").trim();
		String pw = p.getStr("pwd").trim();
		Boolean isSaveId = "on".equals(p.getStr("isSave")) ? true : false;

		dbparams.put("memberEmail", id);
		if (id == null || id.equals("")) {
			rmap.put(Const.D_SCRIPT, Util.jsmsgLink("이메일을 입력해 주세요.", "/m/member/login.do?alertView=t&Message=2", "T"));
			return false;
		}

		if (pw == null || pw.equals("")) {
			rmap.put(Const.D_SCRIPT, Util.jsmsgLink("비밀번호를 입력해 주세요.", "/m/member/login.do?alertView=t&Message=3", "T"));
			return false;
		}
		dbparams.put("memberPassword", Util.sha(pw));

		int memberNo = 0;
		String memberEmail = "";
		String memberPassword = "";
		String memberStatus = "";
		String memberName = "";
		String memberPhone = "";
		int failureCnt = 0;

		HashMap<String, Object> records = mobileMemberDao.loginAct(dbparams);

		if (records != null && !records.isEmpty()) {
			memberNo = Converter.toInt(records.get("memberNo"));
			memberEmail = Converter.toStr(records.get("memberEmail"));
			memberPassword = Converter.toStr(records.get("memberPassword"));
			memberStatus = Converter.toStr(records.get("memberStatus"));
			memberName = Converter.toStr(records.get("memberName"));
			failureCnt = Converter.toInt(records.get("failureCnt")); // 실패횟수
			memberPhone = Converter.toStr(records.get("memberPhone"));
		}

		if (memberNo <= 0) {
			rmap.put(Const.D_SCRIPT,
					Util.jsmsgLink("이메일 또는 비밀번호가 일치하지 않습니다.", "/m/member/login.do?alertView=t&Message=1", "T"));
			return false;
		}

		try {

			if ("3".equals(memberStatus)) {
				rmap.put(Const.D_SCRIPT, Util.gotoURL(
						"/m/member/m_emailconfirm.do?pop=confirm&memberEmail=" + memberEmail + "&memberNo=" + memberNo,
						"T"));
				// rmap.put(Const.D_SCRIPT, Util.jsmsgLink("미인증 고객입니다.",
				// "/member/login.do?pop=confirm", "T"));
				return false;
			}

			if ("5".equals(memberStatus)) {
				rmap.put(Const.D_SCRIPT,
						Util.jsmsgLink("사용정지 고객입니다.", "/m/member/login.do?alertView=t&Message=4", "T"));
				return false;
			}

			if ("6".equals(memberStatus)) {
				rmap.put(Const.D_SCRIPT, Util.jsmsgLink("탈퇴고객입니다.", "/m/member/login.do?alertView=t&Message=5", "T"));
				return false;
			}

			// 인증번호가 있는 경우 인증 시간을 비교한다.
			String lastTime = Converter.toStr(records.get("lastTime"));
			String currentTime = Converter.toStr(records.get("currentTime"));
			int timeCampare = lastTime.compareTo(currentTime); // 인증시간기간 - 현재시간, 0보다 크면 시간초과

			if (null != records.get("authNumber") || !"".equals(p.get("authPasswordConfirm"))) {

				// 현재시간이 인증기간을 지난 경우 인증번호를 재발급 후 나간다.
				if (0 > timeCampare) {
					// 이메일주소 암호화
					String encodeEmail = BASE64Util.encodeString(id); // 이메일 암호화
					rmap.put(Const.D_SCRIPT, Util.jsmsgLink("인증시간이 경과되었습니다. 재발급해주세요.",
							"/m/member/login.do?form=auth&" + encodeEmail + "&alertView=t&Message=7", "T"));
					return false;
				}
			}

			// 인증번호가 없고 실패 5회 이상이거나 4회에서 실패시 오류
			if (null == records.get("authNumber")
					&& (5 <= failureCnt || (4 == failureCnt && (!memberPassword.equals(Util.sha(pw)))))) {
				// 인증번호 6자리 난수 생성
				String authRandomNo = Util.randomNumber();
				dbparams.put("memberNo", memberNo);
				dbparams.put("authNumber", authRandomNo);
				dbparams.put("failureCnt", failureCnt + 1);

				// 5회 실패 후 미인증시 인증번호 insert
				mobileMemberDao.updateLoginAuthNumber(dbparams);

				// 비밀번호 실패시 비밀번호 실패 테이블에 insert
				mobileMemberDao.updateLoginFailure(dbparams);

				// 이메일주소 암호화
				String encodeEmail = BASE64Util.encodeString(id);
				; // 이메일 암호화
				rmap.put(Const.D_SCRIPT, Util.jsmsgLink("로그인 5회이상 실패하였습니다.",
						"/m/member/login.do?form=auth&" + encodeEmail + "&alertView=t&Message=8", "T"));
				return true;
			} else {
				// 암호 비교
				if (!memberPassword.equals(Util.sha(pw))) {
					dbparams.put("memberNo", memberNo);
					dbparams.put("failureCnt", failureCnt + 1);

					// 비밀번호 실패시 비밀번호 실패 테이블에 insert
					mobileMemberDao.updateLoginFailure(dbparams);

					if (null != records.get("authNumber")) {
						// 이메일주소 암호화
						String encodeEmail = BASE64Util.encodeString(id);
						; // 이메일 암호화
						rmap.put(Const.D_SCRIPT, Util.jsmsgLink("비밀번호가 일치하지 않습니다.",
								"/m/member/login.do?form=auth&" + encodeEmail + "&alertView=t&Message=6", "T"));
					} else {
						rmap.put(Const.D_SCRIPT,
								Util.jsmsgLink("비밀번호가 일치하지 않습니다.", "/m/member/login.do?alertView=t&Message=6", "T"));
					}
					return false;
				} else {
					// 로그인 성공시 실패횟수 초기화 -> 삭제로 로직 변경
					dbparams.put("memberNo", memberNo);
					mobileMemberDao.deleteLoginFailure(dbparams);

					// 인증기간내에 인증시도한 경우 인증번호 삭제
					if (null != records.get("authNumber") && 0 <= timeCampare) {

						// 인증번호 삭제
						mobileMemberDao.loginAuthNumberDelete(dbparams);
					}
				}
			}

			sm.setMemberNo(memberNo);
			sm.setmemberName(memberName);
			sm.setMemberEmail(memberEmail);
			sm.setMemberPhone(memberPhone);

			HttpSession session = request.getSession(true);
			session.setAttribute("memberNo", memberNo);
			Device device = DeviceUtils.getCurrentDevice(request);
			String deviceType = "";

			String userAuthToken = null;
			RPMap dbparams2 = new RPMap();
			if (device.isMobile()) {
				dbparams2.put("memberNo", memberNo);
				dbparams2.put("memberEmail", memberEmail);
				// dbparams2.put("memberPhone" , memberPhone);

				HashMap<String, Object> tokenMap = mobileMemberDao.getMemberAuthToken(dbparams2);
				if (tokenMap == null || tokenMap.isEmpty()) {
					userAuthToken = RandomStringUtils.randomAlphanumeric(40);
					dbparams.put("userAuthToken", userAuthToken);
					mobileMemberDao.insertMemberAuthTokenAct(dbparams);
				} else {
					userAuthToken = Converter.toStr(tokenMap.get("userAuthToken"));
				}
				rmap.put(Const.D_SCRIPT,
						Util.gotoURL("/m/member/login_ok.do?mbrE=" + memberEmail + "&userAT=" + userAuthToken, ""));
			} else {
				rmap.put(Const.D_SCRIPT, Util.gotoURL("/m/main/index.do", ""));
			}

			// 아이디 저장
			if (isSaveId) {
				Cookie new_cookie = new Cookie("cookieSaveId", memberEmail);
				new_cookie.setMaxAge(365 * 24 * 60 * 60); // 1 year
				response.addCookie(new_cookie);
			} else {
				Cookie new_cookie = new Cookie("cookieSaveId", "");
				new_cookie.setMaxAge(0);
				response.addCookie(new_cookie);
			}
		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			rmap.put(Const.D_SCRIPT, Util.gotoURL("/m/main/index.do", ""));
			return false;
		}
		return true;
	}

	@Override
	public boolean logOut(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		SessionManager sm = new SessionManager(request, response);
		RPMap dbparams = new RPMap();
		dbparams.put("memberNo", sm.getMemberNo());
		try {
			// 필요할 경우 접속 로그 추가 할 것
		} catch (Exception e) {
			e.printStackTrace();
		}
		mobileMemberDao.deleteMemberAuthToken(dbparams);
		sm.killSession();
		rmap.put(Const.D_SCRIPT, Util.gotoURL("/m/main/index.do", ""));
		return true;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Throwable.class })
	public boolean selectRecommend(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		RPMap dbparams = new RPMap();

		try {
			dbparams.put("recommend", p.getStr("recommend"));
			int recommonCount = mobileMemberDao.selectRecommend(dbparams);

			if (recommonCount == 0) {
				String json = Util.printResult(2, String.format("추천인 정보가 존재하지 않습니다."), null);
				rmap.put("json", json);
				return true;
			} else {
				String json = Util.printResult(1, String.format("성공하였습니다. "), null);
				rmap.put("json", json);
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Throwable.class })
	public boolean selectAuthNumberRequest(RPMap p, RPMap rmap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		RPMap dbparams = new RPMap();

		try {
			dbparams.put("memberEmail", p.getStr("memberEmail"));
			HashMap<String, Object> userAuthInfo = mobileMemberDao.selectUserInfoUseEmail(dbparams);

			// 인증번호 6자리 난수 생성
			String memberNo = Converter.toStr(userAuthInfo.get("memberNo"));
			String authRandomNo = Util.randomNumber();

			dbparams.put("memberNo", memberNo);
			dbparams.put("authNumber", authRandomNo);

			// 5회 실패 후 미인증시 인증번호 insert
			mobileMemberDao.updateLoginAuthNumber(dbparams);

			JSONObject json = new JSONObject();
			JSONObject _json = new JSONObject();

			_json.put("code", 1);
			_json.put("msg", "성공했습니다.");
			_json.put("eof", "0");
			_json.put("authNumber", authRandomNo);

			json.put("result", _json);
			rmap.put("json", json.toString());
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return true;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Throwable.class })
	public boolean selectAuthMember(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		RPMap dbparams = new RPMap();

		try {
			String decodeEmail = BASE64Util.decodeString(p.getStr("memberEmail"));
			dbparams.put("memberEmail", decodeEmail);
			HashMap<String, Object> recommonInfo = mobileMemberDao.selectAuthMember(dbparams);

			if (recommonInfo == null) {
				String json = Util.printResult(0, String.format("로그인 정보가 존재하지 않습니다."), null);
				rmap.put("json", json);
				return true;
			} else {
				JSONObject json = new JSONObject();
				JSONObject _json = new JSONObject();

				_json.put("code", 1);
				_json.put("eof", "0");
				_json.put("memberNo", recommonInfo.get("memberNo"));
				_json.put("memberEmail", recommonInfo.get("memberEmail"));
				_json.put("authNumber", recommonInfo.get("authNumber"));

				json.put("result", _json);
				rmap.put("json", json.toString());
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Throwable.class })
	public boolean memberJoinAct(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		RPMap dbparams = new RPMap();

		try {
			// 추천인 memberNo 호출
			HashMap<String, Object> recommendMyinfo = null;
			if (p.getStr("recommend").trim() != null && !"".equals(p.getStr("recommend").trim())) {
				dbparams.put("recommenderEmail", p.getStr("recommend").trim());
				recommendMyinfo = mobileMemberDao.selectRecommendDetail(dbparams);
				if (recommendMyinfo != null) {
					dbparams.put("recommenderNo", Converter.toInt(recommendMyinfo.get("memberNo")));
				}
			}

			// pw 암호화
			String decodepw = Util.sha(p.getStr("pwd").trim());

			// 파라미터 정리
			dbparams.put("email", p.getStr("email").trim());
			dbparams.put("country", p.getStr("country").trim());
			dbparams.put("pwd", decodepw);
			dbparams.put("name", p.getStr("name").trim());
			dbparams.put("phone", p.getStr("phone").trim());
			dbparams.put("terms", "on".equals(p.getStr("terms").trim()) ? "Y" : "N");
			dbparams.put("privacy", "on".equals(p.getStr("privacy").trim()) ? "Y" : "N");
			dbparams.put("spam", "on".equals(p.getStr("spam").trim()) ? "Y" : "N");
			dbparams.put("joinRoute", "www.returnp.com");
			dbparams.put("recommend", p.getStr("email").trim()); // 이메일 중복 체크용 파라미터

			//System.out.println("회원가입 파리미터 dbparams::" + dbparams);
			if (p.getStr("email").trim() == null || p.getStr("email").trim().equals("")) {
				rmap.put(Const.D_SCRIPT, Util.jsmsgLink("잘못된 경로입니다.", "/m/main/index.do?alertView=t&Message=1", "T"));
				return false;
			}

			if (p.getStr("pwd").trim() == null || p.getStr("pwd").trim().equals("")) {
				rmap.put(Const.D_SCRIPT, Util.jsmsgLink("잘못된 경로입니다.", "/m/main/index.do?alertView=t&Message=1", "T"));
				return false;
			}

			if (p.getStr("name").trim() == null || p.getStr("name").trim().equals("")) {
				rmap.put(Const.D_SCRIPT, Util.jsmsgLink("잘못된 경로입니다.", "/m/main/index.do?alertView=t&Message=1", "T"));
				return false;
			}

			if (p.getStr("phone").trim() == null || p.getStr("phone").trim().equals("")) {
				rmap.put(Const.D_SCRIPT, Util.jsmsgLink("잘못된 경로입니다.", "/m/main/index.do?alertView=t&Message=1", "T"));
				return false;
			}

			// 이메일 중복 체크
			RPMap dbparams2 = new RPMap();
			dbparams2.put("memberEmail", p.getStr("email").trim());
			int memberEmailDuplicate = mobileMemberDao.selectMemberEmailDup(dbparams2);
			if (memberEmailDuplicate > 0) {
				rmap.put(Const.D_SCRIPT,
						Util.jsmsgLink("이미 가입한 이메일입니다.", "/member/join.do?alertView=t&Message=2", "T"));
				return false;
			}

			mobileMemberDao.insertJoinAct(dbparams);

			/* 회원가입후 memberNo갑슬 가져오기 위해 추가 */
			int memberNo = mobileMemberDao.selectMemberNo(dbparams);
			dbparams.put("memberNo", memberNo);

			/* 기본 G-POINT 생성 */
			dbparams.put("nodeNo", memberNo);
			dbparams.put("nodeType", "1");
			dbparams.put("nodeTypeName", "member");
			mobileMemberDao.insertGreenAct(dbparams);

			/* 추천인 G-POINT 생성 */
			dbparams.put("nodeNo", memberNo);
			dbparams.put("nodeType", "2");
			dbparams.put("nodeTypeName", "recommender");
			mobileMemberDao.insertGreenAct(dbparams);

			/* 기본 R-PAY생성 */
			mobileMemberDao.insertRedAct(dbparams);

			/*
			 * Cookie joinCookie = new Cookie("joinCookie","T"); joinCookie.setMaxAge(7);
			 * joinCookie.setPath("/"); response.addCookie(joinCookie);
			 */
			Date today = new Date();
			SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
			String mail_date = date.format(today);
			String mail_name = p.getStr("name").trim().toString();
			String mail_email = BASE64Util.encodeString(p.getStr("email").trim());

			String[] url = request.getRequestURL().toString().split(request.getRequestURI());
			String mail_sign = "<a href =" + url[0] + "/m/member/email_sign_act.do?memberEmail='" + mail_email
					+ "' target ='_blank'>";

			/* send email ->계정:gmail, 운영 반영시에 실제사용값으로 수정요청드립니다.(참고파일: root-context.xml) */
			email.setSubject("회원가입 완료되었습니다.");
			email.setReceiver(p.getStr("email").trim());
			email.setVeloTemplate("mail_emailconfirm.vm");
			dbparams.put("mail_name", mail_name);
			dbparams.put("mail_date", mail_date);
			dbparams.put("mail_sign", mail_sign);
			email.setEmailMap(dbparams);
			email.setHtmlYn("Y");
			/* 임시적으로 이메일 인증 없이 가입하도록 허용 */
			/* emailSender.sendVelocityEmail(email); */
			/* send email ->계정:gmail, 운영 반영시에 실제사용값으로 수정요청드립니다.(참고파일: root-context.xml) */

			rmap.put(Const.D_SCRIPT, Util.gotoURL("/m/member/m_joincomplete.do", ""));
		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return true;
	}

	@Override
	public boolean mypageMyinfo(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);
		dbparams.put("memberNo", sm.getMemberNo());
		try {
			HashMap<String, Object> mypageMyinfo = mobileMemberDao.selectMypageMyinfo(dbparams);

			HashMap<String, Object> membershipRequestPaymentStatus = mobileMemberDao
					.selectMembershipRequestPaymentStatus(dbparams); // 정회원 신청여부

			if (mypageMyinfo == null) {
				rmap.put(Const.D_SCRIPT, Util.jsmsgLink("잘못된 경로입니다.", "/m/main/index.do?alertView=t&Message=1", "T"));
				return false;
			}
			String recoMemberEmail = null;
			if (mypageMyinfo.get("recommenderNo") != null) {
				dbparams.put("recommenderNo", Converter.toInt(mypageMyinfo.get("recommenderNo")));
				recoMemberEmail = mobileMemberDao.recommenderNo(dbparams);
			}
			if (recoMemberEmail != null) {
				mypageMyinfo.put("recoMemberEmail", recoMemberEmail);
			}
			rmap.put("mypageMyinfo", mypageMyinfo);
			ArrayList<HashMap<String, Object>> selectCompanyBankList = mobileMemberDao.selectCompanyBankList(dbparams);
			rmap.put("selectCompanyBankList", selectCompanyBankList);
			rmap.put("membershipRequestPaymentStatus", membershipRequestPaymentStatus);

			HashMap<String, Object> memberTypeInfo = mobileMemberDao.selectmemberTypeInfo(dbparams); // 회원 타입 조회
			rmap.put("memberTypeInfo", memberTypeInfo);

			/* 회원 설정 정보 로딩 */
			HashMap<String, Object> memberConfig = mobileMemberDao.selectMemberConfig(dbparams);

			/* 회원 설정 정보가 존재하지 않으면 기본 정보 Insert */
			if (memberConfig == null) {
				memberConfig = new HashMap<String, Object>();
				memberConfig.put("memberNo", sm.getMemberNo());
				memberConfig.put("devicePush", "N");
				memberConfig.put("emailReceive", "N");
				mobileMemberDao.insertMemberConfigl(memberConfig);
			}
			rmap.put("memberConfig", memberConfig);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public boolean myMemberList(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		dbparams.put("memberNo", Converter.toInt(p.get("memberNo")));
		try {
			rmap.put("myMemberList", mobileMemberDao.selectMyMemberList(dbparams));
			rmap.put("myMemberListCount", mobileMemberDao.selectMyMemberListCount(dbparams));
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public boolean myinfoConfirm(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		HashMap<String, Object> dbparams = new HashMap<String, Object>();

		SessionManager sm = new SessionManager(request, response);
		dbparams.put("memberNo", sm.getMemberNo());
		try {
			HashMap<String, Object> mypageMyinfo = mobileMemberDao.selectMypageMyinfo(dbparams);
			if (mypageMyinfo == null) {
				rmap.put(Const.D_SCRIPT, Util.jsmsgLink("잘못된 경로입니다.", "/m/main/index.do?alertView=t&Message=1", "T"));
				return false;
			}
			rmap.put("mypageMyinfo", mypageMyinfo);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public boolean myinfoConfirmModify(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		SessionManager sm = new SessionManager(request, response);
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		int pwd = p.getInt("pwd");
		dbparams.put("memberNo", sm.getMemberNo());

		try {
			HashMap<String, Object> mypageMyinfo = mobileMemberDao.selectMypageMyinfo(dbparams);

			String recoMemberEmail = null;
			if (mypageMyinfo.get("recommenderNo") != null) {
				dbparams.put("recommenderNo", Converter.toInt(mypageMyinfo.get("recommenderNo")));
				recoMemberEmail = mobileMemberDao.recommenderNo(dbparams);
			}
			if (recoMemberEmail != null) {
				mypageMyinfo.put("recoMemberEmail", recoMemberEmail);
			}

			HashMap<String, Object> dbparams2 = new HashMap<String, Object>();
			dbparams2.put("useStatus", "Y");
			ArrayList<HashMap<String, Object>> countries = mobileMemberDao.selectCountries(dbparams2);

			rmap.put("countries", countries);
			rmap.put("mypageMyinfo", mypageMyinfo);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public boolean myinfoConfirmModifyCheck(RPMap p, RPMap rmap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		SessionManager sm = new SessionManager(request, response);
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		int pwd = p.getInt("pwd");
		dbparams.put("memberNo", sm.getMemberNo());
		try {
			HashMap<String, Object> mypageMyinfo = mobileMemberDao.selectMypageMyinfo(dbparams);
			String decodepw = Util.sha(p.getStr("pwd").trim().toString());
			String memberPass = Converter.toStr(mypageMyinfo.get("memberPassword").toString());

			if (!(memberPass.equals(decodepw))) {
				rmap.put(Const.D_SCRIPT, Util.jsmsgLink("비밀번호가 맞지 않습니다.",
						"/m/mypage/mypage_myinfo_confirm.do?alertView=t&Message=1", "T"));
				return false;
			}

			String recoMemberEmail = null;
			if (mypageMyinfo.get("recommenderNo") != null) {
				dbparams.put("recommenderNo", Converter.toInt(mypageMyinfo.get("recommenderNo")));
				recoMemberEmail = mobileMemberDao.recommenderNo(dbparams);
			}
			if (recoMemberEmail != null) {
				mypageMyinfo.put("recoMemberEmail", recoMemberEmail);
			}
			rmap.put("mypageMyinfo", mypageMyinfo);
			rmap.put(Const.D_SCRIPT, Util.gotoURL("/m/mypage/mypage_myinfo_modify.do", "T"));
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public boolean memberUpdateAct(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		SessionManager sm = new SessionManager(request, response);
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		String oriMemberPassword = null;
		int oriRecommenderNo = 0;
		String oriMemberPhone = null;
		String NewMemberPassword = null;
		int NewRecommenderNo = 0;
		String NewMemberPhone = null;

		try {
			dbparams.put("memberNo", sm.getMemberNo());
			HashMap<String, Object> mypageMyinfo = mobileMemberDao.selectMypageMyinfo(dbparams);
			if (mypageMyinfo != null) {
				oriMemberPassword = Converter.toStr(mypageMyinfo.get("memberPassword").toString());
				if (mypageMyinfo.get("memberPhone") != null) {
					oriRecommenderNo = Converter.toInt(mypageMyinfo.get("recommenderNo"));
				} else {
					oriRecommenderNo = 0;
				}
				oriMemberPhone = Converter.toStr(mypageMyinfo.get("memberPhone"));
			}

			dbparams.put("recommenderEmail", p.getStr("recommend").trim());
			HashMap<String, Object> recommendMyinfo = mobileMemberDao.selectRecommendDetail(dbparams);
			if (recommendMyinfo != null) {
				dbparams.put("recommenderNo", Converter.toInt(recommendMyinfo.get("memberNo")));
				if (Converter.toInt(recommendMyinfo.get("memberNo")) != null) {
					NewRecommenderNo = Converter.toInt(recommendMyinfo.get("memberNo"));
				} else {
					NewRecommenderNo = 0;
				}
			}

			String decodepw = Util.sha(p.getStr("pwd").trim().toString());
			NewMemberPassword = decodepw;
			NewMemberPhone = p.getStr("phone").trim();
			String mail_password = null;
			String mail_recomm = null;
			if (!oriMemberPassword.equals(NewMemberPassword)) {
				mail_password = "<li>비밀번호 : " + p.getStr("pwd").trim() + "</li>";
				dbparams.put("mail_password", mail_password);
				dbparams.put("mail_password_text", "비밀번호");
			} else {
				dbparams.put("mail_password", "");
				dbparams.put("mail_password_text", "");
			}

			if (oriRecommenderNo != NewRecommenderNo) {
				mail_recomm = "<li>추천인 : " + p.getStr("recommend").trim() + "</li>";
				dbparams.put("mail_recomm", mail_recomm);
				if (mail_password != null) {
					dbparams.put("mail_recomm_text", ", 추천인");
				} else {
					dbparams.put("mail_recomm_text", "추천인");
				}
			} else {
				dbparams.put("mail_recomm", "");
				dbparams.put("mail_recomm_text", "");
			}

			if (!oriMemberPhone.equals(NewMemberPhone)) {
				String mail_phone = "<li>핸드폰번호 : " + NewMemberPhone + "</li>";
				dbparams.put("mail_phone", mail_phone);
				if (mail_recomm != null || mail_password != null) {
					dbparams.put("mail_phone_text", ", 핸드폰번호");
				} else {
					dbparams.put("mail_phone_text", "핸드폰번호");
				}
			} else {
				dbparams.put("mail_phone", "");
				dbparams.put("mail_phone_text", "");
			}

			dbparams.put("memberPassword", decodepw);
			dbparams.put("memberPhone", p.getStr("phone").trim());
			dbparams.put("country", p.getStr("country").trim());
			dbparams.put("memberNo", sm.getMemberNo());
			mobileMemberDao.updateUser(dbparams);

			/*메일 서비스는 일시적으로 중단함 
			 * 차후 사용할 시 아래의 코드 주석 해제*/
			/*String[] url = request.getRequestURL().toString().split(request.getRequestURI());
			String mail_sign = "<a href =" + url[0] + "/m/member/login.do target ='_blank'>";*/

			/* send email ->계정:gmail, 운영 반영시에 실제사용값으로 수정요청드립니다.(참고파일: root-context.xml) */
			/*email.setSubject("회원님께서 수정하신 정보를 보내드립니다.");
			email.setReceiver(mypageMyinfo.get("memberEmail").toString());
			email.setHtmlYn("Y");
			email.setVeloTemplate("mail_infomodify.vm");
			dbparams.put("mail_sign", mail_sign);
			email.setEmailMap(dbparams);
			emailSender.sendVelocityEmail(email);*/
			/* send email ->계정:gmail, 운영 반영시에 실제사용값으로 수정요청드립니다.(참고파일: root-context.xml) */

			rmap.put(Const.D_SCRIPT, Util.gotoURL("/m/mypage/mypage_myinfo.do", "T"));
		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return true;
	}

	@Override
	public boolean emailSignAct(String emailSignAct, RPMap rmap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		SessionManager sm = new SessionManager(request, response);
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		dbparams.put("memberEmail", BASE64Util.decodeString(emailSignAct).toString().trim());

		try {
			int emailSignCount = mobileMemberDao.selectEmailSignSuccessCount(dbparams);
			if (emailSignCount > 0) {
				rmap.put(Const.D_SCRIPT,
						Util.jsmsgLink("이메일 인증이 완료된 고객입니다.", "/m/main/index.do?alertView=t&Message=2", "T"));
				return false;
			}
			mobileMemberDao.updateUserMemberStatus(dbparams);
			rmap.put(Const.D_SCRIPT, Util.jsmsgLink("이메일 인증완료되었습니다.", "/m/main/index.do?alertView=t&Message=3", "T"));
		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return false;
		}
		return true;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Throwable.class })
	public boolean findEmailAct(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		RPMap dbparams = new RPMap();

		String memberName = p.getStr("memberName");
		dbparams.put("memberName", memberName);

		String memberPhone = p.getStr("memberPhone");
		dbparams.put("memberPhone", memberPhone);

		try {
			HashMap<String, Object> userInfos = mobileMemberDao.selectFindUserEmailAct(dbparams);
			if (userInfos != null && !userInfos.isEmpty()) {
				String memberEmail = Converter.toStr(userInfos.get("memberEmail"));

				String[] url = request.getRequestURL().toString().split(request.getRequestURI());
				String mail_sign = "<a href =" + url[0] + "/m/member/login.do target ='_blank'>";

				/* send email ->계정:gmail, 운영 반영시에 실제사용값으로 수정요청드립니다.(참고파일: root-context.xml) */
				email.setSubject("가입된 이메일을 보내드립니다.");
				email.setReceiver(memberEmail);
				email.setVeloTemplate("mail_findemail.vm");
				dbparams.put("mail_sign", mail_sign);
				dbparams.put("mail_email", memberEmail);
				email.setEmailMap(dbparams);
				email.setHtmlYn("Y");
				emailSender.sendVelocityEmail(email);
				/* send email ->계정:gmail, 운영 반영시에 실제사용값으로 수정요청드립니다.(참고파일: root-context.xml) */
				Cookie emailViewCookie = new Cookie("emailViewCookie", "T");
				emailViewCookie.setMaxAge(6);
				emailViewCookie.setPath("/");
				response.addCookie(emailViewCookie);

				rmap.put(Const.D_SCRIPT, Util.jsmsgLink("가입하신 이메일로 발송이 완료되었습니다.",
						"/m/member/find_email.do?memberEmail=" + memberEmail + "&alertView=t&Message=1", "T"));
			} else {
				rmap.put(Const.D_SCRIPT,
						Util.jsmsgLink("이메일이 존재하지 않습니다.", "/m/member/find_email.do?alertView=t&Message=2", "T"));
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return true;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Throwable.class })
	public boolean findPwAct(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		RPMap dbparams = new RPMap();
		String memberEmail = p.getStr("email");
		dbparams.put("memberEmail", memberEmail);

		try {
			HashMap<String, Object> userInfos = mobileMemberDao.selectFindEmailAct(dbparams);
			String memberStatus = "";
			if (userInfos != null && !userInfos.isEmpty()) {
				memberStatus = Converter.toStr(userInfos.get("memberStatus"));
				if ("3".equals(memberStatus)) {
					rmap.put(Const.D_SCRIPT, Util.jsmsgLink("미인증 고객입니다. 이메일인증완료후 사용해주세요.",
							"/m/main/index.do?alertView=t&Message=4", "T"));
					return true;
				}

				// 8자리 소문자,숫자 난수
				StringBuffer rendomPw = Util.randomNumberLower();
				// pw 암호화
				String decodePw = Util.sha(rendomPw.toString());
				int memberNo = Converter.toInt(userInfos.get("memberNo"));

				dbparams.put("memberNo", memberNo);
				dbparams.put("tempPassword", decodePw);

				// 임시비밀번호 업데이트
				mobileMemberDao.updateTempPw(dbparams);
				memberEmail = Converter.toStr(userInfos.get("memberEmail"));
				String pw = rendomPw.toString();
				String[] url = request.getRequestURL().toString().split(request.getRequestURI());
				String mail_sign = "<a href =" + url[0] + "/m/member/login.do target ='_blank'>";

				/* send email ->계정:gmail, 운영 반영시에 실제사용값으로 수정요청드립니다.(참고파일: root-context.xml) */
				email.setSubject("회원님께서 요청하신 비밀번호를 보내드립니다.");
				email.setReceiver(memberEmail);
				email.setVeloTemplate("mail_findpw.vm");
				dbparams.put("mail_pw", pw);
				dbparams.put("mail_sign", mail_sign);
				dbparams.put("mail_email", memberEmail);
				email.setEmailMap(dbparams);
				email.setHtmlYn("Y");
				emailSender.sendVelocityEmail(email);
				/* send email ->계정:gmail, 운영 반영시에 실제사용값으로 수정요청드립니다.(참고파일: root-context.xml) */
				rmap.put(Const.D_SCRIPT,
						Util.jsmsgLink("가입하신 이메일로 발송이 완료되었습니다.", "/m/member/find_pw.do?alertView=t&Message=1", "T"));
			} else {
				rmap.put(Const.D_SCRIPT,
						Util.jsmsgLink("이메일이 존재하지 않습니다.", "/m/member/find_pw.do?alertView=t&Message=2", "T"));
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return true;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Throwable.class })
	public boolean selectMemberValidity(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		RPMap dbparams = new RPMap();

		try {
			dbparams.put("memberEmail", p.getStr("email"));
			int memberValidity = mobileMemberDao.selectMemberJoinCount(dbparams);

			if (memberValidity > 0) {
				String json = Util.printResult(2, String.format("중복된 회원정보가 존재합니다."), null);
				rmap.put("json", json);
				return true;
			} else {
				String json = Util.printResult(1, String.format("성공하였습니다."), null);
				rmap.put("json", json);
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Throwable.class })
	public boolean selectPhoneOverlap(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		RPMap dbparams = new RPMap();

		try {
			dbparams.put("memberPhone", p.getStr("memberPhone"));
			int memberValidity = mobileMemberDao.selectMemberPhoneOverlapCount(dbparams);

			if (memberValidity > 0) {
				String json = Util.printResult(2, String.format("중복된 회원정보가 존재합니다."), null);
				rmap.put("json", json);
				return true;
			} else {
				String json = Util.printResult(1, String.format("성공하였습니다."), null);
				rmap.put("json", json);
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Throwable.class })
	public boolean memberEmailConfirmAct(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		RPMap dbparams = new RPMap();
		String memberEmail = p.getStr("memberEmail");
		String memberNo = p.getStr("memberNo");
		SessionManager sm = new SessionManager(request, response);

		try {
			if (memberEmail != null) {
				dbparams.put("memberNo", memberNo);
				dbparams.put("memberEmail", memberEmail);
				HashMap<String, Object> mypageMyinfo = mobileMemberDao.selectMypageMyinfo(dbparams);

				String createTime = mypageMyinfo.get("createTime2").toString();

				/*
				 * 변경: 현재시간->가입당시시간 Date today = new Date(); SimpleDateFormat date = new
				 * SimpleDateFormat("yyyy-MM-dd"); String mail_date = date.format(today);
				 */

				HashMap<String, Object> userInfos = mobileMemberDao.selectFindEmailAct(dbparams);
				String mail_name = userInfos.get("memberName").toString();
				String mail_email = BASE64Util.encodeString(p.getStr("memberEmail").trim());
				String[] url = request.getRequestURL().toString().split(request.getRequestURI());
				String mail_sign = "<a href =" + url[0] + "/m/member/email_sign_act.do?memberEmail='" + mail_email
						+ "' target ='_blank'>";
				String mail_date = createTime;

				/* send email ->계정:gmail, 운영 반영시에 실제사용값으로 수정요청드립니다.(참고파일: root-context.xml) */
				email.setHtmlYn("Y");
				email.setReceiver(memberEmail);
				email.setSubject("본인 인증하기 이메일입니다.");
				email.setVeloTemplate("mail_emailconfirm.vm");
				dbparams.put("mail_name", mail_name);
				dbparams.put("mail_date", mail_date);
				dbparams.put("mail_sign", mail_sign);
				email.setEmailMap(dbparams);
				emailSender.sendVelocityEmail(email);
				/* send email ->계정:gmail, 운영 반영시에 실제사용값으로 수정요청드립니다.(참고파일: root-context.xml) */

				String json = Util.printResult(1, String.format("발송완료 되었습니다."), null);// 주석처리해도 될듯, 페이지에서 리로드
				rmap.put("json", json);
			} else {
				String json = Util.printResult(1, String.format("회원정보를 확인해주시길 바랍니다."), null);
				rmap.put("json", json);
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return true;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Throwable.class })
	public boolean regularMemberAct(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		RPMap dbparams = new RPMap();
		SessionManager sm = new SessionManager(request, response);

		try {
			dbparams.put("memberNo", sm.getMemberNo());
			int memberShipReqCount = mobileMemberDao.selectMemberShipReq(dbparams);

			if (memberShipReqCount > 0) {
				rmap.put(Const.D_SCRIPT,
						Util.jsmsgLink("이미 정회원 신청을 하셨습니다.", "/m/mypage/mypage_myinfo.do?alertView=t&Message=1", "T"));
				return false;
			}

			String memberName = p.getStr("m_name");
			dbparams.put("BankAccountNo", p.getStr("m_bank"));
			HashMap<String, Object> selectCompanyBankAccount = mobileMemberDao.selectCompanyBankAccount(dbparams);
			dbparams.put("bankName", selectCompanyBankAccount.get("bankName"));
			dbparams.put("bankOwnerName", selectCompanyBankAccount.get("bankOwnerName"));
			dbparams.put("bankAccount", selectCompanyBankAccount.get("bankAccount"));
			dbparams.put("memberName", p.getStr("m_name"));
			dbparams.put("BankAccountNo", p.getStr("m_bank"));

			HashMap<String, Object> selectPolicyMembershipTransLimit = mobileMemberDao
					.selectPolicyMembershipTransLimit(dbparams);
			dbparams.put("paymentAmount", selectPolicyMembershipTransLimit.get("membershipTransLimit"));
			dbparams.put("companyBankAccountNo", p.getStr("m_bank"));
			mobileMemberDao.insertMembershipRequest(dbparams);

			HashMap<String, Object> mypageMyinfo = mobileMemberDao.selectMypageMyinfo(dbparams);

			dbparams.put("memberName", mypageMyinfo.get("memberName"));
			dbparams.put("memberEmail", mypageMyinfo.get("memberEmail"));
			dbparams.put("memberNameDepo", memberName);

			String[] url = request.getRequestURL().toString().split(request.getRequestURI());
			String mail_sign = "<a href =" + url[0] + "/m/member/login.do target ='_blank'>";

			/* send email ->계정:gmail, 운영 반영시에 실제사용값으로 수정요청드립니다.(참고파일: root-context.xml) */
			email.setSubject("정회원 신청 정보를 보내드립니다.");
			email.setReceiver(mypageMyinfo.get("memberEmail").toString());
			email.setVeloTemplate("mail_fullmember.vm");
			dbparams.put("mail_sign", mail_sign);
			email.setEmailMap(dbparams);
			email.setHtmlYn("Y");
			emailSender.sendVelocityEmail(email);
			/* send email ->계정:gmail, 운영 반영시에 실제사용값으로 수정요청드립니다.(참고파일: root-context.xml) */

			rmap.put(Const.D_SCRIPT,
					Util.jsmsgLink("가입하신 이메일로 발송이 완료되었습니다.", "/m/main/index.do?alertView=t&Message=5", "T"));
		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return true;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Throwable.class })
	public boolean memberOutAct(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		SessionManager sm = new SessionManager(request, response);
		RPMap dbparams = new RPMap();

		String pwd = p.getStr("pwd");
		String memberEmail = p.getStr("memberEmail");
		String memberPassword = "";
		int memberNo = 0;
		dbparams.put("memberNo", sm.getMemberNo());
		dbparams.put("memberEmail", memberEmail);
		dbparams.put("pwd", pwd);

		try {
			HashMap<String, Object> myinfo = mobileMemberDao.selectMyinfoCheck(dbparams);

			if (myinfo != null && !myinfo.isEmpty()) {
				memberNo = Converter.toInt(myinfo.get("memberNo"));
				memberPassword = Converter.toStr(myinfo.get("memberPassword"));
			}

			if (memberNo <= 0) {
				rmap.put(Const.D_SCRIPT, Util.jsmsgLink("이메일 또는 비밀번호가 일치하지 않습니다.",
						"/m/mypage/mypage_out.do?alertView=t&Message=1", "T"));
				return false;
			}

			// 암호 비교
			if (!memberPassword.equals(Util.sha(pwd))) {
				rmap.put(Const.D_SCRIPT, Util.jsmsgLink("이메일 또는 비밀번호가 일치하지 않습니다.",
						"/m/mypage/mypage_out.do?alertView=t&Message=1", "T"));
				return false;
			}

			dbparams.put("memberNo", myinfo.get("memberNo"));
			dbparams.put("memberStatus", "6"); // 사용자 자발 탈퇴

			mobileMemberDao.memberOutAct(dbparams);
			rmap.put(Const.D_SCRIPT, Util.jsmsgLink("탈퇴되었습니다.", "/m/main/index.do?form=out&", "T"));
			sm.killSession();

		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return true;

	}

	@Override
	public boolean myinfoCheck(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		HashMap<String, Object> dbparams = new HashMap<String, Object>();

		SessionManager sm = new SessionManager(request, response);
		dbparams.put("memberNo", sm.getMemberNo());
		try {
			HashMap<String, Object> mypageMyinfo = mobileMemberDao.selectMypageMyinfo(dbparams);
			if (mypageMyinfo == null) {
				rmap.put(Const.D_SCRIPT, Util.jsmsgLink("잘못된 경로입니다.", "/m/main/index.do?alertView=t&Message=1", "T"));
				return false;
			}
			rmap.put("mypageMyinfo", mypageMyinfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Throwable.class })
	public boolean selectPolicyPointTransLimit(RPMap p, RPMap rmap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		RPMap dbparams = new RPMap();
		try {
			// dbparams.put("pointtranslimit", p.getStr("pointtranslimit"));
			HashMap<String, Object> policy = mobileMemberDao.selectPolicyPointTranslimit(dbparams);

			JSONArray json_arr = new JSONArray();
			JSONObject obj = new JSONObject();
			obj.put("pointTransLimit", policy.get("pointTransLimit"));
			obj.put("rPointMovingMinLimit", policy.get("rPointMovingMinLimit"));
			obj.put("rPointMovingMaxLimit", policy.get("rPointMovingMaxLimit"));
			obj.put("gPointMovingMinLimit", policy.get("gPointMovingMinLimit"));
			obj.put("gPointMovingMaxLimit", policy.get("gPointMovingMaxLimit"));
			json_arr.add(obj);

			JSONObject json = new JSONObject();
			json.put("result", 1);
			json.put("json_arr", json_arr);
			rmap.put(Const.D_JSON, json.toString());
			return true;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Throwable.class })
	public boolean selectMemberEmailInfo(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		RPMap dbparams = new RPMap();
		SessionManager sm = new SessionManager(request, response);
		dbparams.put("memberNo", sm.getMemberNo());

		try {
			dbparams.put("memberEmail", p.getStr("memberEmail"));
			int memberValidity = mobileMemberDao.selectMemberInfo(dbparams);

			if (memberValidity == 1) {
				String json = Util.printResult(1, String.format("성공하였습니다."), null);
				rmap.put("json", json);
				return true;
			} else {
				String json = Util.printResult(2, String.format("실패하였습니다. 정확한 이메일주소를 입력해주세요."), null);
				rmap.put("json", json);
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Throwable.class })
	public boolean selectQrSelectMemberPhoneInfo(RPMap p, RPMap rmap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		RPMap dbparams = new RPMap();
		SessionManager sm = new SessionManager(request, response);

		try {
			dbparams.put("memberPhone", p.getStr("memberPhone"));
			int qrmemberPhone = mobileMemberDao.selectqrMemberPhone(dbparams);

			if (qrmemberPhone > 0) {
				String json = Util.printResult(1, String.format("회원님은 이미 회원가입이 되어 계십니다. 로그인을 해주세요."), null);
				rmap.put("json", json);
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Throwable.class })
	public boolean selectPhoneOverlapModify(RPMap p, RPMap rmap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		RPMap dbparams = new RPMap();
		SessionManager sm = new SessionManager(request, response);
		try {
			dbparams.put("memberPhone", p.getStr("memberPhone"));
			dbparams.put("memberNo", sm.getMemberNo());

			int memberValidity = mobileMemberDao.selectMemberPhoneOverlapModfiyCount(dbparams);

			if (memberValidity > 0) {
				String json = Util.printResult(2, String.format("중복된 회원정보가 존재합니다."), null);
				rmap.put("json", json);
				return true;
			} else {
				String json = Util.printResult(1, String.format("성공하였습니다."), null);
				rmap.put("json", json);
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Throwable.class })
	public boolean updatePaymentStatus(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		RPMap dbparams = new RPMap();
		SessionManager sm = new SessionManager(request, response);

		try {
			dbparams.put("memberNo", sm.getMemberNo());
			mobileMemberDao.updatePaymentStatusRequestCon(dbparams);
			rmap.put(Const.D_SCRIPT,
					Util.jsmsgLink("성공하였습니다.", "/m/mypage/mypage_myinfo.do?alertView=t&Message=2", "T"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}

	@Override
	public boolean selectCountries(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		dbparams.put("useStatus", "Y");
		try {
			ArrayList<HashMap<String, Object>> countries = mobileMemberDao.selectCountries(dbparams);
			rmap.put("countries", countries);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public boolean selectLanguages(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		dbparams.put("useStatus", "Y");
		try {
			ArrayList<HashMap<String, Object>> languages = mobileMemberDao.selectLanguages(dbparams);
			rmap.put("languages", languages);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public boolean getMemberBankAccounts(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);
		try {
			dbparams.put("memberNo", sm.getMemberNo());
			dbparams.put("accountStatus", "Y");
			ArrayList<HashMap<String, Object>> memberBankAccounts = mobileMemberDao.selectBankAccounts(dbparams);
			rmap.put("memberBankAccounts", memberBankAccounts);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public boolean deleteMemberBankAccount(RPMap p, RPMap rmap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		RPMap dbparams = new RPMap();
		try {
			dbparams.put("memberBankAccountNo", Converter.toInt(p.getStr("memberBankAccountNo")));
			int count = mobileMemberDao.deleteMemberBankAccount(dbparams);

			if (count == 0) {
				String json = Util.printResult(1, String.format("잘못된 요청입니다."), null);
				rmap.put("json", json);
				return true;
			} else {
				String json = Util.printResult(0, String.format("지정한 회원 계좌 삭제했습니다."), null);
				rmap.put("json", json);
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();

		}
		return true;
	}

	@Override
	public boolean changeMemberConfig(RPMap p, RPMap rMap, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);
		try {
			dbparams.put("memberNo", sm.getMemberNo());
			dbparams.put(p.getStr("memberConfigName"), p.get("value"));
			int count = mobileMemberDao.updateMemberConfig(dbparams);

			if (count == 0) {
				String json = Util.printResult(1, String.format("잘못된 요청입니다."), null);
				rMap.put("json", json);
				return true;
			} else {
				String json = Util.printResult(0, String.format("설정 변경 완료"), null);
				rMap.put("json", json);
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return false;
		}
	}

	@Override
	public boolean preparePointwithdrawlForm(RPMap p, RPMap rmap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);
		try {
			dbparams.put("memberNo", sm.getMemberNo());
			rmap.put("memberTypeInfo", mobileMemberDao.selectMypageMyinfo(dbparams));
			rmap.put("memberBankAccounts", mobileMemberDao.selectBankAccounts(dbparams));
			rmap.put("rPayInfo", mobileMemberDao.selectMyRedPointMapinfo(dbparams));
			rmap.put("policy", mobileMemberDao.selectPolicyPointTranslimit(dbparams));
			rmap.put("rpayTotalWithdrawal", mobileMemberDao.selectWithdrawalSumPerDay(dbparams));

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public boolean insertPointWithdrawal(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);
		HashMap<String, Object> rpayMap;
		try {
			dbparams.put("memberNo", sm.getMemberNo());
			rpayMap = mobileMemberDao.selectMyRedPointMapinfo(dbparams);

			if ( Converter.toInt(p.getStr("withdrawalAmount")) > (float) rpayMap.get("pointAmount") ) {
				String json = Util.printResult(1, String.format("요청 하신 출금 금액이 보유하신 R POINT 를 초과합니다. 확인후 다시 시도해주세요"),
						null);
				rmap.put("json", json);
				return true;
			}

			dbparams.put("memberBankAccountNo", Converter.toInt(p.getStr("memberBankAccountNo")));
			dbparams.put("withdrawalAmount", Converter.toInt(p.getStr("withdrawalAmount")));

			int count = mobileMemberDao.insertPointWithdrawal(dbparams);
			if (count == 0) {
				String json = Util.printResult(1, String.format("잘못된 요청입니다."), null);
				rmap.put("json", json);
				return true;
			} else {
				int result = Converter.toInt(rpayMap.get("pointAmount"));
				System.out.println((float) rpayMap.get("pointAmount"));
				/* 출금 신청된 회원의 RPay를 출금 금액만큼 차감 */
				rpayMap.put("pointAmount",
						(float) rpayMap.get("pointAmount") - Float.parseFloat(p.getStr("withdrawalAmount")));
				mobileMemberDao.updateRedPoint(rpayMap);
				String json = Util.printResult(0, String.format("출금 요청 등록 완료"), null);
				rmap.put("json", json);
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public boolean updatePointwithdrawal(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);
		try {
			dbparams.put("pointWithdrawalNo", sm.getMemberNo());
			dbparams.put("withdrawalStatus", Converter.toInt(p.getStr("withdrawalStatus")));

			int count = mobileMemberDao.updatePointwithdrawal(dbparams);
			if (count == 0) {
				String json = Util.printResult(1, String.format("잘못된 요청입니다."), null);
				rmap.put("json", json);
				return true;
			} else {
				String json = Util.printResult(0, String.format("출금 요청건 수정 완료"), null);
				rmap.put("json", json);
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public boolean preparePointwithdrawalList(RPMap p, RPMap rmap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);
		try {
			dbparams.put("memberNo", sm.getMemberNo());
			rmap.put("pointWithdrawals", mobileMemberDao.selectPointwithdrawals(dbparams));
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean generateQR(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);
		rmap.put("qr_cmd", p.getStr("qr_cmd"));
		String data = null;
		String pageTitle = "";
		JSONObject qrDataObj = new JSONObject();

		String scheme = request.getScheme();
		String serverName = request.getServerName();
		String port = request.getServerPort() == 80 || request.getServerPort() == 443 ? "" : ":" + String.valueOf(request.getServerPort());
		String qrUrl = scheme + "://" + serverName + port.trim();
		System.out.println(qrUrl);

		try {
			dbparams.put("memberNo", sm.getMemberNo());
			HashMap<String, Object> memberInfo = this.mobileMemberDao.selectMypageMyinfo(dbparams);

			switch (p.getStr("qr_cmd")) {
			case QRManager.QRCmd.GEN_JOIN_RECOM_QR:
				rmap.put("memberInfo", memberInfo);
				pageTitle = this.messageUtils.getMessage("label.gen_join_qr_code");
				rmap.put("pageTitleMessageId", "label.gen_join_qr_code");
				rmap.put("pageMessage", "label.use_join_qr_code");
				// qrDataObj.put("qr_cmd", QRManager.QRCmd.EXE_JOIN_WITH_RECOM);
				// qrDataObj.put("recommender", (String)memberInfo.get("memberEmail"));
				// System.out.println(qrDataObj.toString());
				data = qrUrl + "/m/intro/intro.do?recommender=" + BASE64Util.encodeString((String) memberInfo.get("memberEmail"));
				System.out.println("QR join URL : " + data);
				break;

			case QRManager.QRCmd.GEN_PRODUCT_QR:
				pageTitle = this.messageUtils.getMessage("label.gen_product_qr_code");
				rmap.put("pageTitleMessageId", "label.gen_product_qr_code");
				break;

			case QRManager.QRCmd.GEN_GIFT_QR:
				pageTitle = this.messageUtils.getMessage("label.gen_gift_qr_code");
				rmap.put("pageTitleMessageId", "label.gen_gift_qr_code");
				break;
			}

			rmap.put("pageTitle", pageTitle);
			rmap.put("qr_cmd", p.getStr("qr_cmd"));
			/* 추천인 자동 설정 회원가입 QR이 아니라면, 현재 지원하지 않는 서비스 */
			if (p.getStr("qr_cmd").equals(QRManager.QRCmd.GEN_PRODUCT_QR)
					|| p.getStr("qr_cmd").equals(QRManager.QRCmd.GEN_GIFT_QR)) {
				rmap.put("result", "101");
			} else {
				rmap.put("qrAccessUrl", QRManager.genQRCode(
						request.getSession().getServletContext().getRealPath("/gen_qr"), "/gen_qr", data, null));
				rmap.put("qrEncodeData", data);
				rmap.put("qrPlainData", data);
				rmap.put("result", "100");
				rmap.put("message", this.messageUtils.getMessage("label.gen_qr_success"));
			}

		} catch (Exception e) {
			e.printStackTrace();
			rmap.put("result", "102");
			rmap.put("message", this.messageUtils.getMessage("label.gen_qr_error"));
			return false;
		}
		return true;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean qrCommandControl(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("qrCommandControl");
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);

		JSONParser jsonParser;
		JSONObject qrJson;
		String qr_cmd;
		try {
			// System.out.println("원문 데이타");
			// System.out.println(p.getStr("qr_data"));
			// System.out.println("디코딩 데이타");
			// System.out.println(BASE64Util.decodeString(p.getStr("qr_data")));
			jsonParser = new JSONParser();
			qrJson = (JSONObject) jsonParser.parse(BASE64Util.decodeString(p.getStr("qr_data")));
			qr_cmd = (String) qrJson.get("qr_cmd");

			switch (qr_cmd) {

			/* 추천인 큐알 스캔에 의한 회원 페이지 이동 */
			case QRManager.QRCmd.EXE_JOIN_WITH_RECOM:
				dbparams.put("recommenderEmail", (String) qrJson.get("recommender"));
				HashMap<String, Object> memberMap = this.mobileMemberDao.selectRecommendDetail(dbparams);
				if (memberMap == null) {
					rmap.put("resultCode", "301");
					rmap.put("message", this.messageUtils.getMessage("label.label.no_member"));
					rmap.put("view", "/mobile/error/common_error");
				} else {
					rmap.put("resultCode", "100");
					rmap.put("redirectUrl", "/m/member/join.do?&recommender="
							+ BASE64Util.encodeString(Util.encodeURIComponent((String) qrJson.get("recommender"))));
				}
				break;

			/* 상품권 QR 적립 */
			case QRManager.QRCmd.PAY_BY_GIFTCARD:
				/* 상품권 QR 적립 */
			case QRManager.QRCmd.ACC_BY_GIFTCARD:
				break;
			}
		} catch (Exception e) {
			e.printStackTrace();
			rmap.put("resultCode", "300");
			rmap.put("message", this.messageUtils.getMessage("label.gen_qr_error"));
			rmap.put("view", "/mobile/error/common_error");
			return false;
		}
		return true;
	}

	@Override
	public String handleGiftCardQR(HashMap<String, String> paramMap, ModelMap modelMap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// System.out.println(">>> handleGiftCardQR");
		String runMode = environment.getProperty("run_mode");
		String remoteCallURL = environment.getProperty(runMode + ".handle_gift_card_Req");
		String key = environment.getProperty("key");
		StringBuffer response2 = null;
		try {
			URL url = new URL(remoteCallURL);
			// System.out.println("연결 주소");
			// System.out.println(remoteCallURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setDoInput(true);
			con.setDoOutput(true);
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			con.setRequestMethod("POST");
			con.getOutputStream().write(Util.mapToQueryParam(paramMap).getBytes());

			int responseCode = con.getResponseCode();
			BufferedReader in = null;
			if (responseCode == HttpURLConnection.HTTP_OK) {
				in = new BufferedReader(new InputStreamReader(con.getInputStream()));
				String inputLine;
				response2 = new StringBuffer();
				while ((inputLine = in.readLine()) != null) {
					response2.append(inputLine);
				}
				in.close();
				// System.out.println("응답");
				// System.out.println(response2.toString());
			} else {
				// System.out.println("상품권 QR API 요청 에러");
			}
			// System.out.println("상품권 QR API 요청");
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return response2.toString();
	}

	@Override
	public boolean registerMemberBankAccount(RPMap p, RPMap rmap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		RPMap dbparams = new RPMap();
		SessionManager sm = new SessionManager(request, response);
		try {
			dbparams.put("memberNo", Converter.toInt(sm.getMemberNo()));
			dbparams.put("bankName", Converter.toStr(p.getStr("bankName")));
			dbparams.put("bankAccount", Converter.toStr(p.getStr("bankAccount")));
			dbparams.put("accountOwner", Converter.toStr(p.getStr("accountOwner")));
			dbparams.put("accountStatus", "Y");
			dbparams.put("regAdminNo", 0);
			dbparams.put("regType", "U");
			int count = 0;
			String action = p.getStr("action") != null && !"".equals(p.getStr("action")) ? p.getStr("action")
					: "create";
			if ("create".equals(action)) {
				count = mobileMemberDao.insertMemberBankAccount(dbparams);
			}

			if ("modify".equals(action)) {
				dbparams.put("memberBankAccountNo", Converter.toInt(p.getStr("memberBankAccountNo")));
				count = mobileMemberDao.updateMemberBankAccount(dbparams);
			}

			if (count == 0) {
				String json = Util.printResult(1, String.format("잘못된 요청입니다."), null);
				rmap.put("json", json);
				return true;
			} else {
				String json = Util.printResult(0, String.format("회원 계좌 등록 완료"), null);
				rmap.put("json", json);
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;

		}
	}

	@Override
	public boolean prepareMemberBankAccountForm(RPMap p, RPMap rmap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);
		String action = p.getStr("action") != null && !"".equals(p.getStr("action")) ? p.getStr("action") : "create";
		rmap.put("action", action);

		ArrayList<HashMap<String, Object>> accountMapList = null;
		if ("create".equals(action)) {
			rmap.put("title", this.messageUtils.getMessage("label.regist_bank_account"));
			rmap.put("button_label", this.messageUtils.getMessage("label.regist_bank_account"));
			
			HashMap<String, Object> initBankMap = new HashMap<String, Object> ();
			initBankMap.put("accountOwner", request.getSession().getAttribute("memberName"));
			rmap.put("memberBankAccount", initBankMap);
			return true;
		}

		if ("modify".equals(action)) {
			dbparams.put("memberNo", sm.getMemberNo());
			dbparams.put("memberBankAccountNo", p.getInt("memberBankAccountNo"));
			accountMapList = this.mobileMemberDao.selectBankAccounts(dbparams);
			rmap.put("title", this.messageUtils.getMessage("label.edit_bank_account"));
			rmap.put("button_label", this.messageUtils.getMessage("label.edit_bank_account"));
			if (accountMapList.size() == 1) {
				rmap.put("memberBankAccount", accountMapList.get(0));
			} else {
				rmap.put("messge", "해당 회원의 은행 계좌 정보 요청이 잘못되었습니다");
			}
			return true;
		}
		return false;
	}

}