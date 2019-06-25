<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="f" uri="/WEB-INF/tld/f.tld" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<script type="text/javascript">
function searchList_page(page, upperPage){
	$("#page").val(page);
    $("#upperPage").val(upperPage);
    searchNoticeList();
}
</script>
<body>
<jsp:include page="/WEB-INF/views/common/topper.jsp" />
   <hr class="top_line">
    <div class="faq_tab container">
        <div class="faq_text1"><spring:message code="label.web.notice"/></div>
        <div role="tabpanel" class="faq_table tab-pane fade in active" id="home" aria-labelledby="home-tab">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th scope="col" class="col-lg-1 col-md-1 col-xs-2">번호</th>
                        <th scope="col" colspan="2" class="col-lg-9 col-xs-8">제목</th>
                        <th scope="col" class="col-lg-2 col-md-2 col-xs-2">작성자</th>
                    </tr>
                </thead>
                <tbody>
	            <c:choose>
					<c:when test="${! empty noticeList}">			  
						<c:forEach var="list" items="${noticeList}" varStatus="loop">
						<tr>
					      <th scope="row">${params.recordCount - loop.index - (params.page-1) * 20}</th> 
					      <td colspan="2"><a href="#" onclick="moveNoticeContent('${list.mainBbsNo}');">${list.title}</a></td>
					      <td>관리자</td>
					    </tr>						
						</c:forEach>			  
					</c:when>
					<c:otherwise>		    
						<tr>
					       <td colspan="3">등록된 공지사항이 없습니다.</td>
					    </tr>
					</c:otherwise>
				</c:choose>		                    
                </tbody>
            </table>
        </div>
    </div>
	<jsp:include page="/WEB-INF/views/common/paging.jsp" />
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>