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
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
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

import com.returnp_web.dao.FrontMainDao;
import com.returnp_web.dao.FrontMemberDao;
import com.returnp_web.utils.BASE64Util;
import com.returnp_web.utils.Const;
import com.returnp_web.utils.Converter;
import com.returnp_web.utils.QRManager;
import com.returnp_web.utils.RPMap;
import com.returnp_web.utils.SessionManager;
import com.returnp_web.utils.Util;
import net.sf.json.JSONObject;

/**
 * The Class FrontMainServiceImpl.
 */
@PropertySource("classpath:/config.properties")
@Service
public class FrontMainServiceImpl implements FrontMainService {

	private static final Logger logger = LoggerFactory.getLogger(FrontMainServiceImpl.class);

	/** The front main dao. */
	@Autowired
	private FrontMainDao frontMainDao;

	@Autowired
	private FrontMemberDao frontMemberDao;

	@Autowired
	private MessageSource messageSource;

	@Autowired
	Environment environment;

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

			HashMap<String, Object> serverYearMonth = frontMemberDao.selectYearMonth(dbparams);
			String PREWMONTH = (String) serverYearMonth.get("PREWMONTH");
			String NOWMONTH = (String) serverYearMonth.get("NOWMONTH");
			String NEXTMONTH = (String) serverYearMonth.get("NEXTMONTH");
			rmap.put("PREWMONTH", PREWMONTH);
			rmap.put("NOWMONTH", NOWMONTH);
			rmap.put("NEXTMONTH", NEXTMONTH);

			HashMap<String, Object> mypageMyinfo = frontMemberDao.selectMypageMyinfo(dbparams); // my info
			if (mypageMyinfo == null) {
				rmap.put(Const.D_SCRIPT, Util.jsmsgLink("잘못된 경로입니다.", "/main/index.do?alertView=t&Message=1", "T"));
				return false;
			}
			HashMap<String, Object> myRedPointSumInfo = frontMainDao.selectMyRedPointSumInfo(dbparams); // red point search.
			HashMap<String, Object> myGreenPointSumInfo = frontMainDao.selectMyGreenPointSumInfo(dbparams); // green point Sum search.
			ArrayList<HashMap<String, Object>> selectMyGreenPointList = frontMainDao.selectMyGreenPointList(dbparams); // green point List search.
			ArrayList<HashMap<String, Object>> selectPolicyList = frontMainDao.selectPolicyList(dbparams); // policy. 정책 
			HashMap<String, Object> myRedPointInfo = frontMemberDao.selectMyRedPointMapinfo(dbparams); // red point Map search
			ArrayList<HashMap<String, Object>> selectMyGreenPointSumList = frontMainDao.selectMyGreenPointSumList(dbparams); // green point Sum List search.
			ArrayList<HashMap<String, Object>> selectMyRedPointSumList = frontMainDao.selectMyRedPointSumList(dbparams); // red point Sum one List search.
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
			HashMap<String, Object> selectPolicyMembershipTransLimit = frontMemberDao.selectPolicyMembershipTransLimit(dbparams);
			if (selectPolicyMembershipTransLimit != null) {
				dbparams.put("redPointAccRate", selectPolicyMembershipTransLimit.get("redPointAccRate"));
			} else {
				String json = Util.printResult(1, String.format("잠시후 진행 하시길 바랍니다."), null);
				rmap.put("json", json);
				return true;
			}
			HashMap<String, Object> selectMygreenPointInfo = frontMemberDao.selectMygreenPointInfo(dbparams);
			if (selectMygreenPointInfo != null) {
				myPoint = (float) selectMygreenPointInfo.get("pointAmount");
			} else {
				String json = Util.printResult(1, String.format("잠시후 진행 하시길 바랍니다."), null);
				rmap.put("json", json);
				return true;
			}

