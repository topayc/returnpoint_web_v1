<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.returnp_web.utils.SessionManager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page import="java.net.URL" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">

<head>
 <meta charset="utf-8">
    <meta http-equiv="Content-type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <title>서비스안내</title>  
	<script type="text/javascript" src="/resources/js/lib/jquery-2.2.0.min.js"></script>
	<script type="text/javascript" src="/resources/js/lib/m_common.js"></script>
	<link rel="stylesheet" href="/resources/css/m_common.css">
	  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
	<script>
		var joinData = {
				
		}
		
		var height = window.screen.height - 90;
		var width = window.screen.width
		if (isApp()) {
			getDeviceResolution(function(result) {
				if (result) {
					result = JSON.parse(result);
					if (result.result == "100") {
						height = Number(result.deviceHeight)
								/ window.devicePixelRatio;
					}
				}
			})
		}
		
		function $ComTimer() {}
		$ComTimer.prototype = {
			comSecond : "",
			fnCallback : function() {
			},
			timer : "",
			domId : "",
			fnTimer : function() {
				var m = Math.floor(this.comSecond / 60) + "분 " + (this.comSecond % 60) + "초";
				this.comSecond--; // 1초씩 감소
				this.domId.innerHTML = m;
				if (this.comSecond < 0) { // 시간이 종료 되었으면..
					this.domId.innerHTML  = "&nbsp;";
					clearInterval(this.timer); // 타이머 해제
					alert("인증 시간이 초과하였습니다. 다시 인증해주시기 바랍니다.");
					$("#sendPhoneAuthSms").attr("disabled",false);
				}
			},
			fnStop : function() {
				clearInterval(this.timer);
				this.domId.innerHTML  = "&nbsp;"
				$("#phoneNumber").val("");
				$("#sendPhoneAuthSms").attr("disabled",false);
			}
		}
		
		function sendPhoneAuthSms(){
			var countryPhoneNumber = $('#countryPhoneNumber').val().trim();
			var phoneNumber = $('#phoneNumber').val().trim();
			if (phoneNumber.indexOf("-")  != -1) {
				phoneNumber = phoneNumber.replace(/-/gi, "");
			}
			
			if (phoneNumber.length < 1) {
				 alertOpen("알림", "인증할 전화번호를 입력해주세요", true, false, null, null);
				 return;
			}
			if (!$.isNumeric(phoneNumber)) {
				alertOpen("확인", "전화번호는 숫자만 입력가능합니다", true, false, null, null);
				return false;
			}
			$("#sendPhoneAuthSms").attr("disabled",true);
			$.ajax({
	           	type: "POST",
	               url: "/m/member/sendPhoneAuthSms.do",
	               data: {phoneNumber : {countryPhoneNumber : countryPhoneNumber, phoneNumber : phoneNumber} },
	               success: function (result) {
	            	   $("#progress_loading").hide();
	            	   if (result && typeof result !="undefined") {
	            	   	 $("#progress_loading").hide();
	            	   	 if (result.result.code  == "0") {
	            	   		 joinData.countryPhoneNumber = countryPhoneNumber;
		            	   	 joinData.phoneNumber = phoneNumber ;
		            	   	 alertOpen("확인", alertText, true, false, function(){startTimer(180, "timer") }, null );
	            	   		;
	            		 }else {
	            			 $("#sendPhoneAuthSms").attr("disabled",false);
	            		 }
	               	 }else{
	               		$("#sendPhoneAuthSms").attr("disabled",false);
	               		 alertOpen("알림", "네트워트 장애 발생1. 다시 시도해주세요.", true, false, null, null);
	               	 }
	               },
	               error : function(request, status, error){
	            	   $("#progress_loading").hide();
	            	   $("#sendPhoneAuthSms").attr("disabled",false);
	            	   alertOpen("알림 ", "네트워트 장애 발생2  다시 시도해주세요", true, false, null, null);
	               },
	               dataType: 'json'
	           });
		}
		
		function requestPhoneNumberAuth(){
			var authData = {
				countryPhoneNumber : joinData.countryPhoneNumber, 
				joinData.phoneNumber : phoneNumber
			};
			
			$("#requestPhoneNumberAuth").attr("disabled",true);
			$.ajax({
	           	type: "POST",
	               url: "/m/member/requestPhoneNumberAuth.do",
	               data: {phoneNumber : {countryPhoneNumber : countryPhoneNumber, phoneNumber : phoneNumber} },
	               success: function (result) {
	            	   $("#progress_loading").hide();
	            	   if (result && typeof result !="undefined") {
	            	   	 $("#progress_loading").hide();
	            	   	 if (result.result.code  == "0") {
	            	   		/*인증되었다면 다름 회원 정보 입력 페이지로 슬라이드*/
	            	   		 moveSlide(1);
	            		 }else {
	            		 	 alertOpen("알림", result.result.msg, true, false, null, null );
	            			 $("#requestPhoneNumberAuth").attr("disabled",false);
	            		 }
	               	 }else{
	               		$("#requestPhoneNumberAuth").attr("disabled",false);
	               		 alertOpen("알림", "네트워트 장애 발생1. 다시 시도해주세요.", true, false, null, null);
	               	 }
	               },
	               error : function(request, status, error){
	            	   $("#progress_loading").hide();
	            	   $("#requestPhoneNumberAuth").attr("disabled",false);
	            	   alertOpen("알림 ", "네트워트 장애 발생2  다시 시도해주세요", true, false, null, null);
	               },
	               dataType: 'json'
	           });
		}
		
		function startTimer(second,selId){
			var AuthTimer = new $ComTimer()
			AuthTimer.comSecond = second;
			AuthTimer.fnCallback = function(){alert("다시 인증을 시도해주세요.")};
			AuthTimer.timer =  setInterval(function(){AuthTimer.fnTimer()},1000);
			AuthTimer.domId = document.getElementById(selId);
			$("#sendPhoneAuthSms").attr("disabled",true);
		}
		
		$(document).ready(function() {
			$(".r_login").height(height);
			$slides.css("right", "-100%");
			$slides.eq(0).css("right", "0px");
		});
	</script>
