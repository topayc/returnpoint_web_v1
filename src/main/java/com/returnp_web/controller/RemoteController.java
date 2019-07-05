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
import com.returnp_web.svc.RemoteService;

@Controller
@RequestMapping("/m")
public class RemoteController {
	
	@Autowired private RemoteService remoteService;
	
	//푸쉬 토큰 등록 
	@ResponseBody
	@RequestMapping(value = "/remote/accumulateSaida", method = RequestMethod.POST)
	public String pointbackFromSida(@RequestParam HashMap<String, String> paramMap, ModelMap modelMap,HttpServletRequest request, HttpServletResponse response) throws Exception {
		return remoteService.accumulateSaida(paramMap, modelMap, request, response);
	}
}
