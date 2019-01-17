<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<!-- css   -->
<!-- font -->
<link rel="stylesheet" href="/resources/css/m_common.css">
<!-- js -->
<script type="text/javascript" src="/resources/js/lib/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/m_member.js"></script>
<script type="text/javascript" src="/resources/js/lib/jquery.cookie.js"></script>
<script type="text/javascript" src="/resources/js/lib/m_common.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var pageContextlocale = '${pageContext.response.locale}';
	$("#sel1").val(pageContextlocale); 
});
</script>
<script type="text/javascript">
$(document).ready(function() {
	//탈퇴완료 후 모달 호출
	if($.cookie('emailViewCookie')) {
		$('#Frm2').show();
		$('#Frm').hide();
		var p = getParams();
		$("#memberEmailCheck").val((p["memberEmail"]));
	}else{
		$('#Frm2').hide();
	}
	
	var p = getParams();
	var alertView = (p["alertView"]);
	var Message  = (p["Message"]);
	var message = "";
	var title = "확인";
	if(Message =="1"){
		message = "가입하신 이메일로 발송이 완료되었습니다.";
	}else if(Message =="2"){
		message = "이메일이 존재하지 않습니다.";
	}
	if(alertView =="t"){
		var alertMessageHtml = "";
		var alertTitleHtml = "";
		document.getElementById('alertView').style.display='flex';	
		alertMessageHtml += "<p>"+message+"</p>";
		$('#alertMassage').html(alertMessageHtml);
		alertTitleHtml += "<strong><i class='fas fa-info-circle'></i>"+title+"</strong>";
		$('#alertTitle').html(alertTitleHtml);
		$('#alert_ok').show();
		$('#alert_cancel').hide();
	}
});

function confirm(f) {
	var f = document.Frm;
	var memberName 		= $("#memberName").val();
	var memberPhone 		= $("#memberPhone").val();
    // 이름 체크
	if (!memberName|| memberName.length == 0) {
		alertOpen("확인", "이름을 입력해주세요.", true, false, null, null);
		//alert("이름을 입력해주세요.");
		return false;
	}
	
    // 휴대폰 번호 체크
	if (!memberPhone|| memberPhone.length == 0) {
		alertOpen("확인", "휴대폰번호를 입력해주세요.", true, false, null, null);
		//alert("휴대폰번호를 입력해주세요.");
		return false;
	}
	if (!checkPhonePattern(memberPhone)){
		//alert("숫자만 입력해주세요.");
		alertOpen("확인", "숫자만 입력해주세요.", true, false, null, null);
		return false;
	}	
	f.target = "";
	f.action = "/m/member/find_email_act.do";
	f.submit();
}

//휴대폰 숫자 체크
function checkPhonePattern(str) { 
	var pattern1 = /[0-9]/;	// 숫자
	return pattern1.test(str) ;
}

function goMainPage() {
	location.href = '/m/main/index.do'; 
	return false;
}

</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_find">	

	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4>Find email</h4>
	</header> 
	<!-- content begin -->
	<ul class="submenu">
		<li class="active"><a href="/m/member/find_email.do"><spring:message code="label.findEmail" /></a></li>
		<li><a href="/m/member/find_pw.do"><spring:message code="label.findEmailPassword" /></a></li>
	</ul>
	<section>
	<h4><spring:message code="label.findEmail" /></h4>
	<hr>
	<form name="Frm" id="Frm" style="display:block">
		<div class="txtarea">
			<i class="fas fa-envelope-open"></i>
			<h3><spring:message code="label.findEmailDesc01" /></h3>
			<p><spring:message code="label.findEmailDesc02" /></p>
		</div>
		<div class="form-group find">
			<label for="memberName"><spring:message code="label.mypageConfirmDesc05" /></label> <input type="text" class="form-control" id="memberName" name="memberName">
		</div>	
		<div class="form-group find">
			<label for="memberPhone"><spring:message code="label.mypageConfirmDesc06" /></label> <input type="text"	class="form-control" id="memberPhone" name="memberPhone">
		</div>		
		<div class="btns2">
			<button type="button" class="btn btn-submit" onclick="confirm();"><spring:message code="label.commonConfirm"/></button>
			<button type="button" class="btn btn-submit-cancel" onclick="cancel();"><spring:message code="label.commonCancel"/></button>
		</div>
	</form>
	<form name="Frm2" id="Frm2" style="display:none">
		<div class="txtarea">
			<i class="fas fa-envelope-open"></i>
			<h3><spring:message code="label.findEmailDesc01" /></h3>
			<p><spring:message code="label.findEmailDesc02" /></p>
		</div>
		<div class="form-group find">
			<input type="text"	class="form-control" id="memberEmailCheck" name="memberEmailCheck" readonly>
		</div>	
		<button type="button" class="btn btn-submit"  onclick="goMainPage();"><spring:message code="label.joinDesc04" /></button>
	</form>
	</section>
	<!-- content end -->
</div>
</body>
<!-- body end -->
</html>