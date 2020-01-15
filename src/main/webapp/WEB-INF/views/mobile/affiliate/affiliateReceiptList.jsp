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
<script type="text/javascript" src="/resources/js/lib/m_point_gift.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var pageContextlocale = '${pageContext.response.locale}';
	$("#sel1").val(pageContextlocale);
	
	$(".reqeust_deposit_check").click(function(){
		var target = $(this);
		$.ajax({
	       	   type: "POST",
	              url: "/m/pointCoupon/checkDepositRequest.do",
	               data: {pointCodeIssueRequestNo : target.attr("requestNo")},
	               success: function (result) {
	            	  console.log(result);
	            	   if (result && typeof result !="undefined") {
	            	   		if (result.result.code == 0) {
								$(".requestNo_"+ target.attr("requestNo")).find(".depositStatus").text("입금확인요청중");
								$(".requestNo_"+ target.attr("requestNo")).find(".depositStatus").css("background-color","#BF00FF");
								target.remove();
							}
	            		   	alertOpen("알림", result.result.msg, true, false, null, null); 
		               }else{
		              		alertOpen("알림", "1.장애 발생. 다시 시도해주세요.", true, false, null, null);
		           	   }
	               },
	               error : function(request, status, error){
	            	   alertOpen("알림 ", "2.장애 발생. 다시 시도해주세요", true, false, null, null);
	               },
	               dataType: 'json'
	       });
	});
	
});

</script>
<style>
 * {font-weight:400}
</style>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_terms">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4>${affiliate.affiliateName}</h4>
	</header> 
	<section>
   </section>
     <div id = "progress_loading2">
		<img src="/resources/images/progress_loading.gif"/>
	</div>
</body>
<!-- body end -->
</html>