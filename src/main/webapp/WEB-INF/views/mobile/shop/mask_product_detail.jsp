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
<script type="text/javascript" src="/resources/js/lib/jquery-number.js"></script>
 
<script type="text/javascript">
	
	$(document).ready(function() {
		var pageContextlocale = '${pageContext.response.locale}';
		$("#sel1").val(pageContextlocale);
		$('.product_info_tab').click(function(){
			$(".product_info_tab").removeClass("r_shop_tab_select");
			$(this).addClass("r_shop_tab_select");
			var target = $(this).attr("target");
			$(".product_info").hide();
			$("#" + target).show();
		});
		
		$("#refundInfo").html(productInfo.refundInfo);
		$(".product_info").hide(); 
		$("#r_detail_page").show();
		
	    if (productInfo.gPointRate >  0 ){
		   $("#gpointRate").text($.number( productInfo.gPointRate * 100) + "%") ;
		   $("#gpoint_text").text($.number( productInfo.price * 10 * productInfo.gPointRate) + " GPOINT 적립") ;
		 }
		  
		$("#price").val(productInfo.price);
		
		/*초기 주문 페이지의 주문 가격 세팅*/
		$("#totalPriceAmount_text").text($.number(productInfo.price * 10 * 1) + "원");
		$("#totalPriceAmount").val(productInfo.price * 10);
		
		$("#gpointRate").val(productInfo.gPointRate);
		$("#gpointAdmout").val(productInfo.price * 10 * 1* productInfo.gPointRate );
		$("#productName").val(productInfo.productName);
		if (productInfo.gPointRate > 0) $("#gpointRate_text").text((productInfo.gPointRate * 100) + "% G.POINT 적립");
		
		$("#deliveryChargeType").val(productInfo.curDeliveryType);
		
		var delText = ""
		if (productInfo.curDeliveryType == "condition") {
			delText= $.number(productInfo.deliveryType[productInfo.curDeliveryType].charge) + "원 (" + $.number(productInfo.deliveryType[productInfo.curDeliveryType].limitAmount) + "원 이상 구매시 무료 배송)";
			$("#deliveryChargeLimit").val(productInfo.deliveryType[productInfo.curDeliveryType].limitAmount);
			$("#deliveryCharge").val(productInfo.deliveryType[productInfo.curDeliveryType].charge);
		}
		if (productInfo.curDeliveryType == "nofree"){ 
			delText= $.number(productInfo.deliveryType[productInfo.curDeliveryType].charge) + "원";
			$("#deliveryCharge").val(productInfo.deliveryType[productInfo.curDeliveryType].charge);
			$("#deliveryChargeLimit").val(0);
		}
		if (productInfo.curDeliveryType == "free"){ 
			delText= "배송비 무료";
			$("#deliveryCharge").val(0);
			$("#deliveryChargeLimit").val(0);
		}
		
		$(".delivery_charge_text").text(delText);
		
		$("#unit").change(function() {
			setOrderAmount();
		});
		
		   $("#qty").on("propertychange change keyup paste input", function() {
				var qty = $(this).val().trim();
				if (qty.length > 0 ) {
					if (!$.isNumeric(qty)) {
						alertOpen("확인", "숫자만 입력가능합니다", true, false, null, null);
						return;
					}else {
						qty = parseInt(qty);
						if (qty < 1) {
							$(this).val("1");
						}
						setOrderAmount();
					}
				}
	        })
	        
	        setOrderAmount();
	});
	
	function setOrderAmount(){
		var qty = $("#qty").val();
		var unit = $("#unit").val();
		var orderAmount = parseInt(qty) *  parseInt(unit)  * productInfo.price;
		
		$("#totalPriceAmount_text").text( $.number(orderAmount) + ' 원 (배송비 제외)');
		$("#totalPriceAmount").val(orderAmount );

		$("#gpoint_text").text( $.number(orderAmount *  productInfo.gPointRate) + ' G.POINT를 적립해드립니다');
		$("#gpointAmount").val( orderAmount * productInfo.gPointRate );
	}
	
	function order(){
		var color = $("#color").val().trim();
		var unit  = $("#unit").val().trim();
		var qty  = $("#qty").val().trim();
		
		if (color ==  "0") {
			 alertOpen("알림", "색상을 선택해주세요", true, false,true, null);
			 return;
		}
		
		if (unit == "0") {
			 alertOpen("알림", "묶음을 선택해주세요", true, false,true, null);
			 return;
		}
		
		if (qty.length < 1 || parseInt(qty) < 1) {
			$("#qty").val("");
			$("#qty").focus();
			 alertOpen("알림", "수량을 선택해주세요", true, false,true, null);
			 return;
		}
		$("#productOrderForm").submit();
	}
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
	<h4>KN 99 고기능 은나노 마스크</h4>
	</header>

	<section>
		<div class="shop_main" >
			<div class="r_detail" style = "padding:0px 10px 70px 0px">
				<div class="r_detail_sliderimg">
					<img src="/resources/images/mask_img.png">
				</div>
				<!-----메인이미지 들어가는 자리------->
				<form id ="productOrderForm" name = "productOrderForm" action = "/m/shop/maskOrder.do" method = "post">
				<input type = "hidden" name = "productNo"  id = "productNo"  value = "1"/>
				<input type = "hidden" name = "productName"  id = "productName"  value = ""/>
				<input type = "hidden" name = "totalPriceAmount"  id = "totalPriceAmount" value = ""/>
				<input type = "hidden" name = "price" id = "price" value = ""/>
				<input type = "hidden" name = "gpointRate" id = "gpointRate" value = ""/>
				<input type = "hidden" name = "gpointAmount" id = "gpointAmount" value = ""/>
				<input type = "hidden" name = "deliveryChargeType" id = "deliveryChargeType" value = ""/>
				<input type = "hidden" name = "deliveryCharge" id = "deliveryCharge" value = ""/>
				<input type = "hidden" name = "deliveryChargeLimit" id = "deliveryChargeLimit" value = ""/>
				<div class="r_detail_text">
					<!-----상품 설명 text------->
					<ul>
						<li>KN 99 고기능</li>
						<li><h5>은나노 마스크 Silver Nano Mask</h5></li>
						<li id = "gpointRate_text" style = "font-size : 13px;color : #33cccc;font-weight : 500"></li>
						<li style="margin-bottom:10px;margin-top:20px">옵션
							<select name="color"  id="color" style = "height:35px">
								<option value = "white" >white(흰색)</option>
								<option value = "black" >black(검정색)</option>
								<option value = "gray" >gray(회색)</option>
								<option value = "wine" >wine(와인색)</option>
								<option value = "chacoal" >chacoal(차콜)</option>
							</select>
						</li>
						<li style="margin-bottom:20px;">수량
							<select name="unit" id="unit" style = "height:35px">
								<option value = "10" >10개 묶음</option>
								<option value = "20" >20개 묶음</option>
								<option value = "30" >30개 묶음</option>
							</select>
								<input type="number"  id = "qty"  name = "qty" style = "width:100px;height:35px"  value = "1">&nbsp;개
						</li>
						<li style = "margin-bottom:7px"><h3> <b id = "totalPriceAmount_text"></b> <!-- <span>온라인 최저가</span> --> </h3></li>
						<li><span class="text_point"  id = "gpoint_text"></span></li>
					</ul>
				</div>
				</form>
				<div class="r_delivery">
					<ul>
						<li>일반택배</li>
						<li><span style = "padding: 5px;background-color : #ececec"><b id = "delivery_charge_text" class = "delivery_charge_text" style = "padding : 10px"></b></span> </li>
					</ul>
				</div>
				<div class="r_nav">
					<ul>
						<li class="product_info_tab r_shop_tab_select"  target = "r_detail_page"  style ="border-right:1px solid #eee;width:48%">상품 정보</li>
						<!-- <li><a href="#r_review">리뷰</a></li> -->
						<li class = "product_info_tab" style ="width:48%" target = "r_detail_delivery">배송 / 환불</li>
					</ul>
				</div>
				<div class="product_info r_detail_page" id="r_detail_page">
					<!-------상품상세페이지 이미지 들어가는 자리------->
					<img src="/resources/images/detail.png">
				</div>
		<!-- 		<div class="r_review" id="r_review">
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
				</div> -->
				<div class="product_info r_detail_delivery" id="r_detail_delivery">
					<div class="r_delivery_page">
						<b>배송 관련 안내</b>
						<div class="r_delivery_s">배송</div>
						<div class="r_delivery_l">일반택배상품</div>
						<div class="r_delivery_s">배송비</div>
						<div class="r_delivery_l delivery_charge_text"></div>
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
						<div class="r_delivery_l" id = "refundInfo"></div>
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
					<button onclick = "order();">구매하기</button>
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