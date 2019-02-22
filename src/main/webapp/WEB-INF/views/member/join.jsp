<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="com.returnp_web.utils.SessionManager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<script type="text/javascript" src="/resources/js/lib/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/bootstrap.min.js"></script>
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
		message = "이메일 또는 비밀번호가 일치하지 않습니다.";
	}else if(Message =="2"){
		message = "이미 가입한 이메일입니다.";
	}
	
	$("#domain_list").change(function(){
		var selectValue = $(this).val();
		if (selectValue == "0") {
			$("#domain").val("");
			$("#domain").attr("readonly", false);
		}else {
			$("#domain").attr("readonly", true);
			$("#domain").val(selectValue);
		}
	});
	
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
	
	if (appInfo.access == "APP") {
		bridge.checkPermission(appInfo.permission.READ_PHONE_STATE, function(result){
			if (result.permission == appInfo.permissionResult.PERMITTEED) {
				setPhoneNumber();
			}else {
				bridge.requestPermission(appInfo.permission.READ_PHONE_STATE, function(result){
					result = JSON.parse(result);
					if (result.permission == appInfo.permissionResult.PERMITTEED) {
						setPhoneNumber();
					}else {
						/* 기기 전화번호 가져오는 것을 허용하지 않았을 때의 처리*/
					}
				});
			}
		});
	}
	var parameters = getParams();
	if (parameters['recommender'] && typeof parameters['recommender'] != "undefined" && parameters['recommender'].trim() != '') {
		$('#recommend').val(decodeURIComponent(atob(parameters['recommender'])).trim());
		$("#recommend").attr("readonly",true); 
	}
});

function setPhoneNumber(){
	bridge.getPhoneNumber(function(phone){
		phone = JSON.parse(phone);
		$("#phone").val(phone.phoneNumber);
		$("#phoneOri").val(phone.phoneNumber);
	});	
}

</script>
<script type="text/javascript">
//추천인 유효성 체크
function searchRecommend(){
	var recommend 	= $("#recommend").val().trim();
	var email 		= $("#email").val();

	// 추천인 입력값 유효성 체크
	if (!recommend|| recommend.length == 0) {
		alertOpen("확인", "추천인 이메일을 입력해주세요.", true, false, null, null);
		return false;
	} else if (!checkEmail(recommend)){
		//alert("올바른 추천인 이메일을 입력해주세요.");
		alertOpen("확인", "올바른 추천인 이메일을 입력해주세요.", true, false, null, null);
		return false;
	} 
	
	if( recommend == email ){ // 추천인과 입력한 email의 일치여부 확인
		//alert("이메일과 동일한 추천인은 입력할수 없습니다.");
		alertOpen("확인", "이메일과 동일한 추천인은 입력할수 없습니다.", true, false, null, null);
		return false;
	}
	
	$.ajax({
		method : "POST",
		url    : "/member/selectRecommend.do",
		dataType: "json",
		data   : {
			recommend		: recommend
		},

		success: function(data) {
			if (data.result.code > 0 ) {
				//alert(data.result.msg);
				alertOpen("확인", data.result.msg, true, false, null, null);
				if ( data.result.code == 1 ){
					$("#recommendEmail").val(recommend);
					$("#recommendConfirm").val("Y");
				}
				return false;
			}
		},

		error: function (request, status, error) {
			alertOpen("확인", request.responseText, true, false, null, null);
			//alert(request.responseText);
			$("#recommend").focus();
			return false;
		}
	});

}

//회원 유효성 체크
function searchMember(){
	var recommend 	= $("#recommend").val();
	var email 		= $("#email").val().trim() + "@" + $("#domain").val().trim();
	var domain  = $("#domain").val().trim();
	// 추천인 입력값 유효성 체크
	if (!email|| email.length == 0) {
		alertOpen("확인", "이메일을 입력해 주십시오.", true, false, null, null);
		//alert("이메일을 입력해주세요.");
		return false;
	} else if (!domain ||domain.length == 0){
		alertOpen("확인", "이메일의 도메인을 선택해주세요</br>직접 입력하거나 셀렉트 박스에서 선택할 수 있습니다", true, false, null, null);
		return false;
	} else if (!checkEmail(email)){
		alertOpen("확인", "올바른 이메일을 입력해주세요.", true, false, null, null);
		//alert("올바른 이메일을 입력해주세요.");
		return false;
	} 
	if( recommend == email ){ // 추천인과 입력한 email의 일치여부 확인
		//alert("이메일과 동일한 추천인은 입력할수 없습니다.");
		alertOpen("확인", "이메일과 동일한 추천인은 입력할수 없습니다.", true, false, null, null);
		return false;
	}
	$.ajax({
		method : "POST",
		url    : "/member/select_member_validity.do",
		dataType: "json",
		data   : {
			email		: email + "@" + domain
		},
		success: function(data) {
			if (data.result.code > 0) {
				alertOpen("확인", data.result.msg, true, false, null, null);
				if ( data.result.code == 1 ){
					$("#emailOri").val(email);
					$("#emailConfirm").val("Y");
					return false;
				}
			}
		},
		error: function (request, status, error) {
			alertOpen("확인", request.responseText, true, false, null, null);
			$("#email").focus();
			return false;
		}
	});
}


