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
<script type="text/javascript" src="/resources/js/lib/jquery.animateNumber.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var pageContextlocale = '${pageContext.response.locale}';
	$("#sel1").val(pageContextlocale); 
	
	var comma_separator_number_step = $.animateNumber.numberStepFactories.separator(',')
	var accCount = ${model.qramountAcc};
	$('#accPoint').animateNumber(
		{ 
			number: accCount, 
			numberStep: comma_separator_number_step
		});
	if ($(".qr_kicc").length > 0){
		$(".text").fadeIn(200);
	}
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
		<h4><spring:message code="label.point_acc_info" /></h4>
	</header> 
	<!-- content begin -->
	<c:choose>
	<c:when test="${model.qr_parsing_result=='success'}">
	<section>
		<div class="page point qrinfo">
			<div class="qrimg"><img src="${model.qrAccessUrl}"></div>
			<div class="listpoint">
				<span id = "accPoint" style = "font-weight: 500;font-size : 40px"></span></br>
				<c:choose>
					<c:when test="${model.routerMap.status == '1'}">
						<small>P</small> <spring:message code="label.acc_word" />
					</c:when>
					<c:otherwise>
					<div class="qr_kicc" >
						<p class = "text" style = "display:none">
							<c:if test  = "${model.paymentRouterName == 'KICC' }"> 올페이먼트를 통하여 설치된 단말기의 </c:if>${model.paymentRouterName} 밴사의 적립은 현재 중지중입니다. </br>영수증 적립 서비스를 이용해주세요
							</br>자세한 내용은 공지를 참고해주세요
						</p>
					</div>
					</c:otherwise>
				</c:choose>
			</div>
			<ul class="pointinfo">
				<input type = "hidden" class = "returnp_qr"  id ="qr_org"  value = "${model.qr_org}" />
				<input type = "hidden" class = "returnp_qr"  id ="pay_type" value = "${model.pay_type}"/>
				<input type = "hidden" class = "returnp_qr"  id ="pam" value = "${model.pam}"/>
				<input type = "hidden" class = "returnp_qr"  id ="af_id" value = "${model.af_id}"/>
				<input type = "hidden" class = "returnp_qr"  id ="pat" value = "${model.pat}"/>
				<input type = "hidden" class = "returnp_qr"  id ="pan" value = "${model.pan}"/>
				<input type = "hidden" class = "returnp_qr"  id ="pas" value = "${model.pas}"/>
				
				<!-- KICC 외의 다른 밴일 경우는 아래의 2개의 태그가 생성되어, 적립시 서버로 전송됨 -->
				<c:if test = "${not empty model.paymentRouterType}"> <input type = "hidden" class = "returnp_qr"  id ="paymentRouterType" value = "${model.paymentRouterType}"/> </c:if>
				<c:if test = "${not empty model.paymentRouterName}"> <input type = "hidden" class = "returnp_qr"  id ="paymentRouterName" value = "${model.paymentRouterName}"/> </c:if>
				<c:if test = "${not empty model.seq}"> <input type = "hidden" class = "returnp_qr"  id ="seq" value = "${model.seq}"/> </c:if>
				
				<li><span  class = "gift_qr_title"><spring:message code="label.payment_method" /></span> ${model.pay_type_str}</li>
				<li><span id = "pam"  class = "gift_qr_title" ><spring:message code="label.amount_of_payment" /></span> <fmt:formatNumber value="${model.pam}" pattern="###,###,###,###"/></li>
				<li><span  class = "gift_qr_title"><spring:message code="label.merchange_name" /></span> ${model.affiliateName}</li>
				<li><span  class = "gift_qr_title"><spring:message code="label.unit_code" /></span> ${model.af_id}</li>
				<li><span  class = "gift_qr_title"><spring:message code="label.approval_date" /></span> ${model.pat}</li>
				<li><span  class = "gift_qr_title"><spring:message code="label.approval_number" /></span> ${model.pan}</li>
				<li style = "display: none"><span ><spring:message code="label.approval_status" /></span> ${model.pas}</li>
				<li><span   class = "gift_qr_title"><spring:message code="label.approval_status" /></span> ${model.pas_str}</li>
				<li><span   class = "gift_qr_title">VAN</span> ${model.paymentRouterName}</li>
			</ul>	
		</div>			
		<div class="btns2">
			<c:if test = "${model.routerMap.status == '1'}">
				<button type="button" class="btn btn-submit" onclick = "startPointBack()"><spring:message code="label.ok" /></button>
			<button type="button" class="btn btn-submit-cancel"  onclick = "history.back()"><spring:message code="label.cancel" /></button>
			</c:if>
		</div>
	</section>
	</c:when>
	<c:otherwise>
	<section class="qr_nodata"><!-- 0824 -->
		<div> 
			<i class="fas fa-exclamation-triangle"></i>${model.qr_parsing_error_message}
			<button type="button" class="btn btn-submit"  onclick = "history.back()"><spring:message code="label.cancel" /></button>
		</div>
	</section>	
	</c:otherwise>
	</c:choose>
	<!-- content end -->	
</div>
<div id = "progress_loading2" style = "display:none;color : #aaa;font-size : 30px;top:50%"> <i class="fas fa-circle-notch fa-spin"></i> </div>
</body>
<!-- body end -->
</html>