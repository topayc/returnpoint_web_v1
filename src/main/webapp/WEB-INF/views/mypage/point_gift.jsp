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
<link rel="stylesheet" href="/resources/css/common.css">
<!-- js -->
<script src="/resources/js/lib/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/point_gift.js"></script>
<script type="text/javascript" src="/resources/js/lib/common.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var pageContextlocale = '${pageContext.response.locale}';
	$("#sel1").val(pageContextlocale);  
});
</script>
<script type="text/javascript">
$(document).ready(function(){
	selectPolicy(); //가격 정책 조회
	//red point 모달창
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
	$("#redPointGiftMemberEmailOri1").val($("#redPointGiftMemberEmail1").val());
	$("#redPointGiftMemberEmailOri2").val($("#redPointGiftMemberEmail2").val());
	$("#redPointGiftMemberEmailOri3").val($("#redPointGiftMemberEmail3").val());
	$("#redPointGiftMemberEmailOri4").val($("#redPointGiftMemberEmail4").val());
	$("#redPointGiftMemberEmailOri5").val($("#redPointGiftMemberEmail5").val());
	$("#redPointGiftMemberEmailOri6").val($("#redPointGiftMemberEmail6").val());
	$("#redPointGiftMemberEmailOri7").val($("#redPointGiftMemberEmail7").val());
	
	//greed point 모달창
	//1
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
	
	//2
	$("#thousandwon2").click(function() {
		$("#point2").val(Number($("#point2").val())+Number(1000));
	}); 
	$("#tenthousandwon2").click(function() {
		$("#point2").val(Number($("#point2").val())+Number(10000));
	});
	$("#fiftythousandwon2").click(function() {
		$("#point2").val(Number($("#point2").val())+Number(50000));
	});
	$("#onehundredthousandwon2").click(function() {
		$("#point2").val(Number($("#point2").val())+Number(100000));
	});
	
	//3
	$("#thousandwon3").click(function() {
		$("#point3").val(Number($("#point3").val())+Number(1000));
	}); 
	$("#tenthousandwon3").click(function() {
		$("#point3").val(Number($("#point3").val())+Number(10000));
	});
	$("#fiftythousandwon3").click(function() {
		$("#point3").val(Number($("#point3").val())+Number(50000));
	});
	$("#onehundredthousandwon3").click(function() {
		$("#point3").val(Number($("#point3").val())+Number(100000));
	});
	
	//4
	$("#thousandwon4").click(function() {
		$("#point4").val(Number($("#point4").val())+Number(1000));
	}); 
	$("#tenthousandwon4").click(function() {
		$("#point4").val(Number($("#point4").val())+Number(10000));
	});
	$("#fiftythousandwon4").click(function() {
		$("#point4").val(Number($("#point4").val())+Number(50000));
	});
	$("#onehundredthousandwon4").click(function() {
		$("#point4").val(Number($("#point4").val())+Number(100000));
	});
	
	//5
	$("#thousandwon5").click(function() {
		$("#point5").val(Number($("#point5").val())+Number(1000));
	}); 
	$("#tenthousandwon5").click(function() {
		$("#point5").val(Number($("#point5").val())+Number(10000));
	});
	$("#fiftythousandwon5").click(function() {
		$("#point5").val(Number($("#point5").val())+Number(50000));
	});
	$("#onehundredthousandwon5").click(function() {
		$("#point5").val(Number($("#point5").val())+Number(100000));
	});
	
	//6
	$("#thousandwon6").click(function() {
		$("#point6").val(Number($("#point6").val())+Number(1000));
	}); 
	$("#tenthousandwon6").click(function() {
		$("#point6").val(Number($("#point6").val())+Number(10000));
	});
	$("#fiftythousandwon6").click(function() {
		$("#point6").val(Number($("#point6").val())+Number(50000));
	});
	$("#onehundredthousandwon6").click(function() {
		$("#point6").val(Number($("#point6").val())+Number(100000));
	});
	
	//7
	$("#thousandwon7").click(function() {
		$("#point7").val(Number($("#point7").val())+Number(1000));
	}); 
	$("#tenthousandwon7").click(function() {
		$("#point7").val(Number($("#point7").val())+Number(10000));
	});
	$("#fiftythousandwon7").click(function() {
		$("#point7").val(Number($("#point7").val())+Number(50000));
	});
	$("#onehundredthousandwon7").click(function() {
		$("#point7").val(Number($("#point7").val())+Number(100000));
	});
});
</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_point">	

	<!-- nav -->
	<jsp:include page="/WEB-INF/views/common/topper.jsp" />
	<!-- nav -->
		<h4>Point info</h4>
	</header> 
	<!-- content begin -->	
	<ul class="submenu">
		<li><a href="./newpoint.do"><spring:message code="label.pointinquiry"/></a></li>
		<!-- 포인트전환페이지 <li><a href="./point_transfer.do"><spring:message code="label.switchPoints"/></a></li> -->
		<li class="active"><a href="./point_gift.do"><spring:message code="label.pointGift"/></a></li>
	</ul>
	<section class="point_tarnsfer">
		<ul>
			<a data-toggle="tab" href="#Gpoint"><li class="gpoint active"><p class="rpt"><spring:message code="label.gPointPresents"/></p><p><fmt:formatNumber value="${model.myGreenPointSumInfo.greenPointAmountSum}" pattern="###,###,###,###"/></p></li></a>
			<a data-toggle="tab" href="#Rpoint"><li class="rpoint"><p class="gpt"><spring:message code="label.rPointPresents"/></p><p><fmt:formatNumber value="${model.myRedPointSumInfo.redPointAmountSum}" pattern="###,###,###,###"/></p></li></a>
		</ul>
		<div class="tab-content">
		    <div id="Gpoint" class="tab-pane fade in active">	
		    	<i class="fa fa-sort-down"></i>	  	
				<div class="tabtitle"><spring:message code="label.gPointPresents"/></div>
				
				<!-- 회원 -->
				<c:if test="${model.myGreenPointMap.memberPoint != null}">	
				<div class="listbox gplist">
					<div class="listmember"><span class="node nd1"><spring:message code="label.mmember"/></span>GPoint</div>
					<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointMap.memberPoint}" pattern="###,###,###,###"/></span></div>
					<a type="button" data-toggle="modal" data-target="#gpoint_gift" class="listbtn" onclick="resetGpointvalue('1');"><i class="fas fa-gift"></i><spring:message code="label.pointGift"/></a>
				</div>
				</c:if>
				
				<!-- 정회원 -->
				<c:if test="${model.myGreenPointMap.recommenderPoint != null}">
				<div class="listbox gplist">
					<div class="listmember"><span class="node nd2"><spring:message code="label.mfullMembership"/></span>GPoint</div>
					<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointMap.recommenderPoint}" pattern="###,###,###,###"/></span></div>
					<a type="button" data-toggle="modal" data-target="#gpoint_gift1" class="listbtn" onclick="resetGpointvalue('2');"><i class="fas fa-gift"></i><spring:message code="label.pointGift"/></a>
				</div>
				</c:if>
				
				<!-- 영업관리자 -->
				<c:if test="${model.myGreenPointMap.saleManagerPoint != null}">
				<div class="listbox gplist">
					<div class="listmember"><span class="node nd3"><spring:message code="label.msalesManager"/></span>GPoint</div>
					<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointMap.saleManagerPoint}" pattern="###,###,###,###"/></span></div>
					<a type="button" data-toggle="modal" data-target="#gpoint_gift2" class="listbtn" onclick="resetGpointvalue('6');"><i class="fas fa-gift"></i><spring:message code="label.pointGift"/></a>
				</div>
				</c:if>
				
				<!-- 협력업체 -->
				<c:if test="${model.myGreenPointMap.affiliatePoint != null}">
				<div class="listbox gplist">
					<div class="listmember"><span class="node nd4"><spring:message code="label.mpartners"/></span>GPoint</div>
					<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointMap.affiliatePoint}" pattern="###,###,###,###"/></span></div>
					<a type="button" data-toggle="modal" data-target="#gpoint_gift3" class="listbtn" onclick="resetGpointvalue('5');"><i class="fas fa-gift"></i><spring:message code="label.pointGift"/></a>
				</div>	
				</c:if>
				
				<!-- 대리점 -->
				<c:if test="${model.myGreenPointMap.agancyPoint != null}">
				<div class="listbox gplist">
					<div class="listmember"><span class="node nd5"><spring:message code="label.magency"/></span>GPoint</div>
					<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointMap.agancyPoint}" pattern="###,###,###,###"/></span></div>
					<a type="button" data-toggle="modal" data-target="#gpoint_gift4" class="listbtn" onclick="resetGpointvalue('4');"><i class="fas fa-gift"></i><spring:message code="label.pointGift"/></a>
				</div>
				</c:if>
				
				<!-- 지사 -->
				<c:if test="${model.myGreenPointMap.branchPoint != null}">
				<div class="listbox gplist">
					<div class="listmember"><span class="node nd6"><spring:message code="label.mbranch"/></span>GPoint</div>
					<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointMap.branchPoint}" pattern="###,###,###,###"/></span></div>
					<a type="button" data-toggle="modal" data-target="#gpoint_gift5" class="listbtn" onclick="resetGpointvalue('3');"><i class="fas fa-gift"></i><spring:message code="label.pointGift"/></a>
				</div>
				</c:if>
				
				<!-- 총판 -->
				<c:if test="${model.myGreenPointMap.SoleDistPoint != null}">
				<div class="listbox gplist">
					<div class="listmember"><span class="node nd7"><spring:message code="label.msoleDist"/></span>GPoint</div>
					<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointMap.SoleDistPoint}" pattern="###,###,###,###"/></span></div>
					<a type="button" data-toggle="modal" data-target="#gpoint_gift6" class="listbtn" onclick="resetGpointvalue('7');"><i class="fas fa-gift"></i><spring:message code="label.pointGift"/></a>
				</div>
				</c:if>
		    </div>
	    	<div id="Rpoint" class="tab-pane fade">	
	    		<i class="fa fa-sort-down"></i>						
				<div class="tabtitle"><spring:message code="label.rPointPresents"/></div>
				<div class="listbox gplist">
					<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myRedPointSumInfo.redPointAmountSum}" pattern="###,###,###,###"/></span></div>
					<a type="button" data-toggle="modal" data-target="#rpoint_gift" class="listbtn" onclick="resetRpointvalue('10');"><i class="fas fa-gift"></i><spring:message code="label.pointGift"/></a>
				</div>
	    	</div>
		</div>
		<input type="hidden" id="rPointMovingMinLimit" name="rPointMovingMinLimit"/>
		<input type="hidden" id="rPointMovingMaxLimit" name="rPointMovingMaxLimit"/>
		<input type="hidden" id="gPointMovingMinLimit" name="gPointMovingMinLimit"/>
		<input type="hidden" id="gPointMovingMaxLimit" name="gPointMovingMaxLimit"/>
	</section>
	<!-- content end -->
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<!-- footer -->
</div>  
 	<!-- privacy policy modal -->
	<jsp:include page="../company/m_privacypolicy.jsp" flush="false" />
	<!-- privacy policy modal end -->
	<!-- terms of ues modal -->
	<jsp:include page="../company/m_termsofuse.jsp" flush="false" />
	<!-- terms of ues modal end -->
	<!-- point gift modal -->
	<jsp:include page="../mypage/m_gpoint_gift.jsp" flush="false" />
	<jsp:include page="../mypage/m_gpoint_gift1.jsp" flush="false" />
	<jsp:include page="../mypage/m_gpoint_gift2.jsp" flush="false" />
	<jsp:include page="../mypage/m_gpoint_gift3.jsp" flush="false" />
	<jsp:include page="../mypage/m_gpoint_gift4.jsp" flush="false" />
	<jsp:include page="../mypage/m_gpoint_gift5.jsp" flush="false" />
	<jsp:include page="../mypage/m_gpoint_gift6.jsp" flush="false" />
	<jsp:include page="../mypage/m_rpoint_gift.jsp" flush="false" />
	<!-- point gift modal end -->
</body>
<!-- body end -->
</html>