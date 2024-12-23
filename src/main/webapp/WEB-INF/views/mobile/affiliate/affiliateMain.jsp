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
	
	$(".memer_noti_item").click(function(){
		var param = {isViewed : 'Y', memberNotiNo : $(this).attr('requestNo').trim()}
		$.getJSON('/m/board/memberNoti/changeStatus.do', param, function(result){
			if (result && typeof result !="undefined") {
      	   		if (result.result.code == 0) {
				}
             }else{
            		alertOpen("알림", "장애 발생. 다시 시도해주세요.", true, false, null, null);
         	   }
		});	
	});
	
});

</script>
<style>
 * {font-weight:400}
</style>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_terms">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4>${affiliate.affiliateName}</h4>
	</header> 
  
	<section>
	<div class="affiliate_main">
		<ul>
			<c:if test = "${! empty affiliateNotices}">
			<c:forEach items = "${affiliateNotices}" var = "affiliateNotice">
			<li onclick = "movePage('/m/board/boardDetail.do?dType=mainBbs&mainBbsNo=${affiliateNotice.mainBbsNo}')">
				<ul>
					<c:choose>
						<c:when test="${fn:length(affilaiteNotice.title) gt 35}">
							<li class="affiliate_main_fran" ><b>가맹점공지</b>&nbsp;<c:out value="${fn:substring(affiliateNotice.title, 0, 35)}"></c:out>...
						 	<c:set var="now1" value="<%=new java.util.Date()%>"/>
				        	 <fmt:parseNumber value="${now1.time / (1000*60*60*24)}" integerOnly="true" var="today1"></fmt:parseNumber>
						 	<fmt:parseDate value="${affiliateNotice.createTime}" var="affiliateNoticePostDate" pattern="yyyy-MM-dd "/>
				          	<fmt:parseNumber value="${affiliateNoticePostDate.time / (1000*60*60*24)}" integerOnly="true" var="postData1"></fmt:parseNumber>
							<c:if test="${today1 - postData1 <= 7}">
							<span class = "new_notice"> NEW</span>
							</c:if>
					    </c:when>
					    <c:otherwise>
					    	<b>가맹점공지</b>&nbsp;<c:out value="${affiliateNotice.title}"> </c:out>
					    	<c:set var="now" value="<%=new java.util.Date()%>"/>
							<fmt:parseNumber value="${now.time / (1000*60*60*24)}" integerOnly="true" var="today"></fmt:parseNumber>
							<fmt:parseDate value="${affilaiteNotice.createTime}" var="noticePostDate" pattern="yyyy-MM-dd "/>
							<fmt:parseNumber value="${noticePostDate.time / (1000*60*60*24)}" integerOnly="true" var="postData"></fmt:parseNumber>
							<c:if test="${today - postData <= 7}">
								<span class = "new_notice"> NEW</span>
							</c:if>
					    </c:otherwise>
					</c:choose>	
					<li class="affiliate_main_day">
						<fmt:parseDate value="${affilaiteNotice.createTime}" var="createTime" pattern="yyyy-MM-dd HH:mm:ss"/>
						<fmt:formatDate value="${createTime}" pattern="yyyy-MM-dd HH:mm"/> 
					</li>
				</ul>
			</li>
			</c:forEach>
			</c:if>
			<c:if test = "${! empty model.notReadNotis}">
			<li data-toggle="collapse" data-target="#member_noti" >
				<b>알림</b>&nbsp;아직 읽지 않은 알림 메세지가 
				<span style = "color : red;font-weight:600">${fn:length(model.notReadNotis)}</span>개가 있습니다.<span>
				<!-- <i class="fas fa-chevron-right list_blt"></i></span></li> -->
			</c:if>
		</ul>
		<c:if test = "${! empty model.notReadNotis}">
		<div id = "member_noti"  class="collapse list_toggle" style = "background-color:#f1f1f1">
			<ul>
				<c:forEach items = "${model.notReadNotis}" var = "noti">
					<li class = "memer_noti_item"  requestNo = "${noti.memberNotiNo}" onclick = "movePage('/m/board/memberNotiDetail.do?memberNotiNo=${noti.memberNotiNo}')" style = "padding : 3% 3%;font-size:12px;border-bottom: 1px solid #ddd;border-top: 1px solid #fff" >ㆍ${noti.notiTitle} 
						&nbsp;&nbsp;<fmt:parseDate value="${noti.createTime}" var="createTime" pattern="yyyy-MM-dd HH:mm:ss"/>
						<fmt:formatDate value="${createTime}" pattern="yyyy-MM-dd"/> 
					</li>
				</c:forEach>
			</ul>
		</div>
		</c:if>
		<div class="affiliate_conbox">
		<div class="affiliate_conbox1">
			<ul>
				<li><span>영수증 매출</span>${affiliate.affiliateName}</li>
			</ul>
				<div class="affiliate_con1">
					<ul>
						<li>현재까지 영수증 총 매출</li>
						<li><span><fmt:formatNumber value="${model.receiptSaleSummary.totalReceiptPayAmount}" pattern="###,###,###,###"/></span></li>
					</ul>
				</div>
				<div class="affiliate_con2">
					<ul>
						<li onclick = "movePage('/m/affiliate/affiliateReceiptList.do?statusCode=TRL&affiliateNo=${model.affiliate.affiliateNo}')">전체내역조회(${model.receiptSaleSummary.totalReceipCount})</li>
						<li><span><fmt:formatNumber value="${model.receiptSaleSummary.totalReceiptPayAmount}" pattern="###,###,###,###"/></span></li>
					</ul>
				</div>
				<div class="affiliate_con2">
					<ul>
						<li onclick = "movePage('/m/affiliate/affiliateReceiptList.do?statusCode=CRL&affiliateNo=${model.affiliate.affiliateNo}')">처리완료조회(${model.receiptSaleSummary.totalReceiptCompleteCount})</li>
						<li><span><fmt:formatNumber value="${model.receiptSaleSummary.totalReceiptCompletePayAmount}" pattern="###,###,###,###"/></span></li>
					</ul>
				</div>
				<div class="affiliate_con2">
					<ul>
						<li onclick = "movePage('/m/affiliate/affiliateReceiptList.do?statusCode=NRL&affiliateNo=${model.affiliate.affiliateNo}')">미처리내역조회(${model.receiptSaleSummary.totalReceiptNotCompleteCount})</li>
						<li><span><fmt:formatNumber value="${model.receiptSaleSummary.totalReceiptNotCompletePayAmount}" pattern="###,###,###,###"/></span></li>
					</ul>
				</div>
			</div>
			<div class="affiliate_conbox2">
			<ul>
				<li><span>단말기 QR 적립 매출</span>${affiliate.affiliateName}</li>
			</ul>
				<div class="affiliate_con1">
					<ul>
						<li>현재까지 단말기 QR 적립 매출</li>
						<li><span><fmt:formatNumber value="${model.qrSaleSummary.totalQrPayAmount}" pattern="###,###,###,###"/></span></li>
					</ul>
				</div>
				<div class="affiliate_con2">
					<ul>
						<li>전체내역 조회</li>
						<li><span><fmt:formatNumber value="${model.qrSaleSummary.totalQrPayAmount}" pattern="###,###,###,###"/></span></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
   </section>
     <div id = "progress_loading2">
		<img src="/resources/images/progress_loading.gif"/>
	</div>
</body>
<!-- body end -->
</html>