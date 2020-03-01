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
		$.fn.serializeObject = function () {
		    "use strict";
		    var result = {};
		    var extend = function (i, element) {
		        var node = result[element.name];
		        if ('undefined' !== typeof node && node !== null) {
		           if ($.isArray(node)) {
		               node.push(element.value);
		           } else {
		               result[element.name] = [node, element.value];
		           }
		        } else {
		            result[element.name] = element.value;
		        }
		    };
		 
		    $.each(this.serializeArray(), extend);
		    return result;
		};
		
		
		var height = window.screen.height - 90;
		var width = window.screen.width
		
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
					$("#phoneAuthNumber").val("");
				}
			},
			fnStop : function() {
				clearInterval(this.timer);
				this.domId.innerHTML  = "&nbsp;"
				$("#phoneNumber").val("");
				$("#sendPhoneAuthSms").attr("disabled",false);
			}
		}
		
		var isSendingSms = false;
		var settingData = {};
		function sendPhoneAuthSms(){
			if (isSendingSms == true){
				return;
			} 
			isSendingSms = true;
			
			var phoneNumber = $('#phoneNumber').val().trim();
			var name = $('#name').val().trim();
			
			if (name.length < 1) {
				alertOpen("알림", "이름을 입력해주세요", true, false, null, null);
				isSendingSms = false;
				return;
			}

			if (phoneNumber.indexOf("-")  != -1) {
				phoneNumber = phoneNumber.replace(/-/gi, "");
				$('#phoneNumber').val(phoneNumber)
			}
			
			if (phoneNumber.length < 1) {
				alertOpen("알림", "전화번호를 입력해주세요", true, false, null, null);
				isSendingSms = false;
				return;
			}
			
			if (!$.isNumeric(phoneNumber)) {
				alertOpen("확인", "전화번호는 숫자만 입력가능합니다", true, false, null, null);
				isSendingSms = false;
				return false;
			}
			
			if (!checkPhoneNumber(phoneNumber)) {
				alertOpen("확인", "휴대폰 번호 형식이 옳바르지 않습니다", true, false, null, null);
				isSendingSms = false;
				return false;
			}
			
			$("#progress_loading2").show();
			$("#sendPhoneAuthSms").attr("disabled",true);
			$.ajax({
	           	type: "POST",
	               url: "/m/member/sendPasswordAuthSms.do",
	               data: {phoneNumber : phoneNumber , name : name},
	               success: function (result) {
	            	   isSendingSms =	false;
	            	   $("#progress_loading2").hide();
		               alertOpen("확인", result.result.msg, true, false, null, null );
	            	  
	            	   if (result && typeof result !="undefined") {
	            	   	 if (result.result.code  == 0) {
	            	   		/*  joinData.countryPhoneNumber = countryPhoneNumber; */
		            	   	 settingData.phoneNumber = phoneNumber ;
		            	   	 settingData.name = name;
		            	   	 startTimer(180, "timer")
	            	   		;
	            		 }else {
	            			 $("#sendPhoneAuthSms").attr("disabled",false);
	            		 }
	               	 }else{
	               		$("#sendPhoneAuthSms").attr("disabled",false);
	               	 	isSendingSms =	false;
	               		alertOpen("알림", "네트워트 장애 발생1. 다시 시도해주세요.", true, false, null, null);
	               	 }
	               },
	               error : function(request, status, error){
	            	   isSendingSms = false;
	            	   $("#progress_loading2").hide();
	            	   $("#sendPhoneAuthSms").attr("disabled",false);
	            	   alertOpen("알림 ", "네트워트 장애 발생2  다시 시도해주세요", true, false, null, null);
	               },
	               dataType: 'json'
	           });
		}

		var isAuthRequesting = false;
		function requestPhoneNumberAuth() {
			if (isAuthRequesting == true) return;
			isAuthRequesting = true;

			$("#requestPhoneNumberAuth").attr("disabled", true);
			var phoneAuthNumber = $("#phoneAuthNumber").val().trim();
			var phoneNumber = $("#phoneNumber").val().trim();
			var name = $("#name").val().trim();
			
			if (phoneNumber.indexOf("-")  != -1) {
				phoneNumber = phoneNumber.replace(/-/gi, "");
				$('#phoneNumber').val(phoneNumber)
			}
			
			if (phoneNumber.length < 1) {
				alertOpen("알림", "전화번호를 입력해주세요", true, false, null, null);
				isSendingSms = false;
				return;
			}
			
			if (!$.isNumeric(phoneNumber)) {
				alertOpen("확인", "전화번호는 숫자만 입력가능합니다", true, false, null, null);
				isSendingSms = false;
				return false;
			}

			if (name.length < 1) {
				alertOpen("알림", "이름을 입력해주세요", true, false, null, null);
				isSendingSms = false;
				return;
			}
			
			if (phoneAuthNumber.length < 1) {
				alertOpen("확인", "인증번호가 입력되지 않았습니다.", true, false, function() { startTimer(180, "timer") }, null);
				isAuthRequesting = false;
				return;
			}
			
			$("#progress_loading2").show();
			
			$.ajax({
				type : "POST",
				url : "/m/member/requestPasswordAuthSms.do",
				data : {
					phoneNumber : phoneNumber,
					phoneAuthNumber : phoneAuthNumber,
					name : name
				},
				success : function(result) {
					isAuthRequesting = false;
					$("#progress_loading2").hide();
					if (result && typeof result != "undefined") {
						if (result.result.code == 0) {
							settingData.phoneAuthNumber = phoneAuthNumber;
							AuthTimer.fnStop(); 
							$(".phone").html(phoneNumber);
							$(".joinDate").html("회원 가입일 : " + result.result.data);
							alertOpen("알림", result.result.msg, true, false, function(){moveSlide(1)}, null);
						} else {
							alertOpen("알림", result.result.msg, true, false, null, null);
							$("#requestPhoneNumberAuth") .attr("disabled", false);
						}
					} else {
						isAuthRequesting = false;
						$("#requestPhoneNumberAuth").attr("disabled", false);
						alertOpen("알림", "네트워트 장애 발생1. 다시 시도해주세요.", true, false, null, null);
					}
				},
				error : function(request, status, error) {
					isAuthRequesting = false;
					$("#progress_loading2").hide();
					$("#requestPhoneNumberAuth").attr("disabled", false);
					alertOpen("알림 ", "네트워트 장애 발생2  다시 시도해주세요", true, false, null, null);
				},
				dataType : 'json'
			});
		}

		var isSubmitting = false;

		function changePasswordSubmit() {
			if (isSubmitting == true) return false;
			isSubmitting = true;
			var password = $("#password").val().trim();
			var passwordConfirm = $("#passwordConfirm").val().trim();

			if (password.length < 1) {
				$("#password").focus();
				isSubmitting = false;
				alertOpen("알림 ", "비밀번호가 입력되지 않았습니다.", true, false, null, null);
				return;
			}
			
			var passReg = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,12}$/;
			if (!passReg.test(password)) {
				$("#password").focus();
				isSubmitting = false;
				alertOpen("알림 ", "비밀번호는 영문자로 시작하는 8 ~12자 영문자 또는 숫자이어야 합니다.", true, false, null, null);
				return;
			}

			if (passwordConfirm.length < 1) {
				$("#passwordConfirm").focus();
				isSubmitting = false;
				alertOpen("알림 ", "비밀번호 확인이 입력되지 않았습니다.", true, false, null, null);
				return;
			}

			if (password != passwordConfirm) {
				isSubmitting = false;
				alertOpen("알림 ", "입력하신 비밀번호와 비밀번호 확인이 다릅니다.", true, false, null, null);
				return;
			}
			
			settingData.password = password;
			settingData.passwordConfirm = passwordConfirm;;
			
			$("#progress_loading2").show();
			$.ajax({
				type : "POST",
				url : "/m/member/changePasswordSubmit.do",
				data : settingData,
				success : function(result) {
					isSubmitting = false;
					$("#progress_loading2").hide();
					if (result && typeof result != "undefined") {
						$("#progress_loading2").hide();
						if (result.result.code == 0) {
							alertOpen("알림", result.result.msg, true, false, function(){movePageReplace('/m/member/newLogin.do')}, null);
						}else {
							alertOpen("알림", result.result.msg, true, false, null, null);
						}
					} else {
						alertOpen("알림", "네트워트 장애 발생1. 다시 시도해주세요.", true, false, null, null);
					}
				},
				error : function(request, status, error) {
					$("#progress_loading2").hide();
					isSubmitting = false;
					alertOpen("알림 ", "네트워트 장애 발생2  다시 시도해주세요", true, false, null, null);
				},
				dataType : 'json'
			});
		}

		var AuthTimer;
		function startTimer(second, selId) {
			AuthTimer = new $ComTimer()
			AuthTimer.comSecond = second;
			AuthTimer.fnCallback = function() {
				alert("다시 인증을 시도해주세요.")
			};
			AuthTimer.timer = setInterval(function() {
				AuthTimer.fnTimer()
			}, 1000);
			AuthTimer.domId = document.getElementById(selId);
			$("#sendPhoneAuthSms").attr("disabled", true);
		}
		
		var joinCheck = {
			termsofuse :false,
			privacypolicy : false,
			marketing : false,
			allcheck : false
		}
		
		$(document).ready(function() {
			$(".r_login").height(height);
			$slides.css("right", "-100%");
			$slides.eq(0).css("right", "0px");
			$('#phoneNumber').val("");
			$('#phoneAuthNumber').val("");
			$(".join_slide").css("height" , height + "px");
			
			$("#all_agree").bind("click", function(){
				if (joinCheck.allcheck == false) {
					$(this).addClass("join_check");
					$("#next").addClass("white_font");
					joinCheck.allcheck = true;
					joinCheck.termsofuse = true;
					joinCheck.privacypolicy = true;
					joinCheck.marketing = true;
					$(".agree").addClass("join_check");
					
					
					
				}else {
					$(this).removeClass("join_check");
					$(".agree").removeClass("join_check");
					$("#next").removeClass("white_font");
					joinCheck.allcheck = false;
					joinCheck.termsofuse = false;
					joinCheck.privacypolicy = false;
					joinCheck.marketing = false;
					
				}
			})
			
			$(".agree").bind("click", function(){
				var id = $(this).attr("id");
				if (joinCheck[id] == false){
					$(this).addClass("join_check");
					joinCheck[id] = true;
					if (joinCheck.termsofuse == true && joinCheck.privacypolicy == true){
						$("#next").addClass("white_font");
					}
				}else {
					$(this).removeClass("join_check");
					joinCheck[id] = false;
					$("#all_agree").removeClass("join_check")
					joinCheck.allcheck = false;
					if (joinCheck.termsofuse == false  ||  joinCheck.privacypolicy == false){
						$("#next").removeClass("white_font");
					}
				}
			});
			
			$("#next").bind("click", function(){
				if (joinCheck.termsofuse == true && joinCheck.privacypolicy == true){
					moveSlide(1);
				}else {
					return;
				}
			})
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
		<div class="r_login_page3 join_slide">
			<h3>휴대폰 인증</h3>
			<p> <span>비밀번호 재설정은 휴대폰 인증이 필요합니다</span> </p>
			</br>
			<p> <span>이름과 전화번호를 입력하신 후 '인증번호 받기'를 클릭하면 입력하신 번호로 인증번호 6자리가 발송됩니다.</span> </p>
			</br>
			<p> <span>아래 시간안에 인증번호를 입력하신 후 인증을 진행해주세요.</span> </p>
			</br>
			<div class="phone_input1">
				<input type="text" id="name"  name="name" placeholder="이름" style = "padding-left:15px;">
			</div>
			<div class="phone_input1">
				<input type="number" id="phoneNumber"  name="phoneNumber" placeholder="휴대폰번호(숫자만 입력)" style = "padding-left:15px;">
			</div>
			<div class="phone_input2">
				<input type="number" id="phoneAuthNumber" name="phoneAuthNumber" placeholder="인증번호 입력">
				<button id  = "sendPhoneAuthSms" onclick = "sendPhoneAuthSms();return false;">인증번호받기</button>
			</div>
			<!-- <span>위의 정보를 입력하신 후 인증번호 받기를 클릭하면 입력하신 번호로 인증번호 6자리가 발송됩니다 </br>아래 시간안에 인증번호를 입력하신 후 인증을 진행해주세요.</span> -->
			<div class="time" id = "timer">&nbsp;</div>
			<button type = "button" id = "requestPhoneNumberAuth"  onclick = "requestPhoneNumberAuth()">인증하기</button>
		</div> 
		<div class="r_pass1 join_slide">
			<h3>아이디 확인</h3>
			<div class="r_pass1_text">
				<h5>고객님께서 가입하신 회원 아이디 입니다.</h5>
				<p><b class = "phone"></b></p>
				<p class = "joinDate"></p>
				<button onclick = "moveSlide(2)">비밀번호 재설정</button>
			</div>
			<button onclick = "movePageReplace('/m/member/newLogin.do')">로그인</button>
		</div>
		<div class="r_pass2 join_slide">
			<h3>비밀전호 재설정</h3>
			<div class="r_pass1_text">
				<h5>고객님께서 가입하신 회원 아이디 입니다.</h5>
				<p><b class = "phone"></b></p>
				<p class = "joinDate"></p>
			</div>
			<div class="r_pass_box">
				<input type="password" id = "password" name = "password" placeholder="새비밀번호 입력(영문숫자 12자리이상)">
				<input type="password" id = "passwordConfirm" name = "passwordConfirm" placeholder="새비밀번호 재입력">
			</div>
			<button onclick = "changePasswordSubmit()">변경</button>
		</div>
		
	</div>
	<div id = "progress_loading2" style = "display:none;color : #aaa;font-size : 30px;top:50%"> <i class="fas fa-circle-notch fa-spin"></i> </div>
	<script type="text/javascript">
	var current = 0;
		var $slides = $(".join_slide");
		var total = 3;
		
		function setSlide() {
			if (current + 1 >= total)
				moveSlide(0);
			else
				moveSlide(current + 1);
		}

		function moveSlide(idx) {
			$(".r_login").height(height);
			$slides.eq(current).animate( { "right" : "100%" },{ duration: 200});
			$slides.eq(idx).css({"right" : "-100%" });
			$slides.eq(idx).animate({ "right" : "0px" },{ duration:200});
			current = idx;
		}
		

	</script>
</body>
</html>