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
	selectPolicy(); //가격 정책 조회
	$("#thousandwon1").click(function() {
		$("#point1").val(Number($("#point1").val())+Number(1000));
	}); 
	$("#tenthousandwon1").click(function() {
		$("#point1").val(Number($("#point1").val())+Number(10000));
	});
	$("#fiftythousandwon1").click(function() {
		$("#point1").val(Number($("#point1").val())+Number(50000));
	});
	$("#onehundredthousandwon1").click(function() {
		$("#point1").val(Number($("#point1").val())+Number(100000));
	});
	//선물받은 회원 조회 유효성 초기화
	$("#redPointGiftMemberEmailOri1").val($("#redPointGiftMemberEmail1").val());
});

</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_terms">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4><spring:message code="label.pointGift" /></h4>
	</header> 	
	<section>
		<div class="m_point_transfer">
			<form name="Frm2">
				<div class="modal-body">
					<div class="listmember"><strong><span class="node nd1"><spring:message code="label.mmember"/>&nbsp;</span>R-POINT</strong></div>
					<div class="listpoint"><strong><small>P</small>&nbsp;<span><fmt:formatNumber value="${model.myGreenPointMap.memberPoint}" pattern="###,###,###,###"/></span></strong></div>
					<div class="pointinput">
						<div class="gift_user"><input type="text" id="redPointGiftMemberEmail1" name="redPointGiftMemberEmail1" placeholder="<spring:message code="label.mpointGiftMemberEnter"/>" onblur="changeAttribute('point1', 1);"/><button type="button" onclick="searchPointGiftMemberEmail('1', 'gpoint_gift');"><spring:message code="label.msearch"/></button></div>
						<input type="hidden" name="redPointGiftMemberEmailOri1" id="redPointGiftMemberEmailOri1">
						<input type="number" placeholder="<spring:message code="label.pointGiftAmount"/>" id="point1" name="point1" onblur="changeAttribute('point1', 1, 'gpoint_gift');"/>			
						<button type="button" id="thousandwon1"><i class="fa fa-plus-circle"></i>1,000</button>
						<button type="button" id="tenthousandwon1"><i class="fa fa-plus-circle"></i>10,000</button>
						<button type="button" id="fiftythousandwon1"><i class="fa fa-plus-circle"></i>50,000</button>
						<button type="button" id="onehundredthousandwon1"><i class="fa fa-plus-circle"></i>100,000</button>			
					</div>
					<ul class="pointinfo">
						<li>- <spring:message code="label.mmemberSumGpoint"/> <strong><fmt:formatNumber value="${model.myGreenPointSumInfo.greenPointAmountSum}" type="number"/></strong>&nbsp; <spring:message code="label.mpoints"/></li>
						<li>- <spring:message code="label.mgpointMinTransforms"/> <strong><fmt:formatNumber value="${model.selectPolicyMap.gPointMovingMinLimit}" type="number"/></strong> <spring:message code="label.mpoints"/></li>
						<li>- <spring:message code="label.mgpointMaxTransforms"/> <strong><fmt:formatNumber value="${model.selectPolicyMap.gPointMovingMaxLimit}" type="number"/></strong> <spring:message code="label.mpoints"/></li>
					</ul>
				</div>
				<button type="button" class="btn btn-submit"  onclick="greenPointTransaction('1', '${model.myGreenPointMap.memberPoint}', '${model.myGreenPointMap.member}' , '${model.myGreenPointMap.memberPointNo}', 'gpoint_gift');"><spring:message code="label.mpointGiftSend"/></button>
			</form>	
		</div>
	</section>	
	<input type="hidden" id="gPointMovingMinLimit" name="gPointMovingMinLimit"/>
	<input type="hidden" id="gPointMovingMaxLimit" name="gPointMovingMaxLimit"/>
</div>
</body>
<!-- body end -->
</html>