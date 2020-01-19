package com.returnp_web.svc;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.ui.ModelMap;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.returnp_web.dao.MobileMainDao;
import com.returnp_web.dao.MobileMemberDao;
import com.returnp_web.utils.BASE64Util;
import com.returnp_web.utils.CodeGenerator;
import com.returnp_web.utils.Const;
import com.returnp_web.utils.Converter;
import com.returnp_web.utils.QRManager;
import com.returnp_web.utils.RPMap;
import com.returnp_web.utils.SessionManager;
import com.returnp_web.utils.Util;


/**
 * The Class FrontMainServiceImpl.
 */
@PropertySource("classpath:/config.properties")
@Service
public class MobileMainServiceImpl implements MobileMainService {

	private static final Logger logger = LoggerFactory.getLogger(MobileMainServiceImpl.class);

	/** The front main dao. */
	@Autowired
	private MobileMainDao mobileMainDao;

	@Autowired
	private MobileMemberDao mobileMemberDao;

	@Autowired
	private MessageSource messageSource;

	@Autowired
	Environment environment;

	@Override
	public boolean memberTotal(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception {

		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);

		try {

			int memberTotal = mobileMainDao.selectMemberTotal(dbparams); // red point search.

			rmap.put("memberTotal", memberTotal);

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public boolean myPointInfo(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception {

		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);

		// 추후 다국어 alert 요청시 아래의 것 활용하세요.(18.07.11)
		String message = messageSource.getMessage("messages.greeting", null, LocaleContextHolder.getLocale());

		try {
			if(sm.getMemberEmail() == null ) {
				rmap.put(Const.D_SCRIPT, Util.jsmsgLink("잘못된 경로입니다.", "/m/member/login.do", "T"));
				return false;
			}
			dbparams.put("memberNo", sm.getMemberNo());

			String move = p.getStr("move");
			Date d = new Date();
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat dfDiff = new SimpleDateFormat("yyyy-MM");
			String serverDate = df.format(d);
			String serverDateDiff = dfDiff.format(d);
			if (move == null || "".equals(move)) {
				dbparams.put("TIME", serverDate); // 현재년월일
				dbparams.put("SEARCHTIME", serverDateDiff); // 현재년월
			} else {
				dbparams.put("TIME", move + "-01"); // 현재선택한 년월일
				dbparams.put("SEARCHTIME", move); // 현재년월
			}

			HashMap<String, Object> serverYearMonth = mobileMemberDao.selectYearMonth(dbparams);
			String PREWMONTH = (String) serverYearMonth.get("PREWMONTH");
			String NOWMONTH = (String) serverYearMonth.get("NOWMONTH");
			String NEXTMONTH = (String) serverYearMonth.get("NEXTMONTH");
			rmap.put("PREWMONTH", PREWMONTH);
			rmap.put("NOWMONTH", NOWMONTH);
			rmap.put("NEXTMONTH", NEXTMONTH);

			HashMap<String, Object> mypageMyinfo = mobileMemberDao.selectMypageMyinfo(dbparams); // my info
			if (mypageMyinfo == null) {
				rmap.put(Const.D_SCRIPT, Util.jsmsgLink("잘못된 경로입니다.", "/m/main/index.do?alertView=t&Message=1", "T"));
				return false;
			}
			HashMap<String, Object> myRedPointSumInfo = mobileMainDao.selectMyRedPointSumInfo(dbparams); // red point search.
			HashMap<String, Object> myGreenPointSumInfo = mobileMainDao.selectMyGreenPointSumInfo(dbparams); // green point Sum search.
			ArrayList<HashMap<String, Object>> selectMyGreenPointList = mobileMainDao.selectMyGreenPointList(dbparams); // green point List search.
			ArrayList<HashMap<String, Object>> selectPolicyList = mobileMainDao.selectPolicyList(dbparams); // policy. 정책
			HashMap<String, Object> myRedPointInfo = mobileMemberDao.selectMyRedPointMapinfo(dbparams); // red point Map search
			ArrayList<HashMap<String, Object>> selectMyGreenPointSumList = mobileMainDao.selectMyGreenPointSumList(dbparams); // green point Sum List search.
			ArrayList<HashMap<String, Object>> selectMyRedPointSumList = mobileMainDao.selectMyRedPointSumList(dbparams); // red point Sum one List search.
			for (Map<String, Object> selectPolicyMap : selectPolicyList) {
				for (Map.Entry<String, Object> entry : selectPolicyMap.entrySet()) {
					String key = entry.getKey();
					Object value = entry.getValue();
					selectPolicyMap.put(key, value);
				}
				rmap.put("selectPolicyMap", selectPolicyMap);
			}
			if (selectMyGreenPointList != null) {
				for (Map<String, Object> myGreenPointMap : selectMyGreenPointList) {
					for (Map.Entry<String, Object> entry : myGreenPointMap.entrySet()) {
						String key = entry.getKey();
						Object value = entry.getValue();
						myGreenPointMap.put(key, value);
					}
					rmap.put("myGreenPointMap", myGreenPointMap);
				}
			}

			for (Map<String, Object> myGreenPointSumMap : selectMyGreenPointSumList) {
				if (myGreenPointSumMap != null) {
					for (Map.Entry<String, Object> entry : myGreenPointSumMap.entrySet()) {
						String key = entry.getKey();
						Object value = entry.getValue();
						myGreenPointSumMap.put(key, value);
					}
					rmap.put("myGreenPointSumMap", myGreenPointSumMap);
				}
			}

			for (Map<String, Object> myRedPointSumMap : selectMyRedPointSumList) {
				if (myRedPointSumMap != null) {
					for (Map.Entry<String, Object> entry : myRedPointSumMap.entrySet()) {
						String key = entry.getKey();
						Object value = entry.getValue();
						myRedPointSumMap.put(key, value);
					}
					rmap.put("myRedPointSumMap", myRedPointSumMap);
				}
			}

			/**
			 * 참고 1-일반회원 member 2. 정회원 recommender 3. 지사 branch 4. 대리점 agancy 5. 협력업체 affiliate 6. 영업관리자 saleManager 7. 총판 SoleDist
			 **/
			rmap.put("mypageMyinfo", mypageMyinfo);
			rmap.put("myRedPointSumInfo", myRedPointSumInfo);
			rmap.put("myGreenPointSumInfo", myGreenPointSumInfo);
			rmap.put("selectMyGreenPointList", selectMyGreenPointList);
			rmap.put("serverDateDiff", serverDateDiff);
			rmap.put("myRedPointInfo", myRedPointInfo);

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	@Override
	public boolean initMain(RPMap paramMap, RPMap rmap, HttpServletRequest request, HttpServletResponse response) {
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);

		try {
			if(sm.getMemberEmail() == null ) {
				rmap.put(Const.D_SCRIPT, Util.jsmsgLink("잘못된 경로입니다.", "/m/member/login.do", "T"));
				return false;
			}
			dbparams.put("memberNo", sm.getMemberNo());

			HashMap<String, Object> mypageMyinfo = mobileMemberDao.selectMypageMyinfo(dbparams); // my info
			if (mypageMyinfo == null) {
				rmap.put(Const.D_SCRIPT, Util.jsmsgLink("잘못된 경로입니다.", "/m/main/index.do?alertView=t&Message=1", "T"));
				return false;
			}
			
			HashMap<String, Object> myRedPointSumInfo = mobileMainDao.selectMyRedPointSumInfo(dbparams); // red point search.
			HashMap<String, Object> myGreenPointSumInfo = mobileMainDao.selectMyGreenPointSumInfo(dbparams); // green point Sum search.
			
			dbparams.clear();
			dbparams.put("memberNo", sm.getMemberNo());
			HashMap<String, Object> affiliateMap = mobileMainDao.selectAffiliate(dbparams);
			if (affiliateMap != null) {
				rmap.put("affiliate", affiliateMap);
				dbparams.clear();
				dbparams.put("bbsType1", "1");
				dbparams.put("bbsType2", "2");
				dbparams.put("bbsLimit", 2);
				ArrayList<HashMap<String, Object>> affiliateNotices = this.mobileMainDao.selectBoards(dbparams);
				if (affiliateNotices.size()>0) {
					rmap.put("affiliateNotice", affiliateNotices.get(0));
					rmap.put("affiliateNotices", affiliateNotices);
				} 
			}
			
			rmap.put("myRedPointSumInfo", myRedPointSumInfo);
			rmap.put("myGreenPointSumInfo", myGreenPointSumInfo);

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Throwable.class })
	public boolean pointConvertRequest(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception {

		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);
		dbparams.put("memberNo", sm.getMemberNo());

		try {

			dbparams.put("nodeType", p.getStr("nodeType"));
			dbparams.put("convertPointAmount", (float) p.getInt("convertPointAmount"));
			dbparams.put("requestNodeTypeName", p.getStr("requestNodeTypeName"));
			dbparams.put("greenPointNo", p.getStr("greenPointNo"));
			float myPoint = 0;
			HashMap<String, Object> selectPolicyMembershipTransLimit = mobileMemberDao.selectPolicyMembershipTransLimit(dbparams);
			if (selectPolicyMembershipTransLimit != null) {
				dbparams.put("redPointAccRate", selectPolicyMembershipTransLimit.get("redPointAccRate"));
			} else {
				String json = Util.printResult(1, String.format("잠시후 진행 하시길 바랍니다."), null);
				rmap.put("json", json);
				return true;
			}
			HashMap<String, Object> selectMygreenPointInfo = mobileMemberDao.selectMygreenPointInfo(dbparams);
			if (selectMygreenPointInfo != null) {
				myPoint = (float) selectMygreenPointInfo.get("pointAmount");
			} else {
				String json = Util.printResult(1, String.format("잠시후 진행 하시길 바랍니다."), null);
				rmap.put("json", json);
				return true;
			}

			float pointAmount = myPoint - (float) p.getInt("convertPointAmount"); // 현재 포인트-차감포인트=최종 잔여 포인트
			dbparams.put("pointAmount", pointAmount);
			mobileMainDao.insertPointConvertRequestAct(dbparams);
			mobileMainDao.insertPointConvertTransactionAct(dbparams);
			mobileMainDao.updateGreenPointUse(dbparams);
			String json = Util.printResult(0, String.format("성공하였습니다."), null);
			rmap.put("json", json);

			return true;
		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return true;
	}

	// 레드포인트 선물하기
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Throwable.class })
	public boolean redPointConvertRequest(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception {

		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);
		dbparams.put("memberNo", sm.getMemberNo());

		try {
			dbparams.put("memberEmail", p.getStr("redPointGiftMemberEmail"));
			// 추천인 memberNo 호출
			HashMap<String, Object> recipientMemberinfo = mobileMemberDao.selectRecipientMemberinfo(dbparams);
			if (recipientMemberinfo != null) {
				dbparams.put("pointReceiver", Converter.toInt(recipientMemberinfo.get("memberNo"))); // pointReceiver :
																										// 송금받을 멤버 번호
			} else {
				String json = Util.printResult(1, String.format("잠시후 진행 하시길 바랍니다."), null);
				rmap.put("json", json);
				return true;
			}
			if(p.getStr("convertPointAmount") == null || p.getStr("convertPointAmount").equals("")) {
				String json = Util.printResult(1, String.format("잠시후 진행 하시길 바랍니다."), null);
				rmap.put("json", json);
				return true;
			}

			dbparams.put("pointTransferAmount", p.getStr("convertPointAmount")); // transferPointAmount : 송금액
			float pointAmount = ((float) p.getInt("pointAmount") - (float) p.getInt("convertPointAmount")); // 현재포인트-차감포인트=최종잔여 포인트
			dbparams.put("pointAmount", pointAmount); // 내 레드포인트 잔액
			dbparams.put("pointTransferer", sm.getMemberNo());
			dbparams.put("pointType", "2"); // redpoint:2
			HashMap<String, Object> receiverRedPointInfo = mobileMainDao.selectReceiverRedPointInfo(dbparams);
			if (receiverRedPointInfo == null) {
				String json = Util.printResult(1, String.format("잠시후 진행 하시길 바랍니다."), null);
				rmap.put("json", json);
				return true;
			}
			// 현재 포인트+부여(선물)포인트=최종 잔여 포인트
			float receiverPointAmount = (float) receiverRedPointInfo.get("pointAmount") + (float) p.getInt("convertPointAmount");
			dbparams.put("receiverPointAmount", receiverPointAmount);
			mobileMainDao.insertPointTransferTransactionAct(dbparams);
			mobileMainDao.updateMyRedPointUse(dbparams);
			mobileMainDao.updateReceiveRedPoint(dbparams);
			String json = Util.printResult(0, String.format("성공하였습니다."), null);
			rmap.put("json", json);
			return true;

		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return true;
	}

	// 그린포인트 선물하기
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Throwable.class })
	public boolean greenPointConvertRequest(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception {

		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);
		dbparams.put("memberNo", sm.getMemberNo());

		try {
			dbparams.put("memberEmail", p.getStr("redPointGiftMemberEmail"));
			dbparams.put("nodeType", p.getStr("nodeType"));
			float myPoint = 0;

			// 포인트 선물 받을 memberNo 호출
			HashMap<String, Object> recipientMemberinfo = mobileMemberDao.selectRecipientMemberinfo(dbparams);
			if (recipientMemberinfo != null) {
				dbparams.put("pointReceiver", Converter.toInt(recipientMemberinfo.get("memberNo"))); // pointReceiver : 송금받을 멤버 번호
			} else {
				String json = Util.printResult(1, String.format("잠시후 진행 하시길 바랍니다."), null);
				rmap.put("json", json);
				return true;
			}

			HashMap<String, Object> selectMygreenPointInfo = mobileMemberDao.selectMygreenPointInfo(dbparams);
			if (selectMygreenPointInfo != null) {
				myPoint = (float) selectMygreenPointInfo.get("pointAmount");
			} else {
				String json = Util.printResult(1, String.format("잠시후 진행 하시길 바랍니다."), null);
				rmap.put("json", json);
				return true;
			}

			if(p.getStr("convertPointAmount") == null || p.getStr("convertPointAmount").equals("")) {
				String json = Util.printResult(1, String.format("잠시후 진행 하시길 바랍니다."), null);
				rmap.put("json", json);
				return true;
			}

			dbparams.put("pointTransferAmount", p.getStr("convertPointAmount")); // transferPointAmount : 송금액
			float pointAmount = myPoint - (float) p.getInt("convertPointAmount"); // 현재 포인트-차감포인트=최종 잔여 포인트
			dbparams.put("pointAmount", pointAmount); // 내 그린포인트 잔액
			dbparams.put("pointTransferer", sm.getMemberNo());
			dbparams.put("pointType", "1"); // greedpoint:1

			//선물받을 사람 그린 포인트 조회
			HashMap<String, Object> receiverGreenPointInfo = mobileMainDao.selectReceiverGreenPointInfo(dbparams);
			if (receiverGreenPointInfo == null) {
				String json = Util.printResult(1, String.format("잠시후 진행 하시길 바랍니다."), null);
				rmap.put("json", json);
				return true;
			}

			float receiverPointAmount = (float) receiverGreenPointInfo.get("pointAmount") + (float) p.getInt("convertPointAmount");
			dbparams.put("receiverPointAmount", receiverPointAmount);
			mobileMainDao.insertPointTransferTransactionAct(dbparams);
			mobileMainDao.updateMyGreenPointUse(dbparams);
			mobileMainDao.updateReceiveGreenPoint(dbparams);
			String json = Util.printResult(0, String.format("성공하였습니다."), null);
			rmap.put("json", json);
			return true;

		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return true;
	}

	/* 
	 * Intro 페이지에서 추천인 (가맹점)이 있는 경우 해당 가맹점의 아이디를 추천인으로 설정
	 */
	@Override
	public boolean prepareIntro(RPMap paramMap, RPMap dataMap, HttpServletRequest request,
			HttpServletResponse response) {
	
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		try {
			//dataMap.put("recommender", BASE64Util.encodeString("kjs67737389@gmail.com"));
			dbparams.put("affiliateSerial", paramMap.get("tid")); 
			dbparams.put("paymentRouterType", "VAN");
			dbparams.put("paymentRouterName", paramMap.get("v"));
			HashMap<String, Object> affiliateCommand = mobileMemberDao.selectAffiliateCommand(dbparams);
			dataMap.put("recommender", affiliateCommand.get("memberEmail"));
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	/* 
	 * KICC 전용 영수증 적립 큐알 뷰 서비스 
	 */
	@Override
	public boolean kiccQrImgView(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) {
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		String decode64Qr = null;

		try {
			decode64Qr = BASE64Util.decodeString(p.getStr("qr_data"));
			
			URL url = new URL(decode64Qr);
			String queryParmStr = url.getQuery();
			
		/*	System.out.println("-------------------------------kiccQrImgView - KICC QR 데이타--------------------------------------");
			System.out.println(decode64Qr);
			System.out.println(queryParmStr);
			System.out.println("----------------------------------------------------------------------------------------------------------");*/

			
			HashMap<String, String> qrParsemap = QRManager.parseQRToMap(queryParmStr);
			if (qrParsemap == null) {
				rmap.put("qr_parsing_result", "error");
				rmap.put("qr_parsing_error_message", "유효하지 않은 QR CODE");
			} else {
				// 가맹점 정보
				dbparams.put("tid", qrParsemap.get("af_id")); // 가맹점 시리얼 넘버 조회
				ArrayList<HashMap<String, Object>> affiliateTids = mobileMemberDao.selectAffiliateTid(dbparams);
				if (affiliateTids.size() < 1) {
					rmap.put("qr_parsing_result", "error");
					rmap.put("qr_parsing_error_message", "유효하지 않은 QR CODE  </br>존재하지 않는 가맹점 코드[" +qrParsemap.get("af_id")  +  "]");
					return true;
				}
				dbparams.clear();
				
				// 가맹점 조회
				dbparams.put("affiliateNo", affiliateTids.get(0).get("affiliateNo"));
				dbparams.put("affiliateSerial", qrParsemap.get("af_id"));
				dbparams.put("paymentRouterType", qrParsemap.get("paymentRouterType"));
				dbparams.put("paymentRouterName", qrParsemap.get("paymentRouterName"));
				HashMap<String, Object> affiliateInfo = mobileMemberDao.selectAffiliateCommand(dbparams);
				
				if (affiliateInfo == null) {
					rmap.put("qr_parsing_result", "error");
					rmap.put("qr_parsing_error_message", "유효하지 않은 QR CODE  </br>유효하지 않은 가맹점[" +qrParsemap.get("af_id")  +  "]");
				} else {
					HashMap<String, String> queryMap = Util.queryToMap(queryParmStr);
					rmap.put("paymentRouterType", qrParsemap.get("paymentRouterType"));
					rmap.put("paymentRouterName", qrParsemap.get("paymentRouterName"));
					
					rmap.put("qr_parsing_result", "success");
					rmap.put("qr_org", p.getStr("qr_data"));
					
					//rmap.put("qr_pay_type_str", p.getStr("pay_type").equals("1") ? "신용카드 결제" : "현금 결제");
					rmap.put("qrAccessUrl", QRManager.genQRCode(request.getSession().getServletContext().getRealPath("/qr_temp"), "/qr_temp", decode64Qr, null));
					Util.copyRPmapToMap(rmap, qrParsemap);
					rmap.put("affiliateName", affiliateInfo.get("affiliateName"));

					float amountAccumulated = Float.parseFloat(qrParsemap.get("pam")); // 가맹점 시리얼 넘버 조회
					HashMap<String, Object> policy = mobileMemberDao.selectPolicyPointTranslimit(dbparams);

					float customerComm = (float) policy.get("customerComm");
					float qramountAcc = (amountAccumulated * customerComm);
					rmap.put("qramountAcc", qramountAcc);
					
					/*밴사 상태 조회 */
					HashMap<String, Object> dbparams2 = new HashMap<String, Object>();
					dbparams2.put("paymentRouterType", "VAN");
					dbparams2.put("paymentRouterName", "KICC");
					HashMap<String, Object> routerMap = mobileMemberDao.selectPaymentRouter(dbparams2);
					rmap.put("routerMap", routerMap);
					
					/* 기존 적립 키 정보 삭제 */
					String accKeyName = (String)request.getSession().getAttribute("accKeyName");
					if (accKeyName != null) {
						request.getSession().removeAttribute(accKeyName);
						request.getSession().removeAttribute(accKeyName+ "_type");
						request.getSession().removeAttribute(accKeyName+ "_router");
						request.getSession().removeAttribute(accKeyName+ "_time");
					}

					/* 포인트 적립을 위한 적립 유효성 코드를 세션에 저장 */
					accKeyName = CodeGenerator.createTempKey(15);
					request.getSession().setAttribute("accKeyName" ,accKeyName);
					request.getSession().setAttribute(accKeyName + "_type" ,"qrcode");
					request.getSession().setAttribute(accKeyName + "_router" ,qrParsemap.get("paymentRouterName"));
					request.getSession().setAttribute(accKeyName + "_time" ,new Date());
				}
			}
		
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	/* 
	 * KICC 외의 일반 영수증 적립 큐알 뷰 서비스 
	 */
	@Override
	public boolean commonQrImgView(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		String decode64Qr = null;

		try {
			decode64Qr = BASE64Util.decodeString(p.getStr("qr_data"));
			URL url = new URL(decode64Qr);
			String queryParmStr = url.getQuery();
			HashMap<String, String> qrParsemap = QRManager.parseCommonQRToMap(queryParmStr);

			if (qrParsemap == null) {
				rmap.put("qr_parsing_result", "error");
				rmap.put("qr_parsing_error_message", "유효하지 않은 QR CODE");
			} else {
				// 가맹점 정보
				dbparams.put("tid", qrParsemap.get("af_id")); // 가맹점 시리얼 넘버 조회
				ArrayList<HashMap<String, Object>> affiliateTids = mobileMemberDao.selectAffiliateTid(dbparams);
				if (affiliateTids.size() < 1) {
					rmap.put("qr_parsing_result", "error");
					rmap.put("qr_parsing_error_message", "유효하지 않은 QR CODE  </br>존재하지 않는 가맹점 코드[" +qrParsemap.get("af_id")  +  "]");
					return true;
				}
				dbparams.clear();
				
				// 가맹점 조회
				dbparams.put("affiliateNo", affiliateTids.get(0).get("affiliateNo"));
				dbparams.put("affiliateSerial", qrParsemap.get("af_id"));
				dbparams.put("paymentRouterType", qrParsemap.get("paymentRouterType"));
				dbparams.put("paymentRouterName", qrParsemap.get("paymentRouterName"));
				
				HashMap<String, Object> affiliateInfo = mobileMemberDao.selectAffiliateCommand(dbparams);

				if (affiliateInfo == null) {
					rmap.put("qr_parsing_result", "error");
					rmap.put("qr_parsing_error_message", "유효하지 않은 QR CODE  </br>유효하지 않은 가맹점[" +qrParsemap.get("af_id")  +  "]");
				} else {
					
					HashMap<String, String> queryMap = Util.queryToMap(queryParmStr);
					rmap.put("paymentRouterType", qrParsemap.get("paymentRouterType"));
					rmap.put("paymentRouterName", qrParsemap.get("paymentRouterName"));
					rmap.put("seq", qrParsemap.get("seq"));  // 포스별 고유 번호 
					
					rmap.put("qr_parsing_result", "success");
					rmap.put("qr_org", p.getStr("qr_data"));
					//rmap.put("qr_pay_type_str", p.getStr("pay_type").equals("1") ? "신용카드 결제" : "현금 결제");
					rmap.put("qrAccessUrl", QRManager.genQRCode(request.getSession().getServletContext().getRealPath("/qr_temp"), "/qr_temp", decode64Qr, null));
					Util.copyRPmapToMap(rmap, qrParsemap);
					rmap.put("affiliateName", affiliateInfo.get("affiliateName"));

					float amountAccumulated = Float.parseFloat(qrParsemap.get("pam")); // 
					//System.out.println("amountAccumulated::" + amountAccumulated);
					HashMap<String, Object> policy = mobileMemberDao.selectPolicyPointTranslimit(dbparams);
					float customerComm = (float) policy.get("customerComm");
					//System.out.println("customerComm::" + customerComm);
					float qramountAcc = (amountAccumulated * customerComm);
					rmap.put("qramountAcc", qramountAcc);
					
					/*밴사 상태 조회 */
					HashMap<String, Object> dbparams2 = new HashMap<String, Object>();
					dbparams2.put("paymentRouterType", "VAN");
					dbparams2.put("paymentRouterName", qrParsemap.get("paymentRouterName"));
					HashMap<String, Object> routerMap = mobileMemberDao.selectPaymentRouter(dbparams2);
					/*System.out.println("Router Status " + routerMap.get("status"));*/
					rmap.put("routerMap", routerMap);
					
					/* 기존 적립 키 정보 삭제 */
					String accKeyName = (String)request.getSession().getAttribute("accKeyName");
					if (accKeyName != null) {
						request.getSession().removeAttribute(accKeyName);
						request.getSession().removeAttribute(accKeyName+ "_type");
						request.getSession().removeAttribute(accKeyName+ "_router");
						request.getSession().removeAttribute(accKeyName+ "_time");
					}

					/* 포인트 적립을 위한 적립 유효성 코드를 세션에 저장 */
					accKeyName = CodeGenerator.createTempKey(15);
					request.getSession().setAttribute("accKeyName" ,accKeyName);
					request.getSession().setAttribute(accKeyName + "_type" ,"qrcode");
					request.getSession().setAttribute(accKeyName + "_router" ,qrParsemap.get("paymentRouterName"));
					request.getSession().setAttribute(accKeyName + "_time" ,new Date());
				}
			}
			

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	/* 
	 * 상품권 QR 코드  뷰 서비스 
	 */
	@Override
	public boolean giftCardQrImgView(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) {
		//System.out.println(">>>>>> giftCardQrImgView");
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);
		
		JSONParser jsonParser;
		JSONObject qrJson;
		String qr_cmd;
		try {
			jsonParser = new JSONParser();
			qrJson = (JSONObject) jsonParser.parse(BASE64Util.decodeString(p.getStr("qr_data")));
			
			dbparams.put("pinNumber",(String) qrJson.get("pinNumber"));
			HashMap<String, Object> issueMap = this.mobileMemberDao.selectGiftCardIssue(dbparams);
			if (issueMap == null) {
				rmap.put("result", "201");
				rmap.put("messageKey" , "label.wrong_pinnumber");
				return true;
			}
			
			qr_cmd = (String) qrJson.get("qr_cmd");
			
			String giftCardStatus = null;
			switch((String)issueMap.get("giftCardStatus")) {
			case "1":giftCardStatus = messageSource.getMessage("label.normal", null, LocaleContextHolder.getLocale()); break;
			case "2":giftCardStatus = messageSource.getMessage("label.stop_using", null, LocaleContextHolder.getLocale()); break;
			case "3":giftCardStatus = messageSource.getMessage("label.accumulatable", null, LocaleContextHolder.getLocale()); break;
			case "4":giftCardStatus = messageSource.getMessage("label.unpayable", null, LocaleContextHolder.getLocale()); break;
			}
			rmap.put("giftCardStatus", giftCardStatus);
			
			String payableStatus = null;
			switch((String)issueMap.get("payableStatus")) {
			case "Y": payableStatus =  messageSource.getMessage("label.payable", null, LocaleContextHolder.getLocale()); break;
			case "N": payableStatus =  messageSource.getMessage("label.unpayable_processed", null, LocaleContextHolder.getLocale()) ; break;
			}
			rmap.put("payableStatus", payableStatus);
			
			String accableStatus = null;
			switch((String)issueMap.get("accableStatus")) {
			case "Y":accableStatus =  messageSource.getMessage("label.accumulatable", null, LocaleContextHolder.getLocale()); break;
			case "N":accableStatus =  messageSource.getMessage("label.unaccumulatable_processed", null, LocaleContextHolder.getLocale()); break;
			}
			rmap.put("accableStatus", accableStatus);
			
			switch(qr_cmd ){
			/* 상품권 큐알에 의한 적립*/
			case QRManager.QRCmd.ACC_BY_GIFTCARD:
				System.out.println("상품권 큐알 스캔에 의한 적립 처리");
				rmap.put("qr_cmd", "900");
				rmap.put("result", "100");
				rmap.put("title", messageSource.getMessage("label.acc_by_gift_card_qr", null, LocaleContextHolder.getLocale()));
				//rmap.put("title", "상품권 적립 QR 스캔");
				rmap.put("issueMap",issueMap);
				rmap.put("giftCardQrData", p.getStr("qr_data"));
				rmap.put("qrAccessUrl", QRManager.genQRCode(
					request.getSession().getServletContext().getRealPath("/gift_temp_qr"),"/gift_temp_qr", p.getStr("qr_data"), null));
				break;
			/*상품권 QR에 의한 결제 처리*/
			case QRManager.QRCmd.PAY_BY_GIFTCARD:
				rmap.put("qr_cmd", "901");
				System.out.println("상품권 결제 큐알 스캔에 의한 결제 처리");
				rmap.put("result", "100");
				rmap.put("title", messageSource.getMessage("label.pay_by_gift_card_qr", null, LocaleContextHolder.getLocale()));
				//rmap.put("title", "상품권 결제 QR 스캔");
				rmap.put("issueMap",issueMap);
				rmap.put("giftCardQrData", p.getStr("qr_data"));
				rmap.put("qrAccessUrl", QRManager.genQRCode(
						request.getSession().getServletContext().getRealPath("/gift_temp_qr"),"/gift_temp_qr", p.getStr("qr_data"), null));
				break;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	/*
	 * KICC 전용 포맷 QR 적립 요청
	 * */
	@Override
	public String kiccQrAccProxy(HashMap<String, String> p, ModelMap rmap, HttpServletRequest request,	HttpServletResponse response) throws Exception {
		
		/*세션 여부 조회*/
		SessionManager sm = new SessionManager(request, response);
		Gson gson = new Gson();
		if (sm == null || sm.getMemberEmail() == null || sm.getMemberEmail().trim().equals("")) {
			JsonObject object = new JsonObject();
			object.addProperty("responseCode", "1000");
			object.addProperty("resultCode", "9081");
			object.addProperty("message", "잘못된 </br> 해당 요청에 대한 세션이 없습니다.");
			return gson.toJson(object);
		}
		
		/* refer 검사 */
	/*	String referer = request.getHeader("referer");
		if (referer == null || referer.trim().length() == 0 || !referer.trim().contains("/m/qr/kiccQrAcc.do")) {
			JsonObject object = new JsonObject();
			object.addProperty("responseCode", "1000");
			object.addProperty("resultCode", "9091");
			object.addProperty("message", "잘못된 직접 요청</br> 직접적인 적립 요청입니다.");
			return gson.toJson(object);
		}*/
		
		/* 적립 요청에 대한 유효성 검사 - 적립 세션 키 검사 */
		String accKeyName = (String)request.getSession().getAttribute("accKeyName");
		String type =(String) request.getSession().getAttribute(accKeyName+ "_type");
        String router = (String)request.getSession().getAttribute(accKeyName + "_router");
        Date time = (Date)request.getSession().getAttribute(accKeyName+ "_time");
		
        if (accKeyName == null || type == null || router == null ||  time == null ) {
			JsonObject object = new JsonObject();
			object.addProperty("responseCode", "1000");
			object.addProperty("resultCode", "9094");
			object.addProperty("message", "유효하지 않은 적립 요청</br> 적립을 위한 적립 코드 대한 정보가 유효하지 않습니다");
			return gson.toJson(object);
		}
		
		String runMode = environment.getProperty("run_mode");
		String remoteCallURL = environment.getProperty(runMode + ".qr_accumulate_point");
		String key = environment.getProperty("key");
		StringBuffer response2 = null;
		
		try {
			p.put("key", key.split(",")[0]);
			URL url = new URL(remoteCallURL + "?" + Util.mapToQueryParam(p));
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setDoInput(true);
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			con.setRequestMethod("GET");
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
				System.out.println("응답");
				System.out.println(response2.toString());
				
				/* 기존 적립 키 정보 삭제 */
				request.getSession().removeAttribute(accKeyName);
				request.getSession().removeAttribute(accKeyName+ "_type");
				request.getSession().removeAttribute(accKeyName+ "_router");
				request.getSession().removeAttribute(accKeyName+ "_time");
			} else {
				System.out.println("포인트 백 적립 요청 에러");
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return response2.toString();
	}


	/*
	 * KICC 외의 다른 일반 QR 적립 요청
	 * */
	@Override
	public String commonQrAccProxy(HashMap<String, String> p, ModelMap rmap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		/*세션 여부 조회*/
		SessionManager sm = new SessionManager(request, response);
		Gson gson = new Gson();
		if (sm == null || sm.getMemberEmail() == null || sm.getMemberEmail().trim().equals("")) {
			JsonObject object = new JsonObject();
			object.addProperty("responseCode", "1000");
			object.addProperty("resultCode", "9081");
			object.addProperty("message", "잘못된 직접 요청</br>해당 요청에 대한 세션이 없습니다.");
			return gson.toJson(object);
		}
		
		/* refer 검사 */
/*		String referer = request.getHeader("referer");
		if (referer == null || referer.trim().length() == 0 || !referer.trim().contains("/m/qr/commonQrAcc.do")) {
			JsonObject object = new JsonObject();
			object.addProperty("responseCode", "1000");
			object.addProperty("resultCode", "9082");
			object.addProperty("message", "잘못된 직접 요청</br> 직접적인 적립 요청입니다.");
			return gson.toJson(object);
		}*/
		
		/* 적립 요청에 대한 유효성 검사 - 적립 세션 키 검사 */
		String accKeyName = (String)request.getSession().getAttribute("accKeyName");
		String type =(String) request.getSession().getAttribute(accKeyName+ "_type");
        String router = (String)request.getSession().getAttribute(accKeyName + "_router");
        Date time = (Date)request.getSession().getAttribute(accKeyName+ "_time");
		
        if (accKeyName == null || type == null || router == null ||  time == null ) {
			JsonObject object = new JsonObject();
			object.addProperty("responseCode", "1000");
			object.addProperty("resultCode", "9087");
			object.addProperty("message", "유효하지 않은 적립 요청</br> 적립을 위한 적립 코드 대한 정보가 유효하지 않습니다.");
			return gson.toJson(object);
		}

		String runMode = environment.getProperty("run_mode");
		String remoteCallURL = environment.getProperty(runMode + ".qr_accumulate_point");
		String key = environment.getProperty("key");
		StringBuffer response2 = null;
		
		try {
			p.put("key", key.split(",")[0]);
			URL url = new URL(remoteCallURL + "?" + Util.mapToQueryParam(p));
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setDoInput(true);
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			con.setRequestMethod("GET");
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
				
				/* 기존 적립 키 정보 삭제 */
				request.getSession().removeAttribute(accKeyName);
				request.getSession().removeAttribute(accKeyName+ "_type");
				request.getSession().removeAttribute(accKeyName+ "_router");
				request.getSession().removeAttribute(accKeyName+ "_time");
			} else {
				System.out.println("포인트 백 적립 요청 에러");
			}
			//System.out.println("포인트 백 적립 요청");
			//System.out.println(remoteCallURL + "?" + Util.mapToQueryParam(p));
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		System.out.println("적립 요청 결과");
		System.out.println(response2.toString());
		return response2.toString();
	}
	
	@SuppressWarnings("unused")
	@Override
	public boolean getBoardList(RPMap rPap, RPMap rmap, HttpServletRequest request, HttpServletResponse response) {
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);
		try {
			dbparams.put("bbsType1", rPap.getStr("bbsType1"));
			
			if (rPap.containsKey("bbsType2") && !rPap.getStr("bbsType2").equals("0")) {
				dbparams.put("bbsType2", rPap.getStr("bbsType2"));
				rmap.put("bbsType2", rPap.getStr("bbsType2"));
			}
			
			if (rPap.getStr("bbsType1").equals("4")) {
				if (sm != null) {
					if (sm.getMemberEmail() != null) {
						dbparams.put("writerNo", sm.getMemberNo());
						dbparams.put("rerv6", sm.getMemberEmail().trim());
					}else {
						rmap.put(Const.D_SCRIPT, Util.jsmsgLink("잘못된 경로입니다", "/m/member/login.do", "T"));
						return false;
					}
				}else {
					rmap.put(Const.D_SCRIPT, Util.jsmsgLink("잘못된 경로입니다", "/m/member/login.do", "T"));
					return false;
				}
			}
			ArrayList<HashMap<String, Object>> boardList = this.mobileMainDao.selectBoards(dbparams);
			rmap.put("boardList", boardList);
			rmap.put("bbsType1", rPap.getStr("bbsType1"));
			
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return true;
	}
	
	@Override
	public boolean getBoardReply(RPMap rPap, RPMap rmap, HttpServletRequest request, HttpServletResponse response) {
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);
		try {
			dbparams.put("mainBbsNo", rPap.getStr("mainBbsNo"));
			dbparams.put("status", "1");
			ArrayList<HashMap<String, Object>> mainBbs = this.mobileMainDao.selectBoards(dbparams);
			rmap.put("mainBbs", mainBbs.get(0));

			if (rPap.containsKey("dType") && rPap.getStr("dType").equals("mainBbs")) {
				rmap.put("detailTargetBbs", mainBbs.get(0));
			}else {
				HashMap<String, Object> subBbs = this.mobileMainDao.selectSubBbs(dbparams);
				rmap.put("subBbs", subBbs);
				rmap.put("detailTargetBbs", subBbs);
			}
			
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return true;
	}
	@Override
	public HashMap<String, Object> getFooter(RPMap rmap) throws Exception {

		RPMap dbparams = new RPMap();
		HashMap<String, Object> map = new HashMap<String, Object>();
		String langLocale = rmap.getStr("langLocale");
		dbparams.put("langLocale", langLocale);
		HashMap<String, Object> company = mobileMainDao.selectCompanyInfo(dbparams);
		map.put("company", company);

		return map;
	}

	@Override
	public HashMap<String, Object> getServerManageStatus() throws Exception {

		HashMap<String, Object> map = new HashMap<String, Object>();
		RPMap dbparams = new RPMap();
		HashMap<String, Object> servermanagestatus = mobileMainDao.selectServerManageStatusInfo(dbparams);
		map.put("status", servermanagestatus);

		return map;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Throwable.class })
	public boolean paymentPointbackRecordDetail(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception {

		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);
		dbparams.put("memberNo", sm.getMemberNo());

		try {

			dbparams.put("nodeType", p.getStr("nodeType"));

			String move = p.getStr("move");
			Date d = new Date();
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat dfDiff = new SimpleDateFormat("yyyy-MM");
			String serverDate = df.format(d);
			String serverDateDiff = dfDiff.format(d);
			if(move == null || "".equals(move)) {
				dbparams.put("TIME", serverDate); //현재년월일
				dbparams.put("SEARCHTIME", serverDateDiff); //현재년월
			}else{
				dbparams.put("TIME", move+"-01"); //현재선택한 년월일
				dbparams.put("SEARCHTIME", move); //현재년월
			}
			HashMap<String,Object> serverYearMonth = mobileMemberDao.selectYearMonth(dbparams);
			String PREWMONTH = (String) serverYearMonth.get("PREWMONTH");
			String NOWMONTH = (String) serverYearMonth.get("NOWMONTH");
			String NEXTMONTH = (String) serverYearMonth.get("NEXTMONTH");

			ArrayList<HashMap<String, Object>> paymentPointbackRecordDetailList = mobileMainDao.selectPaymentPointbackRecordDetailList(dbparams);
			JSONObject json = new JSONObject();
			if (paymentPointbackRecordDetailList.size() != '0') {
				JSONArray json_arr = new JSONArray();
				JSONObject obj = new JSONObject();
				for (int i = 0; i < paymentPointbackRecordDetailList.size(); i++) {
					obj.put("paymentPointbackRecordDetailList", paymentPointbackRecordDetailList);
					json_arr.add(obj);
				}
				json.put("result", 1);
				json.put("json_arr", json_arr);
				json.put("PREWMONTH", PREWMONTH);
				json.put("NOWMONTH", NOWMONTH);
				json.put("NEXTMONTH", NEXTMONTH);
				json.put("serverDateDiff", serverDateDiff);
				rmap.put(Const.D_JSON, json.toString());
			} // else {
				// json = Util.printResult(0, String.format("잠시후 진행 하시길 바랍니다."), null);
				// rmap.put("json", json);
				// }
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return true;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Throwable.class })
	public boolean pointConversionTransactionDetail(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception {

		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);
		dbparams.put("memberNo", sm.getMemberNo());

		try {
			dbparams.put("nodeType", p.getStr("nodeType"));
			String move = p.getStr("move");
			Date d = new Date();
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat dfDiff = new SimpleDateFormat("yyyy-MM");
			String serverDate = df.format(d);
			String serverDateDiff = dfDiff.format(d);
			if(move == null || "".equals(move)) {
				dbparams.put("TIME", serverDate); //현재년월일
				dbparams.put("SEARCHTIME", serverDateDiff); //현재년월
			}else{
				dbparams.put("TIME", move+"-01"); //현재선택한 년월일
				dbparams.put("SEARCHTIME", move); //현재년월
			}
			HashMap<String,Object> serverYearMonth = mobileMemberDao.selectYearMonth(dbparams);
			String PREWMONTH = (String) serverYearMonth.get("PREWMONTH");
			String NOWMONTH = (String) serverYearMonth.get("NOWMONTH");
			String NEXTMONTH = (String) serverYearMonth.get("NEXTMONTH");

			ArrayList<HashMap<String, Object>> pointConversionTransactionDetailList = mobileMainDao.selectPointConversionTransactionDetailList(dbparams);
			JSONObject json = new JSONObject();
			if (pointConversionTransactionDetailList.size() != '0') {
				JSONArray json_arr = new JSONArray();
				JSONObject obj = new JSONObject();
				for (int i = 0; i < pointConversionTransactionDetailList.size(); i++) {
					obj.put("pointConversionTransactionDetailList", pointConversionTransactionDetailList);
					json_arr.add(obj);
				}
				json.put("result", 1);
				json.put("json_arr", json_arr);
				json.put("PREWMONTH", PREWMONTH);
				json.put("NOWMONTH", NOWMONTH);
				json.put("NEXTMONTH", NEXTMONTH);
				json.put("serverDateDiff", serverDateDiff);
				rmap.put(Const.D_JSON, json.toString());
			} // else {
				// json = Util.printResult(0, String.format("잠시후 진행 하시길 바랍니다."), null);
				// rmap.put("json", json);
				// }
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return true;
	}


	@Override
	public boolean faq(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception {

		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);

		// 추후 다국어 alert 요청시 아래의 것 활용하세요.(18.07.11)
		String message = messageSource.getMessage("messages.greeting", null, LocaleContextHolder.getLocale());

		try {
			if(p.getInt("code") < 1) {
				dbparams.put("CODE", 1);
			}else{
				dbparams.put("CODE", p.getInt("code"));
			}
			ArrayList<HashMap<String, Object>> faqList = mobileMainDao.selectFaqList(dbparams);
			HashMap<String, Object> faqTotalCnt = mobileMainDao.faqTotalCnt(dbparams);
			rmap.put("faqList", faqList);
			rmap.put("faqTotalCnt", faqTotalCnt);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public boolean notice(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception {

		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);

		// 추후 다국어 alert 요청시 아래의 것 활용하세요.(18.07.11)
		String message = messageSource.getMessage("messages.greeting", null, LocaleContextHolder.getLocale());

		try {
			ArrayList<HashMap<String, Object>> noticeList = mobileMainDao.selectNoticeList(dbparams);
			HashMap<String, Object> noticeTotalCnt = mobileMainDao.noticeTotalCnt(dbparams);
			rmap.put("noticeList", noticeList);
			rmap.put("noticeTotalCnt", noticeTotalCnt);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Throwable.class })
	public boolean rpmapLoadAct(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception {

		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		dbparams.put("curLat", p.get("curLat"));
		dbparams.put("curLng", p.get("curLng"));
		dbparams.put("distance", p.get("distance"));

		try {

			ArrayList<HashMap<String, Object>> rpmapLoadList = mobileMainDao.selectRpmapLoadList(dbparams);
			rmap.put("json", rpmapLoadList);

			return true;
		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return true;
	}

	
	@Override
	public boolean viewAffiliateDetail(RPMap paramMap, RPMap rmap, HttpServletRequest request,
			HttpServletResponse response) {
		SessionManager sm = new SessionManager(request, response);
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		
		try {
			dbparams.put("affiliateNo", paramMap.getInt("affiliateNo"));
			HashMap<String, Object> affiliateMap = this.mobileMainDao.selectAffiliate(dbparams);
			rmap.put("affiliate", affiliateMap);
			
			HashMap<String, Object> affiliateDetailMap = this.mobileMainDao.selectAffiliateDetail(dbparams);
			rmap.put("affiliateDetail", affiliateDetailMap);
			
			dbparams.clear();
			dbparams.put("memberNo", affiliateMap.get("memberNo"));
			rmap.put("memberAddress", this.mobileMainDao.selectMemberAddress(dbparams));
			rmap.put("affiliateMember", this.mobileMainDao.selectMember(dbparams));

			/*	ArrayList<String> affiliateMainImages = new ArrayList<String>();
			affiliateMainImages.add((String)affiliateDetail.get("affiliateMainImage1") );
			affiliateMainImages.add((String)affiliateDetail.get("affiliateMainImage2") );
			affiliateMainImages.add((String)affiliateDetail.get("affiliateMainImage3") );
			affiliateMainImages.add((String)affiliateDetail.get("affiliateMainImage4") );
			rmap.put("affiliateMainImages", affiliateMainImages);*/
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Throwable.class })
	public boolean faqMoreAct(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception {

		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);

		try {
			dbparams.put("faqcount", p.getInt("faqcount"));
			dbparams.put("morecount", p.getInt("morecount"));
			int morecount =  p.getInt("morecount") + 1;

			if(p.getInt("code") < 1) {
				dbparams.put("CODE", 1);
			}else{
				dbparams.put("CODE", p.getInt("code"));
			}

			ArrayList<HashMap<String, Object>> faqMoreList = mobileMainDao.selectFaqMoreList(dbparams);
			JSONObject json = new JSONObject();
			if (faqMoreList.size() != '0') {
				JSONArray json_arr = new JSONArray();
				JSONObject obj = new JSONObject();
				for (int i = 0; i < faqMoreList.size(); i++) {
					obj.put("faqMoreList", faqMoreList);
					json_arr.add(obj);
				}
				json.put("result", 1);
				json.put("morecount", morecount);
				json.put("faqMoreListSize", faqMoreList.size() + 1);
				json.put("json_arr", json_arr);
				rmap.put(Const.D_JSON, json.toString());
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return true;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Throwable.class })
	public boolean noticeMoreAct(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response)	throws Exception {
		HashMap<String, Object> dbparams = new HashMap<String, Object>();

		try {
			dbparams.put("noticecount", p.getInt("noticecount"));
			dbparams.put("morecount", p.getInt("morecount"));
			int morecount =  p.getInt("morecount") + 1;
			ArrayList<HashMap<String, Object>> noticeMoreList = mobileMainDao.selectNoticeMoreList(dbparams);
			JSONObject json = new JSONObject();
			if (noticeMoreList.size() != '0') {
				JSONArray json_arr = new JSONArray();
				JSONObject obj = new JSONObject();
				for (int i = 0; i < noticeMoreList.size(); i++) {
					obj.put("noticeMoreList", noticeMoreList);
					json_arr.add(obj);
				}
				json.put("result", 1);
				json.put("morecount", morecount);
				json.put("noticeMoreListSize", noticeMoreList.size() + 1);
				json.put("json_arr", json_arr);
				rmap.put(Const.D_JSON, json.toString());
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return true;
	}


	@Override
	public boolean myinfo(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception{

		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);
		dbparams.put("memberNo", sm.getMemberNo());
		try{
			HashMap<String,Object> myinfo = mobileMemberDao.selectMypageMyinfo(dbparams);
			if( myinfo == null ) {
				rmap.put(Const.D_SCRIPT, Util.jsmsgLink("잘못된 경로입니다.", "/main/index.do?alertView=t&Message=1", "T"));
				return false;
			}
			rmap.put("myinfo", myinfo);

		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public boolean qna(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception {

		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);
		String message = messageSource.getMessage("messages.greeting", null, LocaleContextHolder.getLocale());

		try {
			/*if(p.getInt("code") < 1) {
				dbparams.put("CODE", 1);
			}else{
				dbparams.put("CODE", p.getInt("code"));
			}*/
			dbparams.put("memberNo", sm.getMemberNo());

			ArrayList<HashMap<String, Object>> qnaList = mobileMainDao.selectQnaList(dbparams);
			HashMap<String, Object> qnaTotalCnt = mobileMainDao.qnaTotalCnt(dbparams);
			rmap.put("qnaList", qnaList);
			rmap.put("qnaTotalCnt", qnaTotalCnt);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}


	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
	public boolean saveQnaWAct(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception{
		RPMap dbparams = new RPMap();
		SessionManager sm = new SessionManager(request, response);

		try{

			dbparams.put("memberNo", sm.getMemberNo());
			dbparams.put("memberEmail", sm.getMemberEmail());
			dbparams.put("memberName", sm.getMemberName());
			dbparams.put("boardCate"		,p.getInt("boardCate"));
			//코드 테이블에서 정리해서 값을 가져오려고 했으나 09.14일 기준으로 값이 미존재하여 아래와 같이 처리함
			if(p.getInt("boardCate") == 1) {
				dbparams.put("boardName"	,"일반회원");
			}else if(p.getInt("boardCate") == 2) {
				dbparams.put("boardName"	,"회원정보");
			}else if(p.getInt("boardCate") == 3) {
				dbparams.put("boardName"	,"포인트");
			}else{
				dbparams.put("boardName"	,"기타");
			}
			dbparams.put("boardWriterName"	,p.getStr("boardWriterName").trim());
			dbparams.put("boardTitle"		,p.getStr("boardTitle").trim());
			dbparams.put("boardContent"		,p.getStr("boardContent").trim());
			mobileMemberDao.insertQnaWAct(dbparams);

		    rmap.put(Const.D_SCRIPT, Util.gotoURL("/m/board/qna.do" , ""));
		}catch(Exception e){
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return true;
	}

	@Override
	public boolean qnaNode(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception {

		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);
		String message = messageSource.getMessage("messages.greeting", null, LocaleContextHolder.getLocale());

		try {
			dbparams.put("memberNo", sm.getMemberNo());
			ArrayList<HashMap<String, Object>> qnaNodeList = mobileMainDao.selectQnaNodeList(dbparams);
			HashMap<String, Object> qnaNodeTotalCnt = mobileMainDao.qnaNodeTotalCnt(dbparams);

			rmap.put("qnaNodeList", qnaNodeList);
			rmap.put("qnaNodeTotalCnt", qnaNodeTotalCnt);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
	public boolean saveQnaNodeWAct(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception{
		RPMap dbparams = new RPMap();
		SessionManager sm = new SessionManager(request, response);

		try{

			dbparams.put("memberNo", sm.getMemberNo());
			dbparams.put("memberEmail", sm.getMemberEmail());
			dbparams.put("memberName", sm.getMemberName());
			dbparams.put("boardCate" ,p.getInt("boardCate"));
			//코드 테이블에서 정리해서 값을 가져오려고 했으나 09.26일 기준으로 값이 미존재하여 아래와 같이 처리함
			if(p.getInt("boardCate") == 1) {
				dbparams.put("boardName"	,"일반회원");
			}else if(p.getInt("boardCate") == 2) {
				dbparams.put("boardName"	,"정회원");
			}else if(p.getInt("boardCate") == 3) {
				dbparams.put("boardName"	,"지사");
			}else if(p.getInt("boardCate") == 4){
				dbparams.put("boardName"	,"대리점");
			}else if(p.getInt("boardCate") == 5){
				dbparams.put("boardName"	,"협력업체");
			}else if(p.getInt("boardCate") == 6){
				dbparams.put("boardName"	,"영업관리자");
			}else{
				dbparams.put("boardName"	,"총판");
			}


			//dbparams.put("boardWriterName"	,p.getStr("boardWriterName").trim());
			dbparams.put("boardTitle"		,p.getStr("boardTitle").trim());
			dbparams.put("boardContent"		,p.getStr("boardContent").trim());

			dbparams.put("rerv1"			,p.getStr("rerv1").trim());
			dbparams.put("rerv2"			,p.getStr("rerv2").trim());
			dbparams.put("rerv3"			,p.getStr("rerv3").trim());
			dbparams.put("rerv4"			,p.getStr("rerv4").trim());
			dbparams.put("rerv5"			,p.getStr("rerv5").trim());
			dbparams.put("rerv6"			,p.getStr("rerv6").trim());
			//dbparams.put("rerv7"			,p.getStr("rerv7").trim());
			mobileMemberDao.insertQnaNodeWAct(dbparams);
		    rmap.put(Const.D_SCRIPT, Util.gotoURL("/m/board/qna_node.do" , ""));
		}catch(Exception e){
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return true;
	}

	/*포인트 적립 세부 정보 */
	@Override
	public boolean pointDetailAccInfo(RPMap p, RPMap rmap, HttpServletRequest request,
			HttpServletResponse response) {
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);

		try {
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public boolean showPointCouponInfo(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) {
		SessionManager sm = new SessionManager(request, response);
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		try {
			if(sm.getMemberEmail() == null ) {
                rmap.put(Const.D_SCRIPT, Util.jsmsgLink("잘못된 경로입니다.", "/m/member/login.do", "T"));
                return false;
            }
			dbparams.put("couponNumber", p.getStr("couponNumber"));
			HashMap<String, Object> pointCoupon = this.mobileMainDao.selectPointCoupon(dbparams);
			
			if (pointCoupon == null) {
				 rmap.put("result", "error");
                 rmap.put("message", "등록 되지 않는 적립 코드 ");
                 return true;
			}
			switch((String)pointCoupon.get("useStatus")) {
			case "1":
				rmap.put("result", "success");
				switch((String)pointCoupon.get("couponType")) {
					case "1":
						pointCoupon.put("couponTypeStr", "영수증에 의한 포인트 적립");
					break;
				}
				rmap.put("pointCoupon", pointCoupon);
				break;
			case "2":
				 rmap.put("result", "error");
				  rmap.put("message", "사용 중지된 적립 코드 입니다");
				break;
			case "3":
				 rmap.put("result", "error");
				  rmap.put("message", "사용 완료된 적립 코드입니다");
				break;
			case "4":
				  rmap.put("message", "사용 등록이 해제된 적립 코드입니다");
				 rmap.put("result", "error");
				break;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public String accPointCoupon(HashMap<String, String> p, ModelMap map, HttpServletRequest request,
			HttpServletResponse response) {
		String runMode = environment.getProperty("run_mode");
		String remoteCallURL = environment.getProperty(runMode + ".handle_point_coupon");
		String key = environment.getProperty("key");
		StringBuffer response2 = null;
		try {
			p.put("key", key.split(",")[0]);
			URL url = new URL(remoteCallURL + "?" + Util.mapToQueryParam(p));
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setDoInput(true);
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			con.setRequestMethod("GET");
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
				//System.out.println("응답");
				System.out.println(response2.toString());
			} else {
				//System.out.println("포인트 백 적립 요청 에러");
			}
			//System.out.println("포인트 백 적립 요청");
			//System.out.println(remoteCallURL + "?" + Util.mapToQueryParam(p));
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return response2.toString();
	}

	@Override
	public boolean prepareNewAffiliateSearch(RPMap paramMap, RPMap rmap, HttpServletRequest request, HttpServletResponse response) {
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);
		try {
			dbparams.put("parentCategoryNo", 0);
			ArrayList<HashMap<String, Object>> affiliateCategories = this.mobileMemberDao.selectAffiliateCategories(dbparams);
			rmap.put("affiliateCategories", affiliateCategories);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public ArrayList<HashMap<String, Object>> findAffiliatesByCate(Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) {
		try {
			int pageSize = 500;

			paramMap.put("pagination", "1"); 
			paramMap.put("pageSize", pageSize); 
			if (!paramMap.containsKey("page")) {
				paramMap.put("offset", "0"); 
			}else {
				paramMap.put("offset",(Integer.valueOf((String)paramMap.get("page")) -1) * pageSize );
			}
			ArrayList<HashMap<String, Object>> selectedAffiliates= this.mobileMemberDao.findAffiliatesByCate(paramMap);
			return selectedAffiliates;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public boolean initPointCodeMain(RPMap paramMap, RPMap rmap, HttpServletRequest request, HttpServletResponse response) {
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);

		try {
			if(sm.getMemberEmail() == null ) {
				rmap.put(Const.D_SCRIPT, Util.jsmsgLink("잘못된 경로입니다.", "/m/member/login.do", "T"));
				return false;
			}
			dbparams.put("memberNo", sm.getMemberNo());
			HashMap<String, Object> pointCodeSummaryMap = this.mobileMemberDao.selectPointCodeSummary(dbparams);
			ArrayList<HashMap<String, Object>> receipts= this.mobileMemberDao.selectPointCodeIssueRequests(dbparams);
			
			dbparams.put("useStatus", "1");
			ArrayList<HashMap<String, Object>> useablePointCodes= this.mobileMemberDao.selectPointCodeIssuess(dbparams);
			
			dbparams.put("useStatus", "3");
			ArrayList<HashMap<String, Object>> completePointCodes= this.mobileMemberDao.selectPointCodeIssuess(dbparams);
			
			rmap.put("pointCodeSummary", pointCodeSummaryMap);
			rmap.put("receipts", receipts);
			rmap.put("useablePointCodes", useablePointCodes);
			rmap.put("completePointCodes", completePointCodes);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	
	@Override
	public boolean selectReceiptDetailInfo(RPMap rPap, RPMap rmap, HttpServletRequest request,
			HttpServletResponse response) {
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);

		try {
			if(sm.getMemberEmail() == null ) {
				rmap.put(Const.D_SCRIPT, Util.jsmsgLink("잘못된 경로입니다.", "/m/member/login.do", "T"));
				return false;
			}
			dbparams.put("memberNo", sm.getMemberNo());
			dbparams.put("pointCodeIssueRequestNo", rPap.getInt("pointCodeIssueRequestNo"));
			HashMap<String, Object> receipt = this.mobileMemberDao.selectReceipt(dbparams);
			rmap.put("receipt", receipt);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public boolean checkDepositRequest(RPMap rPap, RPMap rmap, HttpServletRequest request, HttpServletResponse response) {
		RPMap dbparams = new RPMap();
		try {
			String json = null;
			if (!rPap.containsKey("pointCodeIssueRequestNo") ||  rPap.getInt("pointCodeIssueRequestNo") == 0  || rPap.get("pointCodeIssueRequestNo") == null) {
				json = Util.printResult(1, String.format("109:잘못된 요청입니다.."), null);
				rmap.put("json", json);
				return true;
			}
			
			dbparams.put("pointCodeIssueRequestNo", Converter.toInt(rPap.getStr("pointCodeIssueRequestNo")));
			int count = mobileMemberDao.checkDepositRequest(dbparams);

			if (count == 0) {
				json = Util.printResult(1, String.format("110:잘못된 요청입니다."), null);
				rmap.put("json", json);
				return true;
			} else {
				json = Util.printResult(0, String.format("입금 확인 요청 처리가 완료되었습니다."), null);
				rmap.put("json", json);
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();

		}
		return true;
	}

	@Override
	public boolean uploadReceiptForm(RPMap rPap, RPMap rmap, HttpServletRequest request, HttpServletResponse response) {
		RPMap dbparams = new RPMap();
		SessionManager sm = new SessionManager(request, response);
		try {
			dbparams.put("memberNo", sm.getMemberNo());
			HashMap<String, Object> memberInfo= mobileMemberDao.selectMypageMyinfo(dbparams); 
			rmap.put("memberInfo", memberInfo);
			
			ArrayList<HashMap<String, Object>> affilaitesList = null;
			if (rPap.getStr("receiptType").equals("1")) {
				dbparams.clear();
				dbparams.put("order", "affiliateName ASC");
				affilaitesList = this.mobileMemberDao.selectAffiliates(dbparams);
				rmap.put("affilaitesList",affilaitesList );
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}

	@Override
	public boolean uploadReceipt(RPMap paramMap, RPMap rmap, HttpServletRequest request, HttpServletResponse response) {
		RPMap dbparams = new RPMap();
		SessionManager sm = new SessionManager(request, response);
		try {
			HashMap<String, Object> uploadMemberMap = null;
			/*point_code_issue_request */
			dbparams.put("memberNo",sm.getMemberNo());
			uploadMemberMap = this.mobileMainDao.selectMember(dbparams);
			
			dbparams.put("issueType",paramMap.get("issueType"));
			
			if (paramMap.containsKey("affiliateNo") && paramMap.getStr("affiliateNo").trim().length() > 0  && !paramMap.getStr("affiliateNo").trim().equals("") && paramMap.getStr("affiliateNo") != null) {
				dbparams.put("affiliateNo",paramMap.get("affiliateNo"));
			}
			
			dbparams.put("depositor",paramMap.getStr("depositor"));
			dbparams.put("payAmount",paramMap.getInt("payAmount"));
			dbparams.put("accPointRate",1);
			dbparams.put("accPointAmount",paramMap.getInt("payAmount"));
			dbparams.put("accTargetRange",paramMap.get("accTargetRange"));
			
			dbparams.put("depositAmount",Math.round(paramMap.getInt("payAmount") *  0.15));
			dbparams.put("depositBankAccount",paramMap.getStr("depositBankAccount"));
			dbparams.put("depositRate",0.15);
			dbparams.put("status","1");
			if (paramMap.getStr("issueType").equals("1")) {
				dbparams.put("finalDepositAmount",Math.floor((paramMap.getInt("payAmount") / 11 * 10) * 0.15));
			}else if (paramMap.getStr("issueType").equals("2")) {
				dbparams.put("finalDepositAmount",Math.floor(paramMap.getInt("payAmount") *  0.15));
			}
			dbparams.put("publisher",sm.getMemberNo());
			
			/*
			 * 비가맹점 영수증인 경우 그대로 전달된 입금자 명을 등록지만 , 가맹점 영수증일 경우 입금자명을 가맹점명:가맹점주 이름으로 세팅
			 */
			
			/* 가맹점 정보 */
			HashMap<String, Object> affiliateMap = null;
			/* 가맹점 소유주 멤버 정보  */
			HashMap<String, Object> affiliateMemberMap = null;
			
			if (paramMap.getStr("issueType").equals("1")) {
				HashMap<String, Object> param2 = new HashMap<String, Object>();
				param2.put("affiliateNo", dbparams.getInt("affiliateNo"));
				affiliateMap = this.mobileMainDao.selectAffiliate(param2);
				param2.clear();
				
				param2.put("memberNo", (int)affiliateMap.get("memberNo"));
				affiliateMemberMap = this.mobileMainDao.selectMember(param2);
				dbparams.put("depositor", (String)affiliateMap.get("affiliateName") + ":" + (String)affiliateMemberMap.get("memberName"));
			}
			
			Date date = new Date();
			String fileName = "receipt_" + sm.getMemberNo() + "_" + date.getTime() + ".png";
			String dir = request.getSession().getServletContext().getRealPath("/cloud/images/receipt/");
			dbparams.put("uploadFile","/cloud/images/receipt/"+ fileName);
			
			this.mobileMemberDao.insertPointCodeIssueRequest(dbparams);
			
			/* 
			 * 영수증 파일 저장 후 업데이트 
			 * 영수증 파일 제목은 receipt_멤버번호_요청번호로 구성함  
			 */
			
			File saveDir = new File(dir);
			if (!saveDir.exists()) {
				saveDir.mkdirs();
			}
			
			String base64EncodeImage = paramMap.getStr("receiptFile").split(",")[1].trim();
			byte[] imgBytes = Base64.getDecoder().decode(base64EncodeImage);
			String localFilePath = dir + fileName;
			BufferedOutputStream writer = new BufferedOutputStream(new FileOutputStream(localFilePath));
	        writer.write(imgBytes);
	        writer.flush();
	        writer.close();
	        
	        dbparams.put("uploadFile", "/cloud/images/receipt/" + fileName);
	        int count = this.mobileMemberDao.updatePointCodeIssueRequest(dbparams);
	      
	        /* 
	         * 가맹점 영수증일 경우 해당 가맹점에 대한 노티를 생성 
	         * (영수증을 업로드 했으니, 해당 금액을 입금해달라는 노티)
	         * */
	    	if (paramMap.getStr("issueType").equals("1")) {
	    		HashMap<String, Object> notiMap = new HashMap<String, Object>();
	    		notiMap.put("notiType", "2");
	    		notiMap.put("memberNo", affiliateMap.get("memberNo"));
	    		notiMap.put("nodeNo", affiliateMap.get("affiliateNo"));
	    		notiMap.put("nodeType", "5");
	    		notiMap.put("nodeTypeName", "affiliate");
	    		
	    		String notiTitle = String.format( "[영수증 등록됨]%s님에 의한 영수증 등록 ", uploadMemberMap.get("memberName"));
	    		notiMap.put("notiTitle", notiTitle);
	    		
	    		StringBuilder builder = new StringBuilder();
	    		
	    		builder.append(String.format( "%s님이 %s 영수증을 등록했습니다 ", uploadMemberMap.get("memberName"), affiliateMap.get("affiliateName")));
	    		builder.append(System.getProperty("line.separator"));
	    		builder.append(System.getProperty("line.separator"));
	    		
	    		builder.append(String.format( "1.결제 금액 :  %,d원", paramMap.getInt("payAmount")));
	    		builder.append(System.getProperty("line.separator"));
	    		builder.append(System.getProperty("line.separator"));

	    		builder.append(String.format( "2.최종 입금하실 금액 : %,d원", (int)Math.floor((paramMap.getInt("payAmount") / 11 * 10) * 0.15)));
	    		builder.append(System.getProperty("line.separator"));
	    		builder.append(String.format( "(결제금액에서 부가세를 제외한 금액의 15%%)"));
	    		builder.append(System.getProperty("line.separator"));
	    		builder.append(System.getProperty("line.separator"));
	    		
	    		builder.append("3.입금하실 계좌");
	            builder.append(System.getProperty("line.separator"));
	            builder.append("- 우리은행 1002-751-058576 예금주 : 안영철");
	            builder.append(System.getProperty("line.separator"));
	            builder.append(System.getProperty("line.separator"));

	            builder.append("*가맹점주님이 위 금액을 입금하시면, 영수증을 등록한 회원의 계정으로 적립코드가 등록됩니다");
	    		builder.append(System.getProperty("line.separator"));
	    		builder.append(System.getProperty("line.separator"));
	    		
	    		builder.append("*입금을 하신 후 빠른 처리를 위해서 해당 내역 페이지에서 입금확인 요청하기 버튼을 눌러주시면 더욱 빠른 처리가 가능합니다");
	    		
	    		notiMap.put("notiContent", builder.toString());

	    		String notiExt1 = String.format(
	    			"/m/pointCoupon/receiptDetail.do?pointCodeIssueRequestNo=%d&issueType=%d",
	    			(int)dbparams.get("pointCodeIssueRequestNo"),1);
	    		notiMap.put("notiExt1",  notiExt1);
	    		this.mobileMemberDao.insertMemberNoti(notiMap);
	    		
	    	}
	    	
	        String json = Util.printResult(0, String.format("영수증 업로드 처리가 완료되었습니다."), null);
			rmap.put("json", json);
			
		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return true;
	}

	@Override
	public boolean showPointCodeInfo(RPMap paramMap, RPMap rmap, HttpServletRequest request, HttpServletResponse response) {
		SessionManager sm = new SessionManager(request, response);
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		try {
			if(sm.getMemberEmail() == null ) {
                rmap.put(Const.D_SCRIPT, Util.jsmsgLink("잘못된 경로입니다.", "/m/member/login.do", "T"));
                return false;
            }
			dbparams.put("pointCode", paramMap.getStr("pointCode").trim());
			HashMap<String, Object> pointCode = this.mobileMainDao.selectPointCodeIssue(dbparams);
			
			if (pointCode == null) {
				 rmap.put("result", "error");
                 rmap.put("message", "등록 되지 않는 적립 코드 ");
			}else {
				rmap.put("result", "success");
                rmap.put("pointCode", pointCode);
                return true;
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public String accPointCode(HashMap<String, String> p, ModelMap modelMap, HttpServletRequest request,
			HttpServletResponse response) {
		String runMode = environment.getProperty("run_mode");
		String remoteCallURL = environment.getProperty(runMode + ".handle_point_code");
		String key = environment.getProperty("key");
		StringBuffer response2 = null;
		try {
			p.put("key", key.split(",")[0]);
			URL url = new URL(remoteCallURL + "?" + Util.mapToQueryParam(p));
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setDoInput(true);
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			con.setRequestMethod("GET");
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
				//System.out.println("응답");
				System.out.println(response2.toString());
			} else {
				//System.out.println("포인트 백 적립 요청 에러");
			}
			//System.out.println("포인트 백 적립 요청");
			//System.out.println(remoteCallURL + "?" + Util.mapToQueryParam(p));
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return response2.toString();
	}

	
	
	/*****************************************************************************************************************************************************************
	 * 가맹점 개인화 메인 서비스 메서드 
	 *****************************************************************************************************************************************************************/
	
	@Override
	public boolean prepareAffiliateMain(RPMap rPap, RPMap rmap, HttpServletRequest request, HttpServletResponse response) {
		RPMap dbparams = new RPMap();
		SessionManager sm = new SessionManager(request, response);
		try {
			dbparams.put("affiliateNo", rPap.getInt("affiliateNo"));
			HashMap<String, Object> affiliateMap = this.mobileMainDao.selectAffiliate(dbparams);
			HashMap<String, Object> receiptSaleSummaryMap = this.mobileMainDao.selectAffiliateReceiptSummary(dbparams);
			HashMap<String, Object> qrSaleSummaryMap = this.mobileMainDao.selectAffiliateQrSummary(dbparams);
			rmap.put("receiptSaleSummary", receiptSaleSummaryMap);
			rmap.put("qrSaleSummary", qrSaleSummaryMap);
			
			dbparams.clear();
			dbparams.put("memberNo", sm.getMemberNo());
			dbparams.put("isViewed", "N");
			ArrayList<HashMap<String, Object>>  notReadNotis  = this.mobileMemberDao.selectMemberNotis(dbparams);
			rmap.put("notReadNotis", notReadNotis);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}

	@Override
	public boolean reqeustAffiliateDeposit(RPMap rPap, RPMap rmap, HttpServletRequest request, HttpServletResponse response) {
		SessionManager sm = new SessionManager(request, response);
		HashMap<String, Object> dbParams = new HashMap<String, Object>();

		HashMap<String, Object> insertNotiMap  = new HashMap<String, Object>();
		HashMap<String, Object> affiliateMap = null;
		HashMap<String, Object> requestMemberMap = null;
		HashMap<String, Object> pointCodeIssueRequestMap = null;
		ArrayList<HashMap<String, Object>> pointCodeIssueRequestList = null;
		
		try {
			String json = null;
			if (!rPap.containsKey("pointCodeIssueRequestNo") ||  rPap.getInt("pointCodeIssueRequestNo") == 0  || rPap.get("pointCodeIssueRequestNo") == null) {
				json = Util.printResult(1, String.format("109:잘못된 요청입니다.."), null);
				rmap.put("json", json);
				return true;
			}
			
			/*요청 회원 정보 */
			dbParams.put("memberNo", sm.getMemberNo());
			requestMemberMap = this.mobileMainDao.selectMember(dbParams);
			
			/*해당 영수증 업로드 정보 */
			dbParams.clear();
			dbParams.put("pointCodeIssueRequestNo", rPap.getInt("pointCodeIssueRequestNo"));
			pointCodeIssueRequestList = this.mobileMemberDao.selectPointCodeIssueRequests(dbParams);
			
			if (pointCodeIssueRequestList.size() != 1) {
				json = Util.printResult(1, String.format("110:잘못된 요청입니다."), null);
				rmap.put("json", json);
				return true;
			}
			pointCodeIssueRequestMap = pointCodeIssueRequestList.get(0);

			/*가맹점 정보 */
			dbParams.clear();
			dbParams.put("affiliateNo", pointCodeIssueRequestMap.get("affiliateNo"));
			affiliateMap = this.mobileMemberDao.selectAffiliateInfo(dbParams);
			
			insertNotiMap.put("notiType", "2");
			insertNotiMap.put("memberNo", affiliateMap.get("memberNo"));
			insertNotiMap.put("nodeNo", affiliateMap.get("affiliateNo"));
			insertNotiMap.put("nodeType", "5");
			insertNotiMap.put("nodeTypeName", "affiliate");
            
            String notiTitle = String.format( "[영수증 입금요청] %s 님에 의한 입금 요청", requestMemberMap.get("memberName"));
            insertNotiMap.put("notiTitle", notiTitle);
            
            StringBuilder builder = new StringBuilder();
            
            builder.append(String.format( 
            	"%s님이 영수증을 등록했으며  ,%s이에 %s 에 대해 다음의 금액을 입금을 요청하고 있습니다",
            	requestMemberMap.get("memberName"), System.getProperty("line.separator"), affiliateMap.get("affiliateName")));
            builder.append(System.getProperty("line.separator"));
            builder.append(System.getProperty("line.separator"));
            
            builder.append(String.format( "1.결제 금액 :  %,d 원", pointCodeIssueRequestMap.get("payAmount")));
            builder.append(System.getProperty("line.separator"));
            
            builder.append(String.format( "2.가맹점주님이 입금할 금액 : %,d원 (결제금액의 15%%)", Math.round((int)pointCodeIssueRequestMap.get("payAmount") *  0.15)));
            builder.append(System.getProperty("line.separator"));
            builder.append("3.입금하실 계좌 : 우리은행 1002-751-058576 예금주 : 안영철");
            builder.append(System.getProperty("line.separator"));
            builder.append(System.getProperty("line.separator"));

            builder.append("*가맹점주님이 위 금액을 입금하시면, 영수증을 등록한 회원의 계정으로 적립코드가 등록됩니다");
            builder.append(System.getProperty("line.separator"));
            builder.append("*입금을 하신 후 빠른 처리를 위해서 해당 내역 페이지에서 입금확인 요청하기 버튼을 눌러주시면 더욱 빠른 처리가 가능합니다");
            
            insertNotiMap.put("notiContent", builder.toString());

            String notiExt1 = String.format(
                "/m/pointCoupon/receiptDetail.do?pointCodeIssueRequestNo=%d&issueType=%d",
                (int)pointCodeIssueRequestMap.get("pointCodeIssueRequestNo"),
                1
            	);
            
            insertNotiMap.put("notiExt1",  notiExt1);
            
            int count =  this.mobileMemberDao.insertMemberNoti(insertNotiMap);
			if (count == 0) {
				json = Util.printResult(1, String.format("110:잘못된 요청입니다."), null);
				rmap.put("json", json);
				return true;
			} else {
				json = Util.printResult(0, String.format("가맹점에 대한 입금 확인 요청이 완료되었습니다."), null);
				rmap.put("json", json);
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();

		}
		return true;
	}

	@Override
	public boolean getMemberNotis(RPMap rPap, RPMap rmap, HttpServletRequest request, HttpServletResponse response) {
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);
		try {
			dbparams.put("memberNo", sm.getMemberNo());
			ArrayList<HashMap<String, Object>> notis = this.mobileMemberDao.selectMemberNotis(dbparams);
			rmap.put("memberNotis", notis);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return true;
	}

	@Override
	public boolean getMemberNotiDetail(RPMap rPap, RPMap rmap, HttpServletRequest request,
			HttpServletResponse response) {
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);
		try {
			dbparams.put("memberNotiNo", rPap.getStr("memberNotiNo"));
			ArrayList<HashMap<String, Object>> notis = this.mobileMemberDao.selectMemberNotis(dbparams);
			if (notis.size()> 0) {
				rmap.put("memberNoti", notis.get(0));
			}
			
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return true;
	}

	@Override
	public boolean changeMemberNotiStatus(RPMap rPap, RPMap rmap, HttpServletRequest request,
			HttpServletResponse response) {
		SessionManager sm = new SessionManager(request, response);
		RPMap dbparams = new  RPMap();
		String json = null;
		try {
			dbparams.put("memberNotiNo", rPap.getStr("memberNotiNo"));
			dbparams.put("isViewed", rPap.getStr("isViewed"));
			int count  = this.mobileMemberDao.updateMemberNotiStatus(dbparams);;
			if (count == 0) {
				json = Util.printResult(1, String.format("110:잘못된 요청입니다."), null);
				rmap.put("json", json);
				return true;
			} else {
				json = Util.printResult(0, String.format("알림 상태 변경 완료"), null);
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
	public boolean affiliateReceiptList(RPMap rPap, RPMap rmap, HttpServletRequest request,
			HttpServletResponse response) {
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);
		try {
			ArrayList<HashMap<String, Object>> receiptList = null;
			
			dbparams.put("memberNo", sm.getMemberNo()); 
			HashMap<String, Object> affiliate = this.mobileMemberDao.selectAffiliateInfo(dbparams);
			
			dbparams.clear();
			dbparams.put("affiliateNo", (int)affiliate.get("affiliateNo"));
			dbparams.put("issueType", "1"); 
			
			switch(rPap.getStr("statusCode").trim()) {
			case "TRL": /*전체 내역 조회*/
				receiptList = this.mobileMainDao.selectReceipts(dbparams);
				break;
			case "CRL": /*처리 완료 내역 조회*/
				receiptList = this.mobileMainDao.selectCompletedReceipts(dbparams);
				break;
			case "NRL": /*미 처리 내역 조회*/
				receiptList = this.mobileMainDao.selectNotCompletedReceipts(dbparams);
				break;
			}
			rmap.put("receiptList", receiptList);
			rmap.put("affiliate", affiliate);
			rmap.put("statusCod", rPap.getStr("statusCode").trim());
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return true;
	}
}