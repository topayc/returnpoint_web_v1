<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="f" uri="/WEB-INF/tld/f.tld" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<script type="text/javascript">
$(document).ready(function(){
	var bbsType2css= $("#bbsType2").val();
	$("#class_cd li").removeClass("on");
	$("#bbsType2_sub"+bbsType2css).addClass("on");
});
function searchList_page(page, upperPage){
	$("#page").val(page);
    $("#upperPage").val(upperPage);
    searchFaqList();
}
</script>
<body>
<jsp:include page="/WEB-INF/views/common/topper.jsp" />
<hr class="top_line">
	<div class="faq_tab container page_title">
		<div class="faq_text1">FAQ</div>
		<div class="faq_nav">
			<ul id="class_cd">
				<li id="bbsType2_sub0" cls_cd="750000"><a href="#" onclick="searchFaqTapList('0');">전체</a></li>
				<li id="bbsType2_sub1" cls_cd="750001"><a href="#" onclick="searchFaqTapList('1');">회원</a></li>
				<li id="bbsType2_sub2" cls_cd="750002"><a href="#" onclick="searchFaqTapList('2');">포인트</a></li>
				<li id="bbsType2_sub3" cls_cd="750003"><a href="#" onclick="searchFaqTapList('3');">적립</a></li>
				<li id="bbsType2_sub4" cls_cd="750004"><a href="#" onclick="searchFaqTapList('4');">포인트 사용</a></li>
				<li id="bbsType2_sub5" cls_cd="750004"><a href="#" onclick="searchFaqTapList('5');">상품권</a></li>
				<li id="bbsType2_sub6" cls_cd="750004"><a href="#" onclick="searchFaqTapList('6');">쇼핑몰</a></li>
				<li id="bbsType2_sub7" cls_cd="750004"><a href="#" onclick="searchFaqTapList('7');">가맹</a></li>
				<li id="bbsType2_sub10" cls_cd="750004"><a href="#" onclick="searchFaqTapList('10');">기타</a></li>
			</ul>
		</div>
        <div role="tabpanel" class="faq_table tab-pane fade in active" id="home" aria-labelledby="home-tab">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th scope="col" class="col-lg-1 col-md-1 col-xs-2">번호</th>
                        <th scope="col" colspan="2" class="col-lg-7 col-xs-6">제목</th>
                        <th scope="col" class="col-lg-2 col-md-2 col-xs-2">작성자</th>
                       <!--  <th scope="col" class="col-lg-4 col-md-2 col-xs-4">등록일</th> -->
                    </tr>
                </thead>
                <tbody>
			<c:choose>
				<c:when test="${! empty faqList}">			  
					<c:forEach var="list" items="${faqList}" varStatus="loop">
		 				<tr>
					      <th scope="row">${list.ROWNUM}</th> 
					      <td colspan="2"><a href="#" onclick="moveFaqContent('${list.mainBbsNo}');">${list.title}</a></td>
					      <td>관리자</td>
					 <%--         <td>
					      	<fmt:parseDate value="${list.createTime}" var="noticePostDate" pattern="yyyy-MM-dd "/>
					      	 <fmt:formatDate value="${noticePostDate}" pattern="yyyy-MM-dd"/>
					      </td> --%>
					    </tr>					
					</c:forEach>			  
				</c:when>
				<c:otherwise>		    
						<tr>
					       <td colspan="3">등록된 FAQ가 없습니다.</td>
					    </tr>
				</c:otherwise>
			</c:choose>			   
			  </tbody>
			</table>
	      </div>
	</div>
	<form id="faqform" name="faqform">
	    <input type="hidden" id="bbsType2" name="bbsType2" value="${params.bbsType2}"/>
	</form>
	<jsp:include page="/WEB-INF/views/common/paging.jsp" />
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>