<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="com.returnp_web.utils.SessionManager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html lang="en">
<head> 
<title>ReturnP</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge"><!-- 0710 ie가 edge로 맞춰지는 메타 추가 -->
<meta name="format-detection" content="telephone=no"/><!-- 0710 edge상에서 전화번호 자동인식으로 인한 메타 추가 -->
<!-- css   -->
<!-- font -->
<link rel="stylesheet" href="/resources/css/m_common.css">
<!-- js -->

<script type="text/javascript" src="/resources/js/lib/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/m_common.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var pageContextlocale = '${pageContext.response.locale}';
	$("#sel1").val(pageContextlocale); 
});
</script>
<style type="text/css">
.gift_qr_title{
	font-weight : bold
}
</style>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_qr">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4>${ model.title} </h4>
	</header> 
	<!-- content begin -->
	<c:choose>
	<c:when test="${model.result=='100'}">
	<section>
		<div class="page point qrinfo">
			<div class="qrimg"><img src="${model.qrAccessUrl}"></div>
			<div class="listpoint">
			<small>P</small>
				<span><fmt:formatNumber value="${fn:trim(model.issueMap.giftCardAmount)}" pattern="###,###,###,###"/></span> 
				<c:if test="${model.qr_cmd=='900'}">적립</c:if>
				<c:if test="${model.qr_cmd=='901'}">결제</c:if>
			</div>
				<ul class="pointinfo">
				<input type = "hidden"   id ="giftCardQrData"  value = "${model.giftCardQrData}" />
				<input type = "hidden"  id ="pinNumber"  value = "${model.issueMap.pinNumber}" />
				
				<li><span class = "gift_qr_title" ><spring:message code="label.gift_card_pin"/></span> ${model.issueMap.pinNumber}</li>
				<li><span class = "gift_qr_title"><spring:message code="label.gift_card_amount"/></span><fmt:formatNumber value="${fn:trim(model.issueMap.giftCardAmount)}" pattern="###,###,###,###"/> </li>
				
				<c:if test="${model.qr_cmd=='900'}">
				<li><span class = "gift_qr_title"><spring:message code="label.accable_status"/></span>${model.accableStatus}</li>
				<li><span class = "gift_qr_title"><spring:message code="label.amount_accumulated"/></span><fmt:formatNumber value="${fn:trim(model.issueMap.giftCardAmount)}" pattern="###,###,###,###"/></li>
				</c:if>
				
				<c:if test="${model.qr_cmd=='901'}">
				<li><span class = "gift_qr_title"><spring:message code="label.payable_status"/></span> ${model.payableStatus}</li>
				<li><span class = "gift_qr_title"><spring:message code="label.payment_amount"/></span><fmt:formatNumber value="${fn:trim(model.issueMap.giftCardAmount)}" pattern="###,###,###,###"/></li>
				</c:if>
				<li><span class = "gift_qr_title"><spring:message code="label.published_date"/></span> ${model.issueMap.issueTime}</li>
				<li><span class = "gift_qr_title"><spring:message code="label.expiration_date"/></span> ${model.issueMap.expirationTime}</li>
			</ul>	
		</div>			
		<div class="btns2">
			<button type="button" class="btn btn-submit" onclick = "startGiftCardProcess('${model.qr_cmd}', '${model.issueMap.giftCardStatus}' ,'${model.issueMap.accableStatus}', '${model.issueMap.payableStatus}')">
			<spring:message code="label.joinDesc04"/>
			</button>
			<button type="button" class="btn btn-submit-cancel"  onclick = "history.back()"><spring:message code="label.commonCancel"/></button>
		</div>
	</section>
	</c:when>
	<c:otherwise>
	<section class="qr_nodata"><!-- 0824 -->
		<div> 
			<i class="fas fa-exclamation-triangle"></i><spring:message code="${model.messageKey}"/>
		</div>
		<button type="button" class="btn btn-submit"  onclick = "history.back()"><spring:message code="label.joinDesc04"/></button>
	</section>	
	</c:otherwise>
	</c:choose>
	<!-- content end -->	
</div>
</body>
<!-- body end -->
</html>