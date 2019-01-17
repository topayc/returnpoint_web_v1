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
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<!-- css   -->
<!-- font -->
<link rel="stylesheet" href="/resources/css/common.css">
<!-- js -->
<script src="/resources/js/lib/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/bootstrap.min.js"></script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_point">	
	<header>
		<nav>
			<div class="group_wrap">
				<div class="nav-brand">
					<a href="../main/index.do"><img src="/resources/images/logo.png" /></a>
				</div>
				<ul>
					<li><a href="/company/service_member.do"><i class="fas fa-sort-down"></i><spring:message code="label.serviceMember" /></li>
					<li><a href="/company/company_identity.do"><i class="fas fa-sort-down"></i><spring:message code="label.companyInfo" /></a></li>
					<c:choose>
				<c:when test="${(sessionScope.memberEmail == null) || (sessionScope.memberEmail == '')}">					
					<li><a href="/member/login.do"><i class="fas fa-sort-down"></i><spring:message code="label.pointInfo" /></a></li>
				</c:when>			
				<c:otherwise>		
					<li><a href="/mypage/point.do"><i class="fas fa-sort-down"></i><spring:message code="label.pointInfo" /></a></li>
				</c:otherwise>
				</c:choose> 
					<!-- <li><a href="./customer_notice.do"><i class="fas fa-sort-down"></i>고객센터</a></li> -->
					<!-- 로그인 전  -->
				<c:choose>
				<c:when test="${(sessionScope.memberEmail == null) || (sessionScope.memberEmail == '')}">
					<li class="member form-login-in"><a href="/member/login.do"><i class="fas fa-sign-in-alt"></i> <spring:message code="login.form.submit" /></a></li>
					<li class="member form-login-in"><a href="/member/join.do"><i class="fas fa-user"></i> <spring:message code="label.join" /></a></li>
				</c:when>
				<c:otherwise>
					<li class="member form-login-out" id="login-out"><a href="/member/logout.do"><i class="fas fa-sign-out-alt"></i> <spring:message code="label.logout" /></a></li>    
					<li class="member form-login-out"><a href="/mypage/mypage_myinfo.do"><i class="fas fa-user"></i> <spring:message code="label.myPage" /></a></li>
				</c:otherwise>
				</c:choose> 
				</ul>
			</div>
		</nav>
		<h4>Point info</h4>
	</header>
	<!-- content begin -->	
	<ul class="submenu">
		<li><a href="./newpoint.do">포인트조회</a></li>
		<li><a href="./point_transfer.do">포인트전환</a></li>
		<li class="active"><a href="./point_gift.do">포인트선물</a></li>
	</ul>
	<section class="point_tarnsfer">
		<ul>
			<a data-toggle="tab" href="#Gpoint"><li class="gpoint active"><p class="rpt">GPoint 선물하기 </p><p>500,000,000</p></li></a>
			<a data-toggle="tab" href="#Rpoint"><li class="rpoint"><p class="gpt">RPoint 선물하기</p><p>500,000</p></li></a>
		</ul>
		<div class="tab-content">
		    <div id="Gpoint" class="tab-pane fade in active">	
		    	<i class="fa fa-sort-down"></i>	  	
				<div class="tabtitle">GPoint 선물하기</div>
				<div class="listbox gplist">
					<div class="listmember"><span class="node nd1">회원</span>GPoint</div>
					<div class="listpoint"><small>P</small><span>1,000,000</span></div>
					<a type="button" data-toggle="modal" data-target="#gpoint_gift" class="listbtn"><i class="fas fa-gift"></i>포인트선물</a>
				</div>
				<div class="listbox gplist">
					<div class="listmember"><span class="node nd2">정회원</span>GPoint</div>
					<div class="listpoint"><small>P</small><span>350,000</span></div>
					<a type="button" data-toggle="modal" data-target="#gpoint_gift" class="listbtn"><i class="fas fa-gift"></i>포인트선물</a>
				</div>
				<div class="listbox gplist">
					<div class="listmember"><span class="node nd3">영업관리자</span>GPoint</div>
					<div class="listpoint"><small>P</small><span>1,000</span></div>
					<a type="button" data-toggle="modal" data-target="#gpoint_gift" class="listbtn"><i class="fas fa-gift"></i>포인트선물</a>
				</div>
				<div class="listbox gplist">
					<div class="listmember"><span class="node nd4">협력업체</span>GPoint</div>
					<div class="listpoint"><small>P</small><span>455,000</span></div>
					<a type="button" data-toggle="modal" data-target="#gpoint_gift" class="listbtn"><i class="fas fa-gift"></i>포인트선물</a>
				</div>	
				<div class="listbox gplist">
					<div class="listmember"><span class="node nd5">대리점</span>GPoint</div>
					<div class="listpoint"><small>P</small><span>85,000</span></div>
					<a type="button" data-toggle="modal" data-target="#gpoint_gift" class="listbtn"><i class="fas fa-gift"></i>포인트선물</a>
				</div>	
				<div class="listbox gplist">
					<div class="listmember"><span class="node nd6">지사</span>GPoint</div>
					<div class="listpoint"><small>P</small><span>12,000,000</span></div>
					<a type="button" data-toggle="modal" data-target="#gpoint_gift" class="listbtn"><i class="fas fa-gift"></i>포인트선물</a>
				</div>	
				<div class="listbox gplist">
					<div class="listmember"><span class="node nd7">총판</span>GPoint</div>
					<div class="listpoint"><small>P</small><span>32,000</span></div>
					<a type="button" data-toggle="modal" data-target="#gpoint_gift" class="listbtn"><i class="fas fa-gift"></i>포인트선물</a>
				</div>	
		    </div>
	    	<div id="Rpoint" class="tab-pane fade">	
	    		<i class="fa fa-sort-down"></i>						
				<div class="tabtitle">RPoint 선물하기</div>
				<div class="listbox gplist">
					<div class="listpoint"><small>P</small><span>1,000,000</span></div>
					<a type="button" data-toggle="modal" data-target="#rpoint_gift" class="listbtn"><i class="fas fa-gift"></i>포인트선물</a>
				</div>
	    	</div>
		</div>
	</section>
	<!-- content end -->
	<footer>
		<div>Copyrightⓒreturnp All rights reserved.</div>
		<div>
			<span><a type="button" data-toggle="modal" data-target="#myprivacy"><spring:message code="label.myPrivacy" /></a></span> 
			<span><a type="button" data-toggle="modal" data-target="#myterms"><spring:message code="label.myTerms" /></a></span> 
			<span><spring:message code="label.bizAddr" /></span> 
			<span>TEL : 02-888-8888</span> 
			<span>FAX : 02-888-8888</span>
		</div>
		<p>
<!-- 			<a class="btn-info" href="/company/customer_notice.do">공지사항</a>
			<a class="btn-info" href="/company/customer_help.do">회원문의</a> -->
		</p>
	</footer>	
	
 	<!-- privacy policy modal -->
	<jsp:include page="../company/m_privacypolicy.jsp" flush="false" />
	<!-- privacy policy modal end -->
	
	<!-- terms of ues modal -->
	<jsp:include page="../company/m_termsofuse.jsp" flush="false" />
	<!-- terms of ues modal end -->
	
	<!-- point gift modal -->
	<jsp:include page="./m_gpoint_gift.jsp" flush="false" />
	<jsp:include page="./m_rpoint_gift.jsp" flush="false" />
	<!-- point gift modal end -->
	
</body>
<!-- body end -->
</html>
