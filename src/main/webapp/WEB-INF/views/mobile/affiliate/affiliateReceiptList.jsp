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
								$(".requestNo_"+ target.attr("requestNo")).find(".depositStatus").text("입금확인요청중");
								$(".requestNo_"+ target.attr("requestNo")).find(".depositStatus").css("background-color","#BF00FF");
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
	<div class="affiliate_receiptlist_page">
		<c:forEach items = "${model.receiptList}" var= "receipt">
		<div class="affiliate_receiptlist requestNo_${receipt.pointCodeIssueRequestNo}" >
			<div class="receiptlist_fran">${receipt.affiliateName}</div>
			<div class="receiptlist_day">
				<fmt:parseDate value="${receipt.createTime}" var="noticePostDate" pattern="yyyy-MM-dd HH:mm:ss"/>
				<fmt:formatDate value="${noticePostDate}" pattern="yyyy-MM-dd HH:mm"/>
			</div>
			<div class="receiptlist_list">
				<ul>
					<li>ㆍ영수증 업로드 회원 : ${receipt.memberName}</li>
					<li>ㆍ결제 금액 : <fmt:formatNumber value="${receipt.payAmount}" pattern="###,###,###,###"/>원</li>
					<li>ㆍ가맹점주가 입금할 금액 : <fmt:formatNumber value="${receipt.depositAmount}" pattern="###,###,###,###"/>원</li>
					<li>ㆍ상태 : 
					<c:choose>
					<c:when test = "${receipt.status== '1'}" ><span class = "depositStatus" style = "background-color : #DF0101">입급확인중</span></c:when>
					<c:when test = "${receipt.status== '2'}"><span class = "depositStatus" style = "background-color : #BF00FF">입금확인 요청중</span></c:when>
					<c:when test = "${receipt.status== '3'}"><span class = "depositStatus" style = "background-color : #4000FF">입금확인 완료</span></c:when>
					<c:when test = "${receipt.status== '4'}"><span class = "depositStatus" style = "background-color : #04B404">적립코드 발급완료</span></c:when>
					<c:when test = "${receipt.status== '5'}"><span class = "depositStatus" style = "background-color : #FF8000">입금취소 </span></c:when>
					<c:when test = "${receipt.status== '6'}"><span class = "depositStatus" style = "background-color : #6E6E6E">처리불가  </span></c:when>
					</c:choose>	
					</li>
				</ul>
			</div>
			<c:if test = "${receipt.status == '1'}"> 
				<button class = "reqeust_deposit_check"   requestNo = "${receipt.pointCodeIssueRequestNo}">입금 확인 요청하기</button>
			</c:if>
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