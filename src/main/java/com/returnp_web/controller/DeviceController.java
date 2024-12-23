package com.returnp_web.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.returnp_web.controller.dto.ReturnpBaseResponse;
import com.returnp_web.svc.DeviceService;

@Controller
@RequestMapping("/m")
public class DeviceController {
	
	@Autowired private DeviceService deviceService;
	
	//푸쉬 토큰 등록 
	@ResponseBody
	@RequestMapping(value = "/device/registPushToken", method = RequestMethod.POST)
	public ReturnpBaseResponse registPushToken(@RequestParam HashMap<String, Object> paramMap, ModelMap modelMap,HttpServletRequest request, HttpServletResponse response) throws Exception {
		return deviceService.registPushToken(paramMap, modelMap, request, response);
	}
	
	//버젼 정보 가져오기
	@ResponseBody
	@RequestMapping(value = "/device/getVersion", method = RequestMethod.GET, produces="application/json")
	public String getVersioin(@RequestParam HashMap<String, Object> paramMap, ModelMap modelMap,HttpServletRequest request, HttpServletResponse response) throws Exception {
		return deviceService.getVersion(paramMap, modelMap, request, response);
	}
}
