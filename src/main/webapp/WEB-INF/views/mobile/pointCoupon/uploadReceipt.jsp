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
	
	 $(".recv_method").click(function(){
		 $(".recv_method").removeClass("push_select");
		 $(this).addClass("push_select");
		 return false;
	 });
});

</script>
<style>
* {font-weight:400}
.toggle {width:100%}
.btn-success {background-color: #5cb85c !importtant;}
.btn-danger {background-color: #ccc !importtant;}
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
			<p>결제 영수증상의 결제 금액 합계를 입력해주세요.</p>
			<form>
				<input type="text" placeholder="결제 금액 입력(숫자)"   >
				
				<p style = "margin-top:15px">적립코드를 받을 방법을 선택해주세요(PUSH/SMS)</p>
				<div >
					<button class="push_select recv_method">푸쉬로받기</button>
					<button class = "recv_method" style="margin-left:-2%;">문자로받기</button>
				</div>
			</form>
			<div style = "margin-top:30px">
				<p>회원님이 입금하셔야 할 금액</p>
				<p class="upload_conbox_p" style = "margin-top:10px;font-size : 25px;font-weight:bold;color : #888">27,900원</p>
			</div>
		</div>
		<div class="bottom_btn">
			<div class="bottom_btn1">올리기</div>
			<div class="bottom_btn2">취소</div>
		</div>
		<%-- <div class="btns2">
			<button type="button" class="btn btn-submit" onclick = "startPointBack()"><spring:message code="label.ok" /></button>
			<button type="button" class="btn btn-submit-cancel"  onclick = "history.back()"><spring:message code="label.cancel" /></button>
		</div> --%>
	</div>
   </section>
</body>
<!-- body end -->
</html>