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
<script type="text/javascript" src="/resources/js/lib/jquery.animateNumber.min.js"></script>
<script type="text/javascript">
var isSubmitting  = false;
function submitWithdrawl(){
	if (isSubmitting == true) {
		return;
	}
	isSubmitting = true;
	var withdrawalAmount = $("#withdrawalAmount").val().trim();

	var rPayBalance= ${model.rPayInfo.pointAmount};
	var memberBankAccountNo = $("#memberBankAccountNo").val().trim();

	var rpay_withdrawable_amount = parseInt($("#rpay_withdrawable_amount").val().trim());
	var rpay_total_withdrawal_per_week = parseInt($("#rpay_total_withdrawal_per_week").val().trim());
	
	var rPayWithdrawalMinLimit = parseInt($("#rPayWithdrawalMinLimit").val().trim());
	
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
	rpay_withdrawable_amount = rpay_withdrawable_amount <= 0 ? 0 :rpay_withdrawable_amount;
	//alert(rpay_withdrawable_amount);
	if (withdrawalAmount >  rpay_withdrawable_amount) { 
		alertOpen(
			"확인", "회원님은 금주 <b> " + 
			numberWithComma(rpay_total_withdrawal_per_week) + " </b>을 출금 요청하셨으며 </br> 현재  출금 가능금액은 <b> " +  
			numberWithComma(rpay_withdrawable_amount) +" </b>입니다" , true, false, null, null);
		return false;
	}  
	
	if (withdrawalAmount > rPayBalance) { 
		alertOpen("확인", "출금 금액이 보유중인 R POINT를 초과합니다.</br> 확인후 다시 시도해주세요", true, false, null, null);
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
			    $("#btn-submit").attr('disabled', true);
			},
			
			success: function(data) {
				if (data.result.code == 0 ) {
					alertOpen("확인", "R 포인트의 현금 출금 요청이 완료되었습니다.", true, false, function(){
						history.go(-1);
						//movePage('/m/mypage/rpoint/rpoint_withdrawal.do');
					}, null);
				}else{
					alertOpen("확인", data.result.msg, false, true, null, null);
				}
				isSubmitting = false;
			},
			error: function (request, status, error) {
				isSubmitting = false;
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
	var comma_separator_number_step = $.animateNumber.numberStepFactories.separator(',')
	var p1 =${model.rPayInfo.pointAmount}
	$('#holding_rpoint').animateNumber({
			number : p1,
			numberStep : comma_separator_number_step
		});
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
							<div class="listmember" style = "font-size : 12px;font-weight:300"><spring:message code="label.holding_rpoint"/></div>
							<div class="listpoint" >
								<strong><span style = "font-size: 35px;font-weight: 500;" id = "holding_rpoint"></span>
								<span style = "font-size: 35px;font-weight: 500;">P</span></strong></div>
							<div class="pointinput" >
								<div class="form-group" style = "margin: 0 10px 10px 0">
									<input type="number"  style = "font-weight:400;font-size : 14px" placeholder="<spring:message code="label.desc_withdraw"/>" id="withdrawalAmount" name="withdrawalAmount""/>			
								</div>
								<div class="form-group" style = "margin: 0 10px 10px 0">
									<select class="form-control" id="memberBankAccountNo" name="memberBankAccountNo" style = "font-weight:400;font-size : 14px"> 
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
							<ul class="pointinfo" style = "padding-left:20px;margin-top:30px">
								<li style = "list-style-type: disc;font-weight:300"><spring:message code="label.rpay_withdrawal_fee_policy" /></li>
								<li style = "list-style-type: disc;font-weight:300"><spring:message code="label.rpay_withdrawal_min_quide" arguments="${model.policy.rPayWithdrawalMinLimit}" /></li>
								<li style = "list-style-type: disc;font-weight:300"><spring:message code="label.rpay_withdrawal_max_per_week_quide" arguments="${model.policy.rPayWithdrawalMaxLimitPerWeek}" /></li>
									<li style = "list-style-type: disc;font-weight:300"><spring:message code="label.rpay_withdrawal_day" /></li>
								<li style = "list-style-type: disc;font-weight:300">출금 정책은 예고없이 변경될 수 있습니다</li>
							</ul>
						</div>
						<div class="btns2">
							<button type="button" class="btn btn-submit" onclick="submitWithdrawl();"><spring:message code="label.withdrawl_req"/></button>
							<button type="button" class="btn btn-submit-cancel" id="withdrawalCancel"><spring:message code="label.cancel"/></button>
						</div>
						<input type = "hidden" name = "rPayBalance"  id = "rPayBalance" value = "${model.rPayInfo.pointAmount}"/>
						<input type = "hidden" name = "rPayWithdrawalMinLimit"  id = "rPayWithdrawalMinLimit" value = "${model.policy.rPayWithdrawalMinLimit}"/>
						<input  type = "hidden"  name = "rpay_total_withdrawal_per_week"  id = "rpay_total_withdrawal_per_week" value = "${model.rpayTotalWithdrawalPerWeek}"/>
						<input type = "hidden" name = "rpay_withdrawable_amount"  id = "rpay_withdrawable_amount" value = "${model.policy.rPayWithdrawalMaxLimitPerWeek - model.rpayTotalWithdrawalPerWeek}"/>
					</form>	
				</div>
			</section>	
        </c:otherwise>
	</c:choose>	
</div>
</body>
<!-- body end -->
</html>