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
<link rel="stylesheet" href="/resources/web_css/common.css">
<script type="text/javascript" src="/resources/js/lib/m_common.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$(".fran_button1").click(function(){
	        $(".fran_top").slideToggle(300);
	   });	
		searchCity();
		var country = '${params.country}';
		searchCountry('${params.city}');
	});
	
	function franchiseeInfoGoogleMapPopup(affiliateNo){
		url = "/board/franchiseeInfoGoogleMap.do?affiliateNo="+affiliateNo;
		window.open(url, "url", " toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=yes");
	}
	
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
<style >
nav { padding-top : 0px}
h4, .h4, h5, .h5, h6, .h6 {
    margin-top: 0px;
    margin-bottom: 10px;
}

</style>
</head>
<!-- header end -->
<!-- body begin -->
<body class="affiliate_search_container" style="padding-top: 0px;">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4><spring:message code="label.franchise" /></h4>
	</header> 
	<section>
		<div class="fran container">
	        <div class="fran_text1"><spring:message code="label.web.findaMerchant"/><button type="button" class="btn btn-primary btn-lg fran_button1">검색창</button></div>
	        <div class="fran1">
				 <div class="fran_top">
				<form id="franchiseeform" name="franchiseeform">
					  <div class="fran2 col-lg-6">
	                    <select class="form-control fran4_text1" id="city" name="city" onchange="searchCountry($('select[name=city]').val());" value="${params.city}">
	                      <option value="">시/도</option> 
	                    </select>
	                </div>
					  <div class="fran2 col-lg-6">
	                  <select class="form-control fran4_text1" id="country" name="country" value="${params.country}" >
	                      <option value="">구/군</option>
	                    </select>
	                </div>
					  <div class="form-group has-success has-feedback frna5">
	                        <div class="col-lg-12 fran5_1">
	                            <input type="text" class="form-control" placeholder="매장명을 입력해 주세요.">
	                        </div>
	                        <div class="col-lg-12 fran5_2">
	                            <button onclick="searchFranchisee();" style ="width:90px"><spring:message code="label.web.search"/></button>
	                        </div>
	                    </div>
				</form>
				</div>
			</div>
			<c:choose>
			<c:when test="${! empty franchiseeInfoList}">	
			    <c:forEach var="list" items="${franchiseeInfoList}" varStatus="loop">
			    <div class="fran_box container">
	                <div class="img_box"><img src="/resources/web_images/no_image.png"></div>
	                <div class="fran_text_box">
	                    <ul>
	                        <li>${list.affiliateName}</li>
	                        <li>${list.affiliateTel}</li>
	                        <li>${list.affiliateAddress}</li>
	                    </ul>
	                </div>
	                <a href="#" onclick="franchiseeInfoGoogleMapPopup('${list.affiliateNo}');">
	                    <div class="fran_map"><img src="/resources/web_images/map.png"></div>
	                </a>
				</div>
	            </c:forEach>
	        </c:when>
	        <c:otherwise>
	            <p>검색된 주소와 일치되는 가맹점이 없습니다.</p>
	        </c:otherwise>  
	        </c:choose>
	</div>
	<jsp:include page="/WEB-INF/views/common/paging.jsp" />
	</section>
</body>
<!-- body end -->
</html>