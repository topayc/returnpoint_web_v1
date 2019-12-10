<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="com.returnp_web.utils.SessionManager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="f" uri="/WEB-INF/tld/f.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	$('.del_account').click(function(){
		var target = $(this);
		alertOpen(
			"확인", 
			"정말로 계좌를 삭제하시겠습니까? ", 
			true, 
			true, 
			function(){deleteAccount(target.attr('memberBankNo').trim());}, 
			null);
		
	})
});

function deleteAccount(memberBankAccountNo) {
	  bridge.getSessionValue('PREF_ALL_SESSION', function(result){
		  var userAuthToken;
		  var ajax;
		  if (!result) {
			  ajax = true;
		  }else {
			  result = JSON.parse(result)
			  userAuthToken = result.user_auth_token;
		  }
		  
		$.ajax({
			method : "get",
			url    : "/m/mypage/m_delete_bank_account.do",
			dataType: "json",
			data   : {
				memberBankAccountNo : memberBankAccountNo
			},
			 beforeSend : function(xhr){
			     if (!userAuthToken) {
					 xhr.setRequestHeader("AJAX","true");
			     }else {
			    	 xhr.setRequestHeader("user_auth_token",userAuthToken);
			     }
			 },
			success: function(data) {
				if (data.result.code == 0 ) {
					alertOpen("확인", "계좌 삭제 완료", true, false, function(){location.reload();}, null);
				}else{
					alertOpen("확인", data.result.msg, false, true, null, null);
				}
			},
			error: function (request, status, error) {
				alertOpen("확인", data.result.msg, false, true, null, null);
			}
			});
	  });
}

