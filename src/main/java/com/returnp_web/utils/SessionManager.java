package com.returnp_web.utils;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class SessionManager
{
	protected HttpSession session;
	protected final Log logger = LogFactory.getLog(getClass());
	
	public SessionManager(HttpServletRequest request, HttpServletResponse response)
	{
		session = request.getSession();
	}
	
	private int memberNo;
	private String memberName;
	private String memberPhone;
	private String memberEmail;
	private String memberType;
	
	public String getMemberPhone() {
		return session.getAttribute("memberPhone") == null ? null : (String)session.getAttribute("memberPhone");
	}
	
	public void setMemberPhone(String memberPhone) {
		session.setAttribute("memberPhone", memberPhone);
	}
	public int getMemberNo(){
		return session.getAttribute("memberNo") == null ? null : (int)session.getAttribute("memberNo");
	}
	public void setMemberNo(int memberNo){
		session.setAttribute("memberNo", memberNo);
	}

	public String getMemberName(){
		return session.getAttribute("memberName") == null ? null : (String)session.getAttribute("memberEmail");
	}
	public void setmemberName(String memberName){
		session.setAttribute("memberName", memberName);
	}
	
	public String getMemberEmail(){
		return session.getAttribute("memberEmail") == null ? null : (String)session.getAttribute("memberEmail");
	}
	public void setMemberEmail(String memberEmail){
		session.setAttribute("memberEmail", memberEmail);
	}
	
	public String getMemberType(){
		return session.getAttribute("memberType") == null ? null : (String)session.getAttribute("memberType");
	}
	public void setMemberType(String memberType){
		session.setAttribute("memberType", memberType);
	}
	
	public void killSession(){
		try{
			Enumeration keys = session.getAttributeNames();
			while (keys.hasMoreElements()){
				session.removeAttribute(keys.nextElement().toString());
			}
		}
		catch(Exception e) {}
	}
	
}