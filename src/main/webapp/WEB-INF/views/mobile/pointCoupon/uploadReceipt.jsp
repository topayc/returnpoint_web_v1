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
<script type="text/javascript">
$(document).ready(function(){
	var pageContextlocale = '${pageContext.response.locale}';
	$("#sel1").val(pageContextlocale);
});

</script>
<style>
* {font-weight:400}
</style>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_terms">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4>영수증 올리기</h4>
	</header> 
	<section>
	<div class="upload_receipt">
		<div class="bg_black">
			<div class="bg_white">
				<div class="bg_img">
					<img src="/resources/images/bg_img.jpg">
				</div>
			</div>
		</div>
		<div class="upload_conbox">
			<p>영수증상의 결제 금액 합계를 입력해주세요.</p>
			<form>
				<input type="text" placeholder="숫자만 입력해주세요."  >
			</form>
			<div class="upload_text">
				<ul>
					<li class="upload_text1">고객님이 입금하실 금액은 결제금액의 15%인</li>
					<li class="upload_text2">27,900원입니다.</li>
				</ul>
			</div>
		</div>
		<div class="bottom_btn">
			<div class="bottom_btn1">올리기</div>
			<div class="bottom_btn2">취소</div>
		</div>
	</div>
   </section>
</body>
<!-- body end -->
</html>