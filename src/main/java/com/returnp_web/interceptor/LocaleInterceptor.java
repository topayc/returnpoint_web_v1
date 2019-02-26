package com.returnp_web.interceptor;

import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.LocaleEditor;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import org.springframework.web.servlet.support.RequestContextUtils;
import org.springframework.web.util.WebUtils;

import com.returnp_web.svc.FrontMainService;
import com.returnp_web.utils.RPMap;

/**
 * The Class FrontInterceptor.
 */
@Component
public class LocaleInterceptor extends HandlerInterceptorAdapter {
	
	/** The Constant logger. */
	private static final Logger logger = LoggerFactory.getLogger(LocaleInterceptor.class);
	//private String paramName;
	
	/** The fcs. */
	@Autowired
	private FrontMainService fms;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws ServletException {

		String uri = request.getRequestURI();
		String url = request.getRequestURL().toString();
		String action = url.substring(url.indexOf(".") + 1, url.length());
		
		if (logger.isDebugEnabled()){
			logger.debug("uri ==>" + uri);
			logger.debug("url ==>" + request.getRequestURL().toString());
			logger.debug("action ==>" + action);
			logger.debug("locale" + request.getLocale().toString());
	/*		logger.debug("accept locale : " + request.getLocale().toString());
			logger.debug("korean locale : " + Locale.KOREAN.toString());
			logger.debug("korea locale : " + Locale.KOREA.toString());
			logger.debug("chinese locale : " + Locale.CHINESE.toString());
			logger.debug("china locale : " + Locale.CHINA.toString());
			logger.debug("english locale : " + Locale.ENGLISH.toString());*/
		}
		
		try {
			String newLocale = request.getParameter("lang");
			System.out.println("Local Lang : " + newLocale);
			if(newLocale != null){
				LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
				if(localeResolver == null){
					throw new IllegalStateException("No LocaleResolver found: not in a DispatcherServlet request?");
				}
				LocaleEditor localeEditor = new LocaleEditor();
				localeEditor.setAsText(newLocale);
				localeResolver.setLocale(request, response, (Locale) localeEditor.getValue());
				if (request.getParameter("returnUrl") != null) {
					response.sendRedirect(request.getParameter("returnUrl"));
				}else {
					response.sendRedirect(request.getRequestURI());
				}
				return false;
			}else {
				Locale locale = (Locale) WebUtils.getSessionAttribute(request, SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME);
				if (locale == null){
					Locale  acceptLocale= request.getLocale();
					String langStr = acceptLocale.toString().split("_")[0];
					if (langStr.equals("ko") ) {
						acceptLocale = Locale.KOREAN;
					}else if (langStr.equals("zh")) {
						acceptLocale = Locale.CHINESE;
					}else {
						acceptLocale = Locale.ENGLISH;
					}
					//System.out.println("적용 로케일  : "  + acceptLocale.toString());
					WebUtils.setSessionAttribute( request, SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, acceptLocale);
				}
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}


	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView mv)
			throws Exception {
		HttpSession session = request.getSession(false);
		RPMap dbparams = new RPMap();
		String attrName = "org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE";
		Object localeValue = session.getAttribute(attrName);
		if (localeValue == null) {
			dbparams.put("langLocale", "ko");
		} else {
			dbparams.put("langLocale", localeValue.toString());
		}
		if (mv == null) return;
		mv.addObject("SERVER_MANAGE", fms.getServerManageStatus());
		mv.addObject("FOOTER", fms.getFooter(dbparams));
	}


	@Override
	public void afterCompletion(HttpServletRequest req, HttpServletResponse res, Object handler, Exception ex)
			throws Exception {
	}
}
