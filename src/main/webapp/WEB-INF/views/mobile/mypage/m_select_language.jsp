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
	$("#all_seelct").change(function(){
		if($(this).is(":checked")) {
			$("input[type=checkbox]").prop("checked", true);
		}else {
			$("input[type=checkbox]").prop("checked", false);
		}
	});
	
	$(".selectLang").click(function(){
		var lang = $(this).attr("langCode");
		changeLocalLang(lang.trim())
		//changeMobileLang(lang.trim());
	});
});
</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_recommend">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4><spring:message code="label.mypageSelectLanguage" /></h4>
	</header> 
	<!-- content begin -->
	<section>
		<div class="listS01" id = "myMember_frame">
			<div class="list_title">
				<i class="fas fa-globe-americas"></i> <spring:message code="label.mypageSelectLanguage" />
			</div>
				<c:forEach var = "language" items = "${model.languages}">
				<div class = "list_li" style = "display:flex">
					<div style = "width:5%"><i class="fas fa-angle-right"></i></div>
					<div class  = "selectLang"  langCode = "${language.languageCode}" style = "width:90%">${language.languageEnName} - ${language.languageOrgName}</div>
					<!-- 	<div style = "width:30%">영어</div> -->
				</div>
				</c:forEach>
			
			
		</div>
	</section>		
	<!-- content end -->
</body>
<!-- body end -->
</html>