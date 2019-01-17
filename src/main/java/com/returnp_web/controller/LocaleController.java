package com.returnp_web.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.returnp_web.i18n.LocaleManager;

@Controller
@RequestMapping("/locale")
public class LocaleController extends MallBaseController {
	/**
	 * 자바스크립트에서 로케일 세팅을 위해 요청된 메시지 프로퍼티 파일을 전송하는  컨트롤러 메서드
	 * 
	 * @param propertiesName  en, ko 등은 로케일 스트링
	 * @param response ajax 응답에 내용을 바로 전송하기 위한 출력 객체
	 */
	@RequestMapping("/properties/{propertiesName}.do")
	public void getLocaleProperties(@PathVariable String propertiesName, HttpServletResponse response) throws IOException {
		OutputStream outputStream = response.getOutputStream();
		Resource resource = new ClassPathResource(propertiesName + ".properties");
		InputStream inputStream = resource.getInputStream();

		List<String> readLines = (List<String>) IOUtils.readLines(inputStream);
		IOUtils.writeLines(readLines, null, outputStream);

		IOUtils.closeQuietly(inputStream);
		IOUtils.closeQuietly(outputStream);
	}
	
	/**
	 * 사용자가 셀렉트 박스를 통해서 로케일을 변경했을 때 호출됨 
	 * @param request   
	 * @param response
	 * @param locale     사용자가 선택한 로케일 스트링값(en, ko등의 값)
	 * @return
	 */
	@RequestMapping(value = "/change.do")
    public String changeLocale(HttpServletRequest request, 
    		HttpServletResponse response, 
    		@RequestParam(required = false) String lang, @RequestParam(required = false) String returnUrl) {
		
		Locale locale = new Locale(lang);
		if (locale != null){
			LocaleManager.setLocale(request, response, locale);
        }
		
        // step. 해당 컨트롤러에게 요청을 보낸 주소로 돌아간다.
        String redirectURL = "redirect:" + returnUrl;
        System.out.println("return URL :" + returnUrl);
        return redirectURL;
    }
}
