<%@page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@page import="com.returnp_web.utils.SessionManager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
<HTML>
 <HEAD>
  <TITLE> Returnp</TITLE>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
  <link rel="stylesheet" href="/resources/css/m_common.css">
  <link rel="stylesheet" href="/resources/css/mira_style.css">
  <script type="text/javascript" src="/resources/js/lib/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/m_common.js"></script>
<script type="text/javascript" >
$(document).ready(function(){
	$('#acc_btn').click(function(){
		var qrData = $('#accQrData').val().trim();
		accumulateGiftCardQr(qrData);
	});
})
function viewFullQrCode(giftCardIssueNo, type){
	location.href = "/m/giftCard/viewFullQrCode.do?type="+type+"&giftCardIssueNo="+giftCardIssueNo;
}

</script>
 </HEAD>

 <BODY>
   <jsp:include page="../common/topper.jsp" />
      <h4><spring:message code="label.mygiftcard" /></h4>
   </header>
 <section style="padding-top: 45px;">
 	<div class="mira_img_box">
	<div class="mira_img_box1">
		<img src="/resources/images/giftcard/rp${model.giftCard.giftCardAmount}.jpg" alt="상품권이미지"/>
	</div>
 </div>
 <div class="mira_text_box">
	<ul>
		<li class="mira_text_box1"><spring:message code="label.returnp" /></li>
		<li class="mira_text_box2"><spring:message code="label.returnp_gift_card" /> <fmt:formatNumber value="${model.giftCard.giftCardAmount}" pattern="###,###,###,###"/>원<!-- &nbsp;권 --></li>
		<li class="mira_text_box3">
			<div class="mira_left_box">
			<spring:message code="label.order_number" />
			</div>
			<div class="mira_left_box">	
				${model.giftCard.orderNumber }
			</div>
			<div class="mira_right_box">
				1
			</div>
			<div class="mira_right_box">
				<spring:message code="label.qty" />
			</div>
		</li>
	</ul>
 </div>
 <div class="mira_qr_code_box">
	<div class="mira_qr_code">
		<img onclick = "viewFullQrCode(${model.giftCard.giftCardIssueNo}, 'A')" src="/m/giftCard/downQrCode.do?type=A&giftCardIssueNo=${model.giftCard.giftCardIssueNo}" alt="ACC QR"/>
	</div>
	<p><spring:message code="label.gift_acc" /></p>
</div>
<div class="mira_qr_code_box">
	<div class="mira_qr_code">
		<img onclick = "viewFullQrCode(${model.giftCard.giftCardIssueNo}, 'P')" src="/m/giftCard/downQrCode.do?type=P&giftCardIssueNo=${model.giftCard.giftCardIssueNo}" alt="PAY QR"/>
	</div> 
	<p><spring:message code="label.gift_pay" /></p>
