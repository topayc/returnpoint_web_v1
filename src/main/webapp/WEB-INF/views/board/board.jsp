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
<link rel="stylesheet" href="/resources/css/common.css">
<!-- js -->
<script src="/resources/js/lib/jquery.min.js"></script>
<script src="/resources/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/common.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var pageContextlocale = '${pageContext.response.locale}';
	$("#sel1").val(pageContextlocale);
});
</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_board">	
	<!-- nav -->
	<jsp:include page="/WEB-INF/views/common/topper.jsp" />
	<!-- nav -->
		<h4>Customer Center</h4>
	</header> 
	<!-- content begin -->
	<ul class="submenu pc">
		<li><a href="./faq.do">자주묻는질문</a></li>
		<li><a href="./notice.do">공지사항</a></li>
		<!-- <li><a href="./qna.do">일반상담</a></li>
		<li><a href="./qna_node.do">제휴상담</a></li> -->
	</ul> 
	<section>
		<div class="listS01">
			<div class="list_title"><i class="fas fa-pencil-alt"></i> 게시판 </div>		
			<a href="./faq.do"><div class="list_li">자주묻는질문<span><i class="fas fa-chevron-right"></i></span></div></a>
			<a href="./notice.do"><div class="list_li">공지사항<span><i class="fas fa-chevron-right"></i></span></div></a>
			<!-- 
			<a href="./qna.do"><div class="list_li">일반상담<span><i class="fas fa-chevron-right"></i></span></div></a>	
			<a href="./qna_node.do"><div class="list_li">제휴상담<span><i class="fas fa-chevron-right"></i></span></div></a> -->
			
			<div class="list_title"><i class="fas fa-user-shield"></i> 약관 및 정책 </div>		
			<div class="list_li" data-toggle="modal" data-target="#myterms">이용약관<span><i class="fas fa-chevron-right"></i></span></div>
			<div class="list_li" data-toggle="modal" data-target="#myprivacy">개인정보취급방침<span><i class="fas fa-chevron-right"></i></span></div> 

			<div class="list_title"><i class="fas fa-building"></i> 회사소개 </div>		
			<div class="list_li">상호 : (주) 탑해피월드</div> 		
			<div class="list_li">전화번호 : 02-585-2593</div>		
			<div class="list_li">팩스 : 02-585-2590</div>
			<div class="list_li">주소 : 서울특별시 서초구 사임당로 32 재우빌딩1층</div> 		
			<div class="list_li">사업자번호 : 754-86-01056</div> 		
		</div>
	</section>
	<!-- content end -->
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<!-- footer -->	
</div>
	<!-- privacy policy modal -->
	<jsp:include page="../company/m_privacypolicy.jsp" flush="false" />
	<!-- privacy policy modal end -->
	<!-- terms of ues modal -->
	<jsp:include page="../company/m_termsofuse.jsp" flush="false" />
	<!-- terms of ues modal end -->
</body>
<!-- body end -->
</html>