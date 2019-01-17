<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
	<c:choose>
	<c:when test="${FOOTER.company.langLocale != null && FOOTER.company.langLocale != '' }">
		<footer>
		<c:if test="${FOOTER.company.copyright != null && FOOTER.company.copyright != '' }">
			<div>${FOOTER.company.copyright}</div>
		</c:if>
			<div>
				<span><a type="button" data-toggle="modal" data-target="#myprivacy">개인정보취급및처리방침</a></span> 
				<span><a type="button" data-toggle="modal" data-target="#myterms">이용약관</a></span> 
				<c:if test="${FOOTER.company.companyName != null && FOOTER.company.companyName != ''}">
					<span>${FOOTER.company.companyName}</span> 
				</c:if>
				<c:if test="${FOOTER.company.companyeEmail != null && FOOTER.company.companyeEmail != ''}">
					<span>${FOOTER.company.companyeEmail}</span> 
				</c:if>
				<c:if test="${FOOTER.company.corporateRegistNumber != null && FOOTER.company.corporateRegistNumber != ''}">
					<span>사업자등록번호: ${FOOTER.company.corporateRegistNumber}</span> 
				</c:if>
				<c:if test="${FOOTER.company.corporateType != null && FOOTER.company.corporateType != ''}">
					<span>${FOOTER.company.corporateType}</span> 
				</c:if>
				<c:if test="${FOOTER.company.operatingHours != null && FOOTER.company.operatingHours != ''}">
					<span>고객센터 운영시간: ${FOOTER.company.operatingHours}</span> 
				</c:if>
				<c:if test="${FOOTER.company.customerCenterTel != null && FOOTER.company.customerCenterTel != ''}">
					<span>고객센터 번호: ${FOOTER.company.customerCenterTel}</span> 
				</c:if>
				<c:if test="${FOOTER.company.privacyOfficer != null && FOOTER.company.privacyOfficer != ''}">
					<span>개인정보관리 책임자: ${FOOTER.company.privacyOfficer}</span> 
				</c:if>
				<c:if test="${FOOTER.company.ceo != null && FOOTER.company.ceo != ''}">
					<span>대표이사: ${FOOTER.company.ceo}</span> 
				</c:if>
				<c:if test="${FOOTER.company.companyAddress != null && FOOTER.company.companyAddress != ''}">
					<span>${FOOTER.company.companyAddress}</span> 
				</c:if>
				<c:if test="${FOOTER.company.companyTel != null && FOOTER.company.companyTel != ''}">
					<span>TEL : ${FOOTER.company.companyTel}</span>
				</c:if>
				<c:if test="${FOOTER.company.faxNumber != null && FOOTER.company.faxNumber != ''}">
					<span>FAX : ${FOOTER.company.faxNumber}</span>
				</c:if>
			</div>
		</footer>		
	</c:when>
	<c:otherwise>
		<footer>
		<div>
			<span>Copyrightⓒreturnp All rights reserved.</span>
			<span><a type="button" data-toggle="modal" data-target="#myprivacy"><spring:message code="label.myPrivacy" /></a></span> 
			<span><a type="button" data-toggle="modal" data-target="#myterms"><spring:message code="label.myTerms" /></a></span> 
		</div>
		<p>
		</p>
		</footer>	
	</c:otherwise>
	</c:choose>