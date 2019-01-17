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
<meta name="format-detection" content="telephone=no"/><!-- 0710 edge상에서 전화번호 자동인식으로 인한 메타 추가 -->
<!-- css   -->
<!-- font -->
<link rel="stylesheet" href="/resources/css/common.css">
<!-- js -->
<script src="/resources/js/lib/jquery.min.js"></script>
<script src="/resources/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/member.js"></script>
<script type="text/javascript" src="/resources/js/lib/common.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var pageContextlocale = '${pageContext.response.locale}';
	$("#sel1").val(pageContextlocale);
	
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
</script>
<script type="text/javascript">
function confirm(f) {
	var f = document.Frm;
	var email 		= $("#email").val();
    // 이메일 체크
	if (!email|| email.length == 0) {
		alertOpen("확인", "이메일을 입력해주세요.", true, false, null, null);
		//alert("이메일을 입력해주세요.");
		return false;
	} else if (!checkEmail(email)){
		alertOpen("확인", "올바른 이메일 주소를 입력해야합니다.", true, false, null, null);
		//alert("올바른 이메일 주소를 입력해야합니다.");
		return false;
	}

	f.target = "";
	f.action = "/member/find_pw_act.do";
	f.submit();
}

function cancel(f) {
	location.href = '/main/index.do'; 
	return false;
}
</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_find">

	<!-- nav -->
	<jsp:include page="/WEB-INF/views/common/topper.jsp" />
	<!-- nav -->
		<h4>Find password</h4>
	</header> 
	<!-- content begin -->
	<ul class="submenu">
		<li><a href="./find_email.do"><spring:message code="label.findEmail" /></a></li>
		<li class="active"><a href="./find_pw.do"><spring:message code="label.findEmailPassword" /></a></li>
	</ul>
	<section>
	<h4><spring:message code="label.findEmailPassword" /></h4>
	<hr>
	<form name="Frm">
		<div class="txtarea">
			<i class="fas fa-envelope-open"></i>
			<h3><spring:message code="label.findPwDesc01" /></h3>
			<p><spring:message code="label.findPwDesc02" /></p>
		</div>
		<div class="form-group find">
			<label for="email"><spring:message code="label.mypageConfirmDesc04" /></label> <input type="email"	class="form-control" id="email" name="email">
		</div>		
		<div class="btns2">
			<button type="button" class="btn btn-submit" onclick="confirm();"><spring:message code="label.commonConfirm"/></button>
			<button type="button" class="btn btn-submit-cancel" onclick="cancel();"><spring:message code="label.commonCancel"/></button>
		</div>
	</form>
	</section>
	<!-- content end -->
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<!-- footer -->
</div>
	<!-- privacy policy modal -->
	<jsp:include page="../company/m_privacypolicy.jsp" flush="false" />
	<!-- privacy policy modal end -->
	<!-- terms of ues modal -->
	<jsp:include page="../company/m_termsofuse.jsp" flush="false" />
	<!-- terms of ues modal end -->
</body>
<!-- body end -->
</html>