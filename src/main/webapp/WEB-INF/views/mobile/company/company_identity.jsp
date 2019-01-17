<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="com.returnp_web.utils.SessionManager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html lang="en">
<head> 
<!-- 회사소개 -->
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
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_company_identity">	

	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4>Company</h4> 
	</header>
	<!-- content begin -->
	<section>
		<div class="pc">
			<aside><hr><h4>회사 소개</h4></aside>
			<div class="content">
				<p>유통구조에서 발생하는 이익을 공동분배하여 일자리를 창출하고 신개념의 유통혁신을 이루고자 한다.</p>
			</div>		
			<div class="companybox">	
				<div class="box">
					<div class="title">탑 해피 월드</div>
					<p>(Top Happy World co..,ltd)</p>
				</div>
				<div class="box">		
					<div class="title">창업이념, 경영 철학</div>
					<p>나눔 경영 실현</p>
				</div>
				<div class="box ps">			
					<div class="title">경영 이념</div>
					<p>늘 함께, 건강하게</p>
					<p>일자리 창출, 공동분배</p>
					<p>하나로, 세계로</p>
					<p>가족 경영, 지구촌 하나로</p>
					<p>소비가 소득으로</p>
					<p>소비가 나의 일자리</p>
				</div>
			</div>
		</div>
			<div class="mobile">
			<aside><hr><h4>회사 소개</h4></aside>
			<div class="content">
				<p>유통구조에서 발생하는 이익을 공동분배하여 일자리를 창출하고 신개념의 유통혁신을 이루고자 한다.</p>
			</div>			
			<div class="companybox">
					<div class="title">탑 해피 월드</div>
					<p>(Top Happy World co..,ltd)</p>
			</div>
			<div class="companybox">		
				<div class="title">창업이념, 경영 철학</div>
				<p>나눔 경영 실현</p>
			</div>
			<div class="companybox ps">			
				<div class="title">경영 이념</div>
				<p>늘 함께, 건강하게</p>
				<p>일자리 창출, 공동분배</p>
				<p>하나로, 세계로</p>
				<p>가족 경영, 지구촌 하나로</p>
				<p>소비가 소득으로</p>
				<p>소비가 나의 일자리</p>
			</div>
		</div>
	</section>	
</div>	
</body>
<!-- body end -->
</html>