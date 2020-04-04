package com.returnp_web.utils;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Random;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;

import net.sf.json.JSONObject;

/**
 * 공통함수를 위한  클래스.
 *
 * @version 1.0
 */
public class Util {

	/** The Constant logger. */
	private static final Logger logger = LoggerFactory.getLogger(Util.class);
	
	public static String encodeURIComponent(String s)
	  {
	    String result = null;
	 
	    try
	    {
	      result = URLEncoder.encode(s, "UTF-8")
	                         .replaceAll("\\+", "%20")
	                         .replaceAll("\\%21", "!")
	                         .replaceAll("\\%27", "'")
	                         .replaceAll("\\%28", "(")
	                         .replaceAll("\\%29", ")")
	                         .replaceAll("\\%7E", "~");
	    }
	 
	    // This exception should never occur.
	    catch (UnsupportedEncodingException e)
	    {
	      result = s;
	    }
	 
	    return result;
	  }
	
	public static void encodingURIMap(HashMap<String, String> map) {
		for (Map.Entry<String, String> entry : map.entrySet()) {
		     String key = entry.getKey();
		     Object value = entry.getValue();
		 }
	}
	
	
	
	private static final int NOPOS = -1;

	/**
	 * To so map.
	 *
	 * @param from the from
	 * @return the SO map
	 */
	public static RPMap toRPap(Map<String, Object> from) {
		RPMap to = new RPMap();
		Set<String> set = from.keySet();
		for (String s:set) {
			to.put(s, from.get(s));
		}

		return to;
	}
	
	public static void  copyRPmapToMap(RPMap rpMap, HashMap<String, String> map) {
		Set<String> set = map.keySet();
		for (String s:set) {
			rpMap.put(s, map.get(s));
		}
	}

	public static String mapToQueryParam(HashMap<String, String> source) {
		ArrayList<String> qList = new ArrayList<String>();
		Set<String> set = source.keySet();
		for (String s:set) {
			qList.add(String.format("%s=%s", s, source.get(s)));
		}
		String[]  re  = qList.toArray(new String[qList.size()]);
		return org.apache.commons.lang3.StringUtils.join(re, "&");
	}
	/**
	 * 현재 URL
	 *
	 * @param isQuery the is query
	 * @return the self url
	 */
	public static String getSelfURL(boolean isQuery){
		return isQuery ? 
				String.format("%s?%s", ServletRequestInfoUtil.getServletPath(), ServletRequestInfoUtil.getQueryString()) 
				: ServletRequestInfoUtil.getServletPath();
	}
	
		
	/**
	 * 절대값
	 *
	 * @param val the val
	 * @return the string
	 */
	public static String Abs(int val) {
		return Converter.toStr(Math.abs(val));
	}
		
	/**
	 * Prints the result.
	 *
	 * @param code the code
	 * @param msg the msg
	 * @param params the params
	 * @return the string
	 */
	public static String printResult(int code, String msg, HashMap<String,Object> params) {
		JSONObject json = new JSONObject();
		JSONObject _json = new JSONObject();
		
		_json.put("code", code);
		_json.put("msg", msg.replaceAll("\"", "\\\""));
		
		if (params != null) {
			ArrayList< String > keys = new ArrayList<String>( ) ; 
			Iterator iterator = params.entrySet().iterator( ) ; 
			
			while( iterator.hasNext( ) ) { 
				Entry entry = (Entry)iterator.next( ) ;
				//_json.put(entry.getKey(), "'" + entry.getValue() + "'");
				_json.put(entry.getKey(), entry.getValue());
			}
		}
		
		_json.put("eof", "0");
		json.put("result", _json);
		
		return json.toString();
	}
	

	/**
	 * Gets the SO rmap.
	 *
	 * @return the SO rmap
	 */
	public static RPMap getRPRmap() {
		return getRPRmap(null);
	}
	
	/**
	 * Gets the SO rmap.
	 *
	 * @param defaultpage the defaultpage
	 * @return the SO rmap
	 */
	public static RPMap getRPRmap(String defaultpage) {
		RPMap rmap = new RPMap();
		RPMap vmap = new RPMap();
		rmap.put("var", vmap);
		rmap.put(Const.D_VIEW_PAGE_KEY, defaultpage == null ? "" : defaultpage);
		return rmap;
	}
	
	/**
	 * Gets the SO vmap.
	 *
	 * @param rmap the rmap
	 * @return the SO vmap
	 */
	public static RPMap getSOVmap(RPMap rmap) {
		RPMap var = (RPMap) rmap.get("var");
		return var;
	}

	/**
	 * Gets the rmap.
	 *
	 * @return the rmap
	 */
	public static HashMap<String, Object> getRmap() {
		return getRmap(null);
	}
	
	// Use Controller
	/**
	 * Gets the rmap.
	 *
	 * @param defaultpage the defaultpage
	 * @return the rmap
	 */
	@Deprecated
	public static HashMap<String, Object> getRmap(String defaultpage) {
		HashMap<String, Object> rmap = new HashMap<String, Object>();
		HashMap<String, Object> var = new HashMap<String, Object>();
		rmap.put("var", var);
		rmap.put(Const.D_VIEW_PAGE_KEY, defaultpage == null ? "" : defaultpage);

		return rmap;
	}

