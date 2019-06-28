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
					<a onclick="startQRScan()" class="navbar-qr"><i class="fas fa-qrcode"></i></a>
					<button type="button" class="navbar-toggle" onclick="openNav()">
						<span class="icon-bar"></span> <span class="icon-bar"></span> <span	class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="/m/main/index.do"><img src="/resources/images/logo.png" /></a>
				</div>
				<div id="myNavbarbg"></div>
				<div class=" navbar-collapse" id="myNavbar">
					<a href="javascript:void(0)" class="closebtn" onclick="closeNav()"></a>
					<ul class="nav navbar-nav navbar-right"> 
						<div class="homelink"> <a href="/m/main/index.do"><i class="fas fa-home"></i></a></div>
						<c:choose>
							<c:when	test="${(sessionScope.memberEmail == null) || (sessionScope.memberEmail == '')}">
								<div class="userprofile">
									<div class="profilename"><spring:message code="label.topper.service_use_guide" /></div>
								</div>
							</c:when>
							<c:otherwise> 
								<div class="userprofile">
									<div class="profilename">${sessionScope.memberName} <spring:message code="label.topper.member" /></div>
									<div class="profileemail">${sessionScope.memberEmail}</div>
								</div>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when	test="${(sessionScope.memberEmail == null) || (sessionScope.memberEmail == '')}">
								<li><a href="/m/member/login.do"><i class="fas fa-credit-card"></i><spring:message code="label.topper.menu.check_rpay" /></a></li>
								<li><a href="/m/member/login.do"><i class="fas fa-coins"></i><spring:message code="label.topper.menu.check_rpoint" /></a></li>
								<li><a onclick="startQRScan()"><i class="fas fa-qrcode"></i><spring:message code="label.topper.menu.sacnqr" /></a></li>
							</c:when>
							<c:otherwise>
								<li><a href="/m/mypage/newpay.do"><i class="fas fa-credit-card"></i><spring:message code="label.topper.menu.check_rpay" /></a></li>
								<li><a href="/m/mypage/newpoint.do"><i class="fas fa-coins"></i><spring:message code="label.topper.menu.check_rpoint" /></a></li>
								<li><a onclick="startQRScan()"><i class="fas fa-qrcode"></i><spring:message code="label.topper.menu.sacnqr" /></a></li>
								<li><a href="/m/mypage/manage_qr.do"><i class="fas fa-laptop"></i><spring:message code="label.manage_qr_code" /></a></li>
							</c:otherwise>
						</c:choose>				 
						<li><a onclick="location='/m/map/rpmap.do'"><i class="fas fa-map-marker-alt"></i><spring:message code="label.topper.menu.search_aff" /></a></li>
						<%-- <li><a href="/m/giftCard/giftCardDetail.do"><i class="fas fa-gift"></i><spring:message code="label.mygiftcard" /></a></li> --%>
						<li><a href="/m/giftCard/giftCardList.do"><i class="fas fa-gift"></i><spring:message code="label.mygiftcard" /></a></li> 
						<li><a href="/m/mypage/m_selectLanguage.do"><i class="fas fa-globe-americas"></i> <i class="fas fa-sort-down"></i><spring:message code="label.mypageLanguage" /></a></li>
						<li><a href="/m/board/board.do"><i	class="fas fa-comment"></i><i class="fas fa-sort-down"></i><spring:message code="label.topper.menu.customer_center" /></a></li>
						<c:choose>
							<c:when test="${(sessionScope.memberEmail == null) || (sessionScope.memberEmail == '')}">
								<li class="member form-login-in"><a href="/m/member/login.do"><i class="fas fa-sign-in-alt"></i><spring:message code="login.form.submit" /></a></li>
								<li class="member form-login-in"><a href="/m/member/join.do"><i class="fas fa-user"></i><spring:message code="label.join" /></a></li>
								<!-- 로그인 후 -->
							</c:when>
							<c:otherwise>
								<li class="member form-login-out"><a href="/m/mypage/mypage_myinfo.do"><i class="fas fa-cog"></i><spring:message code="label.topper.menu.my_page" /></a></li>
							</c:otherwise>
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
