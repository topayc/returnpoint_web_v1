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
import org.springframework.web.servlet.mvc.WebContentInterceptor;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.returnp_web.dao.FrontMemberDao;
import com.returnp_web.utils.Converter;
import com.returnp_web.utils.RPMap;
import com.returnp_web.utils.SessionManager;

import org.springframework.web.method.HandlerMethod;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Locale;

/**
 * The Class sessionInterceptor.
 */
@Component
public class FrontSessionInterceptor extends HandlerInterceptorAdapter {
	
	/** The front member dao. */
	@Autowired
	private FrontMemberDao frontMemberDao;
	
	/** The Constant logger. */
	private static final Logger logger = LoggerFactory.getLogger(FrontSessionInterceptor.class);
	//private String paramName;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws ServletException  { 
		try {
			HttpSession session = request.getSession(false);
			Device device = DeviceUtils.getCurrentDevice(request); 
			SessionManager sm = new SessionManager(request, response);
			
			if(!device.isMobile()){ //디바이스가 pc, 테블릿일 경우만 해당
				if(session == null){
					response.sendRedirect(request.getContextPath()+"/member/login.do");
					return false;
				}
			}else{ //디바이스가 모바일일 경우
				String userAuthToken = request.getHeader("user_auth_token");
				String user_agent = request.getHeader("User-Agent");
				RPMap dbparams = new RPMap();
				if (user_agent.indexOf("APP_RETURNP_Android") > -1){ //APP
					if(userAuthToken != null) { //APP이면서 유효한 토큰이 존재
						if(sm.getMemberEmail() == null) {
							String memberPassword = "";
							String memberEmail = "";
							String memberName = "";
							int memberNo = 0;
							dbparams.put("userAuthToken", userAuthToken);
							HashMap<String,Object> memberAuthTokenGb = frontMemberDao.selectMemberAuthToken(dbparams);
							if(memberAuthTokenGb !=null && !memberAuthTokenGb.isEmpty()){ 
								memberEmail = Converter.toStr(memberAuthTokenGb.get("memberEmail"));
								dbparams.put("memberEmail", memberEmail);
								HashMap<String,Object>records = frontMemberDao.loginAppAct(dbparams);
								if(records !=null && !records.isEmpty()){
									memberNo = Converter.toInt(records.get("memberNo"));
									memberEmail = Converter.toStr(records.get("memberEmail"));
									memberName = Converter.toStr(records.get("memberName"));
									sm.setMemberNo(memberNo);
									sm.setmemberName(memberName);
									sm.setMemberEmail(memberEmail);
								} 
								response.sendRedirect(request.getContextPath()+"/m/main/index.do?mbrE="+memberEmail+"&userAT="+userAuthToken);
							}
						}
					}else{
						response.sendRedirect(request.getContextPath()+"/m/member/login.do");
						return false;
					}
				}else{ //APP 아님+접속 기기에 따라 로그인 페이지로 이동 분리 처리(이 부분은 url접속을 대비하여 만약을 위해 처리한것입니다. 외부에 노출이 안되였다면. 삭제하셔도 되요.)
					if(sm.getMemberEmail() == null ) {
						if(!device.isMobile()){ //디바이스가 pc, 테블릿일 경우만 해당
							if(session == null){
								response.sendRedirect(request.getContextPath()+"/member/login.do");
								return false;
							}
						}else{ //디바이스가 모바일일 경우
							response.sendRedirect(request.getContextPath()+"/m/member/login.do");
							return false;
						}
						
					}
					
				}
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}


	@Override
	public void postHandle(HttpServletRequest request, 
                           HttpServletResponse response,
                           Object handler,
                           ModelAndView mv) throws Exception {

	}


	@Override
	public void afterCompletion(HttpServletRequest req, 
                                HttpServletResponse res,
                                Object handler,
                                Exception ex) throws Exception {

		
	}
}
