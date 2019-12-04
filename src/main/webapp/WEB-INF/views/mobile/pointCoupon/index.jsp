<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="format-detection" content="telephone=no"/>
<!-- css   -->
<!-- font -->
<link rel="stylesheet" href="/resources/css/m_common.css">
<!-- js -->
<script type="text/javascript" src="/resources/js/lib/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/m_common.js"></script>
<script type="text/javascript" src="/resources/js/lib/m_point_gift.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var pageContextlocale = '${pageContext.response.locale}';
	$("#sel1").val(pageContextlocale);
});

</script>
<style>
 * {font-weight:300}
</style>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_terms">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4>포인트 쿠폰</h4>
	</header> 
	
	<!-- 팝업창 -->
	
	
	<div id="popup">
	<div class="body">
		<div class="box">
			<div class="popup_top">영수증 업로드 방법을 선택해주세요.<img src="/resources/images/close.png"></div>
			<div class="popup_box">
				<div class="popup_img_box" style="margin-right:2%;"><img src="/resources/images/popup_file.png"><p>파일에서 올리기</p></div>
				<div class="popup_img_box"><img src="/resources/images/popup_camera.png"><p>사진찍어 올리기</p></div>
			</div>
		</div>
	</div>
  </div>
  
  
		
	<section>
		<ul class="coupon_tab">
		   <li class = "on"><a href="#" style="margin-left:2%;" id  = "first_tab" >적립요약</a>
		      <div class="coupon_contents">
		      	<div class="coupon_top">
		      		<div class="coupon_top1">
		      			<ul>
		      				<li class="code_text1">적립총액</li>
		      				<li class="code_text2">100,000</li>
		      			</ul>
		      		</div>
		      		<div class="coupon_top2">
		      			<ul>
		      				<li class="code_text1">사용가능</li>
		      				<li class="code_text2">10</li>
		      			</ul>
		      		</div>
		      		<div class="coupon_top3">
		      			<ul>
		      				<li class="code_text1">사용완료</li>
		      				<li class="code_text2">20</li>
		      			</ul>
		      		</div>
		      	</div>
		      	<div class="coupon_m">
		      		<div class="upload"><a href="#">영수증 업로드 하기</a></div>
		      		<div class="register"><a href="#">적립코드 등록하기</a></div>
		      	</div>
		      	<div class="coupon_code">
		      		<ul>
		      			<li>
		      				<ul>
		      					<li class="code_text1">1982-09-17</li>
		      					<li class="code_text2">코드:SDIJUYWGIOPLLSLFJN</li>
		      					<li class="code_text1">기준 금액 : 10,000</li>
		      					<li class="code_text1">적립 금액 : 10,000 (적립율 100%)</li>
		      				</ul>
		      			</li>
		      			<li>
		      				<ul>
		      					<li class="code_text1">1982-09-17</li>
		      					<li class="code_text2">코드:SDIJUYWGIOPLLSLFJN</li>
		      					<li class="code_text1">기준 금액 : 10,000</li>
		      					<li class="code_text1">적립 금액 : 10,000 (적립율 100%)</li>
		      				</ul>
		      			</li>
		      			<!--  코드 단 추가시 복사 붙여넣기 하시면되요 
		      			<li>
		      				<ul>
		      					<li class="code_text1">1982-09-17</li>
		      					<li class="code_text2">코드:SDIJUYWGIOPLLSLFJN</li>
		      					<li class="code_text1">기준 금액 : 10,000</li>
		      					<li class="code_text1">적립 금액 : 10,000 (적립율 100%)</li>
		      				</ul>
		      			</li>--->
		      		</ul>
		      	</div>
		      </div>
		   </li>
		   <li><a href="#">업로드내역</a>
		      <div class="coupon_contents">
		        <div class="coupon_upload">
		        	<div>
		        		<div class="coupon_img_box"></div>
		        		<span>1982-09-17</span>
		        	</div>
		        	<div>
		        		<div class="coupon_img_box"></div>
		        		<span>1982-09-17</span>
		        	</div>
		        	<div>
		        		<div class="coupon_img_box"></div>
		        		<span>1982-09-17</span>
		        	</div>
		        </div>
		        <div class="coupon_upload">
		        	<div>
		        		<div class="coupon_img_box"></div>
		        		<span>1982-09-17</span>
		        	</div>
		        	<div>
		        		<div class="coupon_img_box"></div>
		        		<span>1982-09-17</span>
		        	</div>
		        	<div>
		        		<div class="coupon_img_box"></div>
		        		<span>1982-09-17</span>
		        	</div>
		        </div>
		        <div class="coupon_upload">
		        	<div>
		        		<div class="coupon_img_box"></div>
		        		<span>1982-09-17</span>
		        	</div>
		        	<div>
		        		<div class="coupon_img_box"></div>
		        		<span>1982-09-17</span>
		        	</div>
		        	<div>
		        		<div class="coupon_img_box"></div>
		        		<span>1982-09-17</span>
		        	</div>
		        </div>
		       <!--추가시 이미지 줄 추가   
		       <div class="coupon_upload">
		        	<div>
		        		<div class="coupon_img_box"></div>
		        		<span>1982-09-17</span>
		        	</div>
		        	<div>
		        		<div class="coupon_img_box"></div>
		        		<span>1982-09-17</span>
		        	</div>
		        	<div>
		        		<div class="coupon_img_box"></div>
		        		<span>1982-09-17</span>
		        	</div>
		        </div> -->
		      </div>
		   </li>
		   <li><a href="#" style="left:50%;">사용완료</a>
		      <div class="coupon_contents">
		        <div class="coupon_code_page1">
		        	<ul>
		      			<li>
		      				<ul>
		      					<li class="code_text1">1982-09-17</li>
		      					<li class="code_text2">코드:SDIJUYWGIOPLLSLFJN</li>
		      					<li class="code_text1">기준 금액 : 10,000</li>
		      					<li class="code_text1">적립 금액 : 10,000 (적립율 100%)</li>
		      				</ul>
		      			</li>
		      			<li>
		      				<ul>
		      					<li class="code_text1">1982-09-17</li>
		      					<li class="code_text2">코드:SDIJUYWGIOPLLSLFJN</li>
		      					<li class="code_text1">기준 금액 : 10,000</li>
		      					<li class="code_text1">적립 금액 : 10,000 (적립율 100%)</li>
		      				</ul>
		      			</li>
		      		</ul>
		        </div>
		      </div>
		   </li>
		   <li><a href="#"style="left:75%;margin-right:2%;">사용가능</a>
		      <div class="coupon_contents">
		        <div class="coupon_code_page2">
		        	<ul>
		      			<li>
		      				<ul>
		      					<li class="code_text1">1982-09-17</li>
		      					<li class="code_text2">코드:SDIJUYWGIOPLLSLFJN</li>
		      					<li class="code_text1">기준 금액 : 10,000</li>
		      					<li class="code_text1">적립 금액 : 10,000 (적립율 100%)</li>
		      					<button>적립</button>
		      				</ul>
		      			</li>
		      			<li>
		      				<ul>
		      					<li class="code_text1">1982-09-17</li>
		      					<li class="code_text2">코드:SDIJUYWGIOPLLSLFJN</li>
		      					<li class="code_text1">기준 금액 : 10,000</li>
		      					<li class="code_text1">적립 금액 : 10,000 (적립율 100%)</li>
		      					<button>적립</button>
		      				</ul>
		      			</li>
		      		</ul>
		        </div>
		      </div>
		   </li>
		</ul>
   </section>
<script>
	$(".coupon_tab > li > a ").click(function(){
	   $(this).parent().addClass("on").siblings().removeClass("on");
	   return false;
	});
	
	$(".upload > a").click(function(){
		$("#popup").addClass("active");
		});
		$("#popup img").click(function(){
		$("#popup").removeClass("active");
		});
	
	</script>
</body>
<!-- body end -->
</html>