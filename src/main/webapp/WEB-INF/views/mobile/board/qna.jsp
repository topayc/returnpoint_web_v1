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
	var pageContextlocale = '${pageContext.response.locale}';
	$("#sel1").val(pageContextlocale);	
});
</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_qna">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4><spring:message code="label.general_enquiries" /></h4>
	</header> 
	<!-- content begin -->
	<section>
		<div class="listS01">			
			<div class="list_title"><i class="fas fa-pencil-alt"></i>&nbsp;<spring:message code="label.general_enquiries" /></div>			
			
		<c:choose>
			<c:when test="${! empty model.qnaList}">	
			<c:forEach var="list" items="${model.qnaList}" varStatus="loop">
			<div data-toggle="collapse" data-target="#faq_${list.boardNo}" class="list_li collapsed ellp">
				<small class="date"><i class="fas fa-calendar-alt"></i> ${list.createTime2}</small><small>${list.boardWriterName}</small><small>${list.boardName}</small>
				<span class="ellp">${list.boardTitle}</span>
				<c:choose>
				<c:when test="${list.anwboardContentCnt ne 0}">
				<small class="state_on"><spring:message code="label.answer_completed" /></small>
				</c:when>
				<c:otherwise>
				<small class="state_off"><spring:message code="label.answer_waiting" /></small>
				</c:otherwise>
				</c:choose>
			</div>
			<div id="faq_${list.boardNo}" class="list_toggle collapse">
				<p>${list.boardContent}</p>
				<c:choose>
				<c:when test="${list.answerContentCnt ne 0}">
				<p class="answer">
				<strong><i class="fas fa-angle-right"></i> <spring:message code="label.answer" /></strong>
				${f:decQuote(list.answerContent)}</p>
				</c:when>
				<c:otherwise>
				<p class="answer">
				<strong><i class="fas fa-angle-right"></i><spring:message code="label.answer" /></strong>
				<spring:message code="label.waiting" /></p>
				</c:otherwise>
				</c:choose>
			</div>
			<c:set var="qnacount" value="${loop.count}"/>
			</c:forEach>	
			</c:when>
			<c:otherwise>
			<div data-toggle="collapse" data-target="#faq1" class="list_li collapsed ellp">
				<span class="ellp"><spring:message code="label.no_post" /></span>
			</div>
			</c:otherwise>
			</c:choose>
			<!-- <button type="submit" class="btn btn-basic">더보기</button> -->
		</div>
		<button type="submit" class="btn btn-submit" onclick="location='/m/board/qna_w.do'"><spring:message code="label.write" /></button>  
	</section>
	<!-- content end -->
</div>
</body>
<!-- body end -->
</html>