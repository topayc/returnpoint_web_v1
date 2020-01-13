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
	<div class="affiliate_receiptlist_page">
		<div class="affiliate_receiptlist">
			<div class="receiptlist_fran">옛날 분식</div>
			<div class="receiptlist_day">2020-01-13</div>
			<div class="receiptlist_list">
				<li>ㆍ영수증 업로드 회원 : 안영철</li>
				<li>ㆍ결제 금액 : 10,000원</li>
				<li>ㆍ가맹점주가 입금할 금액 : 15,000원</li>
				<li>ㆍ상태 : <span>입금확인중</span></li>
			</div>
			<button>입금 확인 요청하기</button>
		</div>
		<div class="affiliate_receiptlist">
			<div class="receiptlist_fran">옛날 분식</div>
			<div class="receiptlist_day">2020-01-13</div>
			<div class="receiptlist_list">
				<li>ㆍ영수증 업로드 회원 : 안영철</li>
				<li>ㆍ결제 금액 : 10,000원</li>
				<li>ㆍ가맹점주가 입금할 금액 : 15,000원</li>
				<li>ㆍ상태 : <span>입금확인중</span></li>
			</div>
			<button>입금 확인 요청하기</button>
		</div>
	</div>
   </section>
     <div id = "progress_loading2">
		<img src="/resources/images/progress_loading.gif"/>
	</div>
</body>
<!-- body end -->
</html>