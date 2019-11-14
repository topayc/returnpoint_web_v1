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
	var giftCardStatus = "${model.giftCardStatus}"
	$(document).ready(function(){
		$('#a_' + giftCardStatus).addClass("nav_select");
		$(".gift_card_nav_a").click(function(){
			var id = $(this).attr("id");
			location.href = "/m/giftCard/giftCardList.do?giftCardStatus=" + id.split("_")[1];
		})
	});
	
	function giftCardDetail(myGiftCardNo) {
		location.href = "/m/giftCard/giftCardDetail.do?myGiftCardNo="+ myGiftCardNo;
	}
</script>
 </HEAD>

 <BODY>
   <jsp:include page="../common/topper.jsp" />
      <h4><spring:message code="label.mygiftcard" /></h4>
   </header>
 <section style="padding-top: 45px;height:84.7%">
 <div class="top_text"><h1>${fn:length(model.myGiftCards)}개의 ${model.giftCardStatusStr} <br/>R 포인트 상품권이 있습니다. </h1></div>
 <div class="gift_card_nav">
	<ul>
		<li><a href="#" class = "gift_card_nav_a" id ="a_3"><spring:message code="label.pay_not" />&nbsp;<span class = "pay_not_count"></span></a></li>
		<li><a href="#" class = "gift_card_nav_a" id ="a_4"><spring:message code="label.acc_not" />&nbsp;<span class = "acc_not_count"></span></a></li>
		<li><a href="#" class = "gift_card_nav_a"  id ="a_1"><spring:message code="label.pay_ok" />&nbsp;<span class = "pay_ok_count"></span></a></li>
		<li><a href="#" class = "gift_card_nav_a" id ="a_2"><spring:message code="label.acc_ok" />&nbsp;<span class = "acc_ok_count"></span></a></li>
	</ul>
 </div>
 
 <div class="con_box" >
	<c:choose>
		<c:when test = "${empty model.myGiftCards}">
			<section class="qr_nodata" style = "background-color : #eeeeee;height:100%">
				<div style = "height : 100%"> 
					<i style = "color : #ccc;font-size : 60px" class="fas fa-exclamation-triangle"></i>
					<span style = "font-size : 16px; color : #555555;font-weight: 400"><spring:message code="label.no_gift_card"/></span></div>
			</section>
		</c:when>
		<c:otherwise>
			<c:forEach items = "${model.myGiftCards}" var = "giftCard">
				<div class="content giftcard"  onclick = "giftCardDetail(${giftCard.myGiftCardNo})">
					<div class="con_box_icon">
						<a href="#">
							<img src="/resources/images/giftcard/rp${giftCard.giftCardAmount}.jpg" alt="상품권이미지1"/>
							<ul>
								<li class="con_box_icon1"><b><spring:message code="label.returnp_gift_card" /></b></li>
								<li class="con_box_icon2"><fmt:formatNumber value="${giftCard.giftCardAmount}" pattern="###,###,###,###"/>원</li>
							</ul>
						</a>
						<div class="logo">
							<c:choose>
								<c:when test = "${model.giftCardStatus == '1'}"><img class = "gift_mark"  src="/resources/images/giftcard/pay_ok.png" alt="결제완료"/></c:when>
								<c:when test = "${model.giftCardStatus == '2'}"><img class = "gift_mark"  src="/resources/images/giftcard/acc_of.png" alt="적립완료"/></c:when>
								<c:when test = "${model.giftCardStatus == '3'}"><img class = "gift_mark"  src="/resources/images/giftcard/pay_not.png" alt="결제가능"/></c:when>
								<c:when test = "${model.giftCardStatus == '4'}"><img class = "gift_mark"  src="/resources/images/giftcard/acc_not.png" alt="적립가능"/></c:when>
							</c:choose>
						</div>
					</div>
					<div class="text_box">
						<ul>
							<li class="text_box2">${giftCard.createTime}</li>
							<!-- <li class="text_box1">form.실장님</li> -->
						</ul>
					</div>
				</div>	
			</c:forEach>
		</c:otherwise>
	</c:choose>

 </div>
 </section>
 </BODY>
</HTML>
