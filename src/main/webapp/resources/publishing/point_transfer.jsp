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
<script type="text/javascript">
$(document).ready(function(){
	selectPolicy();
	/* for(var i=1; i < 8; i++){ 
		$("#point"+i).val(Number($("#point"+i).val())+Number(1000));
	} */
	//모달 창여러개에서 할지, 하나의 창에서 none, block를 처리할지 추후 결정 필요
	//아래처럼 길게 않하려면 모달창이 컨트롤 되어야 하는데 안될경우 팝업 형식, 레이어형식으로 하는게 소스가 간결해질듯
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
	
function resetvalue(postfixId){
	$('#point'+postfixId).val('');
}	
	
function selectPolicy(){	
	var pointtranslimit = "";
	var policypoint = "";
	
	$.ajax({
		method : "POST",
		url    : "/member/policyPointTransLimit.do",
		dataType: "json",
		data   : {
			pointtranslimit		: pointtranslimit
		},
	
		success: function(data) {
			if (data.json_arr.length > 0) {
				for (var i=0; i<data.json_arr.length; i++) {
					$('#pointtranslimit').val(data.json_arr[i].pointTransLImit);
					//policypoint += "<span>Green point <small>"+numberFormat(data.json_arr[i].pointTransLImit)+" 이상"+"</small></span>";
					policypoint += "- "+numberFormat(data.json_arr[i].pointTransLImit)+" 이상의 GPoint만 전환 가능합니다.";
				} 
				//$("#policypointdiv").html(policypoint);
				$("#policypointli").html(policypoint);
			}
		},
		error: function (request, status, error) {
			//alert(request.responseText);
			//location.reload();
			return false;
		}
	});
}
//천단위 콤마 처리
function numberFormat(number) {
    var string = number.toString();
    var length = string.length;
    var standard = (length % 3 === 0) ? 3 : length % 3;
    var arr = [];
    var start = 0;
    while(true){
    	var temp = string.substr(start, standard);
        if (temp === "") break;
        arr.push(temp);
        start = start + standard;
        standard = 3;
    }
    
    var result = arr.join(",");
    return result;
}
function regExpCheck(str, pattern){
    var pattern1 = "[^-0-9 ]";  
    var rxSplit;
    switch (pattern) {
    case 1:
        rxSplit = new RegExp(pattern1);
        break;
    }
	if (rxSplit.test(str)) {return false;} else {return true;}
}
function changeAttribute(attribute, pattern){
	var message = "숫자만 입력가능합니다.";
    /* 
        1 = 숫자만
    */      
    if(!regExpCheck(document.getElementById(attribute).value, pattern)){
    	//if (message != ''){
            alert(message);
        //}
        document.getElementById(attribute).value = "";
        document.getElementById(attribute).focus();
        return;
    }
}
//포인트 전환
function pointTransaction(postfixId, myPoint, requestNodeTypeName, greenPointNo){
	var pointTranVal = $('#point'+postfixId).val();
	var pointtranslimit = $('#pointtranslimit').val();
	//입력된 값이 숫자가 아니거나 마이너스이면 금액을 0으로 셋팅.
	if(isNaN(pointTranVal) || pointTranVal < 0 || pointTranVal=='') pointTranVal=0;
	pointTranVal = new Number(pointTranVal);
		//보유하고 있는 금액보다 크면 보유하고 있는 금액으로 셋팅
		if(Number(pointTranVal) > Number(myPoint)) changeValue = Number(myPoint);
		$('#point'+postfixId).val(pointTranVal); //재계산 후 입력   
		
	if(pointtranslimit > pointTranVal) { 
		alert("최소"+ pointtranslimit +" P부터 교환신청하실수 있습니다.");
		return false;
	}
	if(Number(pointTranVal) > Number(myPoint)){
		alert("신청가능한 포인트를 확인해주세요.");
		$('#point'+postfixId).val('');
		return false;
	}
	if(Number(myPoint) == "0" || Number(myPoint) == null){
		alert("신청가능한 포인트를 확인해주세요.");
		$('#point'+postfixId).val('');
		return false;
	}
	
	if (confirm("포인트를 전환하시겠습니까?")) {
		$.ajax({
			method : "POST",
			url    : "/mypage/pointTransactionAct.do",
			dataType: "json",
			data   : {
				nodeType				: postfixId , //nodeType
				convertPointAmount		: pointTranVal , //convertPointAmount
				requestNodeTypeName 	: requestNodeTypeName, //requestNodeTypeName
				greenPointNo			: greenPointNo, //greenPointNo
				myPoint					: Number(myPoint)
			},
			success: function(data) {
				if (data.result.code == 0 ) {
					alert("저장완료 하였습니다.");
					location.replace("/mypage/point_transfer.do");
				}
			},
			error: function (request, status, error) {
				alert("잠시후 진행해주시길 바랍니다.");
				location.replace("/mypage/point_transfer.do");
			}
		});
	}
}
</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_point">	
	<header>
		<nav>
			<div class="group_wrap">
				<div class="nav-brand">
					<a href="../main/index.do"><img src="/resources/images/logo.png" /></a>
				</div>
				<ul>
					<li><a href="/company/service_member.do"><i class="fas fa-sort-down"></i><spring:message code="label.serviceMember" /></li>
					<li><a href="/company/company_identity.do"><i class="fas fa-sort-down"></i><spring:message code="label.companyInfo" /></a></li>
					<c:choose>
				<c:when test="${(sessionScope.memberEmail == null) || (sessionScope.memberEmail == '')}">					
					<li><a href="/member/login.do"><i class="fas fa-sort-down"></i><spring:message code="label.pointInfo" /></a></li>
				</c:when>			
				<c:otherwise>		
					<li><a href="/mypage/newpoint.do"><i class="fas fa-sort-down"></i><spring:message code="label.pointInfo" /></a></li>
				</c:otherwise>
				</c:choose> 
					<!-- <li><a href="./customer_notice.do"><i class="fas fa-sort-down"></i>고객센터</a></li> -->
					<!-- 로그인 전  -->
				<c:choose>
				<c:when test="${(sessionScope.memberEmail == null) || (sessionScope.memberEmail == '')}">
					<li class="member form-login-in"><a href="/member/login.do"><i class="fas fa-sign-in-alt"></i> <spring:message code="login.form.submit" /></a></li>
					<li class="member form-login-in"><a href="/member/join.do"><i class="fas fa-user"></i> <spring:message code="label.join" /></a></li>
				</c:when>
				<c:otherwise>
					<li class="member form-login-out" id="login-out"><a href="/member/logout.do"><i class="fas fa-sign-out-alt"></i> <spring:message code="label.logout" /></a></li>    
					<li class="member form-login-out"><a href="/mypage/mypage_myinfo.do"><i class="fas fa-user"></i> <spring:message code="label.myPage" /></a></li>
				</c:otherwise>
				</c:choose> 
				</ul>
			</div>
		</nav>
		<h4>Point info</h4>
	</header>
	<!-- content begin -->	
	<ul class="submenu">
		<li><a href="./newpoint.do">포인트조회</a></li>
		<li class="active"><a href="./point_transfer.do">포인트전환</a></li>
		<li><a href="./point_gift.do">포인트선물</a></li> <!-- 0813 메뉴추가 -->	
	</ul>
	<section class="point_tarnsfer">
	
		<h4>포인트 전환<span>* RPoint로 전환 가능한 총 GPoint는 <fmt:formatNumber value="${model.myGreenPointSumInfo.greenPointAmountSum}" type="number"/>P입니다.</span></h4>
		<hr>

		<!-- 회원 -->
		<c:if test="${model.myGreenPointMap.memberPoint != null}">					
		<div class="listbox gplist">
			<div class="listmember"><span class="node nd1">회원</span>GPoint</div>
			<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointMap.memberPoint}" type="number"/></span></div>
			<a type="button" data-toggle="modal" data-target="#point_transfer" class="listbtn" onclick="resetvalue('1');"><i class="fas fa-exchange-alt"></i>포인트전환</a>
		</div>
		</c:if>
				
		<!-- 정회원 -->
		<%-- <fmt:formatNumber var="recommenderPoint" value="${model.myGreenPointMap.recommenderPoint}" type="number"/> --%>
		<c:if test="${model.myGreenPointMap.recommenderPoint != null}">
		<div class="listbox gplist">
			<div class="listmember"><span class="node nd2">정회원</span>GPoint</div>
			<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointMap.recommenderPoint}" type="number"/></span></div>
			<a type="button" data-toggle="modal" data-target="#point_transfer1" class="listbtn" onclick="resetvalue('2');"><i class="fas fa-exchange-alt"></i>포인트전환</a>
		</div>
		</c:if>
				
		<!-- 영업관리자 -->
		<c:if test="${model.myGreenPointMap.saleManagerPoint != null}">
		<div class="listbox gplist">
			<div class="listmember"><span class="node nd3">영업관리자</span>GPoint</div>
			<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointMap.saleManagerPoint}" type="number"/></span></div>
			<a type="button" data-toggle="modal" data-target="#point_transfer2" class="listbtn" onclick="resetvalue('6');"><i class="fas fa-exchange-alt"></i>포인트전환</a>
		</div>
		</c:if>
		
		<!-- 협력업체 -->
		<c:if test="${model.myGreenPointMap.affiliatePoint != null}">
		<div class="listbox gplist">
			<div class="listmember"><span class="node nd4">협력업체</span>GPoint</div>
			<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointMap.affiliatePoint}" type="number"/></span></div>
			<a type="button" data-toggle="modal" data-target="#point_transfer3" class="listbtn" onclick="resetvalue('5');"><i class="fas fa-exchange-alt"></i>포인트전환</a>
		</div>	
		</c:if>
		
		<!-- 대리점 -->
		<c:if test="${model.myGreenPointMap.agancyPoint != null}">
		<div class="listbox gplist">
			<div class="listmember"><span class="node nd5">대리점</span>GPoint</div>
			<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointMap.agancyPoint}" type="number"/></span></div>
			<a type="button" data-toggle="modal" data-target="#point_transfer4" class="listbtn" onclick="resetvalue('4');"><i class="fas fa-exchange-alt"></i>포인트전환</a>
		</div>	
		</c:if>
		
		<!-- 지사 -->
		<c:if test="${model.myGreenPointMap.branchPoint != null}">
		<div class="listbox gplist">
			<div class="listmember"><span class="node nd6">지사</span>GPoint</div>
			<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointMap.branchPoint}" type="number"/></span></div>
			<a type="button" data-toggle="modal" data-target="#point_transfer5" class="listbtn" onclick="resetvalue('3');"><i class="fas fa-exchange-alt"></i>포인트전환</a>
		</div>	
		</c:if>
		
		<!-- 총판 -->
		<c:if test="${model.myGreenPointMap.SoleDistPoint != null}">
		<div class="listbox gplist">
			<div class="listmember"><span class="node nd7">총판</span>GPoint</div>
			<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointMap.SoleDistPoint}" type="number"/></span></div>
			<a type="button" data-toggle="modal" data-target="#point_transfer6" class="listbtn" onclick="resetvalue('7');"><i class="fas fa-exchange-alt"></i>포인트전환</a>
		</div>	
		</c:if>
		<input type="hidden" id="pointtranslimit" name="pointtranslimit"/>
	</section>
	<!-- content end -->
	<footer>
		<div>Copyrightⓒreturnp All rights reserved.</div>
		<div>
			<span><a type="button" data-toggle="modal" data-target="#myprivacy"><spring:message code="label.myPrivacy" /></a></span> 
			<span><a type="button" data-toggle="modal" data-target="#myterms"><spring:message code="label.myTerms" /></a></span> 
			<span><spring:message code="label.bizAddr" /></span> 
			<span>TEL : 02-888-8888</span> 
			<span>FAX : 02-888-8888</span>
		</div>
		<p>
