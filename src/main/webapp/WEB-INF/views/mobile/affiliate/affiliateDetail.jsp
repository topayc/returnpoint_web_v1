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
<link rel="stylesheet" href="/resources/css/affiliate_detail.css">
<!-- js -->
<script type="text/javascript" src="/resources/js/lib/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/bootstrap.min.js"></script>
<link rel="stylesheet" href="/resources/web_css/common.css">
<script type="text/javascript" src="/resources/js/lib/m_common.js"></script>
<!-- <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB-bv2uR929DOUO8vqMTkjLI_E6QCDofb4&callback=initMap"></script> -->
<script>
function movePage(url){
	location.href = url
}

function initMap() {
	 var lat = ${model.memberAddress.lat};
	 var lng = ${model.memberAddress.lng};
	
	var uluru = {lat: lat, lng: lng};
     var map = new google.maps.Map(document.getElementById('map_canvas'), {
       zoom: 15,
       center: uluru
     });
     var marker = new google.maps.Marker({
       position: uluru,
       map: map
     });
   }
	                
</script>
<style >
nav { padding-top : 0px}
h4, .h4, h5, .h5, h6, .h6 {
    margin-top: 0px;
    margin-bottom: 10px;
}
* {color : #000;font-weight: 400;}
.bt_box>button {font-family: 'Nanum Gothic', sans-serif !important;}

</style>
</head>
<!-- header end -->
<!-- body begin -->
<body class="affiliate_search_container" style="padding-top: 0px;">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4><%-- <spring:message code="label.affiliate_detail" /> --%>${model.affiliate.affiliateName}</h4>
	</header> 
	<section>
        <div class="main_slide">
            <div id="myCarousel" class="carousel slide" data-ride="carousel">
                <div class="carousel-inner slide_container" >
                    
                   <%--    <c:forEach var="image"  items="${model.affiliateMainImages}" varStatus="status" >
                      		 <div class="item <c:if test = "${status.count == 1 }">active</c:if>"> <img src="http://211.254.212.90:9093${image}" ></div>
                      </c:forEach> --%>
                   
                    <c:if test = "${model.affiliateDetail.affiliateMainImage1 ne null }">
	                  <%--   <div class="item active"> <img style="max-width: 100%; height: 250px;"  src="http://192.168.123.164:8080${model.affiliateDetail.affiliateMainImage1}" ></div> --%>
	                    <div class="item active"> <img style="max-width: 100%; height: 250px;"  src="http://211.254.212.90:9093${model.affiliateDetail.affiliateMainImage1}" ></div>
                    </c:if>

                   <c:if test = "${model.affiliateDetail.affiliateMainImage2 ne null }">
	               <%--      <div class="item"> <img style="max-width: 100%; height: 250px;" src="http://192.168.123.164:8080${model.affiliateDetail.affiliateMainImage2}" ></div> --%>
	                    <div class="item"> <img style="max-width: 100%; height: 250px;" src="http://211.254.212.90:9093${model.affiliateDetail.affiliateMainImage2}" ></div>
                    </c:if>
                    
                      <c:if test = "${model.affiliateDetail.affiliateMainImage3 ne null }">
	                  <%--   <div class="item"> <img style="max-width: 100%; height: 250px;" src="http://192.168.123.164:8080${model.affiliateDetail.affiliateMainImage3}" ></div> --%>
	                    <div class="item"> <img style="max-width: 100%; height: 250px;" src="http://211.254.212.90:9093${model.affiliateDetail.affiliateMainImage3}" ></div>
                    </c:if>
                    
                      <c:if test = "${model.affiliateDetail.affiliateMainImage4 ne null }">
	                  <%--   <div class="item"> <img style="max-width: 100%; height: 250px;" src="http://192.168.123.164:8080${model.affiliateDetail.affiliateMainImage4}" ></div> --%>
	                    <div class="item"> <img style="max-width: 100%; height: 250px;" src="http://211.254.212.90:9093${model.affiliateDetail.affiliateMainImage4}" ></div>
                    </c:if>
                </div>
            </div>
        </div>
        <div class="main">
            <p class="text1">${model.affiliate.affiliateName}</p>
            <span class="text2">
            	<span style = "padding: 7px;background-color : #33cc33" class="badge badge-pill badge-success">100% 적립</span>
             </span>
            <!-- <span class="text2">최근리뷰 <span class="badge badge-pill badge-success">245</span></span> -->
        </div>
        <div class="bt_box" >
            <button style = "font-size : 12px" type="button" class="btn btn-default <c:if test = "${model.affiliateDetail.commonWeb ne null }">web_link_active</c:if>"  
            <c:if test = "${model.affiliateDetail.commonWeb ne null }">onclick = "location.href='${model.affiliateDetail.commonWeb}'"</c:if> >
            	홈페이지
            </button>
            <button style = "font-size : 12px" type="button" class="btn btn-default etc_link <c:if test = "${model.affiliateDetail.etcLink ne null }">etc_link_active</c:if>" 
            	<c:if test = "${model.affiliateDetail.etcLink ne null }">onclick = "location.href='${fn:split(model.affiliateDetail.etcLink,'@')[1]}'"</c:if>>
            	<c:choose>
            		<c:when test = "${model.affiliateDetail.etcLink ne null }">
            			${fn:split(model.affiliateDetail.etcLink,'@')[0]}
            		</c:when>
            		<c:otherwise>
            			링크 없음
            		</c:otherwise>
            	</c:choose>
            </button>
           
           
           <!--  <button type="button" class="btn btn-default black_box">찜 196</button> -->
            <button type="button" class="btn btn-default">공유</button>
        </div>

    
    <div class="bs-example bs-example-tabs tab" role="tabpanel" data-example-id="togglable-tabs">
        <ul id="myTab" class="aff_nav nav nav-tabs" role="tablist">
            <li role="presentation" class="active"><a href="#profile" role="tab" id="profile-tab" data-toggle="tab" aria-controls="profile">정보</a></li>
            <li role="presentation"><a href="#review" role="tab" id="review-tab" data-toggle="tab" aria-controls="review">소식</a></li>
            <li role="presentation"><a href="#position" role="tab" id="position-tab" data-toggle="tab" aria-controls="position">위치</a></li>
        </ul>
        <div id="myTabContent" class="tab-content">
            <div role="tabpanel" class="tab-pane fade in active" id="profile" aria-labelledBy="profile-tab">
                 <c:if test = "${!empty model.affiliateDetail.overview}">
                 <div class="information">
                    <ul>
                        <li><!-- <img src="/resources/images/back_img5.png"> -->&nbsp;&nbsp;소개</li>
                        <li>
                           <c:set var = "overview" value ="${fn:replace(model.affiliateDetail.overview, LF, '<br>')}"/>
							${f:decQuote(overview)}
                        </li>
                    </ul>
                </div>
                </c:if>
                
                <c:if test = "${!empty model.affiliateDetail.afffiliateNotice}">
                <div class="information">
                    <ul>
                        <li><!-- <img src="/resources/images/back_img5.png"> -->&nbsp;&nbsp;사장님 인사말</li>
                        <li>
                            <c:set var = "afffiliateNotice" value ="${fn:replace(model.affiliateDetail.afffiliateNotice, LF, '<br>')}"/>
							${f:decQuote(afffiliateNotice)}
                        </li>
                    </ul>
                </div>
                 </c:if>
                 
                 <div class="information">
                    <ul>
                        <li><!-- <img src="/resources/images/back_img1.png"> -->&nbsp;&nbsp;영업 정보</li>
                        <li>
                            <ul>
                                <li>전화번호</li>
                                <li>${model.affiliate.affiliateTel}</li>
                            </ul>
                         <li>
                            <ul>
                                <li>핸드폰</li>
                                <li>${model.affiliate.affiliatePhone}</li>
                            </ul>
                        </li>
                         <li>
                            <ul>
                                <li>적립정보</li>
                                <li>결제 시 <span  style = "padding: 4px;background-color : #33cc33"  class="badge badge-pill badge-success">100%</span> G POINT  적립</li>
                            </ul>
                        </li>
                         <li>
                            <ul>
                                <li>영업시간</li>
                                <li>${model.affiliateDetail.openingHours}</li>
                            </ul>
                        </li>
                          <li>
                            <ul>
                                <li>휴무일</li>
                                <li>${model.affiliateDetail.holiday}</li>
                            </ul>
                        </li>
                    </ul>
                </div>
                
                 <div class="information">
                    <ul>
                        <li><!-- <img src="/resources/images/back_img2.png"> -->&nbsp;&nbsp;사업장 정보</li>
                        <li> <ul> <li>상호명</li> <li>${model.affiliate.affiliateName}</li> </ul> </li>
                        <li> <ul> <li>대표자</li> <li>${model.affiliateMember.memberName}</li></ul></li>
                        <li> <ul> <li>사업자 번호</li> <li>${model.affiliateDetail.businessNumber} </li></ul></li>
                        <li> <ul> <li>업종</li> <li>${model.affiliateDetail.businessItem}</li></ul></li>
                        <li> <ul> <li>업태</li> <li>${model.affiliateDetail.businessType} </li></ul></li><li>
                    </ul>
                </div>
               
               <c:if test = "${!empty model.affiliateDetail.etc}">
                <div class="information">
                    <ul>
                        <li><!-- <img src="/resources/images/back_img5.png"> -->&nbsp;&nbsp;부가 정보</li> 
                        <li> <c:set var = "etc" value ="${fn:replace(model.affiliateDetail.etc, LF, '<br>')}"/> ${f:decQuote(etc)} </li>
                    </ul>
                </div>
                </c:if>
            </div>
            <div role="tabpanel" class="tab-pane fade" id="review" aria-labelledBy="review-tab">
          		  <div class="information">
                    <ul>
                        <li><!-- <img src="/resources/images/back_img5.png"> -->&nbsp;&nbsp;소식</li> 
                        <li> <c:set var = "affiliateNews" value ="${fn:replace(model.affiliateDetail.affiliateNews, LF, '<br>')}"/> ${f:decQuote(affiliateNews)} </li>
                    </ul>
                </div>
           <!--      <div class="btn_box"><button type="button" class="btn btn-default" onclick = "movePage('/m/affiliate/reviewForm.do')">리뷰를 남겨주세요</button></div>
                <div class="review">
                    <div class="left_img"><img src="/resources/images/profile_img.png"></div>
                    <div class="right_text">
                        <ul>
                            <li>returnp</li>
                            <li>2019-10-02 </li>
                        </ul>
                    </div>
                    <div class="review_img">
                        <img src="/resources/images/slide_img1.png">
                    </div>
                    <div class="review_img">
                        <img src="/resources/images/slide_img2.png">
                    </div>
                    <div class="review_text">
                        정말 맛있게 잘 먹었습니다. 음식도 너무 깔끔하고 맛있고 사장님도 너무 친절하셔서 다시 또 방문할것 같습니다.
                    </div>
                    <div class="left_img"><img src="/resources/images/profile_img.png"></div>
                    <div class="right_text">
                        <ul>
                            <li>returnp</li>
                            <li>2019-10-02 </li>
                        </ul>
                    </div>
                    <div class="review_img">
                        <img src="/resources/images/slide_img1.png">
                    </div>
                    <div class="review_img">
                        <img src="/resources/images/slide_img2.png">
                    </div>
                    <div class="review_text">
                        정말 맛있게 잘 먹었습니다. 음식도 너무 깔끔하고 맛있고 사장님도 너무 친절하셔서 다시 또 방문할것 같습니다.
                    </div>
                </div> -->
            </div>
            
            <div role="tabpanel" class="tab-pane fade" id="position" aria-labelledBy="position-tab">
                <div style = "padding : 5px 0px  0px  0px ">
                <div  id = "map_canvas" style = "width : 100%; height: 500px;"> </div>
                <p class="position_text">${model.affiliate.affiliateAddress} </p>
                </div>
            </div>
        </div>
    </div>
	</section>
	
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB-bv2uR929DOUO8vqMTkjLI_E6QCDofb4&callback=initMap"></script>
</body>
<!-- body end -->
</html>