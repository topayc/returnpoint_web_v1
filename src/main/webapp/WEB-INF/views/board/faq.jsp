<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="f" uri="/WEB-INF/tld/f.tld" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" /> <!-- <html>~</head>까지 -->
<!-- 완료 -->
<script type="text/javascript">
$(document).ready(function(){
	var bbsType2css= $("#bbsType2").val();
	$("#class_cd li").removeClass("on");
	$("#bbsType2_sub"+bbsType2css).addClass("on");
});

//검색 페이징
function searchList_page(page, upperPage){
	$("#page").val(page);
    $("#upperPage").val(upperPage);
    searchList();
}

function searchList(){
	document.viewList.action = "/board/faq.do";
    document.viewList.submit();
}

function moveFaqContent(mainBbsNo){
	$("#mainBbsNo").val(mainBbsNo);
	document.viewList.action = "/board/faq_content.do";
    document.viewList.submit();
}

//상단 탭 버튼 클릭시 이동
function searchFaqTapList(bbsType2){
	$("#bbsType2").val(bbsType2);
	document.faqform.action = "/board/faq.do";
    document.faqform.submit();
}
</script>
<body>
<jsp:include page="/WEB-INF/views/common/topper.jsp" /> <!-- <nav>~</nav>까지 -->
<hr class="top_line">
	<div class="faq_tab container">
		<div class="faq_text1">FAQ</div>
		<div class="faq_nav">
			<ul id="class_cd">
				<li id="bbsType2_sub0" cls_cd="750000"><a href="#" onclick="searchFaqTapList('0');">전체</a></li>
				<li id="bbsType2_sub1" cls_cd="750001"><a href="#" onclick="searchFaqTapList('1');">회원/가입/탈퇴</a></li>
				<li id="bbsType2_sub2" cls_cd="750002"><a href="#" onclick="searchFaqTapList('2');">포인트</a></li>
				<li id="bbsType2_sub3" cls_cd="750003"><a href="#" onclick="searchFaqTapList('3');">적립 및 출금</a></li>
				<li id="bbsType2_sub10" cls_cd="750004"><a href="#" onclick="searchFaqTapList('10');">기타</a></li>
			</ul>
		</div>
	       <div role="tabpanel" class="faq_table tab-pane fade in active" id="home" aria-labelledby="home-tab">
	        <table class="table table-hover">
			  <thead>
			    <tr>
			      <th scope="col" class="col-lg-1 col-md-1 col-xs-1">번호</th>
			      <th scope="col" colspan="2">제목</th>
			      <th scope="col" class="col-lg-1 col-md-1 col-xs-1">작성자</th>
			    </tr>
			  </thead>
			  <tbody>
			<c:choose>
				<c:when test="${! empty faqList}">			  
					<c:forEach var="list" items="${faqList}" varStatus="loop">
		 				<tr>
					      <th scope="row">${params.recordCount - loop.index - (params.page-1) * 20}</th> 
					      <td colspan="2"><a href="#" onclick="moveFaqContent('${list.mainBbsNo}');">${list.title}</a></td>
					      <td>관리자</td>
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
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp" /> <!-- <footer>~</footer>까지 -->
	<!-- footer -->
</body>
</html>