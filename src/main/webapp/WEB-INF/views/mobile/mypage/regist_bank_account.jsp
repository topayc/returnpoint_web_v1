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

function registBankAccount(){
	if ($("#bankAccount").val().trim().length < 1) {
		alertOpen("알림", "은행 계좌번호를 입력해주세요", false, true, null, null);
		return;
	}
	
	if ($("#accountOwner").val().trim().length < 1) {
		alertOpen("알림", "예금주를 입력해주세요", false, true, null, null);
		return;
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
		  var action = $("#action").val().trim();
		  var resultText = action == "create"? "출금 계좌 등록 완료 완료" : "출금 계좌 수정 완료";
			$.ajax({
				method : "get",
				url    : "/m/mypage/m_regist_mybank_account.do?action="+action,
				dataType: "json",
				data   :  $("#regist_member_bank_account_form").serializeObject(),
				
				beforeSend : function(xhr){
				     if (!userAuthToken) {
						 xhr.setRequestHeader("AJAX","true");
				     }else {
				    	 xhr.setRequestHeader("user_auth_token",userAuthToken);
				     }
				},
				
				success: function(data) {
					console.log(data);
					if (data.result.code == 0 ) {
						alertOpen("확인", resultText, true, false, function(){history.go(-1)}, null);
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
var action = "${model.action}";
$(document).ready(function(){

	$('#cancelGoback').click(function(){
		history.go(-1);
	});
	
	if (action == "create"){
		$("#accountOwner").attr("readonly", true);
		$("#accountOwner").prop("readonly", true);
	}

	if (action == "modify"){
		$("#bankName").val("${model.memberBankAccount.bankName}");
	}
});

</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_terms">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4>출금 계좌 등록</h4>
	</header> 	
		<section>
			<div class="m_point_transfer">
				<form name="Frm2" id = "regist_member_bank_account_form">
					<input type="hidden"	id="action"  name = "action" maxlength="50" value = "${model.action}">
						<input type="hidden"	id="memberBankAccountNo"  name = "memberBankAccountNo" maxlength="50" value = "${model.memberBankAccount.memberBankAccountNo}">
					<div class="form-group" style = "margin-top:5px">
					<!-- 	<input type="text"	class="form-control" name="bankName" id="bankName" maxlength="50"> -->
						<select class="form-control" id="bankName" name="bankName"> 
						
					<!-- 	<option value="003" >기업은행</option>
						<option value="004" >국민은행</option>
						<option value="005" >외환은행</option>
						<option value="007" >수협</option>
						<option value="011" >농협</option>
						<option value="020" >우리은행</option>
						<option value="023" >제일은행</option>
						<option value="027" >씨티은행</option>
						<option value="031" >대구은행</option>
						<option value="032" >부산은행</option>
						<option value="034" >광주은행</option>
						<option value="035" >제주은행</option>
						<option value="037" >전북은행</option>
						<option value="039" >경남은행</option>
						<option value="045" >새마을금고</option>
						<option value="048" >신협</option>
						<option value="071" >우체국</option>
						<option value="081" >하나은행</option>
						<option value="088" >신한은행</option> -->
						
						<option value="기업은행"  >기업은행</option>
						<option value="국민은행" >국민은행</option>
						<option value="외환은행" >외환은행</option>
						<option value="수협" >수협</option>
						<option value="농협" >농협</option>
						<option value="우리은행" >우리은행</option>
						<option value="제일은행" >제일은행</option>
						<option value="씨티은행" >씨티은행</option>
						<option value="대구은행" >대구은행</option>
						<option value="부산은행" >부산은행</option>
						<option value="광주은행" >광주은행</option>
						<option value="제주은행" >제주은행</option>
						<option value="전북은행" >전북은행</option>
						<option value="경남은행" >경남은행</option>
						<option value="새마을금고" >새마을금고</option>
						<option value="신협" >신협</option>
						<option value="우체국" >우체국</option>
						<option value="하나은행" >하나은행</option>
						<option value="신한은행" >신한은행</option>
					</select>
					</div>
					
					<div class="form-group">
						<label for="bankAccount"><small>*</small> <spring:message code="label.bank_account" /></label> 
						<input type="text"	class="form-control" name="bankAccount" id="bankAccount" maxlength="50" value = "${model.memberBankAccount.bankAccount}">
					</div>
					
					<div class="form-group">
						<label for="accountOwner"><small>*</small> <spring:message code="label.bank_owner" /></label> 
						<input type="text"	class="form-control" name="accountOwner" id="accountOwner" maxlength="50" value = "${model.memberBankAccount.accountOwner}">
					</div>
					<div class="btns2">
						<button type="button" class="btn btn-submit" onclick="registBankAccount();">출금 계좌 등록</button>
						<button type="button" class="btn btn-submit-cancel" id="cancelGoback"><spring:message code="label.cancel"/></button>
					</div>					
				</form>	
			</div>
			</section>	
</div>
</body>
<!-- body end -->
</html>