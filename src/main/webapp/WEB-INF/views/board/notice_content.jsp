<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="f" uri="/WEB-INF/tld/f.tld" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<body>
<jsp:include page="/WEB-INF/views/common/topper.jsp" />
<hr class="top_line">
<div class="container">
	<div class="faq_text1 faq_sub1">공지사항</div>
		<div class="faq_sub2">
		 	<span class="faq_text2">${noticeContent.title}</span>
		</div>
		<div class="faq_sub3">
		 	<span class="faq_text3">${noticeContent.content}</span>
		</div>
		<a href="#" onclick="moveNoticeList();"><button type="button" class="btn btn-primary faq_button">목록</button></a>
</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<form id="noticeList" name="noticeList">
	    <input type="hidden" id="page" name="page" value="${params.page}"/>
	    <input type="hidden" id="upperPage" name="upperPage" value="${params.upperPage}"/>
	    <input type="hidden" id="recordPerPage" name="recordPerPage" value="${params.recordPerPage}"/>
	</form>	
</body>
</html>