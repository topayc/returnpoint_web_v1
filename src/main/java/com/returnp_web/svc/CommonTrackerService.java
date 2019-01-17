package com.returnp_web.svc;

/**
 * The Interface CommonTrackerService.
 */
public interface CommonTrackerService {
	
	/**
	 * Adds the.
	 *
	 * @param k the k
	 * @param v the v
	 * @throws Exception the exception
	 */
	void add(String k, String v) throws Exception;
	
	/**
	 * To str.
	 *
	 * @return the string
	 * @throws Exception the exception
	 */
	String toStr() throws Exception;
	
}
