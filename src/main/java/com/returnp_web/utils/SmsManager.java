package com.returnp_web.utils;

import java.util.HashMap;

import org.json.simple.JSONObject;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

public class SmsManager {
	public static final String api_key = "NCSV6EQBWICV7NGG";
	public static final  String api_secret = "U48NJOKTDPZCSMOAX8U9RAQUVQJ0ZUAU";
	
	private JSONObject result = null;
	
	public static JSONObject sendSms(String phoneNumber, String message) {
		Message coolsms = new Message(api_key, api_secret);
		HashMap<String, String> params = new HashMap<String, String>();
		params.put("to", phoneNumber);
	    params.put("from", "01088227467");
	    params.put("type", "SMS");
	    params.put("text", message);
	    params.put("app_version", "rpoint 25"); // application name and version
	    
	    JSONObject obj = null;
	    
	    try {
	      obj = (JSONObject) coolsms.send(params);
	      System.out.println(obj.toString());
	    } catch (CoolsmsException e) {
	      System.out.println(e.getMessage());
	      System.out.println(e.getCode());
	    }
	    return obj;
	}
}