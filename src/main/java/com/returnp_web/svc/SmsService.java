package com.returnp_web.svc;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;

import com.returnp_web.utils.RPMap;

/**
 * sms controller service
 */
@Transactional
public interface SmsService {
	
	/**
	 * 사용자->회원가입 sms 휴대폰 인증
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean selectSmsAuth(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	
	
}
