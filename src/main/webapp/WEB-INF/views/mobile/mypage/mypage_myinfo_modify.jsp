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
	if (isApp()) {
		/*앱인 경우 전화번호 입력박스 입력 금지*/
		$("#phone").attr('readonly', true); 
		bridge.checkPermission(appInfo.permission.READ_PHONE_STATE, function(result){
			result = JSON.parse(result);
			if (result.result == '100'){
				if (result.permissionState == appInfo.permissionResult.PERMITTEED) {
					setPhoneNumber();
				}else {
					bridge.requestPermission(appInfo.permission.READ_PHONE_STATE, function(result){
						result = JSON.parse(result);
						if (result.result == '100'){
							if (result.permissionState == appInfo.permissionResult.PERMITTEED) {
								setPhoneNumber();
							}else {
								alertOpen(
									"알림", 
									"정상적인 서비스 제공을 위해서는 </br>기기 전화번호 가져오기 권한을 </br>활성화 해주셔야 합니다.", 
									true, 
									false, 
									function(){}, 
									null);
							}
						}else {
							alertOpen("알림", "앱 오류 발생", true, false, null, null);
						}
					});
				}
			}else {
				alertOpen("알림", "앱 오류 발생", true, false, null, null);
			}
		});
	}
});

function setPhoneNumber(){
	bridge.getPhoneNumber(function(data){
		data = JSON.parse(data);
		if (data.result == "100"){
			$("#phone").val(data.phoneNumberCountry);
			$("#phoneOri").val(data.phoneNumberCountry);
		}else {
			alertOpen("알림", "앱 오류 발생", true, false, null, null);
		}
	});	
}
</script>
<script type="text/javascript">
//추천인 유효성 체크
function searchRecommend(){
	var recommend 	= $("#recommend").val();
	var email 		= $("#email").val();
	// 추천인 입력값 유효성 체크
	if (!recommend|| recommend.length == 0) {
		alertOpen("확인", "추천인 이메일을 입력해주세요.", true, false, null, null);
		//alert("추천인 이메일을 입력해주세요.");
		return false;
	} else if (!checkEmail(recommend)){
		alertOpen("확인", "올바른 추천인 이메일을 입력해주세요.", true, false, null, null);
		//alert("올바른 추천인 이메일을 입력해주세요.");
		return false;
	} 
	if(recommend == email){ // 추천인과 입력한 email의 일치여부 확인
		//alert("이메일과 동일한 추천인은 입력할수 없습니다.");
		alertOpen("확인", "이메일과 동일한 추천인은 입력할수 없습니다.", true, false, null, null);
		return false;
	}	
	$.ajax({
		method : "POST",
		url    : "/m/member/selectRecommend.do",
		dataType: "json",
		data   : {
			recommend		: recommend
		},
		success: function(data) {
			if (data.result.code > 0) {
				//alert(data.result.msg);
				alertOpen("확인", data.result.msg, true, false, null, null);
				if (data.result.code == 1){
					$("#recommendEmail").val(recommend);
					$("#recommendConfirm").val("Y");
				} 
				return false;
			}
		},
		error: function (request, status, error) {
			//alert(request.responseText);
			alertOpen("확인", request.responseText, true, false, null, null);
			$("#recommend").focus();
			return false;
		}
	});
}

function memberUpdateSubmit() {
	event.preventDefault();
	
	var phone 				= $("#phone").val();
	var phoneOri 			= $("#phoneOri").val();
	var phoneOriM 			= $("#phoneOriM").val();
	var phoneConfirm	 	= $("#phoneConfirm").val();
	
	var email 		= $("#email").val();
	var pwd 		= $("#pwd").val();
	var pwdconfirm 	= $("#pwdconfirm").val();
	//var name 		= $("#name").val();
	var recommend 	= $("#recommend").val();
	var recommendconfirm = $("#recommendConfirm").val();
	var recommendemail	 = $("#recommendEmail").val();
	//var phone 		= $("#phone").val();
	if ( !(!recommend|| recommend.length == 0) && !checkEmail(recommend) ) {
		//alert("올바른 추천인 이메일을 입력해주세요.");
		alertOpen("확인", "올바른 추천인 이메일을 입력해주세요.", true, false, null, null);
		return false;
	}

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
		//alert("비밀번호는 8~12자 이내 영문/숫자를 조합해 주세요.");
		alertOpen("확인", "비밀번호는 8~12자 이내 영문/숫자를 조합해 주세요.", true, false, null, null);
		return false;
	}else if(pwd!=pwdconfirm){
		alertOpen("확인", "비밀번호가 일치하지 않습니다.", true, false, null, null);
		//alert("비밀번호가 일치하지 않습니다.");
		return false;
	}else if(pwd.indexOf("&") > -1){
		alertOpen("확인", "&문자를 사용 할 수 없습니다.", true, false, null, null);
		//alert("&문자를 사용 할 수 없습니다.");
		return false;
	}
	
	// 추천인 체크
	if( (recommendemail != recommend) ){ // 추천인 인증받은 email과 입력한 추천인 email의 일치여부 확인
		  //&& recommendconfirm != "Y"
		//alert("추천인 인증을 해주세요.");
		alertOpen("확인", "추천인 인증을 해주세요.", true, false, null, null);	
		return false;
	} 
	if( recommendemail == email ){ // 추천인 인증받은 email과 입력한 email의 일치여부 확인
		alertOpen("확인", "이메일과 동일한 추천인은 입력할수 없습니다.", true, false, null, null);
		//alert("이메일과 동일한 추천인은 입력할수 없습니다.");
		return false;
	}

	if( (phoneOriM != phone) ){ // 인증받은 phone와 입력한 phone의 일치여부 확인
		//alert("휴대폰 중복가입을 해주세요.");
		alertOpen("확인", "휴대폰 중복 검사를 해주세요.", true, false, null, null);
		return false;
	}
	
	var f = document.Frm;
	f.target = "";
	f.action = "/m/mypage/member_update_act.do";
	f.submit();
}	

