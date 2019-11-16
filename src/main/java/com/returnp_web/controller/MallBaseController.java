package com.returnp_web.controller;

import java.util.Map;

import javax.inject.Provider;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;

import com.google.gson.JsonObject;
import com.returnp_web.svc.CommonTrackerService;
import com.returnp_web.utils.Const;
import com.returnp_web.utils.Converter;
import com.returnp_web.utils.SessionManager;
import com.returnp_web.utils.Util;

/**
 * The Class MallBaseController.
 */
public abstract class MallBaseController{
	
	/** The Constant logger. */
	private static final Logger logger = LoggerFactory.getLogger(MallBaseController.class);

	/** The tracker provider. */
	@Autowired 
	protected Provider<CommonTrackerService> trackerProvider;
	
	public MallBaseController(){
	}

	protected String act(ModelMap map, Map<String, Object> rmap){
		map.addAttribute(Const.D_EXCUTE_SCRIPT_KEY, rmap.get(Const.D_SCRIPT));
		return Const.D_VIEW_JAVASCRIPT;	
	}

	protected String page(boolean bret, ModelMap map, Map<String, Object> rmap) throws Exception{
		if (! bret) {
			return act(map, rmap);
		}
		map.addAttribute("model", rmap);
		return (String)rmap.get(Const.D_VIEW_PAGE_KEY);
	}
	
	protected String ajax_page(boolean bret, ModelMap map, Map<String, Object> rmap) throws Exception{
		if (! bret) {
			String msg = Converter.toStr(rmap.get(Const.D_EXCUTE_AJAX_KEY));
			if (Util.hasText(msg)) {
				rmap.put(Const.D_EXCUTE_AJAX_KEY, msg);
				rmap.put(Const.D_VIEW_PAGE_KEY, Const.D_VIEW_AJAX);
				map.addAttribute("model", rmap);
				return Const.D_VIEW_AJAX;
			}
			return act(map, rmap);
		}

		map.addAttribute("model", rmap);
		return (String)rmap.get(Const.D_VIEW_PAGE_KEY);
	}
	
	protected JsonObject checkAccRequestValid(SessionManager sm, String referer , HttpServletRequest request, HttpServletResponse response) {
		JsonObject  res = new JsonObject();
		
		if (sm == null || sm.getMemberEmail() == null || sm.getMemberEmail().trim().equals("")) {
			JsonObject object = new JsonObject();
			object.addProperty("responseCode", "1000");
			object.addProperty("resultCode", "9081");
			object.addProperty("message", "잘못된 요청</br> 해당 요청에 대한 세션이 없습니다.");
			return res;
		}
		
		/* refer 검사 */
		if (referer == null || referer.trim().length() == 0 || !referer.trim().contains("/m/qr/kiccQrAcc.do")) {
			JsonObject object = new JsonObject();
			object.addProperty("responseCode", "1000");
			object.addProperty("resultCode", "9082");
			object.addProperty("message", "잘못된 직접 요청</br> 직접적인 적립 요청입니다.");
			return res;
		}
		
		/* 적립 요청에 대한 유효성 검사 - 적립 세션 키 검사 */
		
		return res;
	}
	
}