			float pointAmount = myPoint - (float) p.getInt("convertPointAmount"); // 현재 포인트-차감포인트=최종 잔여 포인트
			dbparams.put("pointAmount", pointAmount);
			frontMainDao.insertPointConvertRequestAct(dbparams);
			frontMainDao.insertPointConvertTransactionAct(dbparams);
			frontMainDao.updateGreenPointUse(dbparams);
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
			HashMap<String, Object> recipientMemberinfo = frontMemberDao.selectRecipientMemberinfo(dbparams);
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
			HashMap<String, Object> receiverRedPointInfo = frontMainDao.selectReceiverRedPointInfo(dbparams);
			if (receiverRedPointInfo == null) {
				String json = Util.printResult(1, String.format("잠시후 진행 하시길 바랍니다."), null);
				rmap.put("json", json);
				return true;
			}
			// 현재 포인트+부여(선물)포인트=최종 잔여 포인트
			float receiverPointAmount = (float) receiverRedPointInfo.get("pointAmount") + (float) p.getInt("convertPointAmount");
			dbparams.put("receiverPointAmount", receiverPointAmount);
			frontMainDao.insertPointTransferTransactionAct(dbparams);
			frontMainDao.updateMyRedPointUse(dbparams);
			frontMainDao.updateReceiveRedPoint(dbparams);
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
			HashMap<String, Object> recipientMemberinfo = frontMemberDao.selectRecipientMemberinfo(dbparams);
			if (recipientMemberinfo != null) {
				dbparams.put("pointReceiver", Converter.toInt(recipientMemberinfo.get("memberNo"))); // pointReceiver : 송금받을 멤버 번호
			} else {
				String json = Util.printResult(1, String.format("잠시후 진행 하시길 바랍니다."), null);
				rmap.put("json", json);
				return true;
			}

			HashMap<String, Object> selectMygreenPointInfo = frontMemberDao.selectMygreenPointInfo(dbparams);
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
			HashMap<String, Object> receiverGreenPointInfo = frontMainDao.selectReceiverGreenPointInfo(dbparams);
			if (receiverGreenPointInfo == null) {
				String json = Util.printResult(1, String.format("잠시후 진행 하시길 바랍니다."), null);
				rmap.put("json", json);
				return true;
			}

