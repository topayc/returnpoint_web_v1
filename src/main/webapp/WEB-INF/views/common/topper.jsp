<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="f" uri="/WEB-INF/tld/f.tld" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <nav class="navbar navbar-default navbar-fixed-top main_nav navbar-dark bg-dark">
    <c:if test="${!fn:contains( pageContext.request.requestURI, 'index.jsp' )}"> <!-- GNB를 메인, 기타 페이지로 두개를 잡으면 좋겠지만 현상황에서는 우선은 시안을 기다릴 시간없으니 우선은 있는대로 진행하자고 하심. 안실장님-->
    	<a href="javascript:history.back()"><div class="back_button"></div></a>
	</c:if>
        <div class="after"><a href="/main/index.do"><br><br></a></div>
        <div class="container-fluid" style = "margin-top:14px">
            <div class="navbar-header main_img">
                <button type="button" class="navbar-toggle top_button" data-toggle="collapse" data-target="#mynavbar" aria-expanded="false" data-collapsed="true">
                    <span class="sr-only"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a href="/main/index.do"><img src="/resources/web_images/logo.png"></a>
            </div>
            <div class="collapse navbar-collapse" id="mynavbar">
                <ul class="nav navbar-nav nav_top">
                    <li><a href="/main/index.do"><spring:message code="label.web.home"/></a></li>
                    <li><a href="/company/company_identity.do"><spring:message code="label.web.companyIntroduction"/></a></li>
                    <li><a href="/company/service_member.do"><spring:message code="label.web.serviceInformation"/></a></li>
                    <li><a href="/board/franchisee_info.do"><spring:message code="label.web.findaMerchant"/></a></li>
                    <li><a href="/board/faq.do"><spring:message code="label.web.faq"/></a></li>
                    <li><a href="/board/notice.do"><spring:message code="label.web.notice"/></a></li>
                    <li><a href="/board/partner_ask.do"><spring:message code="label.web.affiliationGuide"/></a></li>
                    <li><select class="form-control main_form" id="sel1" onchange='javascript:changeLang(this.value)'>
							<option value="ko">Korea</option>
							<option value="en">English</option>
							<option value="ch">Chinese</option>
                        </select>
					</li>
                </ul>
            </div>
         </div>
    </nav>