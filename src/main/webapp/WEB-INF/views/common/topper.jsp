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
    	<button type="button" class="close" id="alertClose" name="alertClose" onclick='javascript:alertClose();'>&times;</button>
    	<!-- <span id="alertTitle" name="alertTitle"><strong><i class="fas fa-info-circle"></i> Warning!</strong></span> --> 	
    	<!-- <span id="alertMassage" name="alertMassage"><p>alert 메시지가 들어가는 곳입니다.</p></span> -->
    	<span id="alertTitle" name="alertTitle"></span>
    	<span id="alertMassage" name="alertMassage"></span>
    	<div class="btns">
	    	<button type="button" id="alert_ok" name="alert_ok" onclick='javascript:alertClose();'>확인</button>
	    	<button type="button" id="alert_cancel" name="alert_cancel" onclick='javascript:alertClose();'>취소</button>
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
					<a href="javascript:history.back()" class="navbar-back mobile"><i class="fas fa-chevron-left"></i></a>
					<button type="button" class="navbar-toggle" onclick="openNav()">
						<span class="icon-bar"></span> <span class="icon-bar"></span> <span	class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="/main/index.do"><img src="/resources/images/logo.png" /></a>
				</div>
				<div id="myNavbarbg"></div>
				<div class=" navbar-collapse" id="myNavbar">
					<a href="javascript:void(0)" class="closebtn" onclick="closeNav()"></a>
					<ul class="nav navbar-nav navbar-right">
						<div class="homelink">
							<a href="/main/index.do"><i class="fas fa-home"></i></a>
						</div>
						<c:choose>
							<c:when	test="${(sessionScope.memberEmail == null) || (sessionScope.memberEmail == '')}">
								<div class="userprofile">
									<div class="profilename">로그인을 해주세요.</div>
								</div>
							</c:when>
							<c:otherwise> 
								<div class="userprofile">
									<div class="profilename">${sessionScope.memberName}회원님</div>
									<div class="profileemail">${sessionScope.memberEmail}</div>
								</div>
							</c:otherwise>
						</c:choose>
						<li><a href="/company/service_member.do"><i	class="fas fa-comment"></i><i class="fas fa-sort-down"></i> <spring:message code="label.serviceMember" /></a></li>
						<li><a href="/company/company_identity.do"><i class="fas fa-building"></i><i class="fas fa-sort-down"></i> <spring:message code="label.companyInfo" /></a></li>
						<c:choose>
							<c:when	test="${(sessionScope.memberEmail == null) || (sessionScope.memberEmail == '')}">
								<li><a href="/member/login.do"><i class="fas fa-coins"></i><i class="fas fa-sort-down"></i>	<spring:message code="label.pointInfo" /></a></li>
								<li class="mobile"><a onclick="startQRScan()"><i class="fas fa-qrcode"></i>QR스캔</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="/mypage/newpoint.do"><i class="fas fa-coins"></i><i class="fas fa-sort-down"></i> <spring:message code="label.pointInfo" /></a></li>
								<li class="mobile"><a onclick="startQRScan()"><i class="fas fa-qrcode"></i>QR스캔</a></li>
							</c:otherwise>
						</c:choose>				
						<li class="mobile"><a onclick="location='/map/rpmap.do'"><i class="fas fa-map-marker-alt"></i>내 주위에 가맹점</a></li> 
						<!--<li class="mobile"><a onclick="unsupportedService()"><i class="fas fa-map-marker-alt"></i>내 주위에 가맹점</a></li>   -->						
						<li><a href="/board/board.do"><i	class="fas fa-comment"></i><i class="fas fa-sort-down"></i> <spring:message code="label.customerCenter" /></a></li>
						<c:choose>
							<c:when
								test="${(sessionScope.memberEmail == null) || (sessionScope.memberEmail == '')}">
								<li class="member form-login-in"><a href="/member/login.do"><i class="fas fa-sign-in-alt"></i> <spring:message code="login.form.submit" /></a></li>
								<li class="member form-login-in"><a href="/member/join.do"><i class="fas fa-user"></i> <spring:message code="label.join" /></a></li>
								<!-- 로그인 후 -->
							</c:when>
							<c:otherwise>
								<li class="member form-login-out pc" id="login-out"><a href="/member/logout.do"><i class="fas fa-sign-out-alt"></i>	<spring:message code="label.logout" /></a></li>
								<li class="member form-login-out pc"><a	href="/mypage/mypage_myinfo.do"><i class="fas fa-user"></i> <spring:message	code="label.myPage" /></a></li>
								<li class="member form-login-out mobile"><a	href="/mypage/mypage_myinfo.do"><i class="fas fa-cog"></i> 설정</a></li>
							</c:otherwise>
						</c:choose>
						<!-- 추가 시작-->
						<!-- language begin -->
						<li class="language">
							<select class="form-control" id="sel1"	 onchange='javascript:changeLang(this.value)'>
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
