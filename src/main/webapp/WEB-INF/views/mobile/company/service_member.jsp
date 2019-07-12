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
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_service_member">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4>Service</h4>
	</header> 	
	<section>
		<ul>
			<li>
				<aside><hr><h4>R 포인트란</h4></aside>
				<div class="content">
					<p>소비자의 구매로 인해 발생한  <spring:message code="label.gpoint" /> 를  포인트사용처에서 이용 가능한 <spring:message code="label.rpoint" /> 로 전환해 협력점 및 포인트 선물 등으로 사용할 수 있는 서비스입니다. </p>
					<ul class="comment">
						<li><strong>* <spring:message code="label.gpoint" /></strong> <span>종합 포인트 - 협력점에서 사용한 Point의 합.</span></li>
						<li><strong>* <spring:message code="label.rpoint" /></strong> <span>사용가능 포인트 - <spring:message code="label.gpoint" /> 발생 익일부터 지급하는 Point.</span></li>
						<li><strong>* 포인트 사용처</strong> <span>GLK 와 협력점, 토탈프라자, 해외 협력점.</span></li>
					</ul>
				</div>
			</li>
			<li>
				<aside><hr><h4>R 포인트 이용안내</h4></aside>
				<div class="content">
					<div class="step step_user">					
						<span class="title">소비자 <br class="mobile" /> Step<i class="fas fa-caret-right"></i></span>
						<span>회원가입 <br class="mobile" /> 및 앱설치<i class="fas fa-caret-right"></i></span>
						<span>협력점<br class="mobile" />상품구매<i class="fas fa-sort-down"></i></span>
						<span><spring:message code="label.rpoint" /> <br class="mobile" />전환 및 사용</span>
						<span><spring:message code="label.gpoint" /><br class="mobile" />적립<i class="fas fa-caret-left"></i></span>
						<span>영수증<br class="mobile" />QR 스캔<i class="fas fa-caret-left"></i></span>
					</div>
					<div class="step step_store">									
						<span class="title">협력점 <br class="mobile" /> Step<i class="fas fa-caret-right"></i></span>
						<span>회원 <br class="mobile" /> 가입<i class="fas fa-caret-right"></i></span>
						<span>협력점 <br class="mobile" /> 등록<i class="fas fa-sort-down"></i></span>
						<span><spring:message code="label.rpoint" /><br class="mobile" />전환 및 사용</span>
						<span><spring:message code="label.gpoint" /> <br class="mobile" />적립<i class="fas fa-caret-left"></i></span>
						<span>상품<br class="mobile" />판매<i class="fas fa-caret-left"></i></span>
				</div>
			</li>
			<li>
				<aside><hr><h4>R 포인트 적립및 사용방법 </h4></aside>
				<div class="content">
					<p><strong>[<spring:message code="label.gpoint" /> 적립방법]</strong> <span>협력점에 매출의 발생 할 때 마다 <spring:message code="label.gpoint" /> 가 적립됩니다.
					소비자는 매출의 100%를 <spring:message code="label.gpoint" /> 로 적립 받으며, 협력점은 매출의 15%의 매출 예치금을 현금으로 본사에 즉시 납입합니다</span>
					</p>
					<p><strong>[<spring:message code="label.rpoint" /> 적립방법]</strong> <span><spring:message code="label.gpoint" /> 발생 후 익일부터 <spring:message code="label.gpoint" /> 의 <strong>1/2000 </strong>이 매출 금액의100%가 될 때까지 R Pay로 적립됩니다.</span></p>
					<p><strong>[<spring:message code="label.rpoint" /> 사용방법]</strong> <span><spring:message code="label.gpoint" /> 에서 전환된 <spring:message code="label.rpoint" /> 는 포인트 사용처에서 이용 가능합니다.</span></p>
				</div>
			</li>
			<li>
				<aside><hr><h4>R 포인트 이용을 위한 서비스  </h4></aside>
				<div class="content service">
					<p><i class="far fa-credit-card"></i>카드 결제</p>
					<p><i class="fas fa-coins"></i>코인 결제</p>
					<p><i class="fas fa-map-marker-alt"></i>지역 찾기</p>
					<p><i class="fas fa-store"></i>협력점 <br />즉시 결제</p>
					<p><i class="fas fa-qrcode"></i>협력점 결제 후 <br />포인트적립</p>
					<p><i class="fas fa-print"></i>결제앱</p>
				</div>
			</li>
		</ul>
	</section>	
</div>
</body>
<!-- body end -->
</html>