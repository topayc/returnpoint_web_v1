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
		<h4>영수증 업로드 세부 정보</h4>
	</header> 
	<section>
	<div class="receipt_detail">
		<div class="bg_black">
			<div class="bg_white">
				<div class="bg_img">
					<img src="/resources/images/bg_img.jpg">
				</div>
			</div>
		</div>
		<div class="upload_conbox">
			<div>
				<ul>
					<li>
						<ul>
							<li class="upload_conbox_text1">결제금액</li>
							<li class="upload_conbox_text2">100,000</li>
						</ul>
					</li>
					<li>
						<ul>
							<li class="upload_conbox_text1">이체금액</li>
							<li class="upload_conbox_text2">15,000</li>
						</ul>
					</li>
					<li>
						<ul>
							<li class="upload_conbox_text1">적립금액</li>
							<li class="upload_conbox_text2">100,000</li>
						</ul>
					</li>
					<li>
						<ul>
							<li class="upload_conbox_text1">상태</li>
							<li class="upload_conbox_text2"><span>입금확인중</span></li>
						</ul>
					</li>
				</ul>
			</div>
			<button>입금 확인 요청하기</button>
			<p>입금이 완료되어야 적립코드가 발송되며,입금을 하셨을 경우 <b>입금확인 요청하기</b> 버튼을 클릭하시면 빠른 처리가 가능합니다.</p>
		</div>	
		
	</div>
   </section>
</body>
<!-- body end -->
</html>