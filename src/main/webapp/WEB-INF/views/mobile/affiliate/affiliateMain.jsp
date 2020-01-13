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
		<h4>${model.affiliate.affiliateName}</h4>
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
			<li data-toggle="collapse" data-target="#member_noti" >아직 읽지 않은 알림 메세지가 6개가 있습니다.<span><i class="fas fa-chevron-right list_blt"></i></span></li>
		</ul>
		<div id = "member_noti"  class="collapse list_toggle" style = "background-color:#f1f1f1">
			<ul>
				<li style = "padding : 3% 3%;font-size:12px;border-bottom: 1px solid #ddd;" >읽지 않은 리스트 입니다</li>
				<li style = "padding : 3% 3%;font-size:12px;border-bottom: 1px solid #ddd;border-top: 1px solid #fff" >읽지 않은 리스트 입니다</li>
				<li style = "padding : 3% 3%;font-size:12px;border-bottom: 1px solid #ddd;border-top: 1px solid #fff" >읽지 않은 리스트 입니다</li>
				<li style = "padding : 3% 3%;font-size:12px;border-bottom: 1px solid #ddd;border-top: 1px solid #fff" >읽지 않은 리스트 입니다</li>
			</ul>
		</div>
		<div class="affiliate_conbox1">
			<ul>
				<li><span>영수증 매출</span>${model.affiliate.affiliateName}</li>
			</ul>
				<div class="affiliate_con1">
					<ul>
						<li>현재까지 영수증 총 매출</li>
						<li><span><fmt:formatNumber value="${model.receiptSaleSummary.totalReceiptPayAmount}" pattern="###,###,###,###"/></span></li>
					</ul>
				</div>
				<div class="affiliate_con2">
					<ul>
						<li onclick = "movePage('/m/affiliate/affiliateReceiptList.do?status=0&affiliateNo=${model.affiliate.affiliateNo}')">전체내역 조회</li>
						<li><span><fmt:formatNumber value="${model.receiptSaleSummary.totalReceiptPayAmount}" pattern="###,###,###,###"/></span></li>
					</ul>
				</div>
				<div class="affiliate_con2">
					<ul>
						<li onclick = "movePage('/m/affiliate/affiliateReceiptList.do?status=3_4&affiliateNo=${model.affiliate.affiliateNo}')">처리완료 조회</li>
						<li><span><fmt:formatNumber value="${model.receiptSaleSummary.totalReceiptCompletePayAmount}" pattern="###,###,###,###"/></span></li>
					</ul>
				</div>
				<div class="affiliate_con2">
					<ul>
						<li onclick = "movePage('/m/affiliate/affiliateReceiptList.do?status=1_2__5_6&affiliateNo=${model.affiliate.affiliateNo}')">미처리내역 조회</li>
						<li><span><fmt:formatNumber value="${model.receiptSaleSummary.totalReceiptNotCompletePayAmount}" pattern="###,###,###,###"/></span></li>
					</ul>
				</div>
			</div>
			<div class="affiliate_conbox2">
			<ul>
				<li><span>단말기 QR 적립 매출</span>${model.affiliate.affiliateName}</li>
			</ul>
				<div class="affiliate_con1">
					<ul>
						<li>현재까지 단말기 QR 적립 매출</li>
						<li><span><fmt:formatNumber value="${model.qrSaleSummary.totalQrPayAmount}" pattern="###,###,###,###"/></span></li>
					</ul>
				</div>
				<div class="affiliate_con2">
					<ul>
						<li>전체내역 조회</li>
						<li><span><fmt:formatNumber value="${model.qrSaleSummary.totalQrPayAmount}" pattern="###,###,###,###"/></span></li>
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