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
<link rel="stylesheet" href="/resources/css/common.css">
<!-- js -->

<script type="text/javascript" src="/resources/js/lib/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/common.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var pageContextlocale = '${pageContext.response.locale}';
	$("#sel1").val(pageContextlocale);
});
</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_qr">	
	<!-- nav -->
	<jsp:include page="/WEB-INF/views/common/topper.jsp" />
	<!-- nav -->
		<h4>Point info</h4>
	</header> 
	<!-- content begin -->
	<c:choose>
	<c:when test="${model.qr_parsing_result=='success'}">
	<section>
		<div class="page point qrinfo">
			<div class="qrimg"><img src="${model.qrAccessUrl}"></div>
			<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.qramountAcc}" pattern="###,###,###,###"/></span> 적립</div>
				<ul class="pointinfo">
				<input type = "hidden" class = "returnp_qr"  id ="qr_org"  value = "${model.qr_org}" />
				<input type = "hidden" class = "returnp_qr"  id ="pay_type" value = "${model.pay_type}"/>
				<input type = "hidden" class = "returnp_qr"  id ="pam" value = "${model.pam}"/>
				<input type = "hidden" class = "returnp_qr"  id ="af_id" value = "${model.af_id}"/>
				<input type = "hidden" class = "returnp_qr"  id ="pat" value = "${model.pat}"/>
				<input type = "hidden" class = "returnp_qr"  id ="pan" value = "${model.pan}"/>
				<input type = "hidden" class = "returnp_qr"  id ="pas" value = "${model.pas}"/>
				<li><span>결제 방식</span> ${model.qr_pay_type_str}</li>
				<li><span id = "pam" >결제 금액</span> <fmt:formatNumber value="${model.pam}" pattern="###,###,###,###"/></li>
				<li><span>가맹 점이름</span> ${model.affiliateName}</li>
				<li><span>가맹점 코드</span> ${model.af_id}</li>
				<li><span>승인 일자</span> ${model.pat}</li>
				<li><span>승인 번호</span> ${model.pan}</li>
				<li style = "display: none"><span >승인 상태</span> ${model.pas}</li>
				<li><span  >승인 상태</span> ${model.pas_str}</li>
			</ul>	
		</div>			
		<div class="btns2">
			<button type="button" class="btn btn-submit" onclick = "startPointBack()">확인</button>
			<button type="button" class="btn btn-submit-cancel"  onclick = "history.back()">취소</button>
		</div>
	</section>
	</c:when>
	<c:otherwise>
	<section class="qr_nodata"><!-- 0824 -->
		<div> 
			<i class="fas fa-exclamation-triangle"></i>유효하지 않는 QR 코드입니다 
		</div>
		<button type="button" class="btn btn-submit"  onclick = "history.back()">취소</button>
	</section>	
	</c:otherwise>
	</c:choose>
	<!-- content end -->
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<!-- footer -->		
</div>
	<!-- privacy policy modal -->
	<jsp:include page="../company/m_privacypolicy.jsp" flush="false" />
	<!-- privacy policy modal end -->
	<!-- terms of ues modal -->
	<jsp:include page="../company/m_termsofuse.jsp" flush="false" />
	<!-- terms of ues modal end -->
</body>
<!-- body end -->
</html>