			float receiverPointAmount = (float) receiverGreenPointInfo.get("pointAmount") + (float) p.getInt("convertPointAmount");
			dbparams.put("receiverPointAmount", receiverPointAmount);
			frontMainDao.insertPointTransferTransactionAct(dbparams);
			frontMainDao.updateMyGreenPointUse(dbparams);
			frontMainDao.updateReceiveGreenPoint(dbparams);
			String json = Util.printResult(0, String.format("성공하였습니다."), null);
			rmap.put("json", json);
			return true;
			
		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return true;
	}

	@Override
	public boolean qrImgView(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) {

		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		String decode64Qr = null;

		try {
			decode64Qr = BASE64Util.decodeString(p.getStr("qr_data"));
			URL url = new URL(decode64Qr);
			String queryParmStr = url.getQuery();

			HashMap<String, String> qrParsemap = QRManager.parseQRToMap(queryParmStr);

			if (qrParsemap == null) {
				rmap.put("qr_parsing_result", "error");
				rmap.put("qr_parsing_error_message", "유효하지 않은 QR CODE 입니다.");
			} else {
				// 가맹점 정보
				dbparams.put("af_id", qrParsemap.get("af_id")); // 가맹점 시리얼 넘버 조회
				HashMap<String, Object> affiliateInfo = frontMemberDao.selectAffiliateInfo(dbparams);

				if (affiliateInfo == null) {
					rmap.put("qr_parsing_result", "error");
					rmap.put("qr_parsing_error_message", "유효하지 않은 QR CODE -가맹점 정보가 존재하지 않음");
				} else {
					rmap.put("qr_parsing_result", "success");
					rmap.put("qr_org", p.getStr("qr_data"));
					rmap.put("qr_pay_type_str", p.getStr("pay_type").equals("1") ? "신용카드 결제" : "현금 결제");
					rmap.put("qrAccessUrl", QRManager .genQRCode(request.getSession().getServletContext().getRealPath("/qr_temp"), "/qr_temp", decode64Qr, null));
					Util.copyRPmapToMap(rmap, qrParsemap);
					rmap.put("affiliateName", affiliateInfo.get("affiliateName"));

					float amountAccumulated = Float.parseFloat(qrParsemap.get("pam")); // 가맹점 시리얼 넘버 조회
					System.out.println("amountAccumulated::" + amountAccumulated);
					HashMap<String, Object> policy = frontMemberDao.selectPolicyPointTranslimit(dbparams);
					float customerComm = (float) policy.get("customerComm");
					System.out.println("customerComm::" + customerComm);
					float qramountAcc = (amountAccumulated * customerComm);
					rmap.put("qramountAcc", qramountAcc);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public String qrAccProxy(HashMap<String, String> p, ModelMap rmap, HttpServletRequest request,	HttpServletResponse response) throws Exception {
		String remoteCallURL = environment.getProperty("run_mode").equals("dev")
				? environment.getProperty("dev.pointback_remote_url_by_enc_qr")
				: environment.getProperty("real.pointback_remote_url_by_enc_qr");
		String key = environment.getProperty("key");
		StringBuffer response2 = null;
		try {
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
			} else {
				System.out.println("포인트 백 적립 요청 에러");
			}
			System.out.println("포인트 백 적립 요청");
			System.out.println(remoteCallURL + "?" + Util.mapToQueryParam(p));
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return response2.toString();
	}

	@Override
	public HashMap<String, Object> getFooter(RPMap rmap) throws Exception {
		
		RPMap dbparams = new RPMap();
		HashMap<String, Object> map = new HashMap<String, Object>();
		String langLocale = rmap.getStr("langLocale");
		dbparams.put("langLocale", langLocale);
		HashMap<String, Object> company = frontMainDao.selectCompanyInfo(dbparams);
		map.put("company", company);
		
		return map;
	}

	@Override
	public HashMap<String, Object> getServerManageStatus() throws Exception {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		RPMap dbparams = new RPMap();
		HashMap<String, Object> servermanagestatus = frontMainDao.selectServerManageStatusInfo(dbparams);
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
			HashMap<String,Object> serverYearMonth = frontMemberDao.selectYearMonth(dbparams);
			String PREWMONTH = (String) serverYearMonth.get("PREWMONTH");
			String NOWMONTH = (String) serverYearMonth.get("NOWMONTH");
			String NEXTMONTH = (String) serverYearMonth.get("NEXTMONTH");
			
			ArrayList<HashMap<String, Object>> paymentPointbackRecordDetailList = frontMainDao.selectPaymentPointbackRecordDetailList(dbparams);
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
			HashMap<String,Object> serverYearMonth = frontMemberDao.selectYearMonth(dbparams);
			String PREWMONTH = (String) serverYearMonth.get("PREWMONTH");
			String NOWMONTH = (String) serverYearMonth.get("NOWMONTH");
			String NEXTMONTH = (String) serverYearMonth.get("NEXTMONTH");
			
			ArrayList<HashMap<String, Object>> pointConversionTransactionDetailList = frontMainDao.selectPointConversionTransactionDetailList(dbparams);
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
			ArrayList<HashMap<String, Object>> faqList = frontMainDao.selectFaqList(dbparams);
			HashMap<String, Object> faqTotalCnt = frontMainDao.faqTotalCnt(dbparams); 
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
			ArrayList<HashMap<String, Object>> noticeList = frontMainDao.selectNoticeList(dbparams);
			HashMap<String, Object> noticeTotalCnt = frontMainDao.noticeTotalCnt(dbparams); 
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

			ArrayList<HashMap<String, Object>> rpmapLoadList = frontMainDao.selectRpmapLoadList(dbparams);
			rmap.put("json", rpmapLoadList);

			return true;
		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
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
			
			ArrayList<HashMap<String, Object>> faqMoreList = frontMainDao.selectFaqMoreList(dbparams);
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
			ArrayList<HashMap<String, Object>> noticeMoreList = frontMainDao.selectNoticeMoreList(dbparams);
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
			HashMap<String,Object> myinfo = frontMemberDao.selectMypageMyinfo(dbparams);
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
}