//휴대폰 번호 유효성 체크(중복 휴대폰 번호 사용금지)
function searchPhoneOverlap(){
	var phone 	= $("#phone").val();
	
	// 핸드폰 체크
	if (!phone || phone.length == 0 ) {
		alertOpen("확인", "핸드폰 번호를 입력해주세요.", true, false, null, null);
		//alert("핸드폰 번호를 입력해주세요.");
		return false;
	}
	if (!checkPhonePattern(phone)){
		alertOpen("확인", "숫자만 입력해주세요.", true, false, null, null);
		//alert("숫자만 입력해주세요");
		return false;
	}	
	
	$.ajax({
		method : "POST",
		url    : "/member/select_phone_overlap.do",
		dataType: "json",
		data   : {
			memberPhone		: phone
		},

		success: function(data) {
			if (data.result.code > 0) {
				//alert(data.result.msg);
				alertOpen("확인", data.result.msg, true, false, null, null);
				if ( data.result.code == 1 ){
					$("#phoneOri").val(phone);
					$("#phoneConfirm").val("Y");
					return false;
				}else {
					$("#phoneOri").val("");
					$("#phoneConfirm").val("N");
				}
			}
		},

		error: function (request, status, error) {
			//alert(request.responseText);
			alertOpen("확인", request.responseText, true, false, null, null);
			$("#phone").focus();
			return false;
		}
	});

}

function summitBtnDisabled(isDisabled){
	$('#memberJoinBtn').prop("disabled", isDisabled);
}

