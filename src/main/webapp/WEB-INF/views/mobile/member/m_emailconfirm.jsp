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
});

function emailConfirmSend(){
	var p = getParams();
	var memberEmailReturnValue  = (p["memberEmail"]);
	var memberNo = (p["memberNo"]);
	$.ajax({
		method : "POST",
		url    : "/m/member/member_email_confirm_act.do",
		dataType: "json",
		data   : {
			memberEmail		: memberEmailReturnValue,
			memberNo		: memberNo
		},
		success: function(data) {
			if (data.result.code == 1) {
				top.location.replace("/m/member/login.do");
			}
		},
		error: function (request, status, error) {
			return false;
		}
	});
}
</script>
</head>
<!-- header end -->
<!-- body begin -->
<body>	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4>이메일 인증</h4>
	</header> 	
	<section>
		<div class="m_txtarea">
     	  <i class="fas fa-envelope-open"></i>
          <h3 class="modal-title"><spring:message code="label.memailConfirmFail"/></h3>
          <p><spring:message code="label.mpleaseVerifyYourEmail"/><br />
          <spring:message code="label.mloginAndPointViewsAreAvailable"/></p>
        </div>        
   		<button type="button" class="btn btn-submit" id="emailConfirmSend" onclick="emailConfirmSend();"><spring:message code="label.mresendEmailVerification"/></button>
	</section>	
</div>
</body>
<!-- body end -->
</html>