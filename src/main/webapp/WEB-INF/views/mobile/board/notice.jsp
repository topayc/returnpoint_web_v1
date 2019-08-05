<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="com.returnp_web.utils.SessionManager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ taglib prefix="f" uri="/WEB-INF/tld/f.tld" %>
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
});

function addlist(noticecount){
	var content = "";
	var noticecount = noticecount;
	var morecount = $('#morecount').val();
	if(morecount =="" || morecount ==null){
		morecount = "1";
	}
	$.ajax({
		method : "POST",
		url    : "/m/board/noticeMoreAct.do",
		dataType: "json",
		data   : {
			noticecount		: noticecount,
			morecount		: morecount
		},
        success : function(data){
        	if(data.json_arr.length == 0){
        		alert("더보기가 없습니다");
        	}
        	
            for(i=0; i<data.json_arr.length; i++) {
            	content += "<div data-toggle='collapse' data-target='#notice_"+data.json_arr[i].noticeMoreList[i].boardNo+"' class='list_li collapsed ellp'>"
            	content += "<small><i class='fas fa-calendar-alt'></i>"+data.json_arr[i].noticeMoreList[i].createTime+"</small>"
            	content += "<span>"+data.json_arr[i].noticeMoreList[i].boardTitle+"</span>"
            	content += "</div>"
            	content +="<div id='notice_"+data.json_arr[i].noticeMoreList[i].boardNo+ "' class='list_toggle collapse'>"
            	content +="<p><strong>A</strong>"+data.json_arr[i].noticeMoreList[i].boardContent+"</p>"
            	content +="</div>"; 
            }
            $('#morecount').val(data.morecount);
            //$('#addlist').remove();//remove btn
            $(content).appendTo("#table"); 
        },
        error: function (request, status, error) {
			alert("더보기가 없습니다");
			return false;
		}
		
    });
}
</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_notice">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4><spring:message code="label.notice" /></h4>
	</header> 
	<!-- content begin -->
	<section>
		<div class="listS01">			
			<%-- <div class="list_title"><i class="fas fa-pencil-alt"></i>&nbsp;<spring:message code="label.notice" /></div>		 --%>	
			<div id="table">	
			<c:choose>
				<c:when test="${! empty model.noticeList}">
			<c:forEach var="list" items="${model.noticeList}" varStatus="loop">
			<div data-toggle="collapse" data-target="#notice_${list.boardNo}" class="list_li collapsed ellp">
				<small ><!-- <i class="fas fa-calendar-alt"></i> --> ${list.createTime}</small>
				<span class = "item_title" >[공지]${list.boardTitle}</span> <span><i class="fas fa-chevron-right list_blt"></i></span>
			</div>
			<div id="notice_${list.boardNo}" class="list_toggle collapse">
				<p>${f:decQuote(list.boardContent)}</p>
			</div> 	
			<c:set var="noticecount" value="${loop.count}"/>
			</c:forEach>			
				</c:when>
				<c:otherwise>
					<div class="list_li collapsed ellp">
					<p><spring:message code="label.no_post" /></p>
					</div>
				</c:otherwise>
			</c:choose>				
			</div>
		</div>
		<input type="hidden" id="morecount" name="morecount"/>
		<input type="hidden" id="noticeTotalCnt" name="noticeTotalCnt" value="${model.noticeTotalCnt.CNT}"/>
		<c:if test="${noticecount eq 10}">
			<button type="submit" class="btn btn-basic" id="addlist" onclick="addlist('${noticecount}');">더보기</button>
		</c:if>
	</section>
	<!-- content end -->
</div>
</body>
<!-- body end -->
</html>