function memberJoinSubmit() {
	event.preventDefault();
	summitBtnDisabled(true)
	var email 				= $("#email").val().trim() + "@" + $("#domain").val().trim();
	var pwd 				= $("#pwd").val();
	var pwdconfirm 			= $("#pwdconfirm").val();
	var name 				= $("#name").val();
	var recommend 			= $("#recommend").val();
	var recommendconfirm 	= $("#recommendConfirm").val();
	var recommendemail	 	= $("#recommendEmail").val();
	var emailOri 			= $("#emailOri").val();
	var emailConfirm	 	= $("#emailConfirm").val();
	var phone 				= $("#phone").val();
	var phoneOri 			= $("#phoneOri").val();
	var phoneConfirm	 	= $("#phoneConfirm").val();
	
	var myterms		= ($(":checkbox[name='myterms']").is(":checked")==true) ? 'Y' : 'N';
	var myprivacy	= ($(":checkbox[name='myprivacy']").is(":checked")==true) ? 'Y' : 'N';
	var myspam		= ($(":checkbox[name='myspam']").is(":checked")==true) ? 'Y' : 'N';
	
	// 이름 체크 
	if (!name || name.length == 0) {
		alertOpen("확인", "이름를 입력해주세요.", true, false, null, null);
		summitBtnDisabled(false);
		return false;
	}
	
    // 이메일 체크
	if (!email|| email.length == 0) {
		summitBtnDisabled(false);
		alertOpen("확인", "이메일을 입력해주세요.", true, false, null, null);
		return false;
	} else if (!checkEmail(email)){
		summitBtnDisabled(false);
		alertOpen("확인", "올바른 이메일 주소를 입력해야합니다.", true, false, null, null);
		return false;
	}

	if ( !(!recommend|| recommend.length == 0) && !checkEmail(recommend) ) {
		summitBtnDisabled(false);
		alertOpen("확인", "올바른 추천인 이메일을 입력해주세요.", true, false, null, null);
		return false;
	}

	//pw체크
	if(pwd==""){
		summitBtnDisabled(false);
		alertOpen("확인", "비밀번호를 입력하세요.", true, false, null, null);
		return false;
	}else if(checkSpace(pwd)){
		summitBtnDisabled(false);
		alertOpen("확인", "비밀번호에 공백을 사용 할 수 없습니다.", true, false, null, null);
		return false;
	}else if(!checkPasswordPattern(pwd)){
		summitBtnDisabled(false);
		alertOpen("확인", "비밀번호는 8~12자 이내 영문/숫자를 조합해 주세요.", true, false, null, null);
		return false;
	}else if(pwd!=pwdconfirm){
		summitBtnDisabled(false);
		alertOpen("확인", "비밀번호가 일치하지 않습니다.", true, false, null, null);
		return false;
	}else if(pwd.indexOf("&") > -1){
		summitBtnDisabled(false);
		alertOpen("확인", "&문자를 사용 할 수 없습니다.", true, false, null, null);
		return false;
	}
      
	// 핸드폰 체크
	if (!phone || phone.length == 0) {
		summitBtnDisabled(false);
		alertOpen("확인", "핸드폰 번호를 입력해 주세요.", true, false, null, null);
		return false;
	} else if (!checkPhonePattern(phone)){
		summitBtnDisabled(false);
		alertOpen("확인", "숫자만 입력해주세요.", true, false, null, null);
		return false;
	}		
	
	// 추천인 체크
	if( (recommendemail != recommend) ){ // 추천인 인증받은 email과 입력한 추천인 email의 일치여부 확인
		summitBtnDisabled(false);
		alertOpen("확인", "추천인 확인이 필요합니다</br>추천인 확인 버튼을 눌러주세요", true, false, null, null);
		return false;
	} 
	if( recommendemail == email ){ // 추천인 email과 회원의 email의 일치여부 확인
		summitBtnDisabled(false);
		alertOpen("확인", "이메일과 동일한 추천인은 입력할수 없습니다.", true, false, null, null);
		return false;
	}
	if( (emailOri != email) ){ // 인증받은 email과 입력한 email의 일치여부 확인
		summitBtnDisabled(false);
		alertOpen("확인", "이메일 중복 가입 확인이 필요합니다.", true, false, null, null);
		return false;
	}
	if( (phoneOri != phone) || (phoneConfirm != 'Y')){ // 인증받은 phone와 입력한 phone의 일치여부 확인
		summitBtnDisabled(false);
		alertOpen("확인", "휴대폰 중복가입 확인이 필요합니다", true, false, null, null);
		return false;
	}
	//필수 체크(이용약관, 개인정보)
	if ( myterms == 'N' ) {
		summitBtnDisabled(false);
		alertOpen("확인", "이용 약관을 선택해 주세요.", true, false, null, null);
		return false;
	}
	if ( myprivacy == 'N' ) {
		summitBtnDisabled(false);
		alertOpen("확인", "개인정보 수집 및 이용을 선택해 주세요.", true, false, null, null);
		return false;
	}
	var f = document.Frm;
	$("#email").val(email)
	f.target = "";
	f.action = "/member/join_act.do";
	f.submit(); 
}	


