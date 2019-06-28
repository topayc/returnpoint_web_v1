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
<link rel="stylesheet" href="/resources/css/m_common.css">
<!-- js -->
<script type="text/javascript" src="/resources/js/lib/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/m_common.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
	});

</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_recommend">	
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<%-- <h4><spring:message code="label.gen_gift_qr_code"/></h4> --%>
		<h4><spring:message code="${model.pageTitleMessageId}"/></h4>
	</header> 
	<!-- content begin -->
	<section class="qr_gen_img_container"><!-- 0824 -->
	<c:choose>
		<c:when test="${model.result =='100'}">
		<div class="qrinfo" style ="margin-top:-170px">
			<div style = "margin-bottom:20px;margin-top:50px">
				<i class="fas fa-qrcode"></i>&nbsp
				<span style = "font-weight:400; font-size:15px;">
					<spring:message code="label.gen_qr_success"/>
				</span>
			</div>
			
			<div style = "margin-bottom:30px">
				<span style = "font-weight:400; font-size:16px;border-radius: 15px;background-color: #444444;padding: 5px;color : #ffffff;font-weight : bold;"><spring:message code="label.recommender"/></span> &nbsp;:&nbsp;  
				<span style = "font-weight:400; font-size:16px;"> ${model.memberInfo.memberName}</span>
			</div>
			
		<%-- 	<div style = "margin-bottom:30px">
				<span  style = "font-weight:400;font-size:11px"> ${model.qrPlainData}</span>
			</div> --%>
			<%-- <div style = "margin-bottom:30px">
				<span  style = "font-size:10px"> ${model.qrEncodeData}</span>
			</div> --%>
			<div class="qrimg" style ="width:70%;height:70%">
				<img style ="width:100%;height:100%" src="${model.qrAccessUrl}">
			</div> 
			<div style = "margin-top:50px">
				<span style = "font-weight:400; font-size:13px;color : #999999">
					<spring:message code="label.use_join_qr_code"/>
				</span>
			</div>
			
		</div>
		</c:when>

		<c:when test="${model.result =='101'}">
		<div>
			<i class="fas fa-exclamation-triangle"></i><spring:message code="label.preparing_service"/>
		</div>	
		</c:when>
		
		<c:when test="${model.result =='102'}">
		<div>
			<i class="fas fa-exclamation-triangle"></i><spring:message code="label.gen_qr_error"/>
		</div>
		</c:when>
		
		<c:otherwise>
		<div>
			<i style = "width:90%;height:90%"class="fas fa-exclamation-triangle"></i><spring:message code="label.gen_qr_error"/>
		</div>
		</c:otherwise>
	</c:choose>
		
	</section>
	<!-- content end -->
</body>
<!-- body end -->
</html>