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
			dbparams.put("phone", p.getStr("phone"));
			int Count = 0;
			
			//로직 추가

			
			//로직 추가
			
			if(Count == 0){
				String json = Util.printResult(2, String.format("sms 발송 않습니다."), null);
				rmap.put("json", json);
				return true;
			}else{
				String json = Util.printResult(1, String.format("성공하였습니다. "), null);
				rmap.put("json", json);
				return true;
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return true;
	}


}