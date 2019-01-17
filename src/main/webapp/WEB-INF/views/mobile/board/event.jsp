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
<body class="p_notice">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4>Notice</h4>
	</header> 
	<!-- content begin -->
	<section>
		<div class="listS01">
			<div class="list_title"><i class="fas fa-pencil-alt"></i> ReturnP 공지게시판입니다. </div>	
			<div id="table">		
				<div class="list_li ellp">
					<small><i class="fas fa-calendar-alt"></i> 2018-09-21</small>
					<span>Bitcaritas 코인 상장기념 이벤트</span> 
				</div>
				<div id="notice_12" class="list_toggle collapse in" style="padding: 24px;">
					안녕하세요<br />
					뉴드림 EX거래소 입니다.<br />
					비트카리타스 토큰을 9월 20일 상장예정입니다.<br />
					여러분의 많은 성원과 응원 부탁드립니다.<br />
					더불어 여러분을 위한 이벤트를 함께 마련 하였습니다.
					<img src="/resources/images/m_banner01.jpg" style="width:100%;margin-top:15px;border:1px solid #eee;" />
				</div> 						
			</div>	
		</div>
	</section>
	<!-- content end -->
</div>
</body>
<!-- body end -->
</html>