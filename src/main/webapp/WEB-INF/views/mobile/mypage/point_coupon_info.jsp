<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
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
	$('header').remove();
});
</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_point">
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4> 포인트 쿠폰 코드</h4>
	</header>
	<!-- content begin -->
	<section style="">
		<div>
			<div class="point_coupon_info">
            <div>
               <ul>
                  <li>차미라님 적립 코드</li>
                  <li>200,000 P</li>
                  <li><img src="/resources/images/code.png">&nbsp;적립 코드 <span>AAAAAAAAAAAAAAAAA</span></li>
                  <li><img src="/resources/images/time.png">&nbsp;발급 일자 <span>2017-10-10 10:10:10</span></li>
                  <li><img src="/resources/images/money.png">&nbsp;기준 금액<span>10,000</span></li>
                  <li><img src="/resources/images/percent.png">&nbsp;적립율 <span>14%</span></li>
               </ul>
            </div>
         <ul>
            <li>- 고객센터 : 1234-5678</li>
         </ul>
      </div>
		</div>
	</section>
	<!-- content end -->
</div>
</body>
<!-- body end -->
</html>