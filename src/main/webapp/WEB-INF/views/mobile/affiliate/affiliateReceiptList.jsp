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
<script type="text/javascript" src="/resources/js/lib/m_point_gift.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var pageContextlocale = '${pageContext.response.locale}';
	$("#sel1").val(pageContextlocale);
	
	$(".reqeust_deposit_check").click(function(){
		var target = $(this);
		$.ajax({
	       	   type: "POST",
	              url: "/m/pointCoupon/checkDepositRequest.do",
	               data: {pointCodeIssueRequestNo : target.attr("requestNo")},
	               success: function (result) {
	            	  console.log(result);
	            	   if (result && typeof result !="undefined") {
	            	   		if (result.result.code == 0) {
								$(".requestNo_"+ target.attr("requestNo")).find(".depositStatus").text("입금확인 요청중");
								target.remove();
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
		<h4>${affiliate.affiliateName}</h4>
	</header> 
	<section>
	<c:choose>
	<c:when test = "${! empty model.receiptList}">
	<div class="affiliate_receipt">
		<c:forEach items = "${model.receiptList}" var= "receipt">
			<div class="affiliate_receipt_list requestNo_${receipt.pointCodeIssueRequestNo}" >
				<div class="affiliate_receipt_top_left">${affiliate.affiliateName}
					<span>
						<fmt:parseDate value="${receipt.createTime}" var="noticePostDate" pattern="yyyy-MM-dd HH:mm:ss"/>
						<fmt:formatDate value="${noticePostDate}" pattern="yyyy-MM-dd HH:mm"/>
					</span>
				</div>
				<c:if test = "${receipt.status == '1'}"> 
				<div class="affiliate_receipt_top_right reqeust_deposit_check" requestNo = "${receipt.pointCodeIssueRequestNo}" >입금확인</div>
				</c:if>
				<div class="affiliate_receipt_pay">
					<ul>
						<c:if test = "${receipt.status == '1' or receipt.status == '2'}"> 
						<li style = "font-size:15px;color : #222;">가맹점주님이 입금하실 금액</li>
						</c:if>
						<c:if test = "${receipt.status == '3' or receipt.status == '4'}"> 
						<li style = "font-size:15px;color : #222;">가맹점주님이 입금하신 금액</li>
						</c:if>
						<li style = "font-size:12px;color : #999;margin-top:-12px">결제 금액에서 부가세를 제외한 금액의 15%</li>
						<li><h3><fmt:formatNumber value="${receipt.finalDepositAmount}" pattern="###,###,###,###"/>원</h3></li>
						<c:if test = "${receipt.status == '1' or receipt.status == '2'}"> 
					<!-- 	<li style="font-size:12px;">입금 완료시 회원님께 적립코드가 발송됩니다.</li> -->
						</c:if>
					</ul>
				</div>
				<div class="affiliate_receipt_bottom">
					<ul>
						<li>등록회원</li>
						<li><span> ${receipt.memberName}</span></li>
					</ul>
				</div>
				<div class="affiliate_receipt_bottom">
					<ul>
						<li>결제금액</li>
						<li><span><fmt:formatNumber value="${receipt.payAmount}" pattern="###,###,###,###"/>원</span></li>
					</ul>
				</div>
				<div class="affiliate_receipt_bottom">
					<ul>
						<li>처리상태</li>
						<li>
							<span class = "depositStatus">
								<c:choose>
									<c:when test = "${receipt.status== '1'}" >입급확인중</c:when>
									<c:when test = "${receipt.status== '2'}">입금확인 요청중</c:when>
									<c:when test = "${receipt.status== '3'}">입금확인 완료</c:when>
									<c:when test = "${receipt.status== '4'}">처리완료</c:when>
									<c:when test = "${receipt.status== '5'}">입금취소</c:when>
									<c:when test = "${receipt.status== '6'}">처리불가 </c:when>
									</c:choose>	
							</span>
						</li>
					</ul>
				</div>
			</div>
		</c:forEach>
	</div>
	</c:when>
	<c:otherwise>
		<div class="list_none" style="width:70%;margin-left:15%;margin-top:27%;height:200px;" onclick = "movePage('/m/pointCoupon/receiptDetail.do?pointCodeIssueRequestNo=${receipt.pointCodeIssueRequestNo}')">
		<img src="/resources/images/list_none_img.png" width="80" height="80">
		<p>내역이 존재하지 않습니다</p>
	</div>
	</c:otherwise>
	</c:choose>
   </section>
     <div id = "progress_loading2">
		<img src="/resources/images/progress_loading.gif"/>
	</div>
</body>
<!-- body end -->
</html>