package com.returnp_web.controller.common;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.net.URLDecoder;


public class papagoNMT {

	public static String KOREAN = "ko";
	public static String ENGLISH = "en";
	public static String CHINESE = "zh-CH";
	
	private static String clientId = "";//애플리케이션 클라이언트 아이디값";
	private static String clientSecret = "";//애플리케이션 클라이언트 시크릿값";
	private static String apiURL = " https://openapi.naver.com/v1/papago/n2mt";//파파고 API 서버 주소

	//차례대로 "변환할 언어", "변환될 언어", 변환할 문장"
	public static String translate(String source, String target, String text ) {
		
		try {
			//변환할 문장을 UTF-8 유니코드로 인코딩합니다.
			text = URLEncoder.encode(text, "UTF-8");
			
			//파파고 API 서버와 연결합니다.
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("POST");
			con.setRequestProperty("X-Naver-Client-Id", clientId);
			con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
			
			//파파고 API서버로 전달한 파라미터를 설정합니다.
			String postParams = "source="+source+"&target="+target+"&text="+text;
			
			//파파고 API로 번역할 문장을 전송합니다.
			con.setDoOutput(true);
			DataOutputStream wr = new DataOutputStream(con.getOutputStream());
			wr.writeBytes(postParams);
			wr.flush();
			wr.close();
			
			//파파고 API 서버로부터 번역된 메시지를 전달 받습니다.
			int responseCode = con.getResponseCode();
			BufferedReader br;
			
			//번역에 성공한 경우
			if(responseCode == 200) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			}else { //오류가 발생한 경우
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			//전달받은 메시지를 출력합니다.
			String inputLine;
			StringBuffer response =  new StringBuffer();
			while(( inputLine=br.readLine()) !=null ) {
				response.append(inputLine);
			}
			br.close();
			return response.toString();
		}catch(Exception e){
			return "파파고 API 통신 중에 오류가 발생했습니다.";
		}
	}
	
}