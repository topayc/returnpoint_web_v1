package com.returnp_web.svc;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.ui.ModelMap;

import com.returnp_web.controller.dto.ReturnpBaseResponse;
import com.returnp_web.dao.FrontMainDao;
import com.returnp_web.utils.ResponseUtil;
import com.returnp_web.utils.SessionManager;

@Service
public class DeviceServiceImp implements DeviceService {
	
	@Autowired private FrontMainDao frontMainDao;
	
	@Override
	public ReturnpBaseResponse registPushToken(HashMap<String, Object> paramMap, ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) {
		ReturnpBaseResponse res = new ReturnpBaseResponse();
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);
		
		dbparams.put("memberNo", sm.getMemberNo());
		HashMap<String,Object> deviceInfo = this.frontMainDao.selectDeviceInfo(dbparams);
		if (deviceInfo == null) {
			dbparams.put("memberName", sm.getMemberName());
			dbparams.put("memberPhone", sm.getMemberPhone());
			dbparams.put("memberEmail", sm.getMemberEmail());
			dbparams.put("os", (String)paramMap.get("os"));
			dbparams.put("pushKey", (String)paramMap.get("token"));
			this.frontMainDao.registPushToken(dbparams);
		}else {
			dbparams.put("osName", (String)paramMap.get("os"));
			dbparams.put("pushKey", (String)paramMap.get("token"));
			this.frontMainDao.updateDeviceInfo(dbparams);
		}
		
		try {
			ResponseUtil.setResponse(res, ResponseUtil.RESPONSE_OK, "100", "토큰 등록 성공");
			return res;
		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ResponseUtil.setResponse(res, ResponseUtil.RESPONSE_ERROR, "2000","토큰 등록 오류 발생");
			return res;
		}
	}

}
