<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.returnp_web.utils.SessionManager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

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
<div class="wrap">
	<header>	
		<div id = "progress_loading" style = "display:none">
			<i class="fas fa-circle-notch fa-spin"></i>
		</div>
		<nav class="navbar">
			<div class="container-fluid">
				<div class="navbar-header">
					<a href="javascript:history.back()" class="navbar-back"><i class="fas fa-chevron-left"></i></a>
					<a onclick="startQRScan()" class="navbar-qr"><i class="far fa-bell" style="color:#333;position:relative;"></i>
					<span style="position:absolute;color:#fff;background-color:red;padding:1px 5px;font-size:5px;border-radius:10px;left:25px;top:10px;">1</span></a>
					<button type="button" class="navbar-toggle" onclick="openNav()">
						<span class="icon-bar"></span> <span class="icon-bar"></span> <span	class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="/m/main/index.do"><img src="/resources/images/logo.png" />1111</a>
				</div>
				<div id="myNavbarbg"></div>
				<div class=" navbar-collapse" id="myNavbar">
					<a href="javascript:void(0)" class="closebtn" onclick="closeNav()"></a>
					<ul class="nav navbar-nav navbar-right"> 
						<div class="homelink"> <a href="/m/main/index.do"><i class="fas fa-home"></i></a></div>
						<div class="h_img_link"><img src="/resources/images/r_general.png"></div>
						<c:choose>
							<c:when	test="${(sessionScope.memberEmail == null) || (sessionScope.memberEmail == '')}">
								<div class="userprofile">
									<div class="profilename"><spring:message code="label.topper.service_use_guide" /></div>
								</div>
							</c:when>
							<c:otherwise> 
								<div class="userprofile">
								<%-- 	<div class="profilename"><spring:message code="label.n_nice_meet" /></div> --%>
									<div class="profilename">${sessionScope.memberName} <spring:message code="label.topper.member" /></div>
									<div class="profileemail">${sessionScope.memberEmail}</div>
								</div>
							</c:otherwise>
						</c:choose>
						<!-- 홈링크 하단 페이지 -->
						<div class="r_homelink">
							<ul>
								<li><a href="#"><spring:message code="label.n_notice" /><span>NEW</span><img src="/resources/images/r_home_button.png"></a></li>
								<li><a href="#"><spring:message code="label.n_event" /><span>NEW</span><img src="/resources/images/r_home_button.png"></a></li>
								<li><a href="#"><spring:message code="label.n_add_call" /><img src="/resources/images/r_home_button.png"></a></li>
								<li><a href="#"><spring:message code="label.n_register_affiliate" /><img src="/resources/images/r_home_button.png"></a></li>
								<li><a href="#"><spring:message code="label.n_settings" /><img src="/resources/images/r_home_button.png"></a></li>
								<li><a href="#"><spring:message code="label.n_cs" /><img src="/resources/images/r_home_button.png"></a></li>
								<li><a href="#"><spring:message code="label.n_lang_settings" /><img src="/resources/images/r_home_button.png"></a></li>
								<li><spring:message code="label.n_en_rpoint" />&nbsp;<spring:message code="label.n_cs" />&nbsp;&nbsp;<b>02-989-9812</b></li>
							</ul>
						</div>
	
						<c:choose>
							<c:when test="${(sessionScope.memberEmail == null) || (sessionScope.memberEmail == '')}">
								<li class="member form-login-in"><a href="/m/member/login.do"><i class="fas fa-sign-in-alt"></i><spring:message code="login.form.submit" /></a></li>
								<li class="member form-login-in"><a href="/m/member/join.do"><i class="fas fa-user"></i><spring:message code="label.join" /></a></li>
								<!-- 로그인 후 -->
							</c:when>	
						</c:choose>
						<!-- 추가 시작-->
						<!-- language begin -->
						<li class="language">
							<select class="form-control"  id="sel1" onchange='javascript:changeLang(this.value)'>
								<option value="ko">KOR</option>
								<option value="en">ENG</option>
								<option value="ch">CHA</option>
							</select>
						</li>
						<!-- language end -->
					</ul>
				</div>
			</div>
		</nav>
<script>
document.body.style.height = window.screen.height + "px"; 
</script>
