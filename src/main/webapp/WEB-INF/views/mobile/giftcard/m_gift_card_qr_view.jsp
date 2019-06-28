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
 </HEAD>

 <BODY>
   <jsp:include page="../common/topper.jsp" />
	<c:choose>
		
		<c:when test="${model.type == 'P'}">
			<h4><spring:message code="label.pay_qr" /></h4>
		</c:when>
		
		<c:when  test="${model.type == 'P'}">
			<h4><spring:message code="label.acc_qr" /></h4>
		</c:when>
		
		<c:otherwise>
			<h4><spring:message code="label.mygiftcard" /></h4>
		</c:otherwise>
	</c:choose>
   </header>
 <section style="padding-top: 45px;">
 	<div class="mira_img_box">
	<div class="mira_img_box1">
		<img src="/m/giftCard/downQrCode.do?type=${model.type}&giftCardIssueNo=${model.giftCard.giftCardIssueNo}" alt="상품권이미지"/>
	</div>
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
