package com.returnp_web.utils;

import java.util.Map;

public class EmailVO<object>{

    private String subject;                         // 제목
    private String content;                         // 내용
    private String receiver;                        // 받는사람
    private String htmlYn;                          // html 사용 여부
    private String from;                            // 보낸사람
    private String regUsr;                          // 등록자(로그에 사용하기 위함) 
    private String veloTemplate;                    // Velocity 템플릿 파일

    private Map<String, String> emailMap = null; //velocity에서 사용하기 위한 map 객체

    public String getSubject(){
        return subject;
    }

    public void setSubject(String subject){
        this.subject = subject;
    }
    
    public String getContent(){
        return content;
    }

    public void setContent(String content){
        this.content = content;
    }
    
    public String getReceiver(){
        return receiver;
    }

    public void setReceiver(String receiver){
        this.receiver = receiver;
    }

    public String getHtmlYn(){
        return htmlYn;
    }

    public void setHtmlYn(String htmlYn){
        this.htmlYn = htmlYn;
    }

    public String getFrom(){
        return from;
    }

    public void setFrom(String from){
        this.from = from;
    }

    public String getRegUsr(){
        return regUsr;
    }

    public void setRegUsr(String regUsr){
        this.regUsr = regUsr;
    }

    public String getVeloTemplate(){
        return veloTemplate;
    }

    public void setVeloTemplate(String veloTemplate){
        this.veloTemplate = veloTemplate;
    }

	public Map<String, String> getEmailMap(){
		return emailMap;
	}

	public void setEmailMap(Map<String, String> emailMap){
		this.emailMap = emailMap;
	}
	
}