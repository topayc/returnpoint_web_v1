package com.returnp_web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.returnp_web.svc.SmsService;
import com.returnp_web.utils.Const;
import com.returnp_web.utils.RPMap;
import com.returnp_web.utils.Util;

@Controller
@RequestMapping("/m")
public class SmsController extends MallBaseController{

	@Autowired
	private SmsService sms;

	//모바일 회원가입_sms 인증 정보 조회
	@RequestMapping(value = "/common/smsAuth", produces = "application/text; charset=utf8")
	@ResponseBody
	public String selectSmsAuth(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		RPMap rmap = Util.getRPRmap();
		boolean bret = sms.selectSmsAuth(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}


}