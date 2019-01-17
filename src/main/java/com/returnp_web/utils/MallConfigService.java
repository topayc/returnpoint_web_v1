/**
 * 
 */
package com.returnp_web.utils;

import com.returnp_web.utils.RPMap;

/**
 * The Interface MallConfigService.
 *
 */
public interface MallConfigService {
	void setValue(String key, Object value) throws Exception;
	void setStr(String key, String value) throws Exception;
	void setString(String key, String value) throws Exception;
	void setInt(String key, int value) throws Exception;
	

	int getInt(String key) throws Exception;
	String getStr(String key) throws Exception;
	String getString(String key) throws Exception;
	String[] getStringArray(String key) throws Exception;
	String[] getStrArray(String key) throws Exception;

	String getRuntimeString(String key) throws Exception;
	boolean init(String domain) throws Exception;
	RPMap getMap() throws Exception;
	
	boolean getBool(String key) throws Exception;
	void setBool(String key, boolean value) throws Exception;
	
}
