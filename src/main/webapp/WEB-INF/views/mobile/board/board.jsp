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
<body class="p_board">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4><spring:message code="label.topper.menu.customer_center" /></h4>
	</header> 
	<!-- content begin -->
	<section>
		<div class="listS01">
			<div class="list_title"><i class="fas fa-pencil-alt"></i><spring:message code="label.board" /></div>		
			
			<!-- 자주 묻는 질문-->
			<div class="list_li" onclick = "movePage('/m/board/faq.do')">
				<span class= "item_title"><spring:message code="label.faq" /></span><i class="fas fa-chevron-right"></i> 
			</div>
			
			<!--공지 사항-->
			<div class="list_li" onclick = "movePage('/m/board/notice.do')">
				<span class= "item_title"><spring:message code="label.notice" /></span><span><i class="fas fa-chevron-right"></i></span> 
			</div>
			
			<!--일반 상담-->
			<div class="list_li" onclick = "movePage('/m/board/qna.do')">
				<span class= "item_title"><spring:message code="label.general_enquiries" /></span><span><i class="fas fa-chevron-right"></i></span> 
			</div>
			
			<!--제휴 상담-->
			<div class="list_li" onclick = "movePage('/m/board/qna_node.do')">
				<span class= "item_title"><spring:message code="label.affiliated_inquiry" /></span><span><i class="fas fa-chevron-right"></i></span> 
			</div>
			
			<div class="list_title"><i class="fas fa-user-shield"></i><spring:message code="label.terms_policy" /></div>		
			<!--이용 약관-->
			<div class="list_li" onclick = "movePage('/m/company/m_termsofuse.do')">
				<span class= "item_title"><spring:message code="label.terms_use" /></span><span><i class="fas fa-chevron-right"></i></span>
		    </div>
			
			<!--개인정보 취급 방침-->
			<div class="list_li" onclick = "movePage('/m/company/m_privacypolicy.do')">
				<span class= "item_title"><spring:message code="label.privacy_policy" /></span><span><i class="fas fa-chevron-right"></i></span>
			</div>
 
			<div class="list_title"><i class="fas fa-building"></i><spring:message code="label.returnp_company_overview" /></div>			
			<!--회사 소개-->
			<div class="list_li" onclick = "movePage('/m/company/company_identity.do')">
				<span class= "item_title"><spring:message code="label.company_overview" /></span><span><i class="fas fa-chevron-right"></i></span>
			</div>
			
			<!--서비스 소개-->
			<div class="list_li" onclick = "movePage('/m/company/service_member.do')">
				<span class= "item_title"><spring:message code="label.service_overview" /></span><span><i class="fas fa-chevron-right"></i></span>
			</div>
			
			<div class="list_li"><span class= "item_title"><spring:message code="label.biz_name" /> : (주) 탑해피월드</span> </div>
			<div class="list_li"><span class= "item_title"><spring:message code="label.phone_number" /> : 02-585-5993</span></div>		
			<div class="list_li"><span class= "item_title"><spring:message code="label.fax" /> : 02-585-2590</span></div>
			<div class="list_li"><span class= "item_title"><spring:message code="label.address" /> : 서울특별시 서초구 사임당로 32 재우빌딩1층</span></div> 		
			<div class="list_li"><span class= "item_title"><spring:message code="label.biz_number" /> : 754-86-01056</span></div> 		
		</div>
	</section>
	<!-- content end -->
</div>
</body>
<!-- body end -->
</html>