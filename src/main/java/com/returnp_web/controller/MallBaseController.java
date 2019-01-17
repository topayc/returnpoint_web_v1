package com.returnp_web.controller;

import java.util.Map;

import javax.inject.Provider;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;

import com.returnp_web.svc.CommonTrackerService;
import com.returnp_web.utils.Const;
import com.returnp_web.utils.Converter;
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
	
}