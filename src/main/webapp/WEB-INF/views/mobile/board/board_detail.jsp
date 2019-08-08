<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="com.returnp_web.utils.SessionManager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ taglib prefix="f" uri="/WEB-INF/tld/f.tld" %>
<% pageContext.setAttribute("LF", "\n"); %>
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
<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
});
</script>

</script>	
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_mypage">
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4>${model.mainBbs.title}</h4>
	</header> 
	<!-- content begin -->	
		<section>
		<div class="listS02">
			<div class="list_title"><!-- <i class="fas fa-comment-dots">&nbsp;</i> --><%-- <spring:message code="label.answer" /> --%> 
				<span style = "color : #555">
					<fmt:parseDate value="${model.detailTargetBbs.createTime}" var="noticePostDate" pattern="yyyy-MM-dd "/>
					<fmt:formatDate value="${noticePostDate}" pattern="yyyy-MM-dd"/>
					</span>
				</div>
			<div class="list_li" style = "border : none" >
				<span class ="item_title">
					<c:set var = "content" value ="${fn:replace(model.detailTargetBbs.content, LF, '<br>')}"/>
					${f:decQuote(content)}
				</span>
			</div>

		</div>
	</section>
	<!-- content end -->
</div>	
</body>
<!-- body end -->
</html>