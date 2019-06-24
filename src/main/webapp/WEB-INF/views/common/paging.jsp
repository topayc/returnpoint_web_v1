<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="f" uri="/WEB-INF/tld/f.tld" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
	<!-- 페이징 시작 -->
	<div class="Page navigation container text-center">
	  <ul class="pagination">
	  <c:if test="${params.upperPage > 1}">
	    <li class="page-item">
	      <a href="javascript:searchList_page('${(params.upperPage-2) * params.pagePerUpperPage+1}','${params.upperPage-1}')" aria-label="Previous">
	        <span aria-hidden="true">«</span>
	      </a>
	    </li>
	  </c:if>
	  <c:if test="${params.upperPage <= 1}">
	    <li class="page-item">
	      <a href="#" aria-label="Previous">
	        <span aria-hidden="true">«</span>
	      </a>
	    </li>
	   </c:if>
	<c:forEach var="i" begin="1" end="${params.pagePerUpperPage}" step="1">
       	<c:if test="${params.breakValue =='N'}">	  
			<c:if test="${params.page != ((params.upperPage-1) * params.pagePerUpperPage + i)}">
				<li class="page-item">
					<a href="javascript:searchList_page('${(params.upperPage-1) * params.pagePerUpperPage + i}','${params.upperPage}')" >
						${(params.upperPage-1) * params.pagePerUpperPage + i}
					</a>
				</li>
			</c:if>
			<c:if test="${params.page == ((params.upperPage-1) * params.pagePerUpperPage + i)}">
				<li class="active"><!-- class="page-item_add" 현재 페이지일 경우 속성-->
					<%-- <a href="#">${(params.upperPage-1) * params.pagePerUpperPage + i}</a> --%>
					<a>${(params.upperPage-1) * params.pagePerUpperPage + i}</a> <!-- 현대페이지를 나타내는 포커스 css가 있어야 할듯 -->
				</li>
			</c:if>
			<c:if test="${(params.pageCount == (params.upperPage-1) * params.pagePerUpperPage + i) || (params.pageCount == 0)}">
				<c:set target="${params}" property="breakValue" value="Y"/>
			</c:if>
		</c:if>
	</c:forEach>
	    <c:if test="${params.upperPageCount > params.upperPage}">
	    <li class="page-item">
	       <a href="javascript:searchList_page('${(params.upperPage) * params.pagePerUpperPage + 1}','${params.upperPage+1}')" aria-label="Next">
	        <span aria-hidden="true">»</span>
	      </a>
	    </li>
	    </c:if>
	    <c:if test="${params.upperPageCount <= params.upperPage}">
	    <li class="page-item">
	      <a href="#" aria-label="Next">
	        <span aria-hidden="true">»</span>
	      </a>
	    </li>	    
	    </c:if>
	  </ul>
	</div>
	<form id="viewList" name="viewList">
	    <input type="hidden" id="page" name="page" value="${params.page}"/>
	    <input type="hidden" id="upperPage" name="upperPage" value="${params.upperPage}"/>
	    <input type="hidden" id="recordPerPage" name="recordPerPage" value="${params.recordPerPage}"/>
	    <input type="hidden" id="recordCount" name="recordCount" value="${params.recordCount}"/>
	    <input type="hidden" id="mainBbsNo" name="mainBbsNo" value="${params.mainBbsNo}"/>
	    <input type="hidden" id="bbsType2" name="bbsType2" value="${params.bbsType2}"/>
	    
	    <!-- 가맹점찾기 -->
	    <input type="hidden" id="affiliateName" name="affiliateName" value="${params.affiliateName}"/>
	    <input type="hidden" id="city" name="city" value="${params.city}"/>
	    <input type="hidden" id="country" name="country" value="${params.country}"/>
	    <!-- 가맹점찾기 -->
	</form>
	<!-- 페이징 종료 -->