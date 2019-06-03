package com.returnp_web.interceptor;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.LocaleEditor;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.handler.UserRoleAuthorizationInterceptor;
import org.springframework.web.servlet.mvc.WebContentInterceptor;
import org.springframework.web.servlet.support.RequestContextUtils;
import org.springframework.web.servlet.view.RedirectView;

import com.returnp_web.utils.Const;
import com.returnp_web.utils.Converter;
import com.returnp_web.utils.RPMap;
import com.returnp_web.utils.SessionManager;
import com.returnp_web.utils.Util;

import org.springframework.web.method.HandlerMethod;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Locale;
import com.returnp_web.dao.MobileMemberDao;

/**
 * The Class FrontInterceptor.
 */
@Component
public class MobileSessionInterceptor extends HandlerInterceptorAdapter {

	private static final Logger logger = LoggerFactory.getLogger(MobileSessionInterceptor.class);

	@Autowired
	private MobileMemberDao mobileMemberDao;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws ServletException {

		String uri = request.getRequestURI(); String url = request.getRequestURL().toString();
		String action = url.substring(url.indexOf(".") + 1, url.length());
		SessionManager sm = new SessionManager(request, response);
		
		if (logger.isDebugEnabled()) {
			logger.debug("uri ==>" + uri);
			logger.debug("url ==>" + request.getRequestURL().toString());
			logger.debug("action ==>" + action);
		}

		try {
			
			String userAuthToken = request.getHeader("user_auth_token");
			String isAjax= request.getHeader("AJAX");
			if ("true".equals(isAjax)) return true;
		
			System.out.println("user_auth_tokensss");
			System.out.println(userAuthToken);
			String user_agent = request.getHeader("User-Agent");

			RPMap dbparams = new RPMap();
			if (user_agent.indexOf("APP_RETURNP_Android") > -1) { // APP
				if (userAuthToken != null && !"null".equalsIgnoreCase(userAuthToken)) { // APP이면서 유효한 토큰이 존재
					if (sm.getMemberEmail() == null) {
						dbparams.put("userAuthToken", userAuthToken);
						HashMap<String, Object> memberAuthTokenGb = mobileMemberDao.selectMemberAuthToken(dbparams);

						if (memberAuthTokenGb != null && !memberAuthTokenGb.isEmpty()) {
							RPMap dbparams2 = new RPMap();
							dbparams2.put("memberEmail", Converter.toStr(memberAuthTokenGb.get("memberEmail")));
							HashMap<String, Object> records = mobileMemberDao.loginAppAct(dbparams2);

							if (records != null && !records.isEmpty()) {
								sm.setMemberNo(Converter.toInt(records.get("memberNo")));
								sm.setMemberEmail(Converter.toStr(records.get("memberEmail")));
								sm.setmemberName(Converter.toStr(records.get("memberName")));
								return true;
							}
						} else {
							response.sendRedirect(request.getContextPath() + "/m/member/login.do");
							return false;
						}
					} else {
						return true;
					}
				} else {
					response.sendRedirect(request.getContextPath() + "/m/member/login.do");
					return false;
				}
			}
		} catch (Exception e) {// try{
			e.printStackTrace();
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView mv)
			throws Exception {
	}

	@Override
	public void afterCompletion(HttpServletRequest req, HttpServletResponse res, Object handler, Exception ex)
			throws Exception {
	}
}