$(document).ready(function(){
	// 추천인 기본값 초기화
	$("#recommendEmail").val($("#recommend").val());
	$("#recommendConfirm").val("N");
	
	// 이메일 기본값 초기화
	$("#emailOri").val($("#email").val());
	$("#emailConfirm").val("N");
	
	// 휴대폰 기본값 초기화
	$("#phoneOri").val($("#phone").val());
	$("#phoneConfirm").val("N");
	
	// 전체 선택
	$("#allconfirm").on("click", function(){
		if($("#allconfirm").is(":checked")==true){
			$(":checkbox[name='myterms']").prop("checked", true);
			$(":checkbox[name='myprivacy']").prop("checked", true);
			$(":checkbox[name='myspam']").prop("checked", true);
		}else{
			$(":checkbox[name='myterms']").prop("checked", false);
			$(":checkbox[name='myprivacy']").prop("checked", false);
			$(":checkbox[name='myspam']").prop("checked", false);
		}
	});

	//휴대폰 입력폼에 숫자가 아니면 삭제		
	$("#phone").bind("keyup", function(event) {
	    var regNumber = /^[0-9]*$/;
	    var temp = $("#phone").val();
	    if(!regNumber.test(temp))
	    {
	        $("#phone").val(temp.replace(/[^0-9]/g,""));
	    }
	});

});
</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_join">	

	<!-- nav -->
	<jsp:include page="/WEB-INF/views/common/topper.jsp" />
	<!-- nav -->
		<h4>Member Join</h4>
	</header> 
	<!-- content begin -->
	<section>	
	<h4><spring:message code="label.join" /> <span><small>*</small> <spring:message code="label.joinDesc02" /></span></h4>
	<hr>
	<form name="Frm" method = "post">
		<div class="form-group recommend ">
			<%-- <label for="email"><small>*</small> <spring:message code="label.joinDesc03" /></label>  --%>
			<input type="email"   class="form-control" id="email" name="email" style = "width:23%;"  placeholder="*<spring:message code="label.joinDesc03" />"  >
			<span class="form-control" style = "width:3%;font-size : 20px;border:none" >@</span>
			<input  class="form-control" id="domain" placeholder="*<spring:message code="label.domain" />"  name="domain" style = "width:23%;margin-left: 15px">
			<select class="form-control" id="domain_list" name="domain_list" style = "width:20%;margin-left: 15px"> 
				<option value="0" ><spring:message code="label.input" /></option>
				<option value="naver.com" >naver.com</option>
				<option value="hanmail.net" >hanmail.net</option>
				<option value="gmail.com" >gmail.com</option>
				<option value="nate.com" >nate.com</option>
				<option value="dreamwiz.com" >dreamwiz.com</option>
				<option value="yahoo.co.kr" >yahoo.co.kr</option>
				<option value="hanafos.com" >hanafos.com</option>
				<option value="hotmail.com" >hotmail.com</option>
				<option value="paran.com" >paran.com</option>
			</select>
			<button type="button" class="btn btn-basic" onclick="searchMember();" style = "width:23%;margin-left: 17px"><spring:message code="label.double_check" /></button>
			<input type="hidden" name="emailOri" id="emailOri" style="display:none;">
			<input type="hidden" name="emailConfirm" id="emailConfirm" value="N" style="display:none;">
		</div>
		<div class="form-group">
			<%-- <label for="pwd"><small>*</small> <spring:message code="label.joinDesc05" /></label> --%> 
			<input type="password" class="form-control" name="pwd" id="pwd" minlength="8" maxlength="12" placeholder="*<spring:message code="label.joinDesc05" />" >
		</div>
		<div class="form-group">
			<%-- <label for="pwdconfirm"><small>*</small> <spring:message code="label.joinDesc06" /></label>  --%>
			<input type="password" class="form-control" name="pwdconfirm" id="pwdconfirm" minlength="8" maxlength="12" placeholder="*<spring:message code="label.joinDesc06" />">
		</div>
		<div class="form-group">
			<%-- <label for="name"><small>*</small> <spring:message code="label.joinDesc07" /></label>  --%>
			<input type="text"	class="form-control" name="name" id="name" maxlength="50" placeholder="*<spring:message code="label.joinDesc07" />" >
		</div>
		<div class="form-group">
			<select class="form-control" id="country" name="country"> 
				<option value="" ><spring:message code="label.selectCountry" /></option>
				<c:forEach var = "country" items = "${model.countries}">
				<option value="${country.iso}" >${country.enName} - ${country.krName}</option>
				</c:forEach>
			</select>
		</div>
		<div class="form-group recommend">
			<%-- <label for="phone"><small>*</small> <spring:message code="label.joinDesc09" /></label> --%>
			<input type="tel"	class="form-control" name="phone" id="phone" maxlength="12" placeholder="*<spring:message code="label.joinDesc09" />" >
			<button type="button" class="btn btn-basic" onclick="searchPhoneOverlap();"><spring:message code="label.joinDesc04" /></button>
			<input type="hidden" name="phoneOri" id="phoneOri" style="display:none;">
			<input type="hidden" name="phoneConfirm" id="phoneConfirm" value="N" style="display:none;">
		</div>
		<div class="form-group recommend">
			<%-- <label for="recommend"><spring:message code="label.joinDesc08"/></label> --%>
			 <input type="text" class="form-control" name="recommend" id="recommend" placeholder="<spring:message code="label.joinDesc08" />">
			<button type="button" class="btn btn-basic" onclick="searchRecommend();"><spring:message code="label.joinDesc04" /></button>
			 <input type="hidden" name="recommendEmail" id="recommendEmail" style="display:none;">
			 <input type="hidden" name="recommendConfirm" id="recommendConfirm" value="N" style="display:none;">
		</div>		
		<button id = "memberJoinBtn" type="button" class="btn btn-submit" onclick="memberJoinSubmit();" onsubmit="return false;"><spring:message code="label.joinDesc15" /></button>
		<ul class="checkbox">
			<li><label><input type="checkbox" id="allconfirm"> <spring:message code="label.joinDesc10" /></label></li>
			<li><label><input type="checkbox" class="chk" name="myterms"> <spring:message code="label.joinDesc11" /></label><span><a  data-toggle="modal" data-target="#myterms" ><spring:message code="label.joinDesc14" /></a></span></li>
			<li><label><input type="checkbox" class="chk" name="myprivacy"> <spring:message code="label.joinDesc12" /></label><span><a  data-toggle="modal" data-target="#myprivacy"><spring:message code="label.joinDesc14" /></a></span></li>
			<li><label><input type="checkbox" class="chk" name="myspam"> <spring:message code="label.joinDesc13" /></label></li>
		</ul>
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