	// Use Service
	/**
	 * Gets the vmap.
	 *
	 * @param rmap the rmap
	 * @return the vmap
	 */
//	@Deprecated
	public static HashMap<String, Object> getVmap(Map<String, Object> rmap) {
		@SuppressWarnings("unchecked")
		HashMap <String, Object> var = (HashMap<String, Object>) rmap.get("var");
		return var;
	}
	

	/**
	 * Jsmsg.
	 *
	 * @param msg the msg
	 * @return the string
	 */
	public static String jsmsg(String msg) {
		return jsmsg(msg, "");
	}
	
	/**
	 * Jsmsg.
	 *
	 * @param msg the msg
	 * @param code the code
	 * @return the string
	 */
	public static String jsmsg(String msg, String code) {
		return String.format("__jsmsg('%s', '%s');", msg, code);
	}

	/**
	 * Jsmsg reload.
	 *
	 * @param msg the msg
	 * @param code the code
	 * @return the string
	 */
	public static String jsmsgReload(String msg, String code) {
		return String.format("__jsmsgReload('%s', '%s');", msg, code);
	}

	/**
	 * Jsmsg close.
	 *
	 * @param msg the msg
	 * @return the string
	 */
	public static String jsmsgClose(String msg) {
		return String.format("__jsmsgClose('%s');", msg);
	}

	/**
	 * Goto url.
	 *
	 * @param msg the msg
	 * @return the string
	 */
	public static String gotoURL(String msg) {
		return gotoURL(msg, "");
	}
	
	/**
	 * Goto url.
	 *
	 * @param msg the msg
	 * @param code the code
	 * @return the string
	 */
	public static String gotoURL(String msg, String code) {
		return String.format("__gotoURL('%s', '%s');", msg, code);
	}
	
	/**
	 * Jsmsg link.
	 *
	 * @param msg the msg
	 * @param url the url
	 * @param mode the mode
	 * @return the string
	 */
	public static String jsmsgLink(String msg, String url, String mode) {
		return String.format("__jsmsgLink('%s', '%s', '%s');", msg, url, mode);
	}
	
	/**
	 * Page reload.
	 *
	 * @param mode the mode
	 * @return the string
	 */
	public static String pageReload(String mode) {
		return String.format("__pageReload('%s');", mode);
	}
	
	/**
	 * Checks for text.
	 *
	 * @param str the str
	 * @return true, if successful
	 */
	public static boolean hasText(String str) {
		return StringUtils.hasText(str);
	}
	
	public static boolean hasAllText(String ...strings) {
		for (String s : strings) {
			if (! hasText(s)) return false;
		}
		return true;
	}
	
