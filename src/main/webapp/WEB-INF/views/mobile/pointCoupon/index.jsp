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
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="format-detection" content="telephone=no"/>
<!-- css   -->
<!-- font -->
<link rel="stylesheet" href="/resources/css/m_common.css">
<!-- js -->
<script type="text/javascript" src="/resources/js/lib/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/m_common.js"></script>
<script type="text/javascript" src="/resources/js/lib/m_point_gift.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var pageContextlocale = '${pageContext.response.locale}';
	$("#sel1").val(pageContextlocale);
});

</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_terms">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4>포인트 쿠폰</h4>
	</header> 	
	<section>
		<ul class="coupon_tab">
		   <li class="on" ><a href="#">적립요약</a>
		      <div class="coupon_contents">
		      	<div class="coupon_top">
		      		<div class="coupon_top1">
		      			<ul>
		      				<li class="code_text1">적립총액</li>
		      				<li class="code_text2">100,000</li>
		      			</ul>
		      		</div>
		      		<div class="coupon_top2">
		      			<ul>
		      				<li class="code_text1">사용가능</li>
		      				<li class="code_text2">10</li>
		      			</ul>
		      		</div>
		      		<div class="coupon_top3">
		      			<ul>
		      				<li class="code_text1">사용완료</li>
		      				<li class="code_text2">20</li>
		      			</ul>
		      		</div>
		      	</div>
		      	<div class="coupon_m">
		      		<div class="upload">영수증 업로드 하기</div>
		      		<div class="register">적립코드 등록하기</div>
		      	</div>
		      	<div class="coupon_code">
		      		<ul>
		      			<li>
		      				<ul>
		      					<li class="code_text1">1982-09-17</li>
		      					<li class="code_text2">코드:SDIJUYWGIOPLLSLFJN</li>
		      					<li class="code_text1">기준 금액 : 10,000</li>
		      					<li class="code_text1">적립 금액 : 10,000 (적립율 100%)</li>
		      				</ul>
		      			</li>
		      			<li>
		      				<ul>
		      					<li class="code_text1">1982-09-17</li>
		      					<li class="code_text2">코드:SDIJUYWGIOPLLSLFJN</li>
		      					<li class="code_text1">기준 금액 : 10,000</li>
		      					<li class="code_text1">적립 금액 : 10,000 (적립율 100%)</li>
		      				</ul>
		      			</li>
		      			<!--  코드 단 추가시 복사 붙여넣기 하시면되요 
		      			<li>
		      				<ul>
		      					<li class="code_text1">1982-09-17</li>
		      					<li class="code_text2">코드:SDIJUYWGIOPLLSLFJN</li>
		      					<li class="code_text1">기준 금액 : 10,000</li>
		      					<li class="code_text1">적립 금액 : 10,000 (적립율 100%)</li>
		      				</ul>
		      			</li>--->
		      		</ul>
		      	</div>
		      </div>
		   </li>
		   <li><a href="#">업로드내역</a>
		      <div class="coupon_contents">
		        2번내용
		      </div>
		   </li>
		   <li><a href="#" style="left:50%;">사용완료</a>
		      <div class="coupon_contents">
		        3번내용
		      </div>
		   </li>
		   <li><a href="#"style="left:75%;">사용가능</a>
		      <div class="coupon_contents">
		        4번내용
		      </div>
		   </li>
		</ul>
   </section>
</div>
<script>
	$(".coupon_tab > li > a ").click(function(){
	   $(this).parent().addClass("on").siblings().removeClass("on");
	   return false;
	});</script>
	</section>	
</div>
</body>
<!-- body end -->
</html>