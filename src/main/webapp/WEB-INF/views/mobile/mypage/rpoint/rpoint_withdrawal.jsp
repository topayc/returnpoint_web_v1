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
<script type="text/javascript" src="/resources/js/lib/jquery.animateNumber.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	var comma_separator_number_step = $.animateNumber.numberStepFactories.separator(',')
	var p1 = ${model.rPayInfo.pointAmount};
	$('#member_rpoint').animateNumber({
			number : p1,
			numberStep : comma_separator_number_step
		});
	
/* 	var p2 = ${model.rpayTotalWithdrawal};
	$('#today_withdrawal_rpoint').animateNumber({
			number : p2,
			numberStep : comma_separator_number_step
		});
	
	var p3 = ${model.policy.rPayWithdrawalMaxLimit - model.rpayTotalWithdrawal};
	$('#remain_today_withdrawal_rpoint').animateNumber({
			number : p3,
			numberStep : comma_separator_number_step
		}); */
	});
</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_recommend">	
	<!-- nav -->
	<jsp:include page="../../common/topper.jsp" />
	<!-- nav -->
		<h4>R 포인트 출금</h4>
	</header> 
	<!-- content begin -->
	<section>
		<div class="rpoint_withdrawal">
			<div>
				<div class="rpoint_withdrawal01">
					<ul>
						<li class = "sub">현재 보유 R 포인트</li>
						<li class = "title"><span id = "member_rpoint"></span> P</li>
					</ul>
				</div>
			</div>
			<div>
				<c:set var="now" value="<%=new java.util.Date()%>" />
				<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy년 MM월 dd일" /></c:set> 
				<div class="rpoint_withdrawal01">
					<ul>
						<li class = "sub">금일 총 출금 금액 (<c:out value="${sysYear}" />)</li>
						<li class = "title"><span id = "today_withdrawal_rpoint"><fmt:formatNumber value="${model.rpayTotalWithdrawal}" pattern="###,###,###,###"/></span> P</li>
					</ul>
				</div>
				<div class="rpoint_withdrawal02">
					<button onclick = "movePage('/m/mypage/m_rpay_withdrawal_list.do?memberNo=${model.memberTypeInfo.memberNo}')">출금 리스트</button>
				</div>
			</div>
			<div>
				<div class="rpoint_withdrawal01">
					<ul>
						<li class = "sub">금일 출금 잔여 가능 금액 (<c:out value="${sysYear}" />)</li>
						<li class = "title"><span id = "remain_today_withdrawal_rpoint"><fmt:formatNumber value="${model.policy.rPayWithdrawalMaxLimit - model.rpayTotalWithdrawal}" pattern="###,###,###,###"/></span> P</li>
					</ul>
				</div>
				<div class="rpoint_withdrawal02">
					<<!-- button>출금 리스트</button> -->
				</div>
			</div>
			<div class="rpoint_withdrawal03">
				<ul style = "padding-left:10px">
					<li style = "list-style-type: none">출금 정책</li>
					<li style = "list-style-type: disc;font-weight:300"><spring:message code="label.rpay_withdrawal_fee_policy" /></li>
					<li style = "list-style-type: disc;font-weight:300"><spring:message code="label.rpay_withdrawal_min_quide" arguments="${model.policy.rPayWithdrawalMinLimit}" /></li>
					<li style = "list-style-type: disc;font-weight:300"><spring:message code="label.rpay_withdrawal_max_quide" arguments="${model.policy.rPayWithdrawalMaxLimit}" /></li>
					<li style = "list-style-type: disc;font-weight:300"><spring:message code="label.rpay_withdrawal_max_quide" arguments="${model.policy.rPayWithdrawalMaxLimit}" /></li>
						<li style = "list-style-type: disc;font-weight:300"><spring:message code="label.rpay_withdrawal_day" /></li>
					<li style = "list-style-type: disc;font-weight:300">출금 정책은 예고없이 변경될 수 있습니다</li>
				</ul>
			</div>
			<div class="rpoint_withdrawal_button">
				<button onclick = "movePage('/m/mypage/m_rpay_withdrawal_list.do?memberNo=${model.memberTypeInfo.memberNo}')">출금 리스트</button>
				<button onclick = "movePage('/m/mypage/m_withdrawl_point_form.do')">출금 신청</button>
			</div>
		</div>
	</section>
	<!-- content end -->
</body>
<!-- body end -->
</html>