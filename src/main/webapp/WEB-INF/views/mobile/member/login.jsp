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
<script type="text/javascript" src="/resources/js/lib/jquery.cookie.js"></script>
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
		message = "이메일 또는 비밀번호가 일치하지 않습니다.";
	}else if(Message =="2"){
		message = "이메일을 입력해 주세요.";
	}else if(Message =="3"){
		message = "비밀번호를 입력해 주세요.";
	}else if(Message =="4"){
		message = "사용정지 고객입니다.";
	}else if(Message =="5"){
		message = "탈퇴고객입니다.";
	}else if(Message =="6"){
		message = "비밀번호가 일치하지 않습니다.";
	}else if(Message =="7"){
		message = "인증시간이 경과되었습니다. 재발급해주세요.";
	}else if(Message =="8"){
		message = "로그인 5회이상 실패하였습니다.";
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
function validSubmit(){
	var email 		= $("#email").val();
	var pwd 		= $("#pwd").val();
	var authPassword 		= $("#authPassword").val(); // 인증번호
	var authPasswordConfirm	= $("#authPasswordConfirm").val(); // 인증번호 확인
	event.preventDefault();
    // 이메일 체크
	if(!email|| email.length == 0) {
		alertOpen("확인", "이메일을 입력해주세요.", true, false, null, null);
		//alert("이메일을 입력해주세요.");
		return false;
	}else if(!checkEmail(email)){
		alertOpen("확인", "올바른 이메일 주소를 입력해야합니다.", true, false, null, null);
		//alert("올바른 이메일 주소를 입력해야합니다.");
		return false;
	}
	
	if(pwd==""){
		//alert("비밀번호를 입력하세요.");
		alertOpen("확인", "비밀번호를 입력하세요.", true, false, null, null);
		return false;
	}
	
	// 인증번호가 표시되어있으면
	if(authPassword !=""){
		if(authPassword != authPasswordConfirm ){
			alertOpen("확인", "인증번호가 일치하지 않습니다.", true, false, null, null);
			//alert("인증번호가 일치하지 않습니다.");
			return false;
		}
	}
	
	var f = document.Frm;
	f.target = "";
	f.action = "/m/member/login_act.do";
	f.submit();
	
	return false;
}

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

$(document).ready(function(){
 	/* 이메일 인증이 안된경우 모달 호출
 	if(location.href.match('pop=confirm')){
 		$("#myemailconfirm").modal({backdrop: 'static', keyboard: false});
 	}*/
	
 	//이메일 인증이 안된경우 모달 호출
 	/* if(location.href.match('pop=confirm')){
 		location.href = '/m/member/m_emailconfirm.do';
 	}	 */	
		
	//쿠키 로딩
	if($.cookie('cookieSaveId')) {
		$(":checkbox[name='isSave']").attr('checked', true);
		$('#email').val($.cookie('cookieSaveId'));
	}
	
 	/*이메일 인증 모달창 닫기 버튼
 	$("#emailConfirmClose").on("click", function(){
 		location.replace('./login.do');
 	});
	*/
	
	//인증번호 재전송
	$("#authRequest").on("click", function(){
		var email = $("#email").val();
		$.ajax({
			method : "POST",
			url    : "/m/member/authNumberRequest.do",
			dataType: "json",
			data   : {
				memberEmail		: email
			},
			success:function(data){
				if (data.result.code >= 0){
					//alert(data.result.msg);
					alertOpen("확인", data.result.msg, true, false, null, null);
					if (data.result.code == 1){
						$("#authPassword").val(data.result.authNumber);
					} 
					return false;
				}
			},
			error: function(request, status, error){
				alert(request.responseText);
				return false;
			}
		});
	});
	
	//5회이상 실패시 인증이메일 발송 후 로그인 페이지에 인증번호 폼 표시
	if (location.href.match('form=auth')){
		var authUrl = location.href.split("&");
		if(authUrl[1]){
			var authId = authUrl[1] ;
			$.ajax({
				method : "POST",
				url    : "/m/member/selectAuthMember.do",
				dataType: "json",
				data   : {
					memberEmail		: authId
				},
				success: function(data) {
					if(data.result.code >= 0){
						if(data.result.code == 1){
							$("#authPassword").val(data.result.authNumber);
						} 
						return false;
					}
				},
				error: function (request, status, error) {
					//console.info("request =======>", request);
					alertOpen("확인", request.responseText, true, false, null, null);
					//alert(request.responseText);
					return false;
				}
			});
		}
		$(".form-login-auth").show(); // 인증화면 출력
	}
});

</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_login">	

	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4><spring:message code="label.memberLogin" /></h4>
	</header> 
	<!-- content begin -->
	<section>	
	<h4><spring:message code="label.memberLogin" /></h4>
	<hr>
	<form name="Frm">	
		<div class="txtarea">
			<i class="fas fa-user-circle"></i>			
			<h3><spring:message code="label.memberLogin" /></h3>
		</div>			
<%-- 		<div class="form-group">
			<label for="email"><spring:message code="label.joinDesc03" /></label> <input type="email"	class="form-control" id="email" name="email">
		</div>
		<div class="form-group">
			<label for="pwd"><spring:message code="label.joinDesc05" /></label> <input type="password" class="form-control" id="pwd" name="pwd">
		</div> --%>
		<div class="form-group">
			<input style = "text-align:left" type="email"	class="form-control" id="email" name="email" placeholder="<spring:message code="label.joinDesc03" />">
		</div>
		<div class="form-group">
			<input  style = "text-align:left" type="password" class="form-control" id="pwd" name="pwd" placeholder="<spring:message code="label.joinDesc05" />">
		</div>		
		<div class="form-login-auth" style="display:none;">
			<!-- 로그인 5회 실패시 출력되는 화면입니다.--> 
			<p class="forminfo"><spring:message code="label.loginDesc01" /></p>
			<div class="form-group chptcha_img">
				<!-- <img src="/resources/images/index_img01.jpg" id="authPassword" name="authPassword" /> -->
				<input type="text" class="form-control" style="width:70%;height:60px;border:1px solid #ddd;float:left;text-align:right;" id="authPassword" name="authPassword" readonly>
				<div><button type="button" class="btn btn-basic" id="authRequest"><spring:message code="label.loginDesc02" /></button></div>
			</div>
			<div class="form-group">
				<label for="chptcha_area"><small>*</small> <spring:message code="label.loginDesc03" /></label> <input type="password" class="form-control" id="authPasswordConfirm" name="authPasswordConfirm">
			</div>	
		</div>
		 <!-- -->	
		<button type="submit" class="btn btn-submit" onclick="validSubmit();" onsubmit="return false"><spring:message code="login.form.submit" /></button>
		<ul class="checkbox">
			<li><label><input type="checkbox" name="isSave"> <spring:message code="label.loginDesc04" /></label></li>
			<li><a href="/m/member/join.do"><spring:message code="label.loginDesc05" /></a></li>
			<li><a href="/m/member/find_email.do"><spring:message code="label.loginDesc06" /></a></li>
			<li><a onclick="startQRScan()"><spring:message code="label.recognize_the_promoter_qr" /></a></li>
		</ul>
		
	</form>
	</section>
	
	<!-- content end -->
</div>
</body>
<!-- body end -->
</html>