	public static String sha(String password) {
		try {
	        MessageDigest digest = MessageDigest.getInstance("SHA-256");
	        byte[] hash = digest.digest(password.getBytes("UTF-8"));
	            StringBuffer hexString = new StringBuffer();
	 
	        for (int i = 0; i < hash.length; i++) {
	                String hex = Integer.toHexString(0xff & hash[i]);
	                if (hex.length() == 1)
	                    hexString.append('0');
	            hexString.append(hex);
	        }
	        
	        return hexString.toString() ;
		} catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException();
		}
	}
	
	/**
	 * Flag2 bool.
	 *
	 * @param val the val
	 * @return true, if successful
	 */
	public static boolean flag2Bool(String val) {
		return "T".equals(val);
	}
	
	
	/**
	 * random 6 number.
	 *
	 * @param val the val
	 * @return true, if successful
	 */
	public static String randomNumber() {
	    int num = (int) (Math.random() * 1000000) + 1;
	    
	    String pattern = "%06d"; // 6자리를 좌측에 0으로 채워줌
	    String value = String.format(pattern, num);

		return value;
	}
	
	/**
	 * random 8 number lower.
	 *
	 * @param val the val
	 * @return true, if successful
	 */
	public static StringBuffer randomNumberLower() {
		Random rnd =new Random();
		StringBuffer buf =new StringBuffer();

		for(int i=0;i<8;i++){
		    if(rnd.nextBoolean()){
		        buf.append((char)((int)(rnd.nextInt(26))+97));
		    }else{
		        buf.append((rnd.nextInt(10)));
		    }
		}
		return buf;
	}
	
	
	/**
	 * <p>unsigned byte(바이트) 배열을 16진수 문자열로 바꾼다.</p>
	 * 
	 * <pre>
	 * ByteUtils.toHexString(null)                   = null
	 * ByteUtils.toHexString([(byte)1, (byte)255])   = "01ff"
	 * </pre>
	 * 
	 * @param bytes unsigned byte's array
	 * @return
	 * @see HexUtils.toString(byte[])
	 */
	public static String toHexStringFromBytes(byte[] bytes) {
		if (bytes == null) {
			return null;
		}
		StringBuffer result = new StringBuffer();
		for (byte b : bytes) {
			result.append(Integer.toString((b & 0xF0) >> 4, 16));
			result.append(Integer.toString(b & 0x0F, 16));
		}
		return result.toString();
	}
	
	/**
	 * <p>16진수 문자열을 바이트 배열로 변환한다.</p>
	 * <p>문자열의 2자리가 하나의 byte로 바뀐다.</p>
	 * 
	 * <pre>
	 * ByteUtils.toBytesFromHexString(null)     = null
	 * ByteUtils.toBytesFromHexString("0E1F4E") = [0x0e, 0xf4, 0x4e]
	 * ByteUtils.toBytesFromHexString("48414e") = [0x48, 0x41, 0x4e]
	 * </pre>
	 * 
	 * @param digits 16진수 문자열
	 * @return
	 * @throws NumberFormatException
	 * @see HexUtils.toBytes(String)
	 */
	public static byte[] toBytesFromHexString(String digits) throws IllegalArgumentException, NumberFormatException {
		if (digits == null) {
			return null;
		}
    	int length = digits.length();
    	if (length % 2 == 1) {
    		throw new IllegalArgumentException("For input string: \"" + digits + "\"");
    	}
    	length = length / 2;
    	byte[] bytes = new byte[length];
    	for (int i = 0; i < length; i++) {
    		int index = i * 2;
    		bytes[i] = (byte)(Short.parseShort(digits.substring(index, index+2), 16));
    	}
    	return bytes;
	}

	public static HashMap<String, String> queryToMap(String queryParam){
		HashMap<String, String> map = new HashMap<String, String>();
		String[] params = queryParam.split("&");
		for (int i = 0; i < params.length; i++) {
			String key = params[i].split("=")[0].trim();
			String value = params[i].split("=")[1].trim();
			map.put(key, value);
		}
		return map;
	}

	public static String reverseString(String s) {
	    return ( new StringBuffer(s) ).reverse().toString();
	  }
	
	
	public static HashMap<String, String> parseQRtoMap(HashMap<String, String> map, String key) {
		HashMap<String, String> qrMap = new HashMap<String, String>();
		String encData = map.get(key);
		String[] encArr = encData.split("!");
		
		String field1 = encArr[0].trim();
		String field2 = encArr[1].trim();
		
		String qrPText = 
			AntiLogarithm62.convertBase62toBase10(AntiLogarithm62.strEachReverse(field1)) +
			AntiLogarithm62.convertBase62toBase10(AntiLogarithm62.strEachReverse(field2));
		
		/*VAN 시간을 내부 포맷으로 변경*/
		SimpleDateFormat sdf1= new SimpleDateFormat("yyssMMmmDDhh");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		System.out.println("승인 시간");
		try {
			System.out.println(qrPText.substring(0, 12));
			System.out.println(sdf1.parse(qrPText.substring(0, 12)));
			System.out.println(sdf2.format(sdf1.parse(qrPText.substring(0, 12))));
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			qrMap.put("pat", sdf2.format(sdf1.parse(qrPText.substring(0, 12))));  //승인시간
			qrMap.put("pan", qrPText.substring(12, 16) + qrPText.substring(23, 27));   // 승인 번호
			qrMap.put("af_id", qrPText.substring(16, 23));  // 가맹점 번호
			qrMap.put("pam", String.valueOf(Integer.valueOf(qrPText.substring(27, 35))));    //승인 금액
			qrMap.put("pas", qrPText.substring(35));    //승인 상태 
			qrMap.put("pas_str", qrPText.substring(35).equals("0") ? "승인 완료" : "승인 취소");    //승인 상태 
		} catch (ParseException e) {
			e.printStackTrace();
		}  
		return qrMap;
	}
	
	public static String convertBase62toBase10(String base62) {
		if (base62 == null || base62.length() < 1) {
			return null;
		}

		int len = base62.length();
		double decimalValue = 0;
		int value = 0;

		for (int i = len - 1; i >= 0; i--) {
			char oneChar = base62.charAt(i);
			if (Character.isDigit(oneChar)) {
				value = Integer.parseInt(String.valueOf(base62.charAt(i)));
				decimalValue = decimalValue + (value * Math.pow(62, (len - 1) - i));
			} else {
				byte a = (byte) (oneChar);
				if (a <= 90) {
					value = (a - 65) + 10;
				} else if (a <= 122) {
					value = (a - 97) + 36;
				}
				decimalValue = decimalValue + (value * Math.pow(62, (len - 1) - i));
			}
		}

		return String.valueOf((long) decimalValue);
	}
	
	/**
	 * Dec quote.
	 *
	 * @param value the value
	 * @return the string
	 */
	public static String decQuote(String value) {
		return value == null ? "" : value.replaceAll("&#39;", "'").replaceAll("&quot;","\"");
	}
	
	
	/**
	 * Numeric To Currency
	 *
	 * @param vlaue the vlaue
	 * @return the string
	 */
	public static String num2Cur(String value) {
		DecimalFormat df = new DecimalFormat("###,###");

		String result="";
		if (hasText(value))
			result = df.format(Double.parseDouble(value));
			
		return result;
	}
}