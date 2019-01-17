<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="com.returnp_web.utils.SessionManager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html> 
<html lang="en">
<head>
<title>ReturnP</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<!-- css   -->
<!-- font -->
<link rel="stylesheet" href="/resources/css/common.css">
<!-- js -->
<script src="/resources/js/lib/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/common.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var pageContextlocale = '${pageContext.response.locale}';
	$("#sel1").val(pageContextlocale);
});
</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_rpshop">
	<!-- nav -->
	<jsp:include page="/WEB-INF/views/common/topper.jsp" />
	<!-- nav -->
		<h4>Search for Store</h4>
	</header> 
	<!-- content begin -->	
	<section>
		<h4>내 주변 가맹점</h4>
		<hr>
		<div class="rpstore_wrap">
			<div class="img_area">		
				<div id="myCarousel" class="carousel slide" data-ride="carousel">
				    <!-- Indicators --> 
					<ol class="carousel-indicators">
						<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
						<li data-target="#myCarousel" data-slide-to="1"></li>
						<li data-target="#myCarousel" data-slide-to="2"></li>
					</ol>					
					<div class="carousel-inner">
						<div class="item active"><img src="https://search.pstatic.net/common/?autoRotate=true&quality=95&size=720x480&src=http%3A%2F%2Fldb.phinf.naver.net%2F20170106_179%2F1483702047962bb2vK_JPEG%2F186056605747850_0.jpeg&type=l" alt="Los Angeles" style="width:100%;"></div>
						<div class="item"><img src="https://search.pstatic.net/common/?autoRotate=true&quality=95&size=720x480&src=http%3A%2F%2Fldb.phinf.naver.net%2F20170106_179%2F1483702047962bb2vK_JPEG%2F186056605747850_0.jpeg&type=l" alt="Chicago" style="width:100%;"></div>    
						<div class="item"><img src="https://search.pstatic.net/common/?autoRotate=true&quality=95&size=720x480&src=http%3A%2F%2Fldb.phinf.naver.net%2F20170106_179%2F1483702047962bb2vK_JPEG%2F186056605747850_0.jpeg&type=l" alt="New york" style="width:100%;"></div>
					</div>
					<a class="left carousel-control" href="#myCarousel" data-slide="prev">
						<span class="glyphicon glyphicon-chevron-left"> <i class="fas fa-chevron-left"></i> </span>
					</a>
					<a class="right carousel-control" href="#myCarousel" data-slide="next">
						<span class="glyphicon glyphicon-chevron-right"> <i class="fas fa-chevron-right"></i> </span>
					</a>
				</div>
			</div>
			 <ul class="rpstore_link">
			    <li class="active"><a data-toggle="tab" href="#menu1"><i class="fas fa-store"></i>홈</a></li>
			    <li><a data-toggle="tab" href="#menu2"><i class="fas fa-edit"></i>리뷰</a></li>
			    <li><a href=""><i class="fas fa-star"></i>즐겨찾기</a></li>
			    <li><a href=""><i class="fas fa-share-alt"></i>공유</a></li>
			  </ul>			
			  <div class="tab-content">
			    <div id="menu1" class="tab-pane fade active in">
			    	<div class="info_area">					
						<div class="info_tit"><span class="name">교대곱창</span><span class="cate">곱창,막창,양</span></div>
						<div class="info_sub ellp">날도 쌀쌀한데 곱창 날도 쌀쌀한데 곱창 날도</div>
						<div class="info_tag ellp"><span class="item">흑돼지</span><span class="item">삼겹살</span><span class="item">tv방영</span><span class="item">신선한</span></div>
					</div>
					<div class="info_add"><i class="fas fa-map-marker-alt"></i> 서울시 서초구 서초동 1677-8 <a class="phone" href="tel:02-1234-5678"><i class="fas fa-phone"></i>전화</a></div>	
					<div class="info_add"><i class="fas fa-clock"></i> 매일 11:30 - 05:00 명절 휴무</div>	
					<div class="info_add"><i class="fas fa-gift"></i> 
						<ul class="info_price">
							<li><span class="itemname">곱창</span> <span class="itemprice">50,000원</span></li>
							<li><span class="itemname">대창</span> <span class="itemprice">50,000원</span></li>
							<li><span class="itemname">막창</span> <span class="itemprice">50,000원</span></li>
						</ul>
					</div>	
					<div class="info_map"></div>				
			    </div>
			    <ul id="menu2" class="tab-pane fade">
			    	<li>
				    	<div class="review_img"><img src="https://search.pstatic.net/common/?autoRotate=true&quality=95&size=720x480&src=http%3A%2F%2Fldb.phinf.naver.net%2F20170106_179%2F1483702047962bb2vK_JPEG%2F186056605747850_0.jpeg&type=l" /></div>
				    	<div class="review_txt">
					    	<p class="review_date">2018.08.31</p>
				    		<p class="review_title ellp">[교대맛집] 강남 요대역 곰창 맛집 원조교대곱창 맛나요</p>
				    		<p class="review_content">강남 교대역 원조교대곱창 워낙 유명해서 소개도 필요 없음~ 늦게 가면 줄 서야하고, 원조교대곱창 두 군데 있는데 같은 집이랬다!! 약속 장소로 교대역이 적당해서 찾아갔던 원조교대곱창!!</p>
			    		</div>	
			    	</li>
			    	<li>
				    	<div class="review_img"></div>
				    	<div class="review_txt">
					    	<p class="review_date">2018.08.31</p>
				    		<p class="review_title ellp">[교대맛집] 강남 요대역 곰창 맛집 원조교대곱창 맛나요</p>
				    		<p class="review_content">강남 교대역 원조교대곱창 워낙 유명해서 소개도 필요 없음~ 늦게 가면 줄 서야하고, 원조교대곱창 두 군데 있는데 같은 집이랬다!! 약속 장소로 교대역이 적당해서 찾아갔던 원조교대곱창!!</p>
			    		</div>	
			    	</li>
			    	<li>
				    	<div class="review_txt">
					    	<p class="review_date">2018.08.31</p>
				    		<p class="review_title ellp">[교대맛집] 강남 요대역 곰창 맛집 원조교대곱창 맛나요</p>
				    		<p class="review_content">강남 교대역 원조교대곱창 워낙 유명해서 소개도 필요 없음~ 늦게 가면 줄 서야하고, 원조교대곱창 두 군데 있는데 같은 집이랬다!! 약속 장소로 교대역이 적당해서 찾아갔던 원조교대곱창!!</p>
			    		</div>	
			    	</li>
			    </ul>
			  </div>		  	
		</div>
	</section>
	<!-- content end -->
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<!-- footer -->	
</div> 
 	<!-- privacy policy modal -->
	<jsp:include page="../company/m_privacypolicy.jsp" flush="false" />
	<!-- privacy policy modal end -->
	<!-- terms of ues modal -->
	<jsp:include page="../company/m_termsofuse.jsp" flush="false" />
	<!-- terms of ues modal end -->
</body>
<!-- body end -->
</html>
