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
<meta http-equiv="X-UA-Compatible" content="IE=edge"><!-- 0710 ie가 edge로 맞춰지는 메타 추가 -->
<meta name="format-detection" content="telephone=no"/><!-- 0710 edge상에서 전화번호 자동인식으로 인한 메타 추가 -->
<!-- css   -->
<!-- font -->
<link rel="stylesheet" href="/resources/css/m_common.css">
<!-- js -->
<script type="text/javascript" src="/resources/js/lib/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/m_member.js"></script>
<script type="text/javascript" src="/resources/js/lib/m_common.js"></script>
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
		message = "비밀번호가 일치하지 않습니다.";
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
function validSubmit(f) {
	var email 		= $("#email").val();
	var pwd 		= $("#pwd").val();
	event.preventDefault();
	if(pwd==""){
		//alert("비밀번호를 입력하세요.");
		alertOpen("확인", "비밀번호를 입력하세요.", true, false, null, null);
		return false;
	}else if(checkSpace(pwd)){
		//alert("비밀번호에 공백을 사용 할 수 없습니다.");
		alertOpen("확인", "비밀번호에 공백을 사용 할 수 없습니다.", true, false, null, null);
		return false;
	}else if(!checkPasswordPattern(pwd)){
		//alert("비밀번호는 8~12자 이내 영문/숫자(공백 제외)를 조합해 주세요.");
		alertOpen("확인", "비밀번호는 8~12자 이내 영문/숫자(공백 제외)를 조합해 주세요.", true, false, null, null);
		return false;
	}else if(pwd.indexOf("&") > -1){
		alertOpen("확인", "&문자를 사용 할 수 없습니다.", true, false, null, null);
		//alert("&문자를 사용 할 수 없습니다.");
		return false;
	}
	var f = document.Frm;
	f.target = "";
	f.action = "/m/mypage/mypage_myinfo_check.do";
	f.submit();
}
</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_mypage">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4>Mypage</h4>
	</header> 
	<!-- content begin -->
	<section>
		<h4><spring:message code="label.mypageConfirmDesc01" /></h4>
		<hr>
		<form name="Frm">
			<div class="txtarea">
				<i class="fas fa-address-card"></i>
				<h3><spring:message code="label.mypageConfirmDesc02" /></h3>
				<p><spring:message code="label.mypageConfirmDesc03" /></p>
			</div>
			<div class="form-group">
				<label for="email"><spring:message code="label.mypageConfirmDesc04" /></label> <input type="email"	class="form-control" id="email" value="${model.mypageMyinfo.memberEmail}" disabled>
			</div>			
			<div class="form-group">
				<label for="pwd"><spring:message code="label.joinDesc05" /></label> <input type="password" class="form-control" id="pwd" name="pwd">
			</div>		
			<button type="button" class="btn btn-submit"  onclick="validSubmit();"><spring:message code="label.joinDesc04" /></button>
		</form>
	</section>
	<!-- content end -->
</div>
</body>
<!-- body end -->
</html>