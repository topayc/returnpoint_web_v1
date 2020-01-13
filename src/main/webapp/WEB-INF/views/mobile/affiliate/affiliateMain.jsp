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
		<h4>RETURNP</h4>
	</header> 
  
	<section>
	<div class="affiliate_main">
		<div class="affiliate_conbox1">
			<h3><img src="/resources/images/affiliate_img.png">옛날분식 영수증 매출 (2020년 1월 13일 현재)</h3>
			<div class="affiliate_con1">
				<li>금일까지 영수증 총 매출</li>
				<li><span>14,001,121</span></li>
			</div>
			<div class="affiliate_con2">
				<li>전체 매출 조회</li>
				<li><span>14,001,121</span></li>
			</div>
			<div class="affiliate_con2">
				<li>입금 완료 조회</li>
				<li><span>7,800,000</span></li>
			</div>
			<div class="affiliate_con2">
				<li>미입금 내역 조회</li>
				<li><span>3,091,112</span></li>
			</div>
		</div>
		<div class="affiliate_conbox2">
			<h3><img src="/resources/images/affiliate_img.png">옛날분식 영수증 매출 (2020년 1월 13일 현재)</h3>
			<div class="affiliate_con1">
				<li>금일까지 영수증 총 매출</li>
				<li><span>14,001,121</span></li>
			</div>
			<div class="affiliate_con2">
				<li>전체 매출 조회</li>
				<li><span>14,001,121</span></li>
			</div>
			<div class="affiliate_con2">
				<li>입금 완료 조회</li>
				<li><span>7,800,000</span></li>
			</div>
			<div class="affiliate_con2">
				<li>미입금 내역 조회</li>
				<li><span>3,091,112</span></li>
			</div>
		</div>
	</div>
   </section>
     <div id = "progress_loading2">
		<img src="/resources/images/progress_loading.gif"/>
	</div>
</body>
<!-- body end -->
</html>