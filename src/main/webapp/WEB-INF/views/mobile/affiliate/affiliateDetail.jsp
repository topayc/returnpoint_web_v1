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
<link rel="stylesheet" href="/resources/css/affiliate_detail.css">
<!-- js -->
<script type="text/javascript" src="/resources/js/lib/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/bootstrap.min.js"></script>
<link rel="stylesheet" href="/resources/web_css/common.css">
<script type="text/javascript" src="/resources/js/lib/m_common.js"></script>
<script>
function movePage(url){
	location.href = url
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
		<h4><spring:message code="label.affiliate_detail" /></h4>
	</header> 
	<section>
        <div class="main_slide">
            <div id="myCarousel" class="carousel slide" data-ride="carousel">
                <div class="carousel-inner">
                    <div class="item active">
                        <img src="/resources/images/slide_img1.png" alt="슬라이드이미지">
                    </div>
                    <div class="item">
                        <img src="/resources/images/slide_img2.png" alt="슬라이드이미지">
                    </div>
                    <div class="item">
                        <img src="/resources/images/slide_img3.png" alt="슬라이드이미지">
                    </div>
                </div>
            </div>
        </div>
        <div class="main">
            <p class="text1">박가네소갈비 구로디지털점</p>
            <span class="text2">최근리뷰 <span class="badge badge-pill badge-success">245</span></span>
        </div>
        <div class="bt_box">
            <button type="button" class="btn btn-default">홈페이지</button>
            <button type="button" class="btn btn-default etc_link">youTube</button>
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
                 <div class="information">
                    <ul>
                        <li><img src="/resources/images/back_img5.png">소개</li>
                        <li>
                            언제나 맛있는 음식으로 대접하겠습니다. 좋은 하루 되시고요. 언제든지 문의 주십시오
                        </li>
                    </ul>
                </div>
                
                
                <div class="information">
                    <ul>
                        <li><img src="/resources/images/back_img5.png">사장님 인사말</li>
                        <li>
                            안녕하세요. 사장입니다.
                            </br>
                            안녕하세요. 사장입니다.
                        </li>
                    </ul>
                </div>
                 
                        <div class="information">
                    <ul>
                        <li><img src="/resources/images/back_img1.png">영업 정보</li>
                        
                        <li>
                            <ul>
                                <li>영업시간</li>
                                <li>06:30 - 20:30</li>
                            </ul>
                        </li>
                        <li>
                            <ul>
                                <li>전화번호</li>
                                <li>0123456789</li>
                            </ul>
                        </li>
                          <li>
                            <ul>
                                <li>휴무일</li>
                                <li>매주 월요일</li>
                            </ul>
                        </li>
                        
                        <li>
                            <ul>
                                <li>적립정보</li>
                                <li>결제 시 <span class="badge badge-pill badge-success">100%</span> G POINT  적립</li>
                            </ul>
                        </li>
                    </ul>
                </div>
                
                 <div class="information">
                    <ul>
                        <li><img src="/resources/images/back_img2.png">사업장 정보</li>
                        <li>
                            <ul>
                                <li>상호명</li>
                                <li>박가네소갈비</li>
                            </ul>
                        </li>
                        <li>
                            <ul>
                                <li>대표자</li>
                                <li>안영철</li>
                            </ul>
                        </li>
                            <li>
                            <ul>
                                <li>업종</li>
                                <li>유통 </li>
                            </ul>
                        </li>
                          <li>
                            <ul>
                                <li>업태</li>
                                <li>유통 </li>
                            </ul>
                        </li>
                        
                        <li>
                            <ul>
                                <li>사업자등록번호</li>
                                <li>012-3456-789</li>
                            </ul>
                             <ul>
                                <li>사업장 주소 </li>
                                <li>경기도 수원시 서둔동</li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <div class="information">
                    <ul>
                        <li><img src="/resources/images/back_img5.png">부가 정보</li>
                        <li>
                            담달에 이벤트를 합니다. 100, 000만원 구매시 소주 한병 무료
                        </li>
                    </ul>
                </div>
                
      
            </div>
            <div role="tabpanel" class="tab-pane fade" id="review" aria-labelledBy="review-tab">
          		
          		  <div class="information">
                    <ul>
                        <li><img src="/resources/images/back_img5.png">소식</li>
                        <li>
                            2019년 12월 10일에서 30일까지 오픈 이벤트를 진행합니다.
          			100만원 이상 구매지 핸드폰 악세서리 10종을 무료로 드립니다.
                        </li>
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
                <div class="position">
                    <table cellpadding="0" cellspacing="0" width="462">
                        <tr>
                            <td style="border:1px solid #cecece;"><a href="https://map.naver.com/index.nhn?query=6rWs66Gc65SU7KeA7YS464uo7KeA7Jet&searchCoord=&tab=1&lng=62fb52cd28e863e7e5e0d7ab8342d45d&mapMode=0&mpx=04357a8ba0bc623e406351aa4037cc2a546b99a7a3c9aee745dbefa3f904023c1ebb3c9b43733fd452c6efc63445c9c7&lat=72dfffead0a39bd9ec7a3c7565948b23&dlevel=14&enc=b64&menu=location&__fromRestorer=true" target="_blank"><img src="http://prt.map.naver.com/mashupmap/print?key=p1559271585844_1156680242" width="460" height="340" alt="지도 크게 보기" title="지도 크게 보기" border="0" style="vertical-align:top;" /></a></td>
                        </tr>
                        <tr>
                            <td>
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td height="30" bgcolor="#f9f9f9" align="left" style="padding-left:9px; border-left:1px solid #cecece; border-bottom:1px solid #cecece;"> <span style="font-family: tahoma; font-size: 11px; color:#666;">2019.5.31</span>&nbsp;<span style="font-size: 11px; color:#e5e5e5;">|</span>&nbsp;<a style="font-family: dotum,sans-serif; font-size: 11px; color:#666; text-decoration: none; letter-spacing: -1px;" href="https://map.naver.com/index.nhn?query=6rWs66Gc65SU7KeA7YS464uo7KeA7Jet&searchCoord=&tab=1&lng=62fb52cd28e863e7e5e0d7ab8342d45d&mapMode=0&mpx=04357a8ba0bc623e406351aa4037cc2a546b99a7a3c9aee745dbefa3f904023c1ebb3c9b43733fd452c6efc63445c9c7&lat=72dfffead0a39bd9ec7a3c7565948b23&dlevel=14&enc=b64&menu=location&__fromRestorer=true" target="_blank">지도 크게 보기</a> </td>
                                        <td width="98" bgcolor="#f9f9f9" align="right" style="text-align:right; padding-right:9px; border-right:1px solid #cecece; border-bottom:1px solid #cecece;"> <span style="float:right;"><span style="font-size:9px; font-family:Verdana, sans-serif; color:#444;">&copy;&nbsp;</span>&nbsp;<a style="font-family:tahoma; font-size:9px; font-weight:bold; color:#2db400; text-decoration:none;" href="http://www.nhncorp.com" target="_blank">NAVER Corp.</a></span> </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
                <p class="position_text">서울특별시 구로구 도림천로 477번지(구로동 810-3번지)</p>
            </div>
        </div>
    </div>
	</section>
</body>
<!-- body end -->
</html>