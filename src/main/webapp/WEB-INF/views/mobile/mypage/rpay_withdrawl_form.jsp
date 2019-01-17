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
<script type="text/javascript" src="/resources/js/lib/jquery-number.js"></script>
<script type="text/javascript">

function submitWithdrawl(){
	var withdrawalAmount = $("#withdrawalAmount").val().trim();

	var rPayBalance= ${model.rPayInfo.pointAmount};
	var memberBankAccountNo = $("#memberBankAccountNo").val().trim();

	var rpay_withdrawable_amount = parseInt($("#rpay_withdrawable_amount").val().trim());
	var rpay_total_withdrawal_one_day = parseInt($("#rpay_total_withdrawal_one_day").val().trim());
	
	var rPayWithdrawalMinLimit = parseInt($("#rPayWithdrawalMinLimit").val().trim());
	var rPayWithdrawalMaxLimit = parseInt($("#rPayWithdrawalMaxLimit").val().trim());
	
	if (!memberBankAccountNo || memberBankAccountNo.length == 0) {
		alertOpen("확인", "출금하실 은행계좌를 선택해주세요.", true, false, null, null);
		return false;
	}
	
	if (!withdrawalAmount || withdrawalAmount.length == 0) {
		alertOpen("확인", "출금하실 금액을 입력해주세요", true, false, null, null);
		return false;
	}
	
	if (!$.isNumeric(withdrawalAmount)) {
		alertOpen("확인", "출금 금액은 숫자만 입력가능합니다", true, false, null, null);
		return false;
	}
	
	withdrawalAmount = parseInt(withdrawalAmount);
	if (withdrawalAmount < rPayWithdrawalMinLimit) { 
		alertOpen("확인", "출금 금액은 최저 " + numberWithComma(rPayWithdrawalMinLimit) + " 이상입니다", true, false, null, null);
		return false;
	}
	
	if (withdrawalAmount >  rpay_withdrawable_amount) { 
		alertOpen(
			"확인", "회원님은 금일 총 " + 
			numberWithComma(rpay_total_withdrawal_one_day) + " 을 출금 요청하셨으며 </br> 현재 총 출금 가능금액은 " +  
			numberWithComma(rpay_withdrawable_amount) +" 입니다" , true, false, null, null);
		return false;
	}
	
	if (withdrawalAmount > rPayBalance) { 
		alertOpen("확인", "출금 금액이 보유중인 R-PAY를 초과합니다.</br> 확인후 다시 시도해주세요", true, false, null, null);
		return false;
	}
	
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
			method : "post",
			url    : "/m/mypage/m_withdrawal_point_regist.do",
			dataType: "json",
			data   :  $("#point_withdraw_form").serializeObject(),
			
			beforeSend : function(xhr){
			     if (!userAuthToken) {
					 xhr.setRequestHeader("AJAX","true");
			     }else {
			    	 xhr.setRequestHeader("user_auth_token",userAuthToken);
			     }
			},
			
			success: function(data) {
				if (data.result.code == 0 ) {
					alertOpen("확인", "R PAY의 현금 출금 요청이 완료되었습니다.", true, false, function(){history.go(-1)}, null);
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

$(document).ready(function(){
	var pageContextlocale = '${pageContext.response.locale}';
	$("#sel1").val(pageContextlocale);
	$("#thousandwon1").click(function() {
		$("#withdrawalAmount").val(Number($("#withdrawalAmount").val())+Number(1000));
	}); 
	$("#tenthousandwon1").click(function() {
		$("#withdrawalAmount").val(Number($("#withdrawalAmount").val())+Number(10000));
	});
	$("#fiftythousandwon1").click(function() {
		$("#withdrawalAmount").val(Number($("#withdrawalAmount").val())+Number(50000));
	});
	$("#onehundredthousandwon1").click(function() {
		$("#withdrawalAmount").val(Number($("#withdrawalAmount").val())+Number(100000));
	});

	$('#withdrawalCancel').click(function(){
		history.go(-1);
	})
});

</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_terms">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4><spring:message code="label.rpay_withdrawal" /></h4>
	</header> 	
	<c:choose>
		<c:when test = "${empty model.memberBankAccounts }">
			<section class="qr_nodata"><!-- 0824 -->
				<div> <i class="fas fa-exclamation-triangle"></i><spring:message code="label.desc_no_bank_account"/></div>
				<button type="button" class="btn btn-submit"  onclick = "movePage('/m/mypage/m_mybank_account_form.do')"><spring:message code="label.regist_bank_account"/></button>
			</section>
		</c:when>
		<c:otherwise>
			<section>
				<div class="m_point_transfer">
					<form name="point_withdraw_form"  id = "point_withdraw_form">
						<div class="modal-body">
							<div class="listmember"><strong><span class="node nd1"><spring:message code="label.mmember"/></span>&nbsp;<spring:message code="label.rpay"/></strong></div>
							<div class="listpoint"><strong><small>P</small>&nbsp;<span><fmt:formatNumber value="${model.rPayInfo.pointAmount}" pattern="###,###,###,###"/></span></strong></div>
							<div class="pointinput">
								<div class="form-group">
									<input type="number" placeholder="<spring:message code="label.desc_withdraw"/>" id="withdrawalAmount" name="withdrawalAmount""/>			
								</div>
								<div class="form-group">
									<select class="form-control" id="memberBankAccountNo" name="memberBankAccountNo"> 
									<c:forEach var = 'bank'  items = "${model.memberBankAccounts}">
										<option value = "${bank.memberBankAccountNo}">${bank.bankName} - ${bank.bankAccount} - ${bank.accountOwner}</option>
									</c:forEach>
									</select>
								</div>
								<button type="button" id="thousandwon1"><i class="fa fa-plus-circle"></i>1,000</button>
								<button type="button" id="tenthousandwon1"><i class="fa fa-plus-circle"></i>10,000</button>
								<button type="button" id="fiftythousandwon1"><i class="fa fa-plus-circle"></i>50,000</button>
								<button type="button" id="onehundredthousandwon1"><i class="fa fa-plus-circle"></i>100,000</button>			
							</div>
						<%-- 	<fmt:formatNumber var = "rpayWithdrawMinLimit" value="${model.policy.rPayWithdrawalMinLimit}" pattern="###,###,###,###" scope = "page"/>
							<fmt:formatNumber var = "rpayWithdrawMaxLimit"  value="${model.policy.rPayWithdrawalMaxLimit}" pattern="###,###,###,###" scope = "page"/> --%>
							<ul class="pointinfo">
								<%-- <li>- <strong><spring:message code="label.rpay_withdrawal_quide" arguments="${model.policy.rPayWithdrawalMinLimit}, ${model.policy.rPayWithdrawalMaxLimit}" /></strong></li> --%>
								<li>- <strong><spring:message code="label.rpay_total_withdrawal_one_day" arguments="${model.rpayTotalWithdrawal}" /></strong></li>
								<li>- <strong><spring:message code="label.rpay_withdrawable_amount" arguments="${model.policy.rPayWithdrawalMaxLimit - model.rpayTotalWithdrawal}" /></strong></li>
							</ul>
							<ul class="pointinfo">
								<%-- <li>- <strong><spring:message code="label.rpay_withdrawal_quide" arguments="${model.policy.rPayWithdrawalMinLimit}, ${model.policy.rPayWithdrawalMaxLimit}" /></strong></li> --%>
								<li>- <strong><spring:message code="label.rpay_withdrawal_min_quide" arguments="${model.policy.rPayWithdrawalMinLimit}" /></strong></li>
								<li>- <strong><spring:message code="label.rpay_withdrawal_max_quide" arguments="${model.policy.rPayWithdrawalMaxLimit}" /></strong></li>
							</ul>

							<ul class="pointinfo">
								<li>- <strong><spring:message code="label.rpay_withdrawal_day" /></strong></li>
							</ul>
						</div>
						<div class="btns2">
							<button type="button" class="btn btn-submit" onclick="submitWithdrawl();"><spring:message code="label.withdrawl_req"/></button>
							<button type="button" class="btn btn-submit-cancel" id="withdrawalCancel"><spring:message code="label.cancel"/></button>
						</div>
					</form>	
					<input type = "hidden" name = "rPayBalance"  id = "rPayBalance" value = "${model.rPayInfo.pointAmount}"/>
					<input type = "hidden" name = "rPayWithdrawalMinLimit"  id = "rPayWithdrawalMinLimit" value = "${model.policy.rPayWithdrawalMinLimit}"/>
					<input type = "hidden" name = "rPayWithdrawalMaxLimit"  id = "rPayWithdrawalMaxLimit" value = "${model.policy.rPayWithdrawalMaxLimit}"/>

					<input type = "hidden" name = "rpay_total_withdrawal_one_day"  id = "rpay_total_withdrawal_one_day" value = "${model.rpayTotalWithdrawal}"/>
					<input type = "hidden" name = "rpay_withdrawable_amount"  id = "rpay_withdrawable_amount" value = "${model.policy.rPayWithdrawalMaxLimit - model.rpayTotalWithdrawal}"/>
				</div>
			</section>	
        </c:otherwise>
	</c:choose>	
</div>
</body>
<!-- body end -->
</html>