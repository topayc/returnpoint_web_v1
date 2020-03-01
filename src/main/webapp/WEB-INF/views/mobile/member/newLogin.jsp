<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="com.returnp_web.utils.SessionManager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html lang="ko">

<head>
 <meta charset="utf-8">
    <meta http-equiv="Content-type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <title>서비스안내</title>  
   <link rel="stylesheet" href="/resources/css/m_common.css">
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
   <script type="text/javascript" src="/resources/js/lib/m_common.js"></script>
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
   <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
   <script>
      var height  = window.screen.height - 90;
       var width = window.screen.width
       var isLoginSumitting = false;
       function login(){
    	   if (isLoginSumitting == true) return;
		   isLoginSumitting  = false;
		   
		   var memberPhone = $("#memberPhone").val().trim().replace(/-/gi, "");;
			var memberPassword = $("#memberPassword").val().trim();
			if (memberPhone.length < 1) {
				alertOpen("알림", "휴대폰 번호가 입력되지 않았습니다", true, false, function(){$("#memberPhone").focus()}, null);
				return;
			}
			
			if (!checkPhoneNumber(memberPhone)) {
				alertOpen("확인", "휴대폰 번호 형식이 옳바르지 않습니다", true, false, null, null);
				isSendingSms = false;
				return false;
			}
			
			if (memberPassword.length < 1) {
				alertOpen("알림", "비밀번호가 입력되지 않았습니다", true, false, function(){$("#memberPassword").focus()}, null);
				return;
			}
			
			$("#progress_loading2").show();
			$.ajax({
				type : "POST",
				url : "/m/member/newLogin.do",
				data : {memberPhone : memberPhone, memberPassword : memberPassword},
				success : function(result) {
					isLoginSumitting = false;
					$("#progress_loading2").hide();
					if (result && typeof result != "undefined") {
						$("#progress_loading2").hide();
						var memberPhone, userAuthToken;
						if (result.result.code == 0) {
							if (isApp() && result.result.msg.startsWith("APP")){
								var data = result.result.msg.split(",");
								var session = {userName :data[1] , userEmail : data[2], userPhone : data[3],userAuthToken : data[4]}
							    bridge.setDeviceSession(JSON.stringify(session), function(result) {
							    	 result = JSON.parse(result);
							    	 if (result.result == "100") {
							   		 	bridge.setPushToken();
							         	movePage("/m/main/index.do");
							        }else {
							       		alertOpen("알림", "앱 오류 발생", true, false, null, null);
							        }
							      });
							}else {
								movePage("/m/main/index.do");
							}
						} else {
							alertOpen("알림", result.result.msg, true, false, null, null);
						}
					} else {
						isLoginSumitting = false;
						alertOpen("알림", "네트워트 장애 발생1. 다시 시도해주세요.", true, false, null, null);
					}
				},
				error : function(request, status, error) {
					$("#progress_loading2").hide();
					isLoginSumitting = false;
					alertOpen("알림 ", "네트워트 장애 발생2  다시 시도해주세요", true, false, null, null);
				},
				dataType : 'json'
			});
       }
       
       $(document).ready(function(){
    	   $(".r_join_ok").css("height" , height + "px");
    	   $("#login_btn").bind("click",function(){
    			login();
    	   })
       })
   </script>
</head>

<body style = "background-color : #f1f1f1">
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
	
   <div class="r_join_ok">
      <div class="r_login_page2">
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
            <input type="number" name="memberPhone"  id = "memberPhone" placeholder="휴대폰 번호( - 없이 숫자만 입력)">
             <input type="text" name="memberPassword" id = "memberPassword" placeholder="비밀번호">
         </div>
         <button id="login_btn">로그인</button>
      	<!-- <input type="checkbox" id="isSaveId" name = "isSaveId"><label for="cb">아이디 저장</label>  -->
         <div class="sign_text">
            <ul>
               <li onclick = "movePage('/m/member/newJoinProcess.do')"><spring:message code="label.loginDesc05" /></li>
               <li onclick = "movePage('/m/member/newPassSettings.do')">비밀번호 재설정</a></li>
               <li onclick = "startQRScan()"><spring:message code="label.recognize_the_promoter_qr" /></li>
            </ul>
         </div>
    <!--      <div class="facebook_btn">
            <img src="/resources/images/facebook_logo.png">페이스북으로 회원가입
         </div> -->
      </div>
   </div>
   <div id = "progress_loading2" style = "display:none;color : #aaa;font-size : 30px;top:50%"> <i class="fas fa-circle-notch fa-spin"></i> </div>
</body>
</html>