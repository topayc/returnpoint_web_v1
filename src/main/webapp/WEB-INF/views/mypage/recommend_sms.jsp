<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="com.returnp_web.utils.SessionManager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="f" uri="/WEB-INF/tld/f.tld" %>
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
<link rel="stylesheet" href="/resources/css/common.css">
<!-- js -->
<script src="/resources/js/lib/jquery.min.js"></script>
<script src="/resources/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/common.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var pageContextlocale = '${pageContext.response.locale}';
	$("#sel1").val(pageContextlocale); 	
	
	$("#all_seelct").change(function(){
		if($(this).is(":checked")) {
			$("input[type=checkbox]").prop("checked", true);
		}else {
			$("input[type=checkbox]").prop("checked", false);
		}
	});
	
	 bridge.getDeviceContacts(function(contacts){
		makeContactList(contacts);
	});
	
 /*	makeContactList(
		JSON.stringify([
			{name : "안영철1", phoneNumber : "012-1231-1243"},
			{name : "안영철2", phoneNumber : "012-1231-1223"},
			{name : "안영철3", phoneNumber : "012-1231-1243"},
			{name : "안영철4", phoneNumber : "012-1231-1253"},
			{name : "안영철5", phoneNumber : "012-1231-1263"},
		])
	);*/
});

function sendRecommendSMSCheck(memberName, memberEmail){
	if ($("input[type='checkbox']:checked").length < 1) {
		 alertOpen("알림", "선택하신 전화번호가 없습니다", true, false, null, null);
		 return;
	}
	var smsData = [];
	$("input[type='checkbox']:checked").each(function(index,item){
		smsData.push({
			message :  window.location.protocol + "//" + window.location.host + "/member/join.do?re=" +btoa(encodeURIComponent(memberEmail)),
			phoneNumber : $(this).attr('phoneNumber'),
			url : window.location.protocol + "//" + window.location.host + "/member/join.do?re=" +memberEmail
		})
	});

	bridge.checkPermission(appInfo.permission.SEND_SMS, function(result){
		result = JSON.parse(result);
		if (result.permission == appInfo.permissionResult.PERMITTEED) {
			sendSMS(smsData);
		}else {
			bridge.requestPermission(appInfo.permission.SEND_SMS, function(result){
				result = JSON.parse(result);
				if (result.permission == appInfo.permissionResult.PERMITTEED) {
					sendSMS(smsData);
				}else {
					 alertOpen("확인", result.permissionName + " 권한을 허용하셔야 해당 기능을 사용할 수  있습니다.", true, false, null, null);
				}
			});
		}
	});
}

function sendSMS(smsData){
	$("#progress_loading").show();
	if (!smsData) {
		alertOpen("알림", "잘못된 접근입니다", true, false, null, null); 
		return; 
	}
	smsData = JSON.stringify(smsData) 
	bridge.sendSMS(smsData, function(result){
		$("#progress_loading").hide();
		$("input[type=checkbox]").prop("checked", false);
		alertOpen("알림", "추천 SMS 를 발송했습니다", true, false, null, null); 
	 });
 }
 
function makeContactList(contacts){
	contacts = JSON.parse(contacts);
	$('#contactsCount').html(contacts.length);
	var contactContainer
	var nameDiv;
	var phoneDiv;
	var checkDiv;
	var checkInput; 
	var checkInputImg;  /* 체크이미지 추가로 소스추가*/
	for (var i = 0; i < contacts.length; i++){
		contactContainer = $("<div></div>").addClass("list_li" ).addClass("sms_select" ).css("display", "flex");
		nameDiv = $("<div></div>").css("width", "70%").text(contacts[i].name);
		phoneDiv = $("<div></div>").css("width", "100%").text(contacts[i].phoneNumber);
		checkDiv = $("<label class='container'></label>").css("text-align", "right"); /* 체크이미지 추가로 소스수정*/
		checkInput = $("<input/>").attr("type", "checkbox").addClass("phone_check").attr("phoneNumber", contacts[i].phoneNumber).attr("name", contacts[i].name);
		checkInputImg = $("<i class='checkmark fas fa-check-circle'></i>"); /* 체크이미지 추가로 소스추가*/
		
		checkDiv.append(checkInput);
		checkDiv.append(checkInputImg);  /* 체크이미지 추가로 소스추가*/
		contactContainer.append(nameDiv);
		contactContainer.append(phoneDiv);
		contactContainer.append(checkDiv);
		$('#contact_frame').append(contactContainer);
	}
}

/* 체크박스디자인 수정 이전
 function makeContactList(contacts){
	contacts = JSON.parse(contacts);
	var contactContainer
	var nameDiv;
	var phoneDiv;
	var checkDiv;
	var checkInput; 
	for (var i = 0; i < contacts.length; i++){
		contactContainer = $("<div></div>").addClass("list_li" ).addClass("sms_select" ).css("display", "flex");
		nameDiv = $("<div></div>").css("width", "70%").text(contacts[i].name);
		phoneDiv = $("<div></div>").css("width", "100%").text(contacts[i].phoneNumber);
		checkDiv = $("<div></div>").css("width", "30%");
		checkInput = $("<input/>").attr("type", "checkbox");
		
		checkDiv.append(checkInput);
		contactContainer.append(nameDiv);
		contactContainer.append(phoneDiv);
		contactContainer.append(checkDiv);
		$('#contact_frame').append(contactContainer);
	}
}
*/

</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_recommend">	
	<!-- nav -->
	<jsp:include page="/WEB-INF/views/common/topper.jsp" />
	<!-- nav -->
		<h4>친구 추천</h4>
	</header> 
	<!-- content begin -->
	<section>
		<div class="listS01" id = "contact_frame">
			<div class="list_title">
				<i class="fas fa-building"></i> 연락처 목록 (<span id = "contactsCount"></span>개) 
				<label class="container all">
				  <input id = "all_seelct" type = "checkbox">
				  <i class="checkmark fas fa-check-circle"></i>
				</label>
			</div>		
		</div>
		<a class="btn btn-submit"  onclick = "sendRecommendSMSCheck('${model.myinfo.memberName}', '${model.myinfo.memberEmail}')" id = "send_sms" ><i class="fas fa-sign-out-alt"></i>추천 문자 발송</a>
	</section>	
	<!--  체크박스디자인 수정 이전
		<section>
		<div class="listS01" id = "contact_frame">
			<div class="list_title">
				<i class="fas fa-building"></i> 연락처 목록 
				<label for="all_seelct" style = "margin-left : 180px">전체 선택</label>
				<input id = "all_seelct" type = "checkbox"  style = "margin-left : 3px"/>
			</div>		
		</div>
		<a class="btn btn-submit"  id = "send_sms" ><i class="fas fa-sign-out-alt"></i>추천 문자 발송</a>
	</section>	
	 -->
	<!-- content end -->
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<!-- footer -->	
</body>
<!-- body end -->
</html>