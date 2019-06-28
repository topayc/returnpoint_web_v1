package com.returnp_web.svc;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.ui.ModelMap;

import com.returnp_web.controller.dto.ObjectResponse;
import com.returnp_web.controller.dto.ReturnpBaseResponse;
import com.returnp_web.dao.DeviceDao;
import com.returnp_web.utils.ResponseUtil;
import com.returnp_web.utils.SessionManager;

@Service
public class DeviceServiceImp implements DeviceService {
	
	@Autowired 
	private DeviceDao deviceDao;
	
	@Override
	public ReturnpBaseResponse registPushToken(HashMap<String, Object> paramMap, ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) {
		ReturnpBaseResponse res = new ReturnpBaseResponse();
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);
		
		if (!paramMap.containsKey("token") ||  (String)paramMap.get("token") == null) {
			ResponseUtil.setResponse(res, ResponseUtil.RESPONSE_ERROR, "9076", "푸쉬 토큰이 존재하지 않습니다.");
			return res;
		}
		dbparams.put("memberNo", sm.getMemberNo());
		HashMap<String,Object> deviceInfo = deviceDao.selectDeviceInfo(dbparams);
		if (deviceInfo == null) {
			dbparams.put("memberNo", sm.getMemberNo());
			dbparams.put("memberName", sm.getMemberName());
			dbparams.put("memberPhone", sm.getMemberPhone());
			dbparams.put("memberEmail", sm.getMemberEmail());
			dbparams.put("os", (String)paramMap.get("os"));
			dbparams.put("pushKey", (String)paramMap.get("token"));
			deviceDao.registPushToken(dbparams);
		}else {
			dbparams.put("osName", (String)paramMap.get("os"));
			dbparams.put("pushKey", (String)paramMap.get("token"));
			deviceDao.updateDeviceInfo(dbparams);
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

	@Override
	public String getVersion(HashMap<String, Object> paramMap, ModelMap modelMap,
			HttpServletRequest request, HttpServletResponse response) {
		ObjectResponse<String> res = new ObjectResponse<String>();
		HashMap<String, Object> dbparams = new HashMap<String, Object>();
		try {
			HashMap<String, Object> versionMap = deviceDao.selectLastVersion(dbparams);
			String data = String.valueOf(versionMap.get("version")).trim()  + ":" + String.valueOf(versionMap.get("applyStatus")).trim();
			res.setData(data);
			ResponseUtil.setResponse(res, ResponseUtil.RESPONSE_OK, "100", "버젼 정보 가져오기 성공");
			//return res;
			return data;
		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ResponseUtil.setResponse(res, ResponseUtil.RESPONSE_ERROR, "2000","버젼 정보 가져오기 실패");
			return null;
		}
	}
}
