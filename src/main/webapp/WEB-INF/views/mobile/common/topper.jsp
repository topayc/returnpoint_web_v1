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
					<a class="navbar-qr" onclick = "movePage('/m/board/memberNotiList.do')">
						<i class="far fa-bell" style="color:#333;position:relative;"></i>
						<c:if test = "${notiInfo.notiCount != 0}">
							<span style="position:absolute;color:#fff;background-color:#EC2491;padding:1px 5px;border-radius:10px;left:25px;top:8px;font-size:10px"><b>${notiInfo.notiCount}</b></span> 
						</c:if>
					</a>
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
							<ul class = "topper_menu" >
								<li onclick = "movePage('/m/board/boardList.do?bbsType1=1&bbsType2=1')">
										<spring:message code="label.n_notice" />
										 <c:set var="now" value="<%=new java.util.Date()%>"/>
								         <fmt:parseNumber value="${now.time / (1000*60*60*24)}" integerOnly="true" var="today"></fmt:parseNumber>
										 <fmt:parseDate value="${notice.createTime}" var="noticePostDate" pattern="yyyy-MM-dd "/>
								          <fmt:parseNumber value="${noticePostDate.time / (1000*60*60*24)}" integerOnly="true" var="postData"></fmt:parseNumber>
										<c:if test="${today - postData <= 100}">
										<span class = "new_notice">NEW</span>
										</c:if>
								<%-- <li><a href="#"><spring:message code="label.n_add_call" /><img src="/resources/images/r_home_button.png"></a></li>
								<li ><a href="#"><spring:message code="label.n_register_affiliate" /><img src="/resources/images/r_home_button.png"></a></li>  --%>
								<li onclick = "movePage('/m/mypage/mypage_myinfo.do')"><spring:message code="label.n_myinfo" />/<spring:message code="label.n_settings" /><!-- <img src="/resources/images/r_home_button.png"> --></li>
								<li onclick = "movePage('/m/customer/customerCenter.do')"><spring:message code="label.n_cs" /><!-- <img src="/resources/images/r_home_button.png"> --></li>
								<li onclick = "movePage('/m/mypage/m_selectLanguage.do')"><spring:message code="label.n_lang_settings" /><!-- <img src="/resources/images/r_home_button.png"> --></li>
								<li onclick = "movePage('/m/board/memberNotiList.do')">내알림 보기
									<c:if test = "${notiInfo.notiCount != 0}"> <span style="padding:0.7% 1.8%;font-size:11px;background-color:#EC2491"> ${notiInfo.notiCount}</span></c:if> 
								</li>
								<li onclick = "movePage('/m/mypage/maskOrderList.do')">내 쇼핑리스트</li>
								<c:if test = "${not empty affiliate}">
								<li onclick = "movePage('/m/affiliate/affiliateMain.do?affiliateNo=${affiliate.affiliateNo}')" ><img style="float:left;margin-right:7px;"src="/resources/images/r_fran_btn_img.png"><b>${affiliate.affiliateName}</b> 가맹점 메뉴<!-- <img src="/resources/images/r_home_button.png"> --></li>
								</c:if>
								<c:if test = "${not empty affiliate}">
								<li onclick = "movePage('/m/board/boardList.do?bbsType1=1&bbsType2=2')"><img style="float:left;margin-right:7px;"src="/resources/images/r_fran_btn_img.png"> 가맹점 공지<!-- <img src="/resources/images/r_home_button.png"> --></li>
								</c:if>
								
								<c:choose>
									<c:when test="${(sessionScope.memberEmail == null) || (sessionScope.memberEmail == '')}">
										<li onclick = "movePage('/m/member/login.do')"><spring:message code="login.form.submit" /></li>
										<li onclick = "movePage('/m/member/join.do')"><spring:message code="label.join" /></li>
									</c:when>	
									<c:otherwise>
										<li onclick = "movePage('/m/member/logout.do')">
											<div class = "topper_logout">
												<spring:message code="label.logout" />
											</div>
										</li>
									</c:otherwise>
								</c:choose>
								<li ><spring:message code="label.n_en_rpoint" />&nbsp;<spring:message code="label.n_cs" />&nbsp;&nbsp;<b>02-585-5993</b></li>
							</ul>
						</div>
					</ul>
				</div>
			</div>
		</nav>
<script>
document.body.style.height = window.screen.height + "px"; 
</script>