<!-- 			<a class="btn-info" href="/company/customer_notice.do">공지사항</a>
			<a class="btn-info" href="/company/customer_help.do">회원문의</a> -->
		</p>
	</footer>	
	
 	<!-- privacy policy modal -->
	<jsp:include page="../company/m_privacypolicy.jsp" flush="false" />
	<!-- privacy policy modal end -->
	
	<!-- terms of ues modal -->
	<jsp:include page="../company/m_termsofuse.jsp" flush="false" />
	<!-- terms of ues modal end -->
	
	<!-- 부득이하게 7개 생성, 일정이 급하여 만들고 추후 수정예정 -->
	<!-- point transfer modal -->
	<jsp:include page="./m_point_transfer.jsp" flush="false" />
	<jsp:include page="./m_point_transfer1.jsp" flush="false" />
	<jsp:include page="./m_point_transfer2.jsp" flush="false" />
	<jsp:include page="./m_point_transfer3.jsp" flush="false" />
	<jsp:include page="./m_point_transfer4.jsp" flush="false" />
	<jsp:include page="./m_point_transfer5.jsp" flush="false" />
	<jsp:include page="./m_point_transfer6.jsp" flush="false" />
	
	<!-- terms of ues modal end -->
	
</body>
<!-- body end -->
</html>