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

import com.returnp_web.dao.FrontMemberDao;
import com.returnp_web.utils.Const;
import com.returnp_web.utils.Converter;
import com.returnp_web.utils.EmailSender;
import com.returnp_web.utils.EmailVO;
import com.returnp_web.utils.RPMap;
import com.returnp_web.utils.ServletRequestInfoUtil;
import com.returnp_web.utils.SessionManager;
import com.returnp_web.utils.Util;
import net.sf.json.JSONObject;
import com.returnp_web.utils.BASE64Util;

/**
 * The Class FrontMemberServiceImpl.
 */
@Service
public class SmsServiceImpl implements SmsService {
	
	private static final Logger logger = LoggerFactory.getLogger(SmsServiceImpl.class);
	
	/** The front member dao. */
	@Autowired
	private FrontMemberDao frontMemberDao;
	
	@Autowired
	private EmailVO email;

	@Autowired
	private EmailSender emailSender;
	
	@Autowired
	private MessageSource messageSource;

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
	public boolean selectSmsAuth(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response ) throws Exception{

		RPMap dbparams = new RPMap();
		
		try{
			int Count = 0;
			//로직 추가
			HttpSession session = request.getSession(true);
			String authSmsRandomKey = Util.randomNumber(); //인증번호 6자리 난수 발생
			session.setAttribute("authSmsRandomKey" , authSmsRandomKey);
			dbparams.put("authSmsRandomKey"	, authSmsRandomKey); //난수 6자리
			dbparams.put("phone", p.getStr("phone")); //phone 번호
		
			
			Count = 1; //연동 성공시에
			
			
			
			
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
			//로직 추가
			HttpSession session = request.getSession(true);
			String authSmsRandomKey = session.getAttribute("authSmsRandomKey").toString();
			String authNumberCheck = p.getStr("authNumberCheck");

			if(authSmsRandomKey.equals(authNumberCheck)) {
				Count = 1; //성공
			}else {
				Count = 2; //실패
			}
			
			//로직 추가
			
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