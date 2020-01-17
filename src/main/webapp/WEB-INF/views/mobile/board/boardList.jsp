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
	
	  var p = getParams();
	  if (p['bbsType1'] && p['bbsType1'] == '2'){
		  if (p['bbsType2']) {
			  $("#faq_" + p['bbsType2']).addClass("faq_select");
	  	  }
	  }
});

function showDetailBoard(no){
	location.href = "/m/board/boardDetail.do?mainBbsNo="+ no;
}

function moveFaq(bbsType2){
	location.href = "/m/board/boardList.do?bbsType1=2&bbsType2="+bbsType2
}
</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_qna">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4>
		<c:choose>
         <c:when test = "${model.bbsType1 == '1'}"> 
         	<c:if test = "${model.bbsType2 == '1'}"><spring:message code="label.notice" /> </c:if>
         	<c:if test = "${model.bbsType2 == '2'}"><spring:message code="label.affiliateNotice" /> </c:if>
         </c:when>
         <c:when test = "${model.bbsType1 == '4'}"> <spring:message code="label.general_affiliated_inquiry" /> </c:when>
         <c:when test = "${model.bbsType1 == '2'}"> <spring:message code="label.faq" /> </c:when>
      </c:choose>
		
		</h4>
	</header> 
	<!-- content begin -->
	<section>
		<div class="listS01">			
			<%-- <div class="list_title"><i class="fas fa-pencil-alt"></i><spring:message code="label.affiliated_inquiry" /></div> --%>			
		    <c:if test = "${model.bbsType1 == '2'}"> 
		    <div class="table_box">
		      <table>
		         <tr>
		            <td><a id ="faq_0" onclick = "moveFaq('0')">전체</a></td>
		            <td><a id ="faq_1"onclick = "moveFaq('1')">회원</a></td>
		            <td><a id ="faq_2"onclick = "moveFaq('2')">포인트</a></td>
		            <td><a id ="faq_3"onclick = "moveFaq('3')">적립</a></td>
		         </tr>
		         <tr>
		            <td><a id ="faq_4"onclick = "moveFaq('4')">포인트 사용</a></td>
		            <td><a id ="faq_5"onclick = "moveFaq('5')">상품권</a></td>
		            <td><a id ="faq_6"onclick = "moveFaq('6')">쇼핑몰</a></td>
		            <td><a id ="faq_7"onclick = "moveFaq('7')">가맹</a></td>
		         </tr>
		      </table>
		   </div>
		   </c:if>
	
		<c:choose>
			<c:when test="${! empty model.boardList}">
			<c:forEach var="list" items="${model.boardList}" varStatus="loop">
			<div data-toggle="collapse" data-target="#notice_${list.mainBbsNo}" class="list_li collapsed ellp" style = "padding: 12px 20px">
				<c:if test = "${model.bbsType1 != '2'}">
				<small style ="padding: 0 3px">
					<fmt:parseDate value="${list.createTime}" var="noticePostDate" pattern="yyyy-MM-dd "/>
					<fmt:formatDate value="${noticePostDate}" pattern="yyyy-MM-dd"/>
				 </small>
				</c:if>
				<span class = "item_title"  style = "font-size: 13px">${list.title}
					<c:if test = "${model.bbsType1 == '4' and list.replyCompleted == 'Y'}">
					<span class ="badge badge-success" style = "background-color: #04B404;display : inline;font-weight : 300;font-size: 10px">완료</span>
					</c:if>
				</span>
				 <span><i class="fas fa-chevron-right list_blt"></i></span>
			</div>
			<div id="notice_${list.mainBbsNo}" class="list_toggle collapse">
				  <p>
					<c:set var = "content" value ="${fn:replace(list.content, LF, '<br>')}"/>
					${f:decQuote(content)}
				</p>
				<c:if test = "${model.bbsType1 == '4' and list.replyCompleted == 'Y'}">
					<button style= "margin-left : 10px; margin-bottom: 10px;font-weight: 501; font-size : 12px;padding: 6px;" onclick = "showDetailBoard('${list.mainBbsNo}')">답변 보기</button>
				</c:if>
			</div> 	
			<c:set var="noticecount" value="${loop.count}"/>
			</c:forEach>			
				</c:when>
				<c:otherwise>
					<div class="list_li collapsed ellp">
					<p class = "item_title"><spring:message code="label.no_post" /></p>
					</div>
				</c:otherwise>
			</c:choose>			
		</div>
		<c:if test = "${model.bbsType1 == '4'}">
			<button type="submit" class="btn btn-submit" onclick="location='./qna_node_w.do'"><spring:message code="label.question" /></button>  
		</c:if>
	</section>
	<!-- content end -->
</div>
</body>
<!-- body end -->
</html>