$(document).ready(function(){
	
	//modifySubmitCancel
	// 추천인 기본값 초기화
	$("#recommendEmail").val($("#recommend").val());
	$("#recommendConfirm").val("N");

	//휴대폰 입력폼에 숫자가 아니면 삭제		
	$("#phone").bind("keyup", function(event) {
	    var regNumber = /^[0-9]*$/;
	    var temp = $("#phone").val();
	    if(!regNumber.test(temp))
	    {
	        $("#phone").val(temp.replace(/[^0-9]/g,""));
	    }
	});
	
	//취소 -마이페이지 이동
	$("#modifySubmitCancel").on("click", function(){
		location.replace('./mypage_myinfo.do');
	});
	
})

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
		url    : "/m/member/select_phone_overlapModify.do",
		dataType: "json",
		data   : {
			memberPhone		: phone
		},

		success: function(data) {
			if (data.result.code > 0) {
				//alert(data.result.msg);
				alertOpen("확인", data.result.msg, true, false, null, null);
				if ( data.result.code == 1 ){
					$("#phoneOriM").val(phone);
					$("#phoneConfirm").val("Y");
					return false;
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
</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_mypage modify">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4><spring:message code="label.mypageConfirmDesc01" /></h4>
	</header> 
	<!-- content begin -->
	<section>
		<h4><spring:message code="label.mypageConfirmDesc01" /></h4>
		<hr>
		<form name="Frm">	
			<div class="form-group">
				<label for="email" class = ""><spring:message code="label.joinDesc03" /></label> <input type="email"	class="form-control" name="email" id="email"  value="${model.mypageMyinfo.memberEmail}" disabled>
			</div>
			<div class="form-group">
				<label for="name"><spring:message code="label.joinDesc07" /></label> <input type="text"	class="form-control"  name="name" id="name"  value="${model.mypageMyinfo.memberName}" disabled>
			</div>
			
			<div class="form-group recommend">
				<label for="phone"> <spring:message code="label.joinDesc09" /></label>
				<input type="tel"	class="form-control"  name="phone" id="phone" value="${model.mypageMyinfo.memberPhone}" >
				<button type="button" class="btn btn-basic" onclick="searchPhoneOverlap();"><spring:message code="label.joinDesc04" /></button>
				<input type="hidden" name="phoneOri" id="phoneOri" value="${model.mypageMyinfo.memberPhone}" style="display:none;">
				<input type="hidden" name="phoneOriM" id="phoneOriM" style="display:none;">
				<input type="hidden" name="phoneConfirm" id="phoneConfirm" value="N" style="display:none;">
			</div>
			
			<div class="form-group">
				<label for="pwd"><spring:message code="label.joinDesc05" /></label> <input type="password" class="form-control" name="pwd" id="pwd"  minlength="8" maxlength="12">
			</div>
			<div class="form-group">
				<label for="pwdconfirm"><spring:message code="label.joinDesc06" /></label> <input type="password" class="form-control"  name="pwdconfirm" id="pwdconfirm"  minlength="8" maxlength="12">
			</div>
			
			<div class="form-group">
				<select class="form-control" id="country" name="country"> 
					<option value="" ><spring:message code="label.selectCountry" /></option>
					<c:forEach var = "country" items = "${model.countries}">
					<option value="${country.iso}" <c:if test="${country.iso == model.mypageMyinfo.country}">selected="selected"</c:if>  >${country.enName} - ${country.krName}</option>
					</c:forEach>
				</select>
			</div>
		
		<%-- 	<div class="form-group recommend">
				<label for="recommend"><spring:message code="label.joinDesc08" /></label> <input type="text" class="form-control"  name="recommend" id="recommend" value="${model.mypageMyinfo.recoMemberEmail}" disabled>
				<div><button type="button" class="btn btn-basic" onclick="searchRecommend();"><spring:message code="label.joinDesc04" /></button></div>
				<input type="hidden" name="recommendEmail" id="recommendEmail" style="display:none;">
			 	<input type="hidden" name="recommendConfirm" id="recommendConfirm" value="N" style="display:none;">
			</div>
			<div class="form-group recommend">
				<label for="phone"> <spring:message code="label.joinDesc09" /></label>
				<input type="tel"	class="form-control"  name="phone" id="phone" value="${model.mypageMyinfo.memberPhone}" disabled>
				<button type="button" class="btn btn-basic" onclick="searchPhoneOverlap();"><spring:message code="label.joinDesc04" /></button>
				<input type="hidden" name="phoneOri" id="phoneOri" value="${model.mypageMyinfo.memberPhone}" style="display:none;">
				<input type="hidden" name="phoneOriM" id="phoneOriM" style="display:none;">
				<input type="hidden" name="phoneConfirm" id="phoneConfirm" value="N" style="display:none;">
			</div> --%>
			<div class="btns2"><button type="submit" class="btn btn-submit" onclick="memberUpdateSubmit();">
				<spring:message code="label.mypageDesc04" /></button><button type="button" class="btn btn-submit-cancel" id="modifySubmitCancel"><spring:message code="label.commonCancel" /></button></div>
		</form>
	</section>
	<!-- content end -->
</div>
</body>
<!-- body end -->
</html> 