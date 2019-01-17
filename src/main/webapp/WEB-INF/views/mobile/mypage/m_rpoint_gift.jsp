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
	//red point 모달창 >> 페이지로 변경  company/m_rpoint_gift.jsp
	$("#redthousandwon").click(function() {
		$("#rPoint10").val(Number($("#rPoint10").val())+Number(1000));
	}); 
	$("#redtenthousandwon").click(function() {
		$("#rPoint10").val(Number($("#rPoint10").val())+Number(10000));
	});
	$("#redfiftythousandwon").click(function() {
		$("#rPoint10").val(Number($("#rPoint10").val())+Number(50000));
	});
	$("#redonehundredthousandwon").click(function() {
		$("#rPoint10").val(Number($("#rPoint10").val())+Number(100000));
	});
	//선물받은 회원 조회 유효성 초기화
	$("#redPointGiftMemberEmailOri10").val($("#redPointGiftMemberEmail10").val());
});
</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_terms">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4><spring:message code="label.pointRGift" /></h4>
	</header> 	
	<section>
		<div class="m_point_transfer">
			<form name="Frm2">				
				<div class="modal-body">
					<div class="listmember"><strong>R-PAY</strong></div>
					<div class="listpoint"><strong><small>P</small>&nbsp;<span><fmt:formatNumber value="${model.myRedPointInfo.pointAmount}" pattern="###,###,###,###"/></span></strong></div>
					<div class="pointinput">
						<div class="gift_user"><input type="text" id="redPointGiftMemberEmail10" name="redPointGiftMemberEmail10" placeholder="<spring:message code="label.mpointGiftMemberEnter"/>"><button type="button" onclick="searchPointGiftMemberEmail('10', 'rpoint_gift');"><spring:message code="label.msearch"/></button></div>
						<input type="hidden" name="redPointGiftMemberEmailOri10" id="redPointGiftMemberEmailOri10">
						<input type="number" placeholder="<spring:message code="label.pointGiftAmount"/>" id="rPoint10" name="rPoint10"  onblur="changeAttribute('rPoint10', 1, 'rpoint_gift');"/>			
						<button type="button" id="redthousandwon"><i class="fa fa-plus-circle"></i>1,000</button>
						<button type="button" id="redtenthousandwon"><i class="fa fa-plus-circle"></i>10,000</button>
						<button type="button" id="redfiftythousandwon"><i class="fa fa-plus-circle"></i>50,000</button>
						<button type="button" id="redonehundredthousandwon"><i class="fa fa-plus-circle"></i>100,000</button>			
					</div>
					<ul class="pointinfo">
						<li>- <spring:message code="label.mrpointSumTransforms"/> <strong><fmt:formatNumber value="${model.myRedPointInfo.pointAmount}" type="number"/> </strong>&nbsp;<spring:message code="label.mpoints"/></li>
						<li>- <spring:message code="label.mrpointMinTransforms"/> <strong><fmt:formatNumber value="${model.selectPolicyMap.rPointMovingMinLimit}" type="number"/></strong>&nbsp;<spring:message code="label.mpoints"/></li>
						<li>- <spring:message code="label.mrpointMaxTransforms"/> <strong><fmt:formatNumber value="${model.selectPolicyMap.rPointMovingMaxLimit}" type="number"/></strong>&nbsp;<spring:message code="label.mpoints"/></li>
					</ul>
				</div>
				<button type="button" class="btn btn-submit" onclick="redPointTransaction('10', '${model.myRedPointInfo.pointAmount}', '${model.myRedPointInfo.redPointNo}', 'rpoint_gift');"><spring:message code="label.mpointGiftSend"/></button>
			</form>	
		</div>
	</section>
	<input type="hidden" id="rPointMovingMinLimit" name="rPointMovingMinLimit"/>
	<input type="hidden" id="rPointMovingMaxLimit" name="rPointMovingMaxLimit"/>
</div>
</body>
<!-- body end -->
</html>