</div>
<input type = "hidden" id = "accQrData" value = "${model.giftCard.accQrData}"/>
<div class="mira_account" >
	<ul>
		
		<li>
			<div class="mira_account_left"><spring:message code="label.gift_card_amount" /></div>
			<div class="mira_account_right"><fmt:formatNumber value="${model.giftCard.giftCardAmount}" pattern="###,###,###,###"/></div>
		</li>
		
		<li>
			<div class="mira_account_left"><spring:message code="label.buy_type" /></div>
			<c:choose>
				<c:when test = "${model.giftCard.orderType == '20'}">
					<div class="mira_account_right"><spring:message code="label.buy_type_common" /></div>
				</c:when>
				<c:otherwise>
					<div class="mira_account_right"><spring:message code="label.buy_type_sales" /></div>
				</c:otherwise>
			</c:choose>
		</li>
		
		<li>
			<div class="mira_account_left"><spring:message code="label.order_date" /></div>
			<div class="mira_account_right">${model.giftCard.createTime}</div>
		</li>
		
		<li>
			<div class="mira_account_left"><spring:message code="label.expiration_period" /></div>
			<div class="mira_account_right">구입후 3년 (${model.giftCard.expirationTime})</div>
		</li>
		<li>
			<div class="mira_account_left"><spring:message code="label.order_number" /></div>
			<div class="mira_account_right">${model.giftCard.orderNumber }</div>
		</li>
		
		<li>
			<div class="mira_account_left"><spring:message code="label.gift_status" /></div>
			<c:if test = "${model.giftCard.giftCardStatus == '1'}">
				<div class="mira_account_right"><spring:message code="label.normal" /></div>
			</c:if>
			<c:if test = "${model.giftCard.giftCardStatus == '2'}">
				<div class="mira_account_right2 acc_not"><spring:message code="label.stop_using" /></div>
			</c:if>
			<c:if test = "${model.giftCard.giftCardStatus == '3'}">
				<div class="mira_account_right2 acc_not"><spring:message code="label.unaccumulatable" /></div>
			</c:if>
			<c:if test = "${model.giftCard.giftCardStatus == '4'}">
				<div class="mira_account_right2 acc_not"><spring:message code="label.unpayable" /></div>
			</c:if>
			<c:if test = "${model.giftCard.giftCardStatus == '5'}">
				<div class="mira_account_right2 acc_not"><spring:message code="label.expiration" /></div>
			</c:if>
		</li>
		
		<li>
			<div class="mira_account_left"><spring:message code="label.accable_status" /></div>
			<c:if test = "${model.giftCard.accableStatus == 'Y'}">
				<div class="mira_account_right3"><button class = "acc_btn" id = "acc_btn"><spring:message code="label.accumulate" /></button></div>
				<div class="mira_account_right2 acc_not"><spring:message code="label.acc_not" /></div>
			</c:if>
			<c:if test = "${model.giftCard.accableStatus == 'N'}">
				<div class="mira_account_right2 acc_ok"><spring:message code="label.acc_ok" /></div>
			</c:if>
		</li>
		<li>
			<div class="mira_account_left"><spring:message code="label.payable_status" /></div>
			<c:if test = "${model.giftCard.payableStatus == 'Y'}">
				<div class="mira_account_right2 pay_not"><spring:message code="label.pay_not" /></div>
			</c:if>
			<c:if test = "${model.giftCard.payableStatus == 'N'}">
				<div class="mira_account_right2 pay_ok"><spring:message code="label.pay_ok" /></div>
			</c:if>
		</li>
		<li>
			<div class="mira_account_left"><spring:message code="label.usage" /></div>
			<div class="mira_account_right"><spring:message code="label.franchise" /></div>
		</li>
<%-- 		<li>
			<div class="mira_account_left"><spring:message code="label.customerNotice" /></div>
			<div class="mira_account_right1">
				<div class="mira_bt_box" style = "float : right">
				 <a href="#"><img src="/resources/images/giftcard/button1.png" alt='<spring:message code="label.question" />'/></a>
				</div>
				<div class="mira_bt_box" style = "float : right">
				 <a href="#"><img src="/resources/images/giftcard/button.png" alt='<spring:message code="label.consulting" />'/></a>
				</div>
			</div>
		</li> --%>
	</ul>
</div>
<div class="mira_bot_text">
	<h5>상품정보 및 주의사항</h5>
		<ul>
			<li>1) 리턴포인트 상품권은 전국 RP 가맹점에서 현금처럼 자유롭게 사용 가능합니다.</li>
			<li>2) 리턴포인트 상품권 구입시 적립용 QR코드와 결제용 QR 코드가 생성됩니다.
				<ul>
					<li>- 적립용 QR 코드 : G포인트 적립용, 스캔 혹은 클릭하여 적립</li>
					<li>- 결제용 QR 코드 : RP가맹점에서 현금처럼 사용가능하며, 가맹점 이용후 결제시 제공</li>
				</ul>
			</li>
			<li>3) QR 이미지를 클릭하면 큰 이미지로 보실 수 있습니다</li>
		</ul>
</div>
	</section>
 </BODY>
</HTML>
