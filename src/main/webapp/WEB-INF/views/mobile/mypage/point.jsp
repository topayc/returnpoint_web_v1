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
<script src="/resources/js/lib/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/m_common.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var pageContextlocale = '${pageContext.response.locale}';
	$("#sel1").val(pageContextlocale); 
});
</script>
<script type="text/javascript">
$(document).ready(function(){
	selectPolicy();
});
	
function selectPolicy(){	
	var pointtranslimit = "";
	var policypoint = "";
	
	$.ajax({
		method : "POST",
		url    : "/m/member/policyPointTransLimit.do",
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
            //alert(message);
            alertOpen("확인", message, true, false, null, null);
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
		//alert("최소"+ pointtranslimit +" P부터 교환신청하실수 있습니다.");
		alertOpen("확인", "최소"+ pointtranslimit +" P부터 교환신청하실수 있습니다.", true, false, null, null);
		return false;
	}

	if(Number(pointTranVal) > Number(myPoint)){
		//alert("신청가능한 포인트를 확인해주세요.");
		alertOpen("확인", "신청가능한 포인트를 확인해주세요.", true, false, null, null);
		return false;
	}

	if(Number(myPoint) == "0" || Number(myPoint) == null){
		//alert("신청가능한 포인트를 확인해주세요.");
		alertOpen("확인", "신청가능한 포인트를 확인해주세요.", true, false, null, null);
		return false;
	}
	
	//if (confirm("포인트를 전환하시겠습니까?")) { 
		$.ajax({
			method : "POST",
			url    : "/m/mypage/pointTransactionAct.do",
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
					//alert("저장완료 하였습니다.");
					alertOpen("확인", "저장완료 하였습니다.", true, false, null, null);
					location.replace("/m/mypage/newpoint.do");
				}
			},
			error: function (request, status, error) {
				//alert("새로고침후 진행해주세요.");
				alertOpen("확인", "새로고침후 진행해주세요.", true, false, null, null);
				location.replace("/m/mypage/newpoint.do");
			}
		});
	//}
}

