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
	//var currentTime = new Date()
	//var year = currentTime.getFullYear()
	//var month = currentTime.getMonth() + 1
});
	
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
					policypoint += "<span>Green point <small>"+numberFormat(data.json_arr[i].pointTransLImit)+" 이상"+"</small></span>";
				}
				$("#policypointdiv").html(policypoint);
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
		return false;
	}
	if(Number(myPoint) == "0" || Number(myPoint) == null){
		alert("신청가능한 포인트를 확인해주세요.");
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
					location.replace("/mypage/newpoint.do");
				}
			},
			error: function (request, status, error) {
				alert("새로고침후 진행해주세요.");
				location.replace("/mypage/newpoint.do");
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
		<li class="active"><a href="./newpoint.do">포인트조회</a></li>
		<li><a href="./point_transfer.do">포인트전환</a></li>
		<li><a href="./point_gift.do">포인트선물</a></li> <!-- 0813 메뉴추가 -->	
	</ul>
	<section>
		<h4>포인트 조회</h4>
		<hr>		
		<div class="pointdate"><a href="#"> < </a><span>${model.serverDate}</span><a href="#" class="disable"> > </a></div>
		<ul>
			<a data-toggle="tab" href="#Gpoint"><li class="gpoint active"><p class="rpt">GPoint</p><p><fmt:formatNumber value="${model.myGreenPointSumInfo.greenPointAmountSum}" type="number"/></p></li></a>
			<a data-toggle="tab" href="#Rpoint"><li class="rpoint"><p class="gpt">RPoint</p><p>${model.myRedPointSumInfo.redPointAmountSum}</p></li></a>
		</ul>
		<!-- 노드 타입에 따라 글자, 색상이 구분을 나옴, foreach문 처리 -->
					<!-- 1 회원
					2 정회원
					3 지사
					4 대리점
					5 협력업체
					6 영업관리자
					7 총판 -->
		<div class="tab-content">
		    <div id="Gpoint" class="tab-pane fade in active">	
		    	<i class="fa fa-sort-down"></i>	  	
				<div class="tabtitle">GPoint 적립내역</div>
				<c:forEach var="item" items="${model.paymentPointbackRecordList}" varStatus="loop">
				<div class="listbox gplist">
					<c:if test="${item.nodeType == '1'}">
						<div class="listdate"><i class="far fa-clock"></i><span><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd"/></span></div>
						<div class="listmember"><span class="node nd1">회원</span><span class="type">구매적립</span></div>
						<div class="listshop">Return 가맹점</div>
						<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${item.pointbackAmount}" type="number"/></span></div>
					</c:if>
					<c:if test="${item.nodeType == '2'}">
						<div class="listdate"><i class="far fa-clock"></i><span><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd"/></span></div>
						<div class="listmember"><span class="node nd2">정회원</span><span class="type">구매적립</span></div>
						<div class="listshop">Return 가맹점</div>
						<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${item.pointbackAmount}" type="number"/></span></div>
					</c:if>
					<c:if test="${item.nodeType == '3'}">
						<div class="listdate"><i class="far fa-clock"></i><span><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd"/></span></div>
						<div class="listmember"><span class="node nd6">지사</span><span class="type">구매적립</span></div>
						<div class="listshop">Return 가맹점</div>
						<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${item.pointbackAmount}" type="number"/></span></div>
					</c:if>
					<c:if test="${item.nodeType == '4'}">
						<div class="listdate"><i class="far fa-clock"></i><span><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd"/></span></div>
						<div class="listmember"><span class="node nd5">대리점</span><span class="type">구매적립</span></div>
						<div class="listshop">Return 가맹점</div>
						<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${item.pointbackAmount}" type="number"/></span></div>
					</c:if>
					<c:if test="${item.nodeType == '5'}">
						<div class="listdate"><i class="far fa-clock"></i><span><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd"/></span></div>
						<div class="listmember"><span class="node nd4">협력업체</span><span class="type">구매적립</span></div>
						<div class="listshop">Return 가맹점</div>
						<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${item.pointbackAmount}" type="number"/></span></div>
					</c:if>
					<c:if test="${item.nodeType == '6'}">
						<div class="listdate"><i class="far fa-clock"></i><span><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd"/></span></div>
						<div class="listmember"><span class="node nd3">영업관리자</span><span class="type">구매적립</span></div>
						<div class="listshop">Return 가맹점</div>
						<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${item.pointbackAmount}" type="number"/></span></div>
					</c:if>
					<c:if test="${item.nodeType == '7'}">
						<div class="listdate"><i class="far fa-clock"></i><span><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd"/></span></div>
						<div class="listmember"><span class="node nd7">총판</span><span class="type">구매적립</span></div>
						<div class="listshop">Return 가맹점</div>
						<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${item.pointbackAmount}" type="number"/></span></div>
					</c:if>
				</div>	
				</c:forEach>
		    </div>
	    	<div id="Rpoint" class="tab-pane fade">	
	    		<i class="fa fa-sort-down"></i>		
				<ul>
					<li class="active"><a data-toggle="tab" href="#Rp_transfer">RPoint 전환내역</a></li>
					<li><a data-toggle="tab" href="#Rp_use">RPoint 사용내역</a></li>
				</ul>									
				<div class="tab-content">
					<div id="Rp_transfer" class="tab-pane fade in active">		
					<c:forEach var="item" items="${model.pointConversionTransactionList}" varStatus="loop">			 
						<c:if test="${item.nodeType == '1'}"> 
						<div class="listbox gplist">
							<div class="listdate"><i class="far fa-clock"></i><span><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd"/></span></div>
							<div class="listmember"><span class="node nd1">회원</span></div>
							<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${item.conversionTotalPoint}" type="number"/></span></div>
						</div>
						</c:if>
						<c:if test="${item.nodeType == '2'}"> 
						<div class="listbox gplist">
							<div class="listdate"><i class="far fa-clock"></i><span><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd"/></span></div>
							<div class="listmember"><span class="node nd2">정회원</span></div>
							<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${item.conversionTotalPoint}" type="number"/></span></div>
						</div>
						</c:if>
						<c:if test="${item.nodeType == '3'}"> 
						<div class="listbox gplist">
							<div class="listdate"><i class="far fa-clock"></i><span><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd"/></span></div>
							<div class="listmember"><span class="node nd6">지사</span></div>
							<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${item.conversionTotalPoint}" type="number"/></span></div>
						</div>
						</c:if>
						<c:if test="${item.nodeType == '4'}"> 
						<div class="listbox gplist">
							<div class="listdate"><i class="far fa-clock"></i><span><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd"/></span></div>
							<div class="listmember"><span class="node nd5">대리점</span></div>
							<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${item.conversionTotalPoint}" type="number"/></span></div>
						</div>
						</c:if>
						<c:if test="${item.nodeType == '5'}"> 
						<div class="listbox gplist">
							<div class="listdate"><i class="far fa-clock"></i><span><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd"/></span></div>
							<div class="listmember"><span class="node nd4">협력업체</span></div>
							<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${item.conversionTotalPoint}" type="number"/></span></div>
						</div>
						</c:if>
						<c:if test="${item.nodeType == '6'}"> 
						<div class="listbox gplist">
							<div class="listdate"><i class="far fa-clock"></i><span><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd"/></span></div>
							<div class="listmember"><span class="node nd3">영업관리자</span></div>
							<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${item.conversionTotalPoint}" type="number"/></span></div>
						</div>
						</c:if>
						<c:if test="${item.nodeType == '7'}"> 
						<div class="listbox gplist">
							<div class="listdate"><i class="far fa-clock"></i><span><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd"/></span></div>
							<div class="listmember"><span class="node nd7">총판</span></div>
							<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${item.conversionTotalPoint}" type="number"/></span></div>
						</div>
						</c:if>
					</c:forEach>	
						<!-- <div class="listbox gplist">
							<div class="listdate"><i class="far fa-clock"></i><span>2018.07.30</span></div>
							<div class="listmember"><span class="node nd1">회원</span></div>
							<div class="listpoint"><small>P</small><span>1,000</span></div>
						</div>
						<div class="listbox gplist">
							<div class="listdate"><i class="far fa-clock"></i><span>2018.07.30</span></div>
							<div class="listmember"><span class="node nd2">회원</span></div>
							<div class="listpoint"><small>P</small><span>23,000</span></div>
						</div>
						<div class="listbox gplist">
							<div class="listdate"><i class="far fa-clock"></i><span>2018.07.30</span></div>
							<div class="listmember"><span class="node nd3">영업관리자</span></div>
							<div class="listpoint"><small>P</small><span>50,000</span></div>
						</div>
						<div class="listbox gplist">
							<div class="listdate"><i class="far fa-clock"></i><span>2018.07.30</span></div>
							<div class="listmember"><span class="node nd4">회원</span></div>
							<div class="listpoint"><small>P</small><span>1,800</span></div>
						</div>	 -->		
					</div>
				  
					<div id="Rp_use" class="tab-pane fade">			  
						<div class="listbox gplist">
							<div class="listdate"><i class="far fa-clock"></i><span>2018.07.30</span></div>
							<div class="listshop">ReturnP 가맹점</div>
							<div class="listpoint"><small>P</small><span>1,000</span></div>
						</div>
						<div class="listbox gplist">
							<div class="listdate"><i class="far fa-clock"></i><span>2018.07.30</span></div>
							<div class="listshop">ReturnP 가맹점</div>
							<div class="listpoint"><small>P</small><span>23,000</span></div>
						</div>
						<div class="listbox gplist">
							<div class="listdate"><i class="far fa-clock"></i><span>2018.07.30</span></div>
							<div class="listshop">ReturnP 가맹점</div>
							<div class="listpoint"><small>P</small><span>50,000</span></div>
						</div>
						<div class="listbox gplist">
							<div class="listdate"><i class="far fa-clock"></i><span>2018.07.30</span></div>
							<div class="listshop">ReturnP 가맹점</div>
							<div class="listpoint"><small>P</small><span>1,800</span></div>
						</div>			
				 	</div>
				</div>  
	    	</div>
		</div>
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
	
</body>
<!-- body end -->
</html>