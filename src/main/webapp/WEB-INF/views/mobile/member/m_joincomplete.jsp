<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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
		
	afterJoinComplete();
});

/*회원 가입 후, 디바이스에 있는 추천인 관련 정보를 삭제*/
function afterJoinComplete(){
	bridge.afterJoinComplete(function(result){
	});
}
</script>
</head>
<!-- header end -->
<!-- body begin -->
<body>	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4><spring:message code="label.mcompletedMembership"/></h4>
	</header> 	
	<section>
		<div class="m_txtarea">
     	  <i class="fas fa-envelope-open"></i>
          <h3 class="modal-title"><spring:message code="label.msignUpIsComplete"/></h3>
 <%--          <p><spring:message code="label.mpleaseVerifyYourEmail"/><br />
          <spring:message code="label.mloginAndPointViewsAreAvailable"/></p> --%>
        </div>        
   		 <button type="button" class="btn btn-submit" onclick="location.href='/m/member/login.do'"><spring:message code="label.login"/></button>
     </section>	
</div>
</body>
<!-- body end -->
</html>

