<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="f" uri="/WEB-INF/tld/f.tld" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" /> <!-- <html>~</head>까지 -->
<!-- 완료 -->
<script type="text/javascript">
//목록으로
function moveList(){
	document.faqList.action = "/board/faq.do";
    document.faqList.submit();
}

</script>
<body>
<jsp:include page="/WEB-INF/views/common/topper.jsp" /> <!-- <nav>~</nav>까지 -->
<hr class="top_line">
<div class="container">
	<div class="faq_text1 faq_sub1">FAQ</div>
		<div class="faq_sub2">
		 	<span class="faq_text2">${faqContent.title}</span></span>
		</div>
		<div class="faq_sub3">
		 	<span class="faq_text3">${faqContent.content}</span></span>
		</div>
		<a href="#" onclick="moveList();"><button type="button" class="btn btn-primary faq_button">목록</button></a>
</div>
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp" /> <!-- <footer>~</footer>까지 -->
	<!-- footer -->
	<form id="faqList" name="faqList">
	    <input type="hidden" id="page" name="page" value="${params.page}"/>
	    <input type="hidden" id="upperPage" name="upperPage" value="${params.upperPage}"/>
	    <input type="hidden" id="recordPerPage" name="recordPerPage" value="${params.recordPerPage}"/>
	    <input type="hidden" id="bbsType2" name="bbsType2" value="${params.bbsType2}"/><!-- faq 뎁스 분류로 인해서 추가 -->
	</form>	
</body>
</html>