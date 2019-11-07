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
	/* $("#couponNumber").val(""); */
});


function checkPointCoupon(){
	var number = $('#couponNumber').val().trim();
	if (number.length == 0 ){
		alertOpen("알림", "포인트 적립 코드를 입력해주세요", true, false, null, null);
		return;
	}
	location.href = "/m/coupon/detail_point_coupon_info.do?couponNumber=" + number;
}
</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_terms">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4><spring:message code="label.topper.menu.reg_point_coupon" /></h4>
	</header> 	
	<section>
		<div class="m_point_transfer">
			<form name="Frm2">
				<div class="modal-body">
					<div class="listmember" style = "font-size : 18px;margin-bottom:20px;">
						<strong style = "font_size : 45px;"><spring:message code="label.point_coupon_input2" /></strong>
					</div>
					<div class="pointinput" style = "width: 90%;">
						<div class="">
							<input  type="text" id="couponNumber" name="couponNumber" style = "background-color : #fefefe;font-size : 15px" placeholder = "<spring:message code="label.point_coupon_input"/>">			
					</div>
					<ul class="pointinfo">
						<li style = "list-style-type: disc">한번 사용하신 적립코드는 재 사용이 불가능합니다.</li>
						<li style = "list-style-type: disc">고객센터 : 02-585-5993</li>
					</ul>
				</div>
				<button type="button" id = "chkCoupon" class="btn btn-submit" onclick = "checkPointCoupon()"><spring:message code="label.ok"/></button>
			</form>	
		</div>
	</section>	
</div>
</body>
<!-- body end -->
</html>