</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_point">	

	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4>Point info</h4>
	</header> 
	<!-- content begin -->
	<section>			
		<h4><spring:message code="label.mypointDesc01" /><span>${model.mypageMyinfo.memberEmail}</span></h4>
		<hr style="margin-bottom:70px;">
		<h4 class="redpoint">RED POINT <span><spring:message code="label.mypointDesc02" /></span></h4>
		<div class="txtbox redpoint">
			<spring:message code="label.sum"/><span>${model.myRedPointSumInfo.redPointAmountSum}</span> P
			<p><spring:message code="label.unit"/> : point</p>
		</div>
		<h4 class="graypoint"><spring:message code="label.transform"/> POINT <div id="policypointdiv"></div></h4>		
		<div class="txtbox graypoint">	
			<p><spring:message code="label.switchable"/> Green Point : <span><fmt:formatNumber value="${model.myGreenPointSumInfo.greenPointAmountSum}" type="number"/></span>P</p>	
			<form>
				<c:if test="${model.myGreenPointMap.memberPoint != null || model.myGreenPointMap.memberPoint > '0' }">
					<div class="form-group point">
					<label for="member"><spring:message code="label.mmember"/> Gpoint<span><fmt:formatNumber value="${model.myGreenPointMap.memberPoint}" type="number"/>p</span></label> <input type="number" class="form-control col-sm-2" id="point1" name="point1" onblur="changeAttribute('point1', 1);" />
					<div><button type="button" class="btn btn-basic" onclick="pointTransaction('1', '${model.myGreenPointMap.memberPoint}', '${model.myGreenPointMap.member}' , '${model.myGreenPointMap.memberPointNo}');"><spring:message code="label.mypointDesc05"/></button></div>
					</div>
				</c:if>
				<c:if test="${model.myGreenPointMap.recommenderPoint != null || model.myGreenPointMap.recommenderPoint > '0' }">
					<div class="form-group point">
					<label for="recommender"><spring:message code="label.mfullMembership"/> Gpoint<span><fmt:formatNumber value="${model.myGreenPointMap.recommenderPoint}" type="number"/>p</span></label> <input type="number" class="form-control col-sm-2" id="point2" name="point2" onblur="changeAttribute('point2', 1);" />
					<div><button type="button" class="btn btn-basic" onclick="pointTransaction('2', '${model.myGreenPointMap.recommenderPoint}', '${model.myGreenPointMap.recommender}', '${model.myGreenPointMap.recommenderPointNo}');"><spring:message code="label.mypointDesc05"/></button></div>
					</div>
				</c:if>
				<c:if test="${model.myGreenPointMap.branchPoint != null || model.myGreenPointMap.branchPoint > '0' }">
					<div class="form-group point">
					<label for="branch"><spring:message code="label.mbranch"/> Gpoint<span><fmt:formatNumber value="${model.myGreenPointMap.branchPoint}" type="number"/>p</span></label> <input type="number" class="form-control col-sm-2"  id="point3" name="point3" onblur="changeAttribute('point3', 1);" />
					<div><button type="button" class="btn btn-basic" onclick="pointTransaction('3', '${model.myGreenPointMap.branchPoint}', '${model.myGreenPointMap.branch}' , '${model.myGreenPointMap.branchPointNo}');"><spring:message code="label.mypointDesc05"/></button></div>
					</div>
				</c:if>
				<c:if test="${model.myGreenPointMap.agancyPoint != null || model.myGreenPointMap.agancyPoint > '0' }">
					<div class="form-group point">
					<label for="agancy"><spring:message code="label.magency"/> Gpoint<span><fmt:formatNumber value="${model.myGreenPointMap.agancyPoint}" type="number"/>p</span></label> <input type="number" class="form-control col-sm-2" id="point4" name="point4" onblur="changeAttribute('point4', 1);" />
					<div><button type="button" class="btn btn-basic" onclick="pointTransaction('4', '${model.myGreenPointMap.agancyPoint}', '${model.myGreenPointMap.agancy}', '${model.myGreenPointMap.agancyPointNo}');"><spring:message code="label.mypointDesc05"/></button></div>
					</div>
				</c:if>
				<c:if test="${model.myGreenPointMap.affiliatePoint != null || model.myGreenPointMap.affiliatePoint > '0' }">
					<div class="form-group point">
					<label for="affiliate"><spring:message code="label.mpartners"/> Gpoint<span><fmt:formatNumber value="${model.myGreenPointMap.affiliatePoint}" type="number"/>p</span></label> <input type="number" class="form-control col-sm-2" id="point5" name="point5" onblur="changeAttribute('point5', 1);" />
					<div><button type="button" class="btn btn-basic" onclick="pointTransaction('5', '${model.myGreenPointMap.affiliatePoint}', '${model.myGreenPointMap.affiliate}', '${model.myGreenPointMap.affiliatePointNo}');"><spring:message code="label.mypointDesc05"/></button></div>
					</div>
				</c:if>
				<c:if test="${model.myGreenPointMap.saleManagerPoint != null || model.myGreenPointMap.saleManagerPoint > '0' }">
					<div class="form-group point">
					<label for="saleManager"><spring:message code="label.msalesManager"/> Gpoint<span><fmt:formatNumber value="${model.myGreenPointMap.saleManagerPoint}" type="number"/>p</span></label> <input type="number" class="form-control col-sm-2" id="point6" name="point6" onblur="changeAttribute('point6', 1);" />
					<div><button type="button" class="btn btn-basic" onclick="pointTransaction('6', '${model.myGreenPointMap.saleManagerPoint}', '${model.myGreenPointMap.saleManager}', '${model.myGreenPointMap.saleManagerPointNo}');"><spring:message code="label.mypointDesc05"/></button></div>
					</div>
				</c:if>
				<c:if test="${model.myGreenPointMap.SoleDistPoint != null || model.myGreenPointMap.SoleDistPoint > '0' }">
					<div class="form-group point">
					<label for="SoleDist"><spring:message code="label.msoleDist"/> Gpoint<span><fmt:formatNumber value="${model.myGreenPointMap.SoleDistPoint}" type="number"/>p</span></label> <input type="number" class="form-control col-sm-2" id="point7" name="point7" onblur="changeAttribute('point7', 1);" />
					<div><button type="button" class="btn btn-basic" onclick="pointTransaction('7', '${model.myGreenPointMap.SoleDistPoint}', '${model.myGreenPointMap.SoleDist}', '${model.myGreenPointMap.SoleDistPointNo}');"><spring:message code="label.mypointDesc05"/></button></div>
					</div>
				</c:if>
			</form>
		</div>
		<input type="hidden" id="pointtranslimit" name="pointtranslimit"/>
		<h4 class="greenpoint">GREEN POINT</h4>
		<div class="txtbox greenpoint">		
			<spring:message code="label.sum"/> <span><fmt:formatNumber value="${model.myGreenPointSumInfo.greenPointAmountSum}" type="number"/></span> P
			<p><spring:message code="label.unit"/> : point</p>
		</div>
	</section>
	<!-- content end -->
</div>
</body>
<!-- body end -->
</html>