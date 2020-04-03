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
			<div class="r_detail">
				<div class="r_detail_sliderimg">
					<img src="/resources/images/sliderimg1.png">
				</div>
				<!-----메인이미지 들어가는 자리------->
				<div class="r_detail_text">
					<!-----상품 설명 text------->
					<ul>
						<li>KN 99 고기능</li>
						<li><h5>은나노 마스크 Silver Nano Mask</h5></li>
						<li><span>41%</span><span class="line_t">28,000</span></li>
						<li style="margin-bottom:10px;">옵션<select name="옵션" id="r_option">
									<option>color(색상)</option>
									<option>white(흰색)</option>
									<option>black(검정색)</option>
								</select>
						</li>
						<li style="margin-bottom:10px;">수량<select name="수량" id="r_option">
									<option>선택</option>
									<option>10p</option>
									<option>20p</option>
								</select>
								<input type="text">개
						</li>
						<li><h3>
								16,300원 <span>최저가</span>
							</h3></li>
						<li><span class="text_point">489P</span> 적립해드립니다. (VIP 3배 혜택
							적용됨)</li>
					</ul>
				</div>
				<div class="r_delivery">
					<ul>
						<li>일반택배</li>
						<li><span>무료배송</span></li>
					</ul>
				</div>
				<div class="r_nav">
					<ul>
						<li class="r_shop_tab_select"><a href="#r_detail_page">상품정보</a></li>
						<li><a href="#r_review">리뷰</a></li>
						<li><a href="#r_detail_delivery">배송/환불</a></li>
					</ul>
				</div>
				<div class="r_detail_page" id="r_detail_page">
					<!-------상품상세페이지 이미지 들어가는 자리------->
					<img src="/resources/images/detail.png">
				</div>
				<div class="r_review" id="r_review">
					<!----리뷰들어가는 자리----->
					<p>
						리뷰<span>1,234</span>
					</p>
					<div class="r_review_text">
						<ul>
							<li><div class="r_review_img">
									<img src="/resources/images/myimg.png">
								</div>차미라<span>2020.01.28</span></li>
							<li>너무 좋네요 선배가 와서 양념 치킨 먹다가 바로 흘림 상놈 배송도 엄청 빨리 왔고 사이즈도 3인용
								소파랑 잠 맞네요 그리고 무엇보다 알레르기 때문에 먼지 사이사이에 다 끼는 애들 극도로 싫어해서 단모러그를 찾았는데
								아주 만족스러워요 ㅎㅎ</li>
						</ul>
					</div>
					<div class="r_review_text">
						<ul>
							<li><div class="r_review_img">
									<img src="/resources/images/myimg.png">
								</div>차미라<span>2020.01.28</span></li>
							<li>너무 좋네요 선배가 와서 양념 치킨 먹다가 바로 흘림 상놈 배송도 엄청 빨리 왔고 사이즈도 3인용
								소파랑 잠 맞네요 그리고 무엇보다 알레르기 때문에 먼지 사이사이에 다 끼는 애들 극도로 싫어해서 단모러그를 찾았는데
								아주 만족스러워요 ㅎㅎ</li>
						</ul>
					</div>
					<div class="r_review_text">
						<ul>
							<li><div class="r_review_img">
									<img src="/resources/images/myimg.png">
								</div>차미라<span>2020.01.28</span></li>
							<li>너무 좋네요 선배가 와서 양념 치킨 먹다가 바로 흘림 상놈 배송도 엄청 빨리 왔고 사이즈도 3인용
								소파랑 잠 맞네요 그리고 무엇보다 알레르기 때문에 먼지 사이사이에 다 끼는 애들 극도로 싫어해서 단모러그를 찾았는데
								아주 만족스러워요 ㅎㅎ</li>
						</ul>
					</div>
					<div class="r_review_btn">
						<button>리뷰쓰기</button>
						<input type="text" placeholder="리뷰를 작성해 주세요.">
					</div>
				</div>
				<div class="r_detail_delivery" id="r_detail_delivery">
					<div class="r_delivery_page">
						<b>배송 관련 안내</b>
						<div class="r_delivery_s">배송</div>
						<div class="r_delivery_l">일반택배상품</div>
						<div class="r_delivery_s">배송비</div>
						<div class="r_delivery_l">무료</div>
						<div class="r_delivery_s">도서산간 추가 배송비</div>
						<div class="r_delivery_l">3,000원</div>
						<div class="r_delivery_s">배송불가지역</div>
						<div class="r_delivery_l">배송불가 지역이 없습니다.</div>
					</div>
					<div class="r_delivery_page">
						<b>교환 환불</b>
						<div class="r_delivery_s">반품배송비</div>
						<div class="r_delivery_l">편도 2,500원 (최초 배송비가 무료인 경우 5,000원
							부과)</div>
						<div class="r_delivery_s">교환배송</div>
						<div class="r_delivery_l">2,500원</div>
						<div class="r_delivery_s">보내실 곳</div>
						<div class="r_delivery_l">(34711) 대전 동구 대별동 155-1 (대별동)
							한빛텍스타일</div>
					</div>
					<div class="r_delivery_text">
						<ul>
							<li>반품/교환 사유에 따른 요청 가능 기간</li>
							<li><span>반품 시 먼저 판매자와 연락하셔서 반품사유, 택배사, 배송비, 반품지 주소
									등을 협의하신 후 반품상품을 발송해 주시기 바랍니다.</span></li>
						</ul>
						<ol>
							<li>구매자 단순 변심은 상품 수령 후 7일 이내<br>
							<span>(구매자 반품배송비 부담)</span></li>
							<li>표시/광고와 상이, 상품하자의 경우 상품 수령 후 3개월 이내 혹은 표시/광고와 다른 사실을 안
								날로부터 30일 이내. 둘 중 하나 경과 시 반품/교환 불가<br>
							<span>(판매자 반품배송비 부담)</span>
							</li>
						</ol>
						<ul>
							<li>반품/교환 불가능 사유</li>
							<li><span>아래와 같은 경우 반품/교환이 불가능합니다.</span></li>
						</ul>
						<ol>
							<li>반품요청기간이 지난 경우</li>
							<li>구매자의 책임 있는 사유로 상품 등이 멸실 또는 훼손된 경우(단, 상품의 내용을 확인하기 위하여 포장
								등을 훼손한 경우는 제회)</li>
							<li>포장을 개봉하였으나 포장이 훼손되어 상품가치가 현저히 상실된 경우(예: 식품, 화장품)</li>
							<li>구매자의 사용 또는 일부 소비에 의하여 상품의 가치가 현저히 감소한 경우 (라벨이 떨어진 의류 또는
								태그가 떨어진 명품관 상품인 경우)</li>
							<li>시간의 경과에 의하여 재판매가 곤란할 정도로 상품 등의 가치가 현저히 감소한 경우 (예: 식품,
								화장품)</li>
							<li>고객주문 확인 후 상품제작에 들어가는 주문제작상품</li>
							<li>복제가 가능한 상품 등의 포장을 훼손한 경우 (CD/DVD/GAME/도서의 경우 포장 개봉 시</li>
						</ol>
					</div>
				</div>
				<div class="r_detail_pay">
					<button>구매하기</button>
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