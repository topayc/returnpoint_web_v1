package com.returnp_web.utils;

import java.io.UnsupportedEncodingException;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.log4j.Logger;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.ui.velocity.VelocityEngineUtils;

public class EmailSender {

	@Autowired
	protected JavaMailSender mailSender;

	@Resource(name="velocityEngine")
	VelocityEngine velocityEngine;

	Logger log = Logger.getLogger(this.getClass());

	/**
	 * 
	 * @param Subject 제목
	 * @param Receiver 받는사람
	 * @param HtmlYn 메일형식: 기본->'Y'
	 * @return
	 */
	public void sendVelocityEmail(EmailVO email){
		MimeMessage msg = mailSender.createMimeMessage(); 
        
		try{
			MimeMessageHelper helper = new MimeMessageHelper(msg, false);
			String veloTemplate = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "template/" + email.getVeloTemplate(), "UTF-8", email.getEmailMap());
			helper.setSubject(email.getSubject()); //제목
			helper.setFrom(new InternetAddress("webmaster@returnp.com", "returnp-webmaster")); //보내는사람
			helper.setTo(email.getReceiver()); //받는사람
			//if ( StringUtils.isEmpty(email.getHtmlYn()) == false && email.getHtmlYn().equals("Y") ) {
			if(org.apache.commons.lang3.StringUtils.isEmpty(email.getHtmlYn()) == false && email.getHtmlYn().equals("Y")){
				helper.setText(veloTemplate, true);
			}else{
				helper.setText(veloTemplate);
			}
		}catch(MessagingException e){
			log.error("mailSender error");
			log.debug(e.getMessage());
        } catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try{
			mailSender.send(msg);
		}catch(MailException e){
			log.error("Email MailException...");
			log.debug(e.getMessage());
		}
	}
}