package com.returnp_web.svc;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;

import com.returnp_web.controller.dto.ReturnpBaseResponse;

@Transactional
public interface DeviceService {
	public ReturnpBaseResponse registPushToken(HashMap<String, Object> paramMap, ModelMap map, HttpServletRequest request, HttpServletResponse response);
}
