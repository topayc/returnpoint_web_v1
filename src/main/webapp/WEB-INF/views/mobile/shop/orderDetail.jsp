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
		<div class="shop_main">
			<div class="r_pay">
	<div class="r_address">
		<b>배송지</b>
		<div class="r_pay_address">
			<div class="r_address_left">받는분</div>
			<div class="r_address_right"><input type="text"></div>
			<div class="r_address_left">우편번호</div>
			<div class="r_address_right"><input type="text" style="width:70%;"><button>변경</button></div>
			<div class="r_address_left">주소</div>
			<div class="r_address_right"><input type="text"><input type="text"></div>
			<div class="r_address_left">휴대전화</div>
			<div class="r_address_right"><input type="text"></div>
			<div class="r_address_left">요청사항</div>
			<div class="r_address_right"><input type="text"></div>
		</div>
	</div>
	<div class="r_address">
		<b>주문자</b><span>위와 동일하게 채우기</span>
		<div class="r_pay_address">
			<div class="r_address_left">이름</div>
			<div class="r_address_right"><input type="text"></div>
			<div class="r_address_left">이메일</div>
			<div class="r_address_right"><input type="text"></div>
			<div class="r_address_left">휴대전화</div>
			<div class="r_address_right"><input type="text"></div>
		</div>
		<div class="r_address_check">
		<input type="checkbox" id="r_orderer_box">
			<label for="r_orderer_box"></label>
			SMS 수신동의 (배송알림)
		</div>
	</div>
	<div class="r_address">
		<b>주문상품</b>
			<div class="r_pay_address">
			<div class="r_pay_left">상품정보</div>
			<div class="r_pay_right">배송비/판매자</div>
			<div class="r_pay_left" style="border-bottom:none;">
				<div class="r_pay_left_l">
					<img src="/resources/images/r_pay.png">
				</div>
				<div class="r_pay_left_r">
					<ul>
						<li><span>터치미 극세사 러그-원형/사각</span></li>
						<li>사이즈 : 02[원형] 150x150 / 색상 : 그레이</li>
						<li><span>24,200원</span> <span>|</span>1개</li>
					</ul>
				</div>
			</div>
			<div class="r_pay_right">
				<ul>
					<li>무료배송</li>
					<li><span>한일카페트</span></li>
				</ul>
			</div>
		</div>
	</div>
	<div class="r_address">
		<b>포인트</b>
			<div class="r_address_point">
				<p>3만원이상 결제시 포인트 사용이 가능합니다.</p>
				<input type="text" placeholder="0"><b>P</b>
				<span>사용 가능한 포인트<b>3,819P</b></span>
				<input type="checkbox" id="r_pay_address_point">
				<label for="r_pay_address_point">전액사용</label>
			</div>			
	</div>
	<div class="r_address">
		<b>예상 적립 포인트</b>
		<div class="r_address_p">
			<p><span>242P</span><b>726P</b> 적립 예정</p>
			<span>VIP 3배 혜택이 적용되었습니다.</span>
			<span>총 100만원 이상 구매시 20,000P 추가 적립 됩니다.</span>
		</div>
	</div>
	<div class="r_address">
		<b>결제수단</b>
		<div class="r_pay_bottom">
			<!-- <div class="r_pay_bottom_img"><img src="./img/pay_bottomimg1.png">핸드폰</div> -->
			<div class="r_pay_bottom_img"><img src="/resources/images/pay_bottomimg2.png">무통장 입금</div>
		</div>
		<button onclick = "movePage('/m/shop/orderComplete.do')">결제하기</button>
	</div>
	</div>

		</div>
	</section>
	<div id="progress_loading2">
		<img src="/resources/images/progress_loading.gif" />
	</div>
</body>
<!-- body end -->
</html>