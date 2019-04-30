package com.returnp_web.svc;

import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Locale;
import java.util.Map.Entry;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.RandomStringUtils;
import org.json.simple.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.returnp_web.utils.RPMap;
import com.returnp_web.utils.ServletRequestInfoUtil;
import com.returnp_web.utils.SessionManager;
import com.returnp_web.utils.Util;
import net.sf.json.JSONObject;
import com.returnp_web.utils.BASE64Util;

import com.popbill.api.MessageService;
import com.popbill.api.PopbillException;
import com.popbill.api.message.MessageServiceImp; 

@Service
public class SmsServiceImpl implements SmsService {
	
	private static final Logger logger = LoggerFactory.getLogger(SmsServiceImpl.class);
	private MessageService messageService; //import com.popbill.api.message.MessageServiceImp; 호출
	
	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
	public boolean selectSmsAuth(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response ) throws Exception{
		
		RPMap dbparams = new RPMap();
		
		MessageServiceImp service = new MessageServiceImp();

		//sms 업체 api
		service.setLinkID("TOPHAPPY");
		service.setSecretKey("G9l+lKAjfp8c7T0rCZh0iM2KI2YwULl8h+mX1xjAHwQ=");
		service.setTest(false);
		service.setIPRestrictOnOff(true);
		messageService = service;
		//sms 업체 api
		
		try{
			int Count = 0;
			HttpSession session = request.getSession(true);
			String authSmsRandomKey = Util.randomNumber(); //인증번호 6자리 난수 발생
			session.setAttribute("authSmsRandomKey" , authSmsRandomKey);

			//sms api start
			String testCorpNum = "7548601056"; // 팝빌회원 사업자번호
			String testUserID = "tophappyworld"; // 팝빌회원 아이디 = 웹사이트 아이디
			String sender = "025855993"; // 발신번호
			String receiver = p.getStr("phone");// 수신번호
			
			String memberPhonestatus = null;
			if(receiver.contains("+82")) {//+82
				memberPhonestatus = "1";
			}else if(receiver.contains("82")) { //82
				memberPhonestatus = "2";
			}else { //01 
				memberPhonestatus = "3";
			}
			
			switch(memberPhonestatus) {
				case "1": receiver = receiver.replace("+82", "0");  break;
				case "2": receiver = receiver.replace("82", "0");  break;
			}
			
			String receiverName = ""; // 수신자명
			//String content = "문자메시지 내용"; // 메시지 내용, 90byte 초과된 내용은 삭제되어 전송
			String content = "회원가입 인증번호는: "+authSmsRandomKey+" 입니다.";
			Date reserveDT = null; // 예약전송일시, null 처리시 즉시전송
			Boolean adsYN = false; // 광고문자 전송여부
		    // 전송요청번호
		    // 파트너가 전송 건에 대해 관리번호를 구성하여 관리하는 경우 사용.
		    // 1~36자리로 구성. 영문, 숫자, 하이픈(-), 언더바(_)를 조합하여 팝빌 회원별로 중복되지 않도록 할당.
		    String requestNum = null; 
		    //String receiptNum = null;   
		    String receiptNum = messageService.sendSMS(testCorpNum, sender, receiver, receiverName, content, reserveDT, adsYN, testUserID, requestNum);
		    
		    //sms api end
		    if(receiptNum != null){
		    	Count = 1; //연동 성공시에
		    }else{
		    	Count = 0; //연동 실패시에
		    }
	        
			//연동 부분추가
			if(Count == 1){
				String json = Util.printResult(1, String.format("sms가 발송되었습니다."), dbparams);
				rmap.put("json", json);
				return true;
			}else{
				String json = Util.printResult(2, String.format("sms가 발송되었습니다. 잠시만 기다려주세요."), dbparams);
				rmap.put("json", json);
				return true;
			}
			
		}catch(Exception e){
			e.printStackTrace();
		} 
		return true;
	}


	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
	public boolean selectSmsAuthSession(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response ) throws Exception{
		
			RPMap dbparams = new RPMap();
		
		try{
			int Count = 0;
			HttpSession session = request.getSession(true);
			String authSmsRandomKey = session.getAttribute("authSmsRandomKey").toString();
			String authNumberCheck = p.getStr("authNumberCheck");

			if(authSmsRandomKey.equals(authNumberCheck)){
				Count = 1; //성공
			}else {
				Count = 0; //실패
			}
			if(Count == 1){
				String json = Util.printResult(1, String.format("성공하였습니다."), dbparams);
				rmap.put("json", json);
				return true;
			}else{
				String json = Util.printResult(2, String.format("인증번호가 일치하지 않습니다."), dbparams);
				rmap.put("json", json);
				return true;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return true;
	}
	
}