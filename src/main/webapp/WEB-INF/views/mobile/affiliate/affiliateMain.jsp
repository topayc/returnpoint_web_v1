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
		<ul>
			<li>
				<ul>
					<li class="affiliate_main_fran" ><b>가맹점공지</b>&nbsp;가맹점 시스템 개편<span>NEW</span></li>
					<li class="affiliate_main_day">2020-01-13</li>
				</ul>
			</li>
			<li>아직 읽지 않은 알림 메세지가 6개가 있습니다.</li>
		</ul>
			<div class="affiliate_conbox1">
			<ul>
				<li><span>영수증 매출</span>옛날분식</li>
			</ul>
				<div class="affiliate_con1">
					<ul>
						<li>현재까지 영수증 총 매출</li>
						<li><span>14,001,121</span></li>
					</ul>
				</div>
				<div class="affiliate_con2">
					<ul>
						<li onclick = "movePage('/m/affiliate/affiliateReceiptList.do')">전체매출 조회</li>
						<li><span>14,001,121</span></li>
					</ul>
				</div>
				<div class="affiliate_con2">
					<ul>
						<li>처리완료 조회</li>
						<li><span>7,800,000</span></li>
					</ul>
				</div>
				<div class="affiliate_con2">
					<ul>
						<li>미처리내역 조회</li>
						<li><span>3,091,112</span></li>
					</ul>
				</div>
			</div>
			<div class="affiliate_conbox2">
			<ul>
				<li><span>단말기 QR 매출</span>옛날분식</li>
			</ul>
				<div class="affiliate_con1">
					<ul>
						<li>현재까지 단말기 QR 매출</li>
						<li><span>14,001,121</span></li>
					</ul>
				</div>
				<div class="affiliate_con2">
					<ul>
						<li>전체매출 조회</li>
						<li><span>14,001,121</span></li>
					</ul>
				</div>
				<div class="affiliate_con2">
					<ul>
						<li>적립내역 조회</li>
						<li><span>7,800,000</span></li>
					</ul>
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