</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_recommend">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4><spring:message code="label.point_withdraw_manage"/></h4>
	</header> 
	<!-- content begin -->
	<c:choose>
		<c:when test = "${empty model.pointWithdrawals }">
			<section class="qr_nodata"><!-- 0824 -->
				<div> <i class="fas fa-exclamation-triangle"></i><spring:message code="label.desc_no_point_withdrawal"/></div>
				<button type="button" class="btn btn-submit"  onclick = "movePage('/m/mypage/m_withdrawl_point_form.do')"><spring:message code="label.withdrawl_req"/></button>
			</section>
		</c:when>
		<c:otherwise>
			<section>
				<div class="listS01" id = "account_list_frame" style="padding:2%;background-color:#f1f1f1;">
					<div class="list_title" style="font-size:12px;">* 출금 요청 세부 내역을 보려면 해당 항목을 클릭하세요 <%-- <i class="fas fa-building"></i> <spring:message code="label.desc_point_withdrawal_list"/> --%> </div>
					<c:forEach var="pointWithdrawal"  items="${model.pointWithdrawals}"  >
						<div class="list_li collapsed" data-toggle="collapse" data-target="#point_withdraw_${pointWithdrawal.pointWithdrawalNo}">
						   <%--  <div style = "width:25%;text-align:left">${pointWithdrawal.bankName} </div>
						    <div style = "width:20%;text-align:left">${pointWithdrawal.accountOwner}</span></div>
						    <div style = "width:35%;text-align:left">${pointWithdrawal.bankAccount}</span></div> --%>
						    <div style = "width:100%;text-align:left" >
						    	<span style = "font-size : 15px"><fmt:formatNumber value="${pointWithdrawal.withdrawalAmount}" pattern="###,###,###,###"/>원 출금 요청</span></div>
						     <div style = "width:100%;text-align:left;color : #888;font-size : 13px">
						     	<fmt:formatDate value="${pointWithdrawal.createTime}" pattern="yyyy년 MM월 dd일 HH시 mm분"/>
						     	
						     </div>
						    <div style = "width:20%;text-align:left;position:absolute;right:7%;bottom:40%;" >
						    <c:choose>
						    	<c:when test = "${pointWithdrawal.withdrawalStatus == '1'}"><span class="label label-danger" style="padding:12%;border-radius:20px;font-size:12px;">${pointWithdrawal.withdrawalStatusText}</span></c:when>
						    	<c:when test = "${pointWithdrawal.withdrawalStatus == '2'}"><span class="label label-success" style="padding:12%;border-radius:20px;font-size:12px;">${pointWithdrawal.withdrawalStatusText}</span></c:when>
						    	<c:when test = "${pointWithdrawal.withdrawalStatus == '3'}"><span class="label label-warning" style="padding:12%;border-radius:20px;font-size:12px;">${pointWithdrawal.withdrawalStatusText}</span></c:when>
						    	<c:when test = "${pointWithdrawal.withdrawalStatus == '4'}"><span class="label label-danger" style="padding:12%;border-radius:20px;font-size:12px;">${pointWithdrawal.withdrawalStatusText}</span></c:when>
						    	<c:when test = "${pointWithdrawal.withdrawalStatus == '5'}"><span class="label label-danger" style="padding:12%;border-radius:20px;font-size:12px;">${pointWithdrawal.withdrawalStatusText}</span></c:when>
						    </c:choose>
						    </div>
						</div>		
						<div id = "point_withdraw_${pointWithdrawal.pointWithdrawalNo}" class="list_li list_toggle collapse">
							<div style = "background-color:#fff">
								<p style = "margin-left : 7px;border-bottom: 1px solid #eeeeee;color:#000;font-weight:405;"><!-- <i class="fas fa-chevron-right list_blt">&nbsp;</i> --><span>출금 은행 : ${pointWithdrawal.bankName}</span></p>
								<p style = "margin-left : 7px;border-bottom: 1px solid #eeeeee;color:#000;font-weight:405;"><span>출금 계좌 : ${pointWithdrawal.bankAccount}</span></p>
								<p style = "margin-left : 7px;border-bottom: 1px solid #eeeeee;color:#000;font-weight:405;"><span>예금주 : ${pointWithdrawal.accountOwner}</span></p>
								<p style = "margin-left : 7px;border-bottom: 1px solid #eeeeee;color:#000;font-weight:405;"><span>출금 요청일 : <fmt:formatDate value="${pointWithdrawal.createTime}" pattern="yyyy년 MM월 dd일 HH시 mm분"/> </span></p>
								<p style = "margin-left : 7px;border-bottom: 1px solid #eeeeee;color:#000;font-weight:405;"><span>출금 요청금액 : <fmt:formatNumber value="${pointWithdrawal.withdrawalAmount}" pattern="###,###,###,###"/> 원</span></p>
								<p style = "margin-left : 7px;border-bottom: 1px solid #eeeeee;color:#000;font-weight:405;"><span >출금 처리상태 : &nbsp;
								<c:choose>
						    	<c:when test = "${pointWithdrawal.withdrawalStatus == '1'}"><span class="label label-danger" style="padding:2%;border-radius:20px;">${pointWithdrawal.withdrawalStatusText}</span></c:when>
						    	<c:when test = "${pointWithdrawal.withdrawalStatus == '2'}"><span class="label label-success" style="padding:2%;border-radius:20px;">${pointWithdrawal.withdrawalStatusText}</span></c:when>
						    	<c:when test = "${pointWithdrawal.withdrawalStatus == '3'}"><span class="label label-warning" style="padding:2%;border-radius:20px;">${pointWithdrawal.withdrawalStatusText}</span></c:when>
						    	<c:when test = "${pointWithdrawal.withdrawalStatus == '4'}"><span class="label label-danger" style="padding:2%;border-radius:20px;">${pointWithdrawal.withdrawalStatusText}</span></c:when>
						    	<c:when test = "${pointWithdrawal.withdrawalStatus == '5'}"><span class="label label-danger" style="padding:2%;border-radius:20px;">${pointWithdrawal.withdrawalStatusText}</span></c:when>
						    </c:choose>
								</strong></span></p>
							</div> 
						</div>
					</c:forEach>
				</div>
				<div class="btns2">
					<button type="button" class="btn btn-submit" onclick = "movePage('/m/mypage/m_withdrawl_point_form.do')">
						<i class="fas fa-sign-out-alt"></i>
						<spring:message code="label.withdrawl_req"/>
					</button>
					<button type="button" class="btn btn-submit-cancel"  onclick = "movePage('/m/mypage/rpoint/rpoint_withdrawal.do')">출금 홈으로 가기</button>
				</div>
				
			</section>	
		</c:otherwise>
	</c:choose>
	<!-- content end -->
</body>
<!-- body end -->
</html>