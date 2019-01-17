package com.returnp_web.i18n;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.StringUtils;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import org.springframework.web.util.WebUtils;

public class LocaleManager {
	/** 
	 * 로케일을 설정한다.
	 * @param request     
	 * @param response
	 * @param locale     로케일 객체 
	 */
	public static void setLocale(HttpServletRequest request, HttpServletResponse response,  Locale locale){
		WebUtils.setSessionAttribute(
			     request, SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, locale);
	}
	
	/**
	 * 로케일을 설정한다.
	 * @param request
	 * @param response
	 * @param locale      로케일 문자열
	 */
	public static void setLocale(HttpServletRequest request, HttpServletResponse response,  String locale){
		WebUtils.setSessionAttribute(
			     request, SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, 
			     StringUtils.parseLocaleString(locale));
	}
	
	/**
	 * 메인 페이지 진입시 호출되어, 브라우저 정보로 부터 로케일을 읽어 로케일을 설정한다.
	 * @param request
	 * @param response
	 */
	public static void setInitialLocale(HttpServletRequest request, HttpServletResponse response){
		Locale  locale= request.getLocale();
		WebUtils.setSessionAttribute(
			     request, SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, locale);
		
	}
	
	/**
	 * 로케일을 반환한다. 
	 * 인터셉터를 거쳐 로케일이 미리 설정되기 때문에 이 메서드에서 반환하는 로케일은 널이 될 수 없다.
	 * @param request
	 * @return
	 */
	public static Locale  getLocale(HttpServletRequest request){
		Locale locale = (Locale) WebUtils.getSessionAttribute(request, 
				SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME);
		return locale;
	}
}
