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
<script type="text/javascript">
$(document).ready(function(){
	var pageContextlocale = '${pageContext.response.locale}';
	$("#sel1").val(pageContextlocale);
	
	$("#reqeust_deposit_check").click(function(){
		$.ajax({
	       	   type: "POST",
	              url: "/m/pointCoupon/checkDepositRequest.do",
	               data: {pointCodeIssueRequestNo : $(this).attr("requestNo")},
	               success: function (result) {
	            	  console.log(result);
	            	   if (result && typeof result !="undefined") {
	            	   		if (result.result.code == 0) {
								$(".depositStatus").text("입금확인요청중");
								$(".depositStatus").css("background-color","#BF00FF");
							}
	            		   	alertOpen("알림", result.result.msg, true, false, null, null); 
		               }else{
		              		alertOpen("알림", "1.장애 발생. 다시 시도해주세요.", true, false, null, null);
		           	   }
	               },
	               error : function(request, status, error){
	            	   alertOpen("알림 ", "2.장애 발생. 다시 시도해주세요", true, false, null, null);
	               },
	               dataType: 'json'
	       });
	});
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
		<h4>영수증 업로드 세부 정보</h4>
	</header> 
	<section>
	<div class="receipt_detail">
		<div class="bg_black">
			<div class="bg_white">
				<div class="bg_img">
						<c:choose>
						<c:when test = "${empty model.pointCodes }"><img  src = "/resources/images/bg_img.jpg"/></c:when>
						<c:otherwise><img  src = "${model.receipt.uploadFile }"/></c:otherwise>
						 </c:choose>
				</div>
			</div>
		</div>
		<div class="upload_conbox">
			<p style = "margin-bottom:10px;font-weight:550;color : #000; ">영수증 업로드 세부 정보</p>
			<div>
		<!-- 		<ul>
					<li>
						<ul>
							<li class="upload_conbox_text1">결제금액</li>
							<li class="upload_conbox_text2">100,000</li>
						</ul>
					</li>
					<li>
						<ul>
							<li class="upload_conbox_text1">적립금액</li>
							<li class="upload_conbox_text2">100,000</li>
						</ul>
					</li>
					<li>
						<ul>
							<li class="upload_conbox_text1">입금금액</li>
							<li class="upload_conbox_text2">15,000</li>
						</ul>
					</li>
					<li>
						<ul>
							<li class="upload_conbox_text1">상태</li>
							<li class="upload_conbox_text2"><span class = "depositStatus"  style = "background-color : #DF0101">입금확인중</span></li>
						</ul>
					</li>
				</ul> -->
				
			<ul>
					<li>
						<ul>
							<li class="upload_conbox_text1">결제금액</li>
							<li class="upload_conbox_text2"><fmt:formatNumber value="${model.receipt.payAmount}" pattern="###,###,###,###"/></li>
						</ul>
					</li>
					<li>
						<ul>
							<li class="upload_conbox_text1">적립금액</li>
							<li class="upload_conbox_text2"><fmt:formatNumber value="${model.receipt.accPointAmount}" pattern="###,###,###,###"/></li>
						</ul>
					</li>
					<li>
						<ul>
							<li class="upload_conbox_text1">입금금액</li>
							<li class="upload_conbox_text2"><fmt:formatNumber value="${model.receipt.depositAmount}" pattern="###,###,###,###"/></li>
						</ul>
					</li>
					<li>
						<ul>
							<li class="upload_conbox_text1">상태</li>
							<li class="upload_conbox_text2">
								<c:choose>
							    	<c:when test = "${receipt.depositStatus == '1'}"><span class = "depositStatus" style = "background-color : #DF0101">입급 확인중</span></c:when>
							    	<c:when test = "${receipt.depositStatus == '2'}"><span class = "depositStatus" style = "background-color : #BF00FF">입금 확인 요청중</span></c:when>
							    	<c:when test = "${receipt.depositStatus == '3'}"><span class = "depositStatus" style = "background-color : #04B404">입금 확인 완료</span></c:when>
							    	<c:when test = "${receipt.depositStatus == '4'}"><span class = "depositStatus" style = "background-color : #6E6E6E">입금 취소 </span></c:when>
						    	</c:choose>
							</li>
						</ul>
					</li>
				</ul> 
			</div>
			
		<!-- 	<p style = "margin-top:20px;font-weight:550;color : #000">입금 상태</p>
			<div style = "border : 1px solid #ddd;margin-top:10px;background-color : #BF00FF;color : #fff">
				입금 확인중
			</div> -->
			
			<p style = "margin-top:20px;font-weight:550;color : #000">입금 계좌 정보</p>
			<div style = "border : 1px solid #ddd;margin-top:10px;">
				국민은행   10000-11111   예금주 : 안영철
			</div>
		
		<%-- 	<c:if test = "${receipt.depositStatus == '1'}"> --%>
			<p style = "margin-top:20px;font-weight:550;color : #000; ">빠른 처리를 위해서 입금확인 요청을 해주세요</p>
			<button id = "reqeust_deposit_check" requestNo = "${model.receipt.pointCodeIssueRequestNo}">입금 확인 요청하기</button>
			<p >입금이 완료되어야 적립코드가 발행되며,입금을 하셨을 경우 </br>
				<b>입금확인 요청하기</b> 버튼을 클릭하시면 빠른 처리가 가능합니다.
			</p>
	<%-- 		</c:if> --%>
		</div>	
		
	</div>
   </section>
</body>
<!-- body end -->
</html>