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
<script src="/resources/js/lib/jquery.min.js"></script>
<script src="/resources/js/lib/bootstrap.min.js"></script>
<script src="/resources/js/lib/m_member.js"></script>
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
function outSubmit() {
	event.preventDefault();
	var pwd 		= $("#pwd").val();
	//pw체크
	if(pwd==""){
		//alert("비밀번호를 입력하세요.");
		alertOpen("확인", "비밀번호를 입력하세요.", true, false, null, null);
		return false;
	}else if(checkSpace(pwd)){
		//alert("비밀번호에 공백을 사용 할 수 없습니다.");
		alertOpen("확인", "비밀번호에 공백을 사용 할 수 없습니다.", true, false, null, null);
		return false;
	}else if(!checkPasswordPattern(pwd)){
		alertOpen("확인", "비밀번호는 8~12자 이내 영문/숫자를 조합해 주세요.", true, false, null, null);
		//alert("비밀번호는 8~12자 이내 영문/숫자를 조합해 주세요.");
		return false;
	}else if(pwd.indexOf("&") > -1){
		alertOpen("확인", "&문자를 사용 할 수 없습니다.", true, false, null, null);
		//alert("&문자를 사용 할 수 없습니다.");
		return false;
	}
	var f = document.Frm;
	f.target = "";
	f.action = "/m/member/member_out_act.do";
	f.submit();
}	

$(document).ready(function(){
 	//탈퇴완료 후 모달 호출
 	if(location.href.match('form=out')){
 		location.href = '/m/mypage/m_memberout.do';
 	} 	
	
	/*탈퇴완료 후 모달 호출
 	if(location.href.match('form=out')){
 		$("#mymemberout").modal({backdrop: 'static', keyboard: false});
 	}
	
 	회원탈퇴 모달창 닫기 버튼
 	$("#memberOutClose").on("click", function(){
 		location.replace('/main/index.do');
 	});
 	
 	회원탈퇴 회원가입메뉴 이동버튼
 	$("#memberJoin").on("click", function(){
 		location.replace('/member/join.do');
 	});
 	*/
})
</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_mypage_out">	

	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4>Mypage</h4>
	</header> 
	<!-- content begin -->
	<ul class="submenu pc"><!-- 0820 pc class 추가 -->
	<li><a href="./mypage_myinfo.do"><spring:message code="label.myPage" /></a></li><%-- <li><a href="../mypage/mypage_uselist.do"><spring:message code="label.mypageDesc01" /></a></li> --%><li class="active"><a href="./mypage_out.do"><spring:message code="label.mypageDesc02" /></a></li></ul>
	<section>
	<h4><spring:message code="label.mypageDesc02" /></h4>
	<hr>
	<form name="Frm">
		<div class="txtarea">
			<i class="fas fa-user-minus"></i>
			<h3><spring:message code="label.mypageOutDesc01" /></h3>
			<p><spring:message code="label.mypageOutDesc02" /><br /><spring:message code="label.mypageOutDesc03" /><br />
			<span class="info_red"><spring:message code="label.mypageOutDesc04" /></span>
			</p>
		</div>
		<div class="form-group">
			<label for="email"><spring:message code="label.joinDesc03" /></label> <input type="email"	class="form-control" id="email" name="email" value="${model.mypageMyinfo.memberEmail}" disabled>
			<input type="hidden" id="memberEmail" name="memberEmail" value="${model.mypageMyinfo.memberEmail}">
		</div>			
		<div class="form-group">
			<label for="pwd"><spring:message code="label.joinDesc05" /></label> <input type="password"	class="form-control" id="pwd" name="pwd" minlength="8" maxlength="12">
		</div>		
		<button type="submit" class="btn btn-submit" onclick="outSubmit();"><spring:message code="label.mypageOutDesc05" /></button>
	</form>
	</section>
	<!-- content end -->
</div>	
</body>
<!-- body end -->
</html>