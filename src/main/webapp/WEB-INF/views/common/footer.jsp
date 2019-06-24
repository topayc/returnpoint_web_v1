<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="f" uri="/WEB-INF/tld/f.tld" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 완료 -->
<%-- <c:choose>
	<c:when test="${FOOTER.company.copyright != null && FOOTER.company.copyright != '' }">    
    <div class="_footer">
        <div class="_footer_box1 col-lg-3 col-xs-12">
            <span><a href="/company/privacy.do"><spring:message code="label.web.personalInformationHandlingAndHandlingPolicy"/></a></span>
            <span><a href="/company/customerInfo.do"><spring:message code="label.web.termsAndConditions"/></a></span>
            <span><a data-toggle="modal" href=".modal1"><spring:message code="label.web.emailCollectingProhibition"/></a></span>
        </div>
   		<div class="_footer_box2 col-lg-7 col-xs-12">
			<c:if test="${FOOTER.company.companyName != null && FOOTER.company.companyName != ''}">					
				<span>(주) 탑해피월드</span>
			</c:if>
			<c:if test="${FOOTER.company.companyTel != null && FOOTER.company.companyTel != ''}">	
				<span>TEL : ${FOOTER.company.companyTel}</span>
			</c:if>
			<c:if test="${FOOTER.company.corporateType != null && FOOTER.company.corporateType != ''}">			
				<span>${FOOTER.company.corporateType}</span><br>
			</c:if>
			<c:if test="${FOOTER.company.companyeEmail != null && FOOTER.company.companyeEmail != ''}">	
				<span>${FOOTER.company.companyeEmail}</span>
			</c:if>	
			<c:if test="${FOOTER.company.corporateRegistNumber != null && FOOTER.company.corporateRegistNumber != ''}">				
				<span>사업자등록번호: ${FOOTER.company.corporateRegistNumber}</span><br>
			</c:if>
			<c:if test="${FOOTER.company.operatingHours != null && FOOTER.company.operatingHours != ''}">			
				<span>고객센터 운영시간: ${FOOTER.company.operatingHours}</span>
			</c:if>
			<c:if test="${FOOTER.company.companyAddress != null && FOOTER.company.companyAddress != ''}">	
				<span>${FOOTER.company.companyAddress}</span><br>
			</c:if>	
			<c:if test="${FOOTER.company.copyright != null && FOOTER.company.copyright != ''}">				
				<span>${FOOTER.company.copyright}</span>
			</c:if>	
	        </div>
	</div>
	</c:when>
	<c:otherwise> --%>
    <div class="_footer">
        <div class="_footer_box1 col-lg-3 col-xs-12">
            <span><a href="/company/privacy.do"><spring:message code="label.web.personalInformationHandlingAndHandlingPolicy"/></a></span>
            <span><a href="/company/customerInfo.do"><spring:message code="label.web.termsAndConditions"/></a></span>
            <span><a data-toggle="modal" href=".modal1"><spring:message code="label.web.emailCollectingProhibition"/></a></span>
        </div>
   		<div class="_footer_box2 col-lg-7 col-xs-12">
	            <span><spring:message code="label.web.tophappyworld"/></span>
	            <span>TEL : 02-585-5993</span>
	            <span><spring:message code="label.web.tophappyworldBusiness"/></span><br>
	            <span>RPHelp@returnp.com</span>
	            <span><spring:message code="label.web.tophappyworldBusinessLicenseNumber"/>: 754-86-01056</span><br>
	            <span><spring:message code="label.web.tophappyworldCustomerCenterOperationHours"/>: 10시 ~ 12 시, 14시 ~ 18시</span>
	            <span><spring:message code="label.web.tophappyworldAddress"/></span><br>
	            <span>Copyright&copy;returnp All rights reserved.</span>
	    </div>
	</div>
<%-- 	</c:otherwise>
</c:choose> --%>
    <div class="modal fade modal1" data-backdrop="static" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content1 col-lg-12">
                <div class="modal_top">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span class="modal_close" aria-hidden="true">&times;</span></button>
                    <p class="modal1_text1">ReturnP</p>
                </div>
                <div class="modal1_conbox">
                    <p class="modal1_text2"><spring:message code="label.web.emailCollectingProhibitionMast"/> <span> <spring:message code="label.web.emailCollectingProhibitionSub"/></span></p>
                    <p class="modal1_text3"><spring:message code="label.web.emailCollectingProhibitionDetail"/></p>
                </div>
                <hr>
                <div class="modal_button">
                	<button type="button" class="btn btn-primary btn-lg fran_button" data-dismiss="modal" aria-label="Close" style="margin:auto;"><spring:message code="label.web.closebutton"/></button>
                </div>
            </div>
        </div>
    </div>
    <div id="commonAlertFrame"></div><!-- commonAlert 영역 -->