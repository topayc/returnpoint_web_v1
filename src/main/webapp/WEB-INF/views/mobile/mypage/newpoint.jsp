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
<script type="text/javascript" src="/resources/js/lib/jquery.min.js"></script>
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
	//$("#RpointM").removeClass("active");
	//$("#RpointD").addClass("active");
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
    if (typeof number == 'undefined') return;
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
function gpointDetailView(f, searchtime){
	$("#RpointD").removeClass("fade in active");
	$("#RpointM").removeClass("fade in active");
	$("#GpointM").removeClass("fade in active");
	$("#GpointD").addClass("fade in active");
	var returnHtml			= "";

	var nodeType = f;
	var SEARCHTIME = searchtime;
	$.ajax({
		method : "POST",
		url    : "/m/mypage/paymentPointbackRecordDetail.do?move="+SEARCHTIME,
		dataType: "json",
		data   : {
			nodeType		: nodeType,
			SEARCHTIME		: SEARCHTIME
		},
		success: function(data) {
			returnHtml += "<div class='pointdate'>"+"<a href='#' onclick=\"javascript:gpointDetailView('"+nodeType+"' , '"+data.PREWMONTH+"'    );\">"
			returnHtml += "<i class='fas fa-chevron-circle-left'></i> </a>"
			returnHtml +="<span>"+data.NOWMONTH+"</span>"
			returnHtml += "<a href='#' onclick=\"javascript:gpointDetailView('"+nodeType+"' , '"+data.NEXTMONTH+"'    );\">"
			returnHtml += "<i class='fas fa-chevron-circle-right'></i></a>"
			returnHtml +="</div>";
			for(i=0; i<data.json_arr.length; i++) {
				returnHtml +="<div class='listbox detail'>";
				if(data.json_arr[i].paymentPointbackRecordDetailList[i].nodeType == '1'){
					returnHtml +="<div class='listmember'><span class='type node nd1'>"+data.json_arr[i].paymentPointbackRecordDetailList[i].accumulate+"</span></div>"
					returnHtml +="<div class='listshop'>"+data.json_arr[i].paymentPointbackRecordDetailList[i].companyname+"</div>"
				}else if(data.json_arr[i].paymentPointbackRecordDetailList[i].nodeType == '2'){
					returnHtml +="<div class='listmember'><span class='type node nd2'>"+data.json_arr[i].paymentPointbackRecordDetailList[i].accumulate+"</span></div>"
					returnHtml +="<div class='listshop'>"+data.json_arr[i].paymentPointbackRecordDetailList[i].companyname+"</div>"
				}else if(data.json_arr[i].paymentPointbackRecordDetailList[i].nodeType == '3'){
					returnHtml +="<div class='listmember'><span class='type node nd6'>"+data.json_arr[i].paymentPointbackRecordDetailList[i].accumulate+"</span></div>"
					returnHtml +="<div class='listshop'>"+data.json_arr[i].paymentPointbackRecordDetailList[i].companyname+"</div>"
				}else if(data.json_arr[i].paymentPointbackRecordDetailList[i].nodeType == '4'){
					returnHtml +="<div class='listmember'><span class='type node nd5'>"+data.json_arr[i].paymentPointbackRecordDetailList[i].accumulate+"</span></div>"
					returnHtml +="<div class='listshop'>"+data.json_arr[i].paymentPointbackRecordDetailList[i].companyname+"</div>"
				}else if(data.json_arr[i].paymentPointbackRecordDetailList[i].nodeType == '5'){
					returnHtml +="<div class='listmember'><span class='type node nd4'>"+data.json_arr[i].paymentPointbackRecordDetailList[i].accumulate+"</span></div>"
					returnHtml +="<div class='listshop'>"+data.json_arr[i].paymentPointbackRecordDetailList[i].companyname+"</div>"
				}else if(data.json_arr[i].paymentPointbackRecordDetailList[i].nodeType == '6'){
					returnHtml +="<div class='listmember'><span class='type node nd3'>"+data.json_arr[i].paymentPointbackRecordDetailList[i].accumulate+"</span></div>"
					returnHtml +="<div class='listshop'>"+data.json_arr[i].paymentPointbackRecordDetailList[i].companyname+"</div>"
				}else{
					returnHtml +="<div class='listmember'><span class='type node nd7'>"+data.json_arr[i].paymentPointbackRecordDetailList[i].accumulate+"</span></div>"
					returnHtml +="<div class='listshop'>"+data.json_arr[i].paymentPointbackRecordDetailList[i].companyname+"</div>"
				}
				returnHtml +="<div class='listpoint'><small>P</small><span>"+data.json_arr[i].paymentPointbackRecordDetailList[i].pointbackAmount+"</span></div>"
				returnHtml +="</div>";
			}
			$("#listboxdetail").html(returnHtml);
		},
		error: function (request, status, error) {
			//location.reload();
			return false;
		}
	});
}

