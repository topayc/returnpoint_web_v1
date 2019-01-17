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
});
</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_recommend">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4><spring:message code="label.mypageMyMember" /></h4>
	</header> 
	<!-- content begin -->
	<section>
		<div class="listS01" id = "myMember_frame">
			<div class="list_title">
				<i class="fas fa-building"></i> <spring:message code="label.mypageTotalMemberCount" /> : ${model.myMemberListCount}
			</div>
			<c:if test = "${model.myMemberListCount == 0}" >
				<div class = "list_li" style = "display:flex">
					<spring:message code="label.mypageNoMember" />
				</div>
			</c:if>
			<c:forEach var="myMember" items="${model.myMemberList}">
				<div class = "list_li" style = "display:flex">
					<div style = "width:50%">${myMember.memberName}</div>
					<div style = "width:50%">${myMember.memberEmail} </div>
				</div>
			</c:forEach>
		</div>
	</section>		
	<!-- content end -->
</body>
<!-- body end -->
</html>