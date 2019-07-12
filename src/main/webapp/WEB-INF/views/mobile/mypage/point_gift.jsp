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
//red point gift 페이지로 이동
function resetRpointvalue(){
   location.replace("/m/mypage/m_rpoint_gift.do");
}

//green point reset
function resetGpointvalue(postfixId){
   if(postfixId == "1"){ //회원
      location.replace("/m/mypage/m_gpoint_gift.do");
   }else if(postfixId == "2"){ //정회원
      location.replace("/m/mypage/m_gpoint_gift1.do");
   }else if(postfixId == "3"){ //지사
      location.replace("/m/mypage/m_gpoint_gift5.do");
   }else if(postfixId == "4"){ //대리점
      location.replace("/m/mypage/m_gpoint_gift4.do");
   }else if(postfixId == "5"){ //협력업체
      location.replace("/m/mypage/m_gpoint_gift3.do");
   }else if(postfixId == "6"){ //영업관리자
      location.replace("/m/mypage/m_gpoint_gift2.do");
   }else if(postfixId == "7"){ //총판
      location.replace("/m/mypage/m_gpoint_gift6.do");
   }
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
   <section class="point_tarnsfer" style="padding-top: 50px;">
		<div class="rp_total">
	      <p><fmt:formatNumber value="${model.myGreenPointSumInfo.greenPointAmountSum}" pattern="###,###,###,###"/>P</p>
	      <h6>Total <spring:message code="label.gpoint"/></h6>
	    </div>
      <div class="tab-content">      
      		<ul class="tabtitle">
				<li><a href="/m/mypage/newpoint.do"><spring:message code="label.gpoint"/> 적립내역</a></li>
				<li class="active"><a href="/m/mypage/point_gift.do"><spring:message code="label.gpoint"/> 선물하기</a></li>
			</ul>		
			
          <div id="Gpoint" class="tab-pane fade in active">               
            <!-- 회원 -->
            <c:if test="${model.myGreenPointMap.memberPoint != null}">   
            <div class="listbox gplist">
               <div class="listmember"><span class="node nd1"><spring:message code="label.mmember"/></span><spring:message code="label.gpoint"/></div>
               <div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointMap.memberPoint}" pattern="###,###,###,###"/></span></div>
               <a type="button" class="listbtn" onclick="resetGpointvalue('1');"><i class="fas fa-gift"></i><spring:message code="label.gift"/></a>
            </div>
            </c:if>
            <!-- 정회원 -->
            <c:if test="${model.myGreenPointMap.recommenderPoint != null}">
            <div class="listbox gplist">
               <div class="listmember"><span class="node nd2"><spring:message code="label.mfullMembership"/></span><spring:message code="label.gpoint"/></div>
               <div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointMap.recommenderPoint}" pattern="###,###,###,###"/></span></div>
               <a type="button" class="listbtn" onclick="resetGpointvalue('2');"><i class="fas fa-gift"></i><spring:message code="label.gift"/></a>
            </div>
            </c:if>
            
            <!-- 영업관리자 -->
            <c:if test="${model.myGreenPointMap.saleManagerPoint != null}">
            <div class="listbox gplist">
               <div class="listmember"><span class="node nd3"><spring:message code="label.msalesManager"/></span><spring:message code="label.gpoint"/></div>
               <div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointMap.saleManagerPoint}" pattern="###,###,###,###"/></span></div>
               <a type="button" data-toggle="modal" data-target="#gpoint_gift2" class="listbtn" onclick="resetGpointvalue('6');"><i class="fas fa-gift"></i><spring:message code="label.gift"/></a>
            </div>
            </c:if>
            
            <!-- 협력업체 -->
            <c:if test="${model.myGreenPointMap.affiliatePoint != null}">
            <div class="listbox gplist">
               <div class="listmember"><span class="node nd4"><spring:message code="label.mpartners"/></span><spring:message code="label.gpoint"/></div>
               <div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointMap.affiliatePoint}" pattern="###,###,###,###"/></span></div>
               <a type="button" data-toggle="modal" data-target="#gpoint_gift3" class="listbtn" onclick="resetGpointvalue('5');"><i class="fas fa-gift"></i><spring:message code="label.gift"/></a>
            </div>   
            </c:if>
             
            <!-- 대리점 -->
            <c:if test="${model.myGreenPointMap.agancyPoint != null}">
            <div class="listbox gplist">
               <div class="listmember"><span class="node nd5"><spring:message code="label.magency"/></span><spring:message code="label.gpoint"/></div>
               <div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointMap.agancyPoint}" pattern="###,###,###,###"/></span></div>
               <a type="button" data-toggle="modal" data-target="#gpoint_gift4" class="listbtn" onclick="resetGpointvalue('4');"><i class="fas fa-gift"></i><spring:message code="label.gift"/></a>
            </div>
            </c:if>
            
            <!-- 지사 -->
            <c:if test="${model.myGreenPointMap.branchPoint != null}">
            <div class="listbox gplist">
               <div class="listmember"><span class="node nd6"><spring:message code="label.mbranch"/></span><spring:message code="label.gpoint"/></div>
               <div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointMap.branchPoint}" pattern="###,###,###,###"/></span></div>
               <a type="button" data-toggle="modal" data-target="#gpoint_gift5" class="listbtn" onclick="resetGpointvalue('3');"><i class="fas fa-gift"></i><spring:message code="label.gift"/></a>
            </div>
            </c:if>
            
            <!-- 총판 -->
            <c:if test="${model.myGreenPointMap.SoleDistPoint != null}">
            <div class="listbox gplist">
               <div class="listmember"><span class="node nd7"><spring:message code="label.msoleDist"/></span><spring:message code="label.gpoint"/></div>
               <div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointMap.SoleDistPoint}" pattern="###,###,###,###"/></span></div>
               <a type="button" data-toggle="modal" data-target="#gpoint_gift6" class="listbtn" onclick="resetGpointvalue('7');"><i class="fas fa-gift"></i><spring:message code="label.gift"/></a>
            </div>
            </c:if>
          </div>
      </div>
      <input type="hidden" id="rPointMovingMinLimit" name="rPointMovingMinLimit"/>
      <input type="hidden" id="rPointMovingMaxLimit" name="rPointMovingMaxLimit"/>
      <input type="hidden" id="gPointMovingMinLimit" name="gPointMovingMinLimit"/>
      <input type="hidden" id="gPointMovingMaxLimit" name="gPointMovingMaxLimit"/>
   </section>
   <!-- content end -->
</div>  
</body>
<!-- body end -->
</html>