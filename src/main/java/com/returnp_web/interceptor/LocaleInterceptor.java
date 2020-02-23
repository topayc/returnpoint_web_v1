package com.returnp_web.interceptor;

import java.util.ArrayList;
import java.util.HashMap;
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

import com.returnp_web.dao.MobileMainDao;
import com.returnp_web.dao.MobileMemberDao;
import com.returnp_web.svc.FrontMainService;
import com.returnp_web.utils.RPMap;
import com.returnp_web.utils.SessionManager;

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
	
	@Autowired
	private MobileMemberDao mobileMemberDao;
	
	@Autowired
	private MobileMainDao mobileMainDao;
	
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
			//System.out.println("Local Lang : " + newLocale);
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
				}else {
					/*System.out.println("적용 로케일1  : "  + locale.toString());*/
					
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
		
		
		if (request.getSession().getAttribute("memberNo") != null) {
			SessionManager sm = new SessionManager(request, response);
			
			dbparams.clear();
			dbparams.put("isViewed", "N");
			dbparams.put("memberNo", sm.getMemberNo());
			HashMap<String, Object>  notiCountMap  = this.mobileMemberDao.selectMemberNotiCount(dbparams);
			mv.addObject("notiInfo", notiCountMap);

			/*최신 공지사항 1개 가져오기 */
			dbparams.clear();
			dbparams.put("bbsType1", "1");
			dbparams.put("bbsType2", "1");
			dbparams.put("bbsLimit", 1);
			ArrayList<HashMap<String, Object>> notices = this.mobileMainDao.selectBoards(dbparams);
			if (notices.size() ==1) {
				mv.addObject("notice", notices .get(0));
			}
			
			dbparams.clear();
			dbparams.put("memberNo", sm.getMemberNo());
			HashMap<String, Object> affiliateMap = mobileMainDao.selectAffiliate(dbparams);
			
			if (affiliateMap != null) {
				mv.addObject("affiliate", affiliateMap);
				
				dbparams.clear();
				dbparams.put("bbsType1", "1");
				dbparams.put("bbsType2", "2");
				dbparams.put("bbsLimit", 2);
				
				ArrayList<HashMap<String, Object>> affiliateNotices = this.mobileMainDao.selectBoards(dbparams);
				if (affiliateNotices.size()>0) {
					mv.addObject("affiliateNotice", affiliateNotices.get(0));
					mv.addObject("affiliateNotices", affiliateNotices);
				} 
				
			}
			
		}
		
	}


	@Override
	public void afterCompletion(HttpServletRequest req, HttpServletResponse res, Object handler, Exception ex)
			throws Exception {
	}
}
