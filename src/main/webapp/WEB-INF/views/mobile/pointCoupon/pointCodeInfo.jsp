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
<meta http-equiv="X-UA-Compatible" content="IE=edge"><!-- 0710 ie가 edge로 맞춰지는 메타 추가 -->
<meta name="format-detection" content="telephone=no"/><!-- 0710 edge상에서 전화번호 자동인식으로 인한 메타 추가 -->
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
	var pageContextlocale = '${pageContext.response.locale}';
	$("#sel1").val(pageContextlocale); 
	
/* 	var comma_separator_number_step = $.animateNumber.numberStepFactories.separator(',')
	var accCount = ${model.pointCode.accPointAmount};
	$('#accPoint').animateNumber(
		{ 
			number: accCount, 
			numberStep: comma_separator_number_step
		}); */
});

</script>
<style type="text/css">
.gift_qr_title{
	font-weight : bold
}
</style>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_qr">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4><spring:message code="label.point_coupon_detail" /></h4>
	</header> 
	<!-- content begin -->
	<c:choose>
	<c:when test="${model.result=='success'}">
	<section>
		<div class="page point qrinfo">
			<div class="listpoint" style = "margin-top:20px;">
				<span style = "font-weight: 500;font-size : 40px" id = "accPoint"> <fmt:formatNumber value="${model.pointCode.accPointAmount}" pattern="###,###,###,###"/></span>
				</br><!-- <span style = "font-size : 30px"><i class="fab fa-product-hunt"></i></span> -->
				<small style = "font-weight: bold; font-size : 13px">P</small>
				 
				 &nbsp;<span style = "font-size : 20px"><spring:message code="label.acc_word" /></span>
			</div>
			<ul class="pointinfo" style = "width: 80%;margin-top:70px">
				<input class = "returnp_point_code" type = "hidden"  id = "pointCode" value = "${model.pointCode.pointCode}"/>
				<li class = "gift_qr_title" style = "padding : 15px 0 ; border-top: none"><span  >적립 코드</span> ${model.pointCode.pointCode}</li>
				<li class = "gift_qr_title" style = "padding : 15px 0"><span  >결제 금액</span><fmt:formatNumber value="${model.pointCode.payAmount}" pattern="###,###,###,###"/> 원 </li>
				<li class = "gift_qr_title" style = "padding : 15px 0"><span  >적립율</span><fmt:formatNumber value="${model.pointCode.accPointRate * 100}" pattern="###,###,###,###"/>%</li>
				<li class = "gift_qr_title" style = "padding : 15px 0"><span  >적립 포인트</span><fmt:formatNumber value="${model.pointCode.accPointAmount}" pattern="###,###,###,###"/> P</li>
				<li class = "gift_qr_title" style = "padding : 15px 0"><span  >적립 타입</span>영수증 업로드 적립</li>
				<li class = "gift_qr_title" style = "padding : 15px 0"><span  >발급 시기</span>
					<fmt:parseDate value="${model.pointCode.createTime}" var="createTime" pattern="yyyy-MM-dd HH:mm:ss"/>
					<fmt:formatDate value="${createTime}" pattern="yyyy년 MM월 dd일 HH시 mm분"/> 
				</li>
			</ul>	
		</div>			
		<div class="btns2">
			<button type="button" class="btn btn-submit" onclick = "accPointCode()"><spring:message code="label.accumulate" /></button>
			<button type="button" class="btn btn-submit-cancel"  onclick = "history.back()"><spring:message code="label.cancel" /></button>
		</div>
	</section>
	    <div id = "progress_loading2">
		<img src="/resources/images/progress_loading.gif"/>
	</div>
	</c:when>
	<c:otherwise>
	<section class="qr_nodata"><!-- 0824 -->
		<div> 
			<i class="fas fa-exclamation-triangle" style = "font-size : 70px"></i>
			<span style = "font-size : 13px;">유효하지 않는 적립 코드 입니다 </span></br></br>
			<span style = "font-size : 14px; font-weight : 500;border-radius: 25px;border : 1px solid #888;padding:10px;margin-top:30px">${model.message}</span>
		</div>
		<button type="button" class="btn btn-submit"  onclick = "history.back()"><spring:message code="label.go_back" /></button>
	</section>	
	</c:otherwise>
	</c:choose>
	<!-- content end -->	
</div>

</body>
<!-- body end -->
</html>