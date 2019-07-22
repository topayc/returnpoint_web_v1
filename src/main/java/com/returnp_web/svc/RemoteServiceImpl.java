package com.returnp_web.svc;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.ui.ModelMap;

import com.returnp_web.controller.dto.ObjectResponse;
import com.returnp_web.controller.dto.ReturnpBaseResponse;
import com.returnp_web.dao.DeviceDao;
import com.returnp_web.utils.ResponseUtil;
import com.returnp_web.utils.SessionManager;
import com.returnp_web.utils.Util;

@PropertySource("classpath:/config.properties")
@Service
public class RemoteServiceImpl implements RemoteService {

	@Autowired private MessageSource messageSource;
	@Autowired Environment environment;
	
	@Override
	public String accumulateSaida(HashMap<String, String> paramMap, ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) {
		String runMode = environment.getProperty("run_mode");
		String remoteCallURL = environment.getProperty(runMode + ".saida_accumulate_point");
		String key = environment.getProperty("key");
		StringBuffer response2 = null;
		try {
			URL url = new URL(remoteCallURL + "?" + Util.mapToQueryParam(paramMap));
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setDoInput(true);
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			con.setRequestMethod("GET");
			int responseCode = con.getResponseCode();
			BufferedReader in = null;
			if (responseCode == HttpURLConnection.HTTP_OK) {
				in = new BufferedReader(new InputStreamReader(con.getInputStream()));
				String inputLine;
				response2 = new StringBuffer();
				while ((inputLine = in.readLine()) != null) {
					response2.append(inputLine);
				}
				in.close();
				//System.out.println("응답");
				//System.out.println(response2.toString());
			} else {
				System.out.println("Saida 포인트 백 적립 요청 에러");
			}
			//System.out.println("Saida  포인트 백 적립 요청");
			//System.out.println(remoteCallURL + "?" + Util.mapToQueryParam(paramMap));
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return response2.toString();
	}
	
}
