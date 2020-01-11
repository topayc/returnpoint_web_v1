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
	
	$("#reqeust_affiliate_deposit").click(function(){
		$.ajax({
	       	   type: "POST",
	              url: "/m/pointCoupon/reqeustAffiliateDeposit.do",
	               data: {pointCodeIssueRequestNo : $(this).attr("requestNo")},
	               success: function (result) {
	            	   if (result && typeof result !="undefined") {
	            		   	alertOpen("알림", result.result.msg, true, false, null, null); 
		               }else{
		              		alertOpen("알림", "장애 발생. 다시 시도해주세요.", true, false, null, null);
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
					<img  src = "${model.receipt.uploadFile }"/>
				</div>
			</div>
		</div>
		<div class="upload_conbox">
			<div>
				<p style = "margin-bottom:10px;font-weight:550;color : #000">영수증 업로드 세부 정보</p>
				<ul>
					<li style="border-bottom:none;">
						<ul>
							<li class="upload_conbox_text1">영수증 타입</li>
							<li class="upload_conbox_text2">
								<c:choose>
									<c:when test = "${model.receipt.issueType == '1'}"> ${model.receipt.affiliateName} 가맹점영수증</c:when>
									<c:when test = "${model.receipt.issueType == '2'}">비가맹점</c:when>
								 </c:choose>
							</li>
						</ul>
					</li>
					<li>
						<ul>
							<li class="upload_conbox_text1">결제 금액</li>
							<li class="upload_conbox_text2"><fmt:formatNumber value="${model.receipt.payAmount}" pattern="###,###,###,###"/>원</li>
						</ul>
					</li>
					<li style="border-top:none;">
						<ul>
							<li class="upload_conbox_text1">적립  포인트</li>
							<li class="upload_conbox_text2"><fmt:formatNumber value="${model.receipt.accPointAmount}" pattern="###,###,###,###"/>P</li>
						</ul>
					</li>
					<li style="border-top:none;">
						<ul>
							<li class="upload_conbox_text1">입금할 금액</li>
							<li class="upload_conbox_text2"><fmt:formatNumber value="${model.receipt.depositAmount}" pattern="###,###,###,###"/>원</li>
						</ul>
					</li>
					<li style="border-top:none;">
						<ul>
							<li class="upload_conbox_text1">처리 상태</li>
							<li class="upload_conbox_text2">
								<p><c:choose>
							    	<c:when test = "${model.receipt.status== '1'}"><span class = "depositStatus" style = "background-color : #DF0101">입급확인중</span></c:when>
							    	<c:when test = "${model.receipt.status== '2'}"><span class = "depositStatus" style = "background-color : #BF00FF">입금확인 요청중</span></c:when>
							    	<c:when test = "${model.receipt.status== '3'}"><span class = "depositStatus" style = "background-color : #4000FF">입금확인 완료</span></c:when>
							    	<c:when test = "${model.receipt.status== '4'}"><span class = "depositStatus" style = "background-color : #04B404">적립코드 발급완료</span></c:when>
							    	<c:when test = "${model.receipt.status== '5'}"><span class = "depositStatus" style = "background-color : #FF8000">입금취소 </span></c:when>
							    	<c:when test = "${model.receipt.status == '6'}"><span class = "depositStatus" style = "background-color : #6E6E6E">처리불가  </span></c:when>
						    	</c:choose>
						    	</p>
							</li>
						</ul>
					</li>
					<c:if test = "${model.receipt.status== '1'}">
						<li style="border-top:none;">
						<ul>
							<li class="upload_conbox_text1"> 상태 메시지 </li>
							<li class="upload_conbox_text2">현재 가맹점의 입금을 기다리고 있습니다</li>
						</ul>
						</li>
					</c:if>
				</ul> 
	<!-- 		<p style = "margin-top:20px;font-weight:550;color : #000">입금 계좌 정보</p>
			<div style = "border : 1px solid #ddd;margin-top:10px;">
				우리은행 &nbsp;&nbsp;1002-751-058576 &nbsp;&nbsp;예금주:안영철
			</div> -->
			
			<c:if test = "${model.receipt.status == '1'}"> 
				<p style = "margin-top:20px;font-weight:550;color : #000; " id = "check_deposit_1">가맹점주의 입금이 확인시 회원님 계정으로 적립코드가 등록됩니다.가맹점주에게 입금을 요청하려면 아래 버튼을 눌러주세요</p>
				<button id = "reqeust_affiliate_deposit"   requestNo = "${model.receipt.pointCodeIssueRequestNo}">가맹점주에게 입금 요청하기 </button>
				</br>
				<p>*가맹점주가 푸시알림을 OFF 했을 경우는 가맹점주에게 메시지가 전달되지 않습니다. </p>
			</c:if> 	
		</div>
	
		
	</div>
   </section>
</body>
<!-- body end -->
</html>