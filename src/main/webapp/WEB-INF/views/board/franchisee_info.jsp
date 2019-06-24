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
	searchCity();
	var country = '${params.country}';
	searchCountry('${params.city}');
});

function searchCity(){
	var content = "";
	$.ajax({
		method : "post",
		url    : "/board/searchCity.do",
		dataType: "json",
		success: function(data) {
			for(i=0; i<data.json_arr.length; i++) {
				if('${params.city}' == data.json_arr[i].cityList[i].city_name){
            		content += "<option value=" + data.json_arr[i].cityList[i].city_name + " selected>" + data.json_arr[i].cityList[i].city_name + "</option> ";
				}else{
					content += "<option value=" + data.json_arr[i].cityList[i].city_name + ">" + data.json_arr[i].cityList[i].city_name + "</option> ";
				}
			}
			$(content).appendTo("#city"); 
		},
		error: function (request, status, error) {
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});		
}

function searchCountry(city_name){
	var content = "";
	if(city_name != "세종특별자치시" && city_name != null && city_name != ""){ //세종시는 구/군 없음
		$.ajax({
			method : "post",
			url    : "/board/searchCountry.do",
			dataType: "json",
			data   : {
				city_name : city_name
			},
			success: function(data) {
				$("#country").empty();
				content += "<option value=''>구/군</option>";
				for(i=0; i<data.json_arr.length; i++) {
					if('${params.country}' == data.json_arr[i].countryNameList[i].country_name){
	            		content += "<option value=" + data.json_arr[i].countryNameList[i].country_name + " selected>" + data.json_arr[i].countryNameList[i].country_name + "</option> ";
					}else{
						content += "<option value=" + data.json_arr[i].countryNameList[i].country_name + ">" + data.json_arr[i].countryNameList[i].country_name + "</option> ";
					}
				}
				 $(content).appendTo("#country"); 
			},
			error: function (request, status, error) {
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
			
		});	
	}else{
		for(k = document.all.country.options.length; k > 0; k--){
			document.all.country.options[k] = null;
		}
		document.all.country.options[0] = new Option('구/군','');
	}	 
}

function searchFranchisee(){
	var city= $("#city option:selected").text(); //selectbox에서 선택된 value를 가져오는 방법은 다음과 같다. 
	var country= $("#country option:selected").text(); //selectbox에서 선택된 value를 가져오는 방법은 다음과 같다. 
	var affiliateName = $("#affiliateName").val();
	if( (city == "" || city =="시/도") &&  (affiliateName == "" || affiliateName == null)){
		alert("시도를 선택해주세요.");
		return false;
	}
	document.franchiseeform.action = "/board/franchisee_info.do";
    document.franchiseeform.submit();
}

function searchList_page(page, upperPage){
	$("#page").val(page);
    $("#upperPage").val(upperPage);
    searchList();
}

function searchList(){
	document.viewList.action = "/board/franchisee_info.do";
    document.viewList.submit();
}
</script>
<body>
<jsp:include page="/WEB-INF/views/common/topper.jsp" />
   <hr class="top_line">
    <div class="fran container">
        <div class="fran_text1"><spring:message code="label.web.findaMerchant"/></div>
        <div class="fran1">
            <hr class="fran_line">
            <h3 class="fran_text2"><spring:message code="label.web.addressAndStoreName"/></h3>
			<form id="franchiseeform" name="franchiseeform">
				<div class="fran2 col-lg-6">
					<select class="form-control" id="city" name="city" onchange="searchCountry($('select[name=city]').val());" value="${params.city}"/>
					  <option value="">시/도</option> 
					</select>
				</div>
				<div class="fran2 col-lg-6">
					<select class="form-control" id="country" name="country" value="${params.country}" />
					  <option value="">구/군</option>
					</select>
				</div>
				<div class="fran3 form-group col-lg-12">
				    <input type="text" id="affiliateName" name="affiliateName" class="form-control" value="${fn:trim(params.affiliateName)}" placeholder="매장명을 입력해 주세요."/> 
				</div>
				<hr class="fran_line">
				<a href="#" onclick="searchFranchisee();"><button type="button" class="btn btn-primary btn-lg fran_button"><spring:message code="label.web.search"/></button></a>
			</form>
		</div>
		<div class="fran4 container">
	      <div class="fran_table tab-pane fade in active">
	        <table class="table table-hover">
			  <thead>
			    <tr>
					<th scope="col" class="col-lg-3 col-md-3 col-xs-3 text-center"><spring:message code="label.web.storeName"/></th>
					<th scope="col" class="col-lg-3 col-md-3 col-xs-3 text-center"><spring:message code="label.web.contact"/></th>
					<th scope="col" class="col-lg-6 col-md-6 col-xs-6 text-center"><spring:message code="label.web.address"/></th>
			    </tr>
			  </thead>
			  <tbody>
			<c:choose>
				<c:when test="${! empty franchiseeInfoList}">			  
					<c:forEach var="list" items="${franchiseeInfoList}" varStatus="loop">
			    <tr>
			      <th scope="row" class="text-center">${list.affiliateName}</th>
			      <td class="text-center">${list.affiliateTel}</td>
			      <td class="text-center">${list.affiliateAddress}</td>
			    </tr>
			    	</c:forEach>
			    </c:when>
				<c:otherwise>
				<tr>
			      <td class="text-center" colspan="3">검색된 주소와 일치되는 가맹점이 없습니다.</td>
			    </tr>		    
				</c:otherwise>			    
			   </c:choose> 
			  </tbody>
			</table>
	      </div>
	<jsp:include page="/WEB-INF/views/common/paging.jsp" />
</div>
</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>