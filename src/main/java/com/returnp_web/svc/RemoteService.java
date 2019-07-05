package com.returnp_web.svc;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;

import com.returnp_web.controller.dto.ReturnpBaseResponse;

@Transactional
public interface RemoteService {
	public String accumulateSaida(HashMap<String, String> paramMap, ModelMap modelMap, HttpServletRequest request, HttpServletResponse response);
}