</head>

<body>
	<div class="alert_wrap" id="alertView" name="alertView" style="display:none;">
	  <div class="alert alert-info">
	    <div class="alert_body">
	    	<!-- <button type="button" class="close" id="alertClose" name="alertClose" onclick='javascript:alertClose();'>&times;</button> -->
	    	<!-- <span id="alertTitle" name="alertTitle"><strong><i class="fas fa-info-circle"></i> Warning!</strong></span> --> 	
	    	<!-- <span id="alertMassage" name="alertMassage"><p>alert 메시지가 들어가는 곳입니다.</p></span> -->
	    	<span id="alertTitle" name="alertTitle"></span>
	    	<span id="alertMassage" name="alertMassage"></span>
	    	<div class="btns">
		    	<button type="button" id="alert_ok" name="alert_ok" onclick='javascript:alertClose();'><spring:message code="label.ok" /></button>
		    	<button type="button" id="alert_cancel" name="alert_cancel" onclick='javascript:alertClose();'><spring:message code="label.cancel" /></button>
	    	</div>
	    </div>
	  </div> 
	</div>
	<div class="r_login">
		<!-- <div class="r_login_page1 join_slide">
			<div class="top_main">
				<div class="logo_img">
					<img src="/resources/images/logo_img.png">
				</div>
				<div class="rpoint_text">
					<ul>
						<li><b>RPOINT</b></li>
						<li>소비가 저축이 되는 똑똑한 앱</br>100%적립</li>
					</ul>
				</div>
			</div>
			<button onclick="openRecommendDlg()">계정 만들기</button>
			<div class="login_text">
				<span>이미 R POINT 계정이 있으신가요</span> <span>|</span> <span><b>로그인</b></span>
			</div>
			<div class="facebook_btn">
				<img src="/resources/images/facebook_logo.png">페이스북으로 회원가입
			</div>
		</div>
		<div class="r_login_page2 join_slide">
			<div class="top_main">
				<div class="logo_img">
					<img src="/resources/images/logo_img.png">
				</div>
				<div class="rpoint_text">
					<ul>
						<li><b>RPOINT</b></li>
						<li>소비가 저축이 되는 똑똑한 앱</br>100%적립</li>
					</ul>
				</div>
			</div>
			<div class="input_box">
				<input type="text" name="전화번호" placeholder="전화번호"> <input
					type="text" name="비밀번호" placeholder="비밀번호">
			</div>
			<button>로그인</button>
			<input type="checkbox" id="cb"><label for="cb">아이디 저장</label>
			<div class="sign_text">
				<ul>
					<li>회원가입</li>
					<li>아이디 비밀번호 찾기</li>
					<li>추천인QR로 가입하기</li>
				</ul>
			</div>
			<div class="facebook_btn">
				<img src="/resources/images/facebook_logo.png">페이스북으로 회원가입
			</div>
		</div> -->
		<div class="r_login_page3 join_slide">
			<h3>모바일 인증</h3>
			<p>
				<b>R POINT</b> 앱은 모바일 번호를 아이디로 사용합니다.
			</p>
			<p>아래의 인증 과정을 진행해 주시기 바랍니다.</p>
			</br>
			<div class="phone_input1">
				<select  id = "countryPhoneNumber" >
					<c:forEach var="countryPhoneNumber" items="${model.countryPhoneNumbers}" varStatus="status">
						<option value = "${countryPhoneNumber.countryPhoneNumber}">${countryPhoneNumber.countryName}(${countryPhoneNumber.countryPhoneNumber})</option>
					</c:forEach>
				</select> 
				<input type="text" id="phoneNumber"  name="phoneNumber" placeholder="휴대폰번호">
			</div>
			<div class="phone_input2">
				<input type="text" name="인증번호 입력" placeholder="인증번호 입력">
				<button id  = "sendPhoneAuthSms" onclick = "sendPhoneAuthSms()">인증번호받기</button>
			</div>
			</br>
			<span>입력하신 번호로 인증번호 6자리가 발송됩니다 </br>아래 시간안에 입력하신 후 인증을 진행해주세요.</span>
			<div class="time" id = "timer">&nbsp;</div>
			<button id = "requestPhoneNumberAuth"  onclick = "requestPhoneNumberAuth()">인증하기</button>
		</div>

		<div class="r_login_page5 join_slide">
			<h3>기본 정보 입력</h3>
			<div class="r_id">
				<p>아이디</p>
				<span>아이디는 인증하신 핸드폰 번호가 설정됩니다.</span> <input type="text" name="아이디" placeholder="01012345678">
			</div>
			<div class="r_id">
				<p>비밀번호</p>
				<input type="password" name="비밀번호" placeholder="영문+숫자 10자리이상 설정해주세요.">
			</div>
			<div class="r_id">
				<p>비밀번호 확인</p>
				<input type="password" name="비밀번호 확인" placeholder="비밀번호 확인을 해주세요.">
			</div>
			<div class="r_id">
				<p>이메일 입력</p>
				<input type="text" name="이메일 입력" placeholder="이메일주소를 입력해주세요.">
			</div>
			<div class="r_id">
				<p>추천인 입력</p>
				<span>추천인은 선택입력사항이며, 추천인 전화번호를 입력한 후 추천인 확인 버튼을 눌러주세요</span>
				<div class="r_id_input">
					<input type="text" name="추천인 등록">
					<button onclick="openRecommendDlg()">추천인확인</button>
				</div>
			</div>
			<button>가입하기</button>
		</div>
		<!-- <div class="r_login_page7 join_slide">
			<div class="top_main">
				<div class="logo_img">
					<img src="/resources/images/logo_img.png">
				</div>
				<div class="rpoint_text">
					<ul>
						<li><b>RPOINT</b></li>
						<li>소비가 저축이 되는 똑똑한 앱</br>100%적립</li>
					</ul>
				</div>
			</div>
			<h1>가입을 축하합니다.</h1>
			<div class="r_home">R POINT 홈으로 가기</div>
		</div> -->
	</div>
	<div class="r_login_page4">
		<div class="cord_number">
			<h3>국가선택</h3>
			<div class="close_img">
				<img src="/resources/images/close_img.png">
			</div>
			<div class="cord_input">
				<div class="search_img">
					<img src="/resources/images/search_img.png">
				</div>
				<input type="text" name="국가 이름 또는 코드" placeholder="국가 이름 또는 코드">
			</div>
			<ul>
				<li>가나(+233)</li>
				<li>가봉(+241)</li>
				<li>가이아나()+592</li>
				<li>감비아(+220)</li>
				<li>건지(+44)</li>
			</ul>
		</div>
	</div>
	
	<div class="r_login_page6">
		<div class="r_name">
			<div class="r_name_box">
				<div class="r_name_left">
					<img src="/resources/images/name_left_img.png">
				</div>
				<input type="text" name="recommenderPhone" placeholder="추천인 전화번호">
				<div class="r_name_right">
					<img src="/resources/images/name_right_img.png">
				</div>
			</div>
			<div class="r_name_text">
				<ul>
					<li><span>차미라</span> <span>010-5845-0051</span> <span>mira0326@naver.com</span>
					</li>
					<li><span>차미라</span> <span>010-5845-0051</span> <span>mira0326@naver.com</span>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var current = 0;
		var $slides = $(".join_slide");
		var total = 2;
		
		function setSlide() {
			if (current + 1 >= total)
				moveSlide(0);
			else
				moveSlide(current + 1);
		}

		function moveSlide(idx) {
			$(".r_login").height(height);
			//$slides.eq(current).animate( { "right" : "100%" },{ duration: 200});
			$slides.eq(idx).css({"right" : "-100%" });
			$slides.eq(idx).animate({ "right" : "0px" },{ duration:200});
			current = idx;
		}

	</script>
</body>
</html>