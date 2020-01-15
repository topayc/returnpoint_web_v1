<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="com.returnp_web.utils.SessionManager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="f" uri="/WEB-INF/tld/f.tld" %>
<% pageContext.setAttribute("LF", "\n"); %>
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
<script type="text/javascript">
$(document).ready(function(){
	var pageContextlocale = '${pageContext.response.locale}';
	$("#sel1").val(pageContextlocale); 	
	
	$(".list_li").click(function(){
		var target = $(this);
		var param = {isViewed : 'Y', memberNotiNo : $(this).data('target').split('_')[1].trim()}
		$.getJSON('/m/board/memberNoti/changeStatus.do', param, function(result){
			console.log(result);  
			if (result && typeof result !="undefined") {
      	   		if (result.result.code == 0) {
      	   		target.find('.badge').remove();;
					}
             }else{
            		alertOpen("알림", "장애 발생. 다시 시도해주세요.", true, false, null, null);
         	   }
		});	
	});
});

function showMemberNoticeDetail(no){
	location.href = "/m/board/memberNotiDetail.do?memberNotiNo="+ no;
}

</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_qna">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4>나의 알림 
		</h4>
	</header> 
	<!-- content begin -->
	<section>
		<div class="listS01">			
		<c:choose>
			<c:when test="${! empty model.memberNotis}">
			<c:forEach var="memberNoti" items="${model.memberNotis}" varStatus="loop">
			<div data-toggle="collapse" data-target="#memberNoti_${memberNoti.memberNotiNo}" class="list_li collapsed ellp" style = "padding: 12px 20px">
				<small style ="padding: 0 3px">
					<fmt:parseDate value="${memberNoti.createTime}" var="noticePostDate" pattern="yyyy-MM-dd HH:mm:ss"/>
					<fmt:formatDate value="${noticePostDate}" pattern="yyyy년 MM월 dd일 HH시 mm분"/>
				 </small>
				<span class = "item_title"  style = "font-size: 13px">${memberNoti.notiTitle}
					<c:if test = "${memberNoti.isViewed == 'N'}">
					<span class ="badge badge-success" style = "background-color:red;font-weight :300;font-size: 10px;display:inline;padding:3px 8px;">읽지않음</span>
					</c:if>
				</span>
				 <span><i class="fas fa-chevron-right list_blt"></i></span>
			</div>
			<div id="memberNoti_${memberNoti.memberNotiNo}" class="list_toggle collapse" style="background:#f9f9f9;">
				  <p>
					<c:set var = "content" value ="${fn:replace(memberNoti.notiContent, LF, '<br>')}"/>
					${f:decQuote(content)}
				</p>
			</div> 	
			</c:forEach>			
				</c:when>
				<c:otherwise>
					<div class="list_none" style="width:70%;margin-left:15%;margin-top:27%;height:200px;" onclick = "movePage('/m/pointCoupon/receiptDetail.do?pointCodeIssueRequestNo=${receipt.pointCodeIssueRequestNo}')">
						<img src="/resources/images/list_none_img.png" width="80" height="80">
						<p>알림메시지 내역이 없습니다</p>
					</div>
				</c:otherwise>
			</c:choose>			
		</div>
	</section>
	<!-- content end -->
</div>
</body>
<!-- body end -->
</html>