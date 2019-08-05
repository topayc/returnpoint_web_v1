<%@page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
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
         pointtranslimit      : pointtranslimit
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
   str = String(number);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
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

function rpointDetailView(f, searchtime){
   $("#GpointD").removeClass("fade in active");
   $("#GpointM").removeClass("fade in active");
   $("#RpointM").removeClass("active");
   $("#RpointD").addClass("active");
   var returnHtml         = "";
   var nodeType = f;
   var SEARCHTIME = searchtime;

   $.ajax({
      method : "POST",
      url    : "/m/mypage/pointConversionTransactionDetail.do?move="+SEARCHTIME,
      dataType: "json",
      data   : {
         nodeType      : nodeType,
         SEARCHTIME      : SEARCHTIME
      },
      success: function(data) {
            returnHtml += "<div class='pointdate'>"+"<a href='#' onclick=\"javascript:rpointDetailView('"+nodeType+"' , '"+data.PREWMONTH+"'    );\">"
            returnHtml += "<i class='fas fa-chevron-circle-left'></i> </a>"
            returnHtml +="<span>"+data.NOWMONTH+"</span>"
            returnHtml += "<a href='#' onclick=\"javascript:rpointDetailView('"+nodeType+"' , '"+data.NEXTMONTH+"'    );\">"
            returnHtml += "<i class='fas fa-chevron-circle-right'></i></a>"
            returnHtml +="</div>";

         for(i=0; i<data.json_arr.length; i++) {
            returnHtml += "<div class='listbox detail'><div class='listdate'><i class='far fa-clock'></i><span>"+data.json_arr[i].pointConversionTransactionDetailList[i].createTime+"</span></div>"
            returnHtml +="<div class='listmember'><span class='type node nd1'>"+data.json_arr[i].pointConversionTransactionDetailList[i].accumulate+"</span></div>"
            returnHtml +="<div class='listshop'>"+data.json_arr[i].pointConversionTransactionDetailList[i].companyname+"</div>"
            returnHtml +="<div class='listpoint'><small>P</small><span>"+data.json_arr[i].pointConversionTransactionDetailList[i].conversionTotalPoint+"</span></div>"
            returnHtml +="</div>";
         }
         $("#listboxdetailR").html(returnHtml);
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
      <h4><spring:message code="label.rpoint" /></h4>
   </header>
   <!-- content begin -->
   <section style="padding-top: 50px;">
      <div class="rp_total">
         <p><fmt:formatNumber value="${model.myRedPointSumInfo.redPointAmountSum}" pattern="###,###,###,###"/>P</p>
         <h6 style = "font-weight:600;">Total <spring:message code="label.gpoint" /></h6>
       </div>
      <div class="tab-content">
          <!-- 레드포인트 내역  -->
         <%--    <ul class="tabtitle">
               <li class="active"><a href="/m/mypage/newpay.do"><spring:message code="label.rPointconversionHistory" /></a></li>
               <li><a href="/m/mypage/pay_gift.do"><spring:message code="label.rPointPresents" /></a></li>
            </ul> --%>
            <div id="RpointM" class="tab-pane fade in active">
            <div class="listbox">
               <div class="listmember"><span class="node nd1"><spring:message code="label.member" /></span></div>
               <div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myRedPointSumMap.pointAmount}" pattern="###,###,###,###"/></span></div>
               <a type="button" class="listbtn" onclick="rpointDetailView('1', '');"><i class="fas fa-list"></i><spring:message code="label.detail_view" /> </a>
            </div>
          </div>
          <!-- 레드포인트  노드별 상세 내역   -->
          <div id="RpointD" class="tab-pane">
            <div id="listboxdetailR"></div>
          </div>
      </div>
   </section>
   <!-- content end -->
</div>
</body>
<!-- body end -->
</html>