</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_point">
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4><spring:message code="label.gpoint" /></h4>
	</header>
	<!-- content begin -->
	<section style="padding-top: 50px;">
		<div class="rp_total">
	      <p><fmt:formatNumber value="${model.myGreenPointSumInfo.greenPointAmountSum}" pattern="###,###,###,###"/>P</p>
	      <h6>Total G-POINT</h6>
	    </div>
		<!-- 노드 타입에 따라 글자, 색상이 구분을 나옴, foreach문 처리 -->
		<!-- 1 회원 2 정회원 3 지사 4 대리점 5 협력업체 6 영업관리자 7 총판 -->
		<div class="tab-content">
		<!-- 그린포인트 노드별 포인트 합 -->
			<ul class="tabtitle">
				<li class="active"><a href="/m/mypage/newpoint.do"><spring:message code="label.gPointEarningHistory" /></a></li>
				<li><a href="/m/mypage/point_gift.do"><spring:message code="label.gPointPresents" /></a></li>
			</ul>
		    <div id="GpointM" class="tab-pane fade in active">
				<c:if test="${model.myGreenPointSumMap.memberPoint != null}">
				<div class="listbox">
					<div class="listmember"><span class="node nd1"><spring:message code="label.member" /></span></div>
					<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointSumMap.memberPoint}" pattern="###,###,###,###"/></span></div>
					<a type="button" class="listbtn" onclick="gpointDetailView('1', '');"><i class="fas fa-search"></i><spring:message code="label.detail_view" /> </a>
				</div>
				</c:if>
				<c:if test="${model.myGreenPointSumMap.recommenderPoint != null}">
				<div class="listbox">
					<div class="listmember"><span class="node nd2"><spring:message code="label.recommender" /></span></div>
					<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointSumMap.recommenderPoint}" pattern="###,###,###,###"/></span></div>
					<a type="button" class="listbtn" onclick="gpointDetailView('2', '');"><i class="fas fa-search"></i><spring:message code="label.detail_view" /> </a>
				</div>
				</c:if>
				<c:if test="${model.myGreenPointSumMap.saleManagerPoint != null}">
				<div class="listbox">
					<div class="listmember"><span class="node nd3"><spring:message code="label.saleManager" /></span></div>
					<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointSumMap.saleManagerPoint}" pattern="###,###,###,###"/></span></div>
					<a type="button" class="listbtn" onclick="gpointDetailView('6', '');"><i class="fas fa-search"></i><spring:message code="label.detail_view" /> </a>
				</div>
				</c:if>
				<c:if test="${model.myGreenPointSumMap.affiliatePoint != null}">
				<div class="listbox">
					<div class="listmember"><span class="node nd4"><spring:message code="label.affiliate" /></span></div>
					<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointSumMap.affiliatePoint}" pattern="###,###,###,###"/></span></div>
					<a type="button" class="listbtn" onclick="gpointDetailView('5', '');"><i class="fas fa-search"></i><spring:message code="label.detail_view" /> </a>
				</div>
				</c:if>
				<c:if test="${model.myGreenPointSumMap.agancyPoint != null}">
				<div class="listbox">
					<div class="listmember"><span class="node nd5"><spring:message code="label.agency" /></span></div>
					<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointSumMap.agancyPoint}" pattern="###,###,###,###"/></span></div>
					<a type="button" class="listbtn" onclick="gpointDetailView('4', '');"><i class="fas fa-search"></i><spring:message code="label.detail_view" /> </a>
				</div>
				</c:if>
				<c:if test="${model.myGreenPointSumMap.branchPoint != null}">
				<div class="listbox">
					<div class="listmember"><span class="node nd6"><spring:message code="label.branch" /></span></div>
					<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointSumMap.branchPoint}" pattern="###,###,###,###"/></span></div>
					<a type="button" class="listbtn" onclick="gpointDetailView('3', '');"><i class="fas fa-search"></i><spring:message code="label.detail_view" /></a>
				</div>
				</c:if>
				<c:if test="${model.myGreenPointSumMap.SoleDistPoint != null}">
				<div class="listbox">
					<div class="listmember"><span class="node nd7"><spring:message code="label.soleDist" /></span></div>
					<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointSumMap.SoleDistPoint}" pattern="###,###,###,###"/></span></div>
					<a type="button" class="listbtn" onclick="gpointDetailView('7', '');"><i class="fas fa-search"></i><spring:message code="label.detail_view" /></a>
				</div>
				</c:if>
		    </div>
		    <!-- 그린포인트  노드별 상세 내역   -->
		    <div id="GpointD" class="tab-pane ">
				<div id="listboxdetail"></div>
		    </div>
		</div>
	</section>
	<!-- content end -->
</div>
</body>
<!-- body end -->
</html>