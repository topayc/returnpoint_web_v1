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
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">
	
var element_layer ;

$(document).ready(function() {
	var pageContextlocale = '${pageContext.response.locale}';
	$("#sel1").val(pageContextlocale);
	element_layer = document.getElementById('layer');

});

function closeDaumPostcode() {
    // iframe을 넣은 element를 안보이게 한다.
    element_layer.style.display = 'none';
}

function searchZipCode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("address1").value = extraAddr;
            
            } else {
                document.getElementById("address1").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('zipCode').value = data.zonecode;
            document.getElementById("address1").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("address2").focus();

            // iframe을 넣은 element를 안보이게 한다.
            // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
            element_layer.style.display = 'none';
        },
        width : '100%',
        height : '100%',
        maxSuggestItems : 5
    }).embed(element_layer);

    // iframe을 넣은 element를 보이게 한다.
    element_layer.style.display = 'block';

    // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
    initLayerPosition();
}

// 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
// resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
// 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
function initLayerPosition(){
    var width = 300; //우편번호서비스가 들어갈 element의 width
    var height = 430; //우편번호서비스가 들어갈 element의 height
    var borderWidth = 4; //샘플에서 사용하는 border의 두께

    // 위에서 선언한 값들을 실제 element에 넣는다.
    element_layer.style.width = width + 'px';
    element_layer.style.height = height + 'px';
    element_layer.style.border = borderWidth + 'px solid';
    // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
    element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
    element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
}
	
	isSubmitting = false; 
	
	
	function submitOrder(){
		if (isSubmitting == true) {
			return;
		}
		isSubmitting = true;
		
		var receiverName = $("#receiverName").val().trim();
		var zipCode = $("#zipCode").val().trim();
		var address1 = $("#address1").val().trim();
		var address2 = $("#address2").val().trim();
		var receiverPhone = $("#receiverPhone").val().trim();
		
		if (receiverName.length < 1) {
			 alertOpen("알림", "받는분 이름을 입력해주세요", true, false,true, null);
			 return;
		}
		
		if (zipCode.length < 1) {
			 alertOpen("알림", "우편번호 검색 버튼을 이용해서 번호를 입력해주세요", true, false,true, null);
			 return;
		}
		
		if (address1.length < 1) {
			 alertOpen("알림", "우편번호 검색 버튼을 이용해서 주소를 입력해주세요", true, false,true, null);
			 return;
		}
		
		if (address2.length < 1) {
			 alertOpen("알림", "배송지 상세 주소를 입력해주세요", true, false,true, null);
			 return;
		}
		
		if (receiverPhone.length < 1) {
			 alertOpen("알림", "받는분 전화번호를 입력해세요", true, false,true, null);
			 return;
		}
		var submitData = $("#orderForm").serializeObject();
		$.ajax({
			method : "post",
			url    : "/m/shop/processOrder.do",
			dataType: "json",
			data   :  submitData,
			beforeSend : function(xhr){
				$("#progress_loading2").show(); 	
				$("#btn-submit").attr('disabled', true);
			},
			success: function(data) {
				if (data.result.code == 0 ) {
					movePageReplace('/m/shop/orderComplete.do?orderAmount=' + submitData.orderAmount);
				}else{
					alertOpen("확인", data.result.msg, false, true, null, null);
					 $("#btn-submit").attr('disabled', false);
				}
				isSubmitting = false;
				$("#progress_loading2").hide(); 	
			},
			error: function (request, status, error) {
				isSubmitting = false;
				 $("#btn-submit").attr('disabled', false);
				 $("#progress_loading2").hide(); 	
				alertOpen("확인", "일시적 장애 발생", false, true, null, null);
			}
		});
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

	<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
	<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
	</div>

	<section>
		<form id = "orderForm" name = "orderForm" method = "post" action = "/m/shop/processOrder.do">
		<input type = "hidden" name = "gpointAmount" id = "gpointAmount" value = "${model.gpointAmount }"/>
		<input type = "hidden" name = "gpointRate" id = "gpointRate" value = "${model.gpointRate }"/>
		<input type = "hidden" name = "unit" id = "unit" value = "${model.unit }"/>
		<input type = "hidden" name = "qty" id = "qty" value = "${model.qty }"/>
		<input type = "hidden" name = "color" id = "color" value = "${model.color }"/>
		<input type = "hidden" name = "productNo" id = "productNo" value = "${model.productNo }"/>
		<input type = "hidden" name = "price" id = "price" value = "${model.price }"/>
		<input type = "hidden" name = "deliveryCharge" id = "deliveryCharge" value = "${model.deliveryCharge }"/>
		<input type = "hidden" name = "deliveryChargeType" id = "deliveryChargeType" value = "${model.deliveryChargeType }"/>
		<input type = "hidden" name = "productName" id = "productName" value = "${model.productName }"/>
		<input type = "hidden" name = "orderAmount" id = "orderAmount" value = "${model.orderAmount }"/>
		<input type = "hidden" name = "totalPriceAmount" id = "orderAmount" value = "${model.totalPriceAmount }"/>

		<div class="shop_main">
			<div class="r_pay">
				<div class="r_address">
					<b>배송지</b>
					<div class="r_pay_address">
						<div class="r_address_left">받는분</div>
						<div class="r_address_right">
							<input type="text" id="receiverName" name="receiverName" value="${model.memberMap.memberName }">
						</div>

						<div class="r_address_left">우편번호</div>
						<div class="r_address_right">
							<input type="text" style="width: 70%;" id="zipCode" name="zipCode">
							<button type = "button" onclick = "searchZipCode();return false;">우편</button> 
						</div>

						<div class="r_address_left">주소</div>
						<div class="r_address_right">
							<input type="text" id="address1" name="address1"> 
							<input type="text" id="address2" name="address2">
						</div>

						<div class="r_address_left">휴대전화</div>
						<div class="r_address_right">
							<input type="text" id="receiverPhone" name="receiverPhone" value="${model.memberMap.memberPhone }">
						</div>

						<div class="r_address_left">요청사항</div>
						<div class="r_address_right">
							<input type="text" id="reqMsg" name="reqMsg" value="">
						</div>
					</div>
				</div>
				<div class="r_address">
					<b>주문자</b><!-- <span>위와 동일하게 채우기</span> -->
					<div class="r_pay_address">
						
						<div class="r_address_left">이름</div>
						<div class="r_address_right">
							<input type="text" id="orderName" name="orderName" value="${model.memberMap.memberName }" readonly>
						</div>
						
						<div class="r_address_left">이메일</div>
						<div class="r_address_right">
							<input type="text" id="orderEmail" name="orderEmail" value="${model.memberMap.memberEmail}" readonly>
						</div>
						
						<div class="r_address_left">휴대전화</div>
						<div class="r_address_right">
							<input type="text" id="orderPhone" name="orderPhone" value="${model.memberMap.memberPhone}" readonly>
						</div>
					</div>
					<div class="r_address_check">
						<input type="checkbox" id="r_orderer_box"> <label
							for="r_orderer_box"></label> SMS 수신동의 (배송알림)
					</div>
				</div>
				<div class="r_address">
					<b>주문상품</b>
					<div class="r_pay_address">
						<div class="r_pay_left">상품정보</div>
						<div class="r_pay_right">배송 및 요금</div>
						<div class="r_pay_left" style="border-bottom: none;">
							<div class="r_pay_left_l">
								<img src="/resources/images/r_pay.png">
							</div>
							<div class="r_pay_left_r">
								<ul>
									<li><span>${model.productName}</span></li>
									<li>개당 가격 : ${model.price }</li>
									<li>색상 : ${model.color}</li>
									<li>구매 : ${model.unit } 묶음 ${model.qty} 개 구매</li>
									<li><span style="font-weight: bold">총 상품 금액 : <fmt:formatNumber value="${model.totalPriceAmount}" pattern="###,###,###,###" /> 원
									</span></li>
								</ul>
							</div>
						</div>
						<div class="r_pay_right">
							<ul>
								<li>선결제 : <fmt:formatNumber value="${model.deliveryCharge}" pattern="###,###,###,###" /> </li>
							</ul>
						</div>
					</div>
				</div>
				<div class="r_address">
					<b>적립 G 포인트</b>
					<p style="font-size: 13px; color: #999">결제 및 입금 확인시 결제금액의 ${model.gpointRate * 100} % 에 해당하는 G.POINT 를 적립해드립니다.</p>
					<div class="r_address_p">
						<b style="color: #33cccc"><fmt:formatNumber value="${model.gpointAmount}" pattern="###,###,###,###" /> </b> G POINT 적립 예정
					</div>
				</div>
				
				<div class="r_address">
					<b>최종 결제 금액</b>
					<table style = "width : 100%;margin-top:15px;font-size: 14px" cellpadding= "5px">
						<tr>
							<td class="r_table1" style = "width : 70%">• 총 상품 금액</td>
							<td class="r_table1" style = "width : 70%;text-align: right"><fmt:formatNumber value="${model.totalPriceAmount}" pattern="###,###,###,###" />원 </td>
						</tr>
						<tr>
							<td class="r_table1" style = "width : 70%">• 배송비</td>
							<td class="r_table1" style = "width : 70%;text-align: right"><fmt:formatNumber value="${model.deliveryCharge}" pattern="###,###,###,###" />원</td>
						</tr>
					</table>
					<div style = "font-size : 20px; font-weight:bold;text-align:right"><fmt:formatNumber value="${model.orderAmount}" pattern="###,###,###,###" />원</div>
				</div>
				
				<div class="r_address">
					<b>결제수단</b>
					<p style="font-size: 13px; color: #999">현재 무통장 입금 결제만 가능합니다</p>
					<div class="r_pay_bottom">
						<!-- <div class="r_pay_bottom_img"><img src="./img/pay_bottomimg1.png">핸드폰</div> -->
						<div class="r_pay_bottom_img" style="border: 4px solid #33cccc">
							<img src="/resources/images/pay_bottomimg2.png">무통장 입금
						</div>
					</div>
					<button id = "submit_btn"  type = "button" onclick="submitOrder()">결제하기</button>
				</div>
			</div>
			
		</div>
	</form>
	</section>
	<div id="progress_loading2">
		<img src="/resources/images/progress_loading.gif" />
	</div>
</body>
<!-- body end -->
</html>