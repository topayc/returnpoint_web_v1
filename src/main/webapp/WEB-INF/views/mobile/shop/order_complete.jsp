<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.returnp_web.utils.SessionManager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>ReturnP</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="format-detection" content="telephone=no" />
<!-- css   -->
<!-- font -->
<link rel="stylesheet" href="/resources/css/m_common.css">
<!-- js -->
<script type="text/javascript" src="/resources/js/lib/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/m_common.js"></script>
<script type="text/javascript" src="/resources/js/lib/m_point_gift.js"></script>
<script type="text/javascript" src="/resources/js/lib/jquery.sticky.js"></script>
 
<script type="text/javascript">
	$(document).ready(function() {
		var pageContextlocale = '${pageContext.response.locale}';
		$("#sel1").val(pageContextlocale);

	});
</script>
<style>
* {
	font-weight: 400
}
</style>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_terms">
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
	<h4>마스크</h4>
	</header>

	<section>
		<div class="r_order">
			<div class="r_order_img">
				<img src="/resources/images/r_order.png">
			</div>
			<div class="r_cart_img">
				<img src="/resources/images/r_cart.png">
			</div>
			<div class="r_order_text">
				<h3>아래의 표를 참조해서 입금해주세요.</h3>
				<div class="text_box">
					<div class="text_left">
						<ul>
							<li>예금주</li>
							<li>은행명</li>
							<li>계좌번호</li>
							<li>입금금액</li>
						<!-- 	<li>기한</li> -->
						</ul>
					</div>
					<div class="text_right">
						<ul>
							<li>주식회사 탑해피월드</li>
							<li>우리은행</li>
							<li>1005-703-612321</li>
							<li id = "orderAmount"><fmt:formatNumber value="${model.orderAmount}" pattern="###,###,###,###" /> 원</li>
						<!-- 	<li id = "depositDay">2020.04.08까지</li> -->
						</ul>
					</div>
				</div>
			</div>
			<button class="r_btn1" onclick = "movePage('/m/mypage/maskOrderList.do')">주문현황보기</button>
			<button class="r_btn2" onclick = "movePage('/m/main/index.do')">메인으로가기</button>
		</div>
	</section>
	<div id="progress_loading2">
		<img src="/resources/images/progress_loading.gif" />
	</div>
</body>
<!-- body end -->
</html>