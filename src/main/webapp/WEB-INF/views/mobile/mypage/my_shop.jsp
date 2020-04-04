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
 * {font-weight:400}
</style>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_terms">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4>나의 쇼핑 리스트</h4>
	</header> 
  
	<section>
	<div class="r_basket">
		<div class="r_basket_page">
			<div class="r_basket_day">
			<span class="r_basket_day1">18648682|2020.40.03</span><span class="r_basket_day2">></span><span class="r_basket_day3" onclick = "movePage('/m/shop/orderDetail.do')">주문상세보기</span>
			</div>
			<div class="r_basket_box">
				<!-- <div class="r_basket_page_btn">
					<input type="checkbox" id="r_check">
					<label for="r_check"></label>
				</div> -->
				<div class="r_basket_con">
					<div class="r_basket_contents">
						<div class="r_basket_img">
							<img src="/resources/images/r_basket_img.png">
						</div>
						<div class="r_basket_contents_text">
							<ul>
								<li>빈백 풋스툴 발받침</li>
								<li>3colors</li>
								<li><span>배송완료</span></li>
							</ul>
						</div>
					</div>
					<div class="r_basket_goods">
						<h5>무광올리브그린 보호패드포함</h5>
						<span>33,900원</span>
					</div>
					<div class="r_table_box">
					<p>결제정보</p>
					<table>
						<tr>
							<td class="r_table1">상품금액</td>
							<td class="r_table2">22,900</td>
							<td class="r_table1">결제방법</td>
							<td class="r_table2">무통장</td>
						</tr>
						<tr>
							<td class="r_table1">할인금액</td>
							<td class="r_table2">(-)6,000원</td>
							<td class="r_table1">주문자</td>
							<td class="r_table2">차미라</td>
						</tr>
						<tr>
							<td class="r_table1">선불배송비</td>
							<td class="r_table2">(+)0원</td>
							<td class="r_table1">연락처</td>
							<td class="r_table2">010-5845-0051</td>
						</tr>
						<tr>
							<td class="r_table1">사용포인트</td>
							<td class="r_table2">(-)0P</td>
							<td class="r_table1">이메일</td>
							<td class="r_table2">mira0326@naver.com</td>
						</tr>
						<tr>
							<td class="r_table1">쿠폰할인가</td>
							<td class="r_table2">(-)0P</td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td class="r_table1">결제금액</td>
							<td class="r_table2">16,900원</td>
							<td></td>
							<td></td>
						</tr>
					</table>
					</div>
					<div class="r_table_box" style="border:none;">
					<p>배송지 정보</p>
					<table>
						<tr>
							<td class="r_table1">수령인</td>
							<td class="r_table2">차미라</td>
						</tr>
						<tr>
							<td class="r_table1">연락처</td>
							<td class="r_table2">010-5845-0051</td>
						</tr>
						<tr>
							<td class="r_table1">주소</td>
							<td class="r_table2">서울시 구로구 구로동 1129-69</td>
						</tr>
						<tr>
							<td class="r_table1">배송메로</td>
							<td class="r_table2"></td>
						</tr>
					</table>
					</div>
				</div>
			</div>
		</div>


		<div class="r_basket_page">
			<p>인터피플 배송</p>
			<div class="r_basket_box">
				<!-- <div class="r_basket_page_btn">
					<input type="checkbox" id="r_check">
					<label for="r_check"></label>
				</div> -->
				<div class="r_basket_con">
					<div class="r_basket_contents">
						<div class="r_basket_img">
							<img src="/resources/images/r_basket_img.png">
						</div>
						<div class="r_basket_contents_text">
							<ul>
								<li>빈백 풋스툴 발받침</li>
								<li>3colors</li>
								<li><span>무료배송|일반택배</span></li>
							</ul>
						</div>
					</div>
					<div class="r_basket_goods">
						<h5>무광올리브그린 보호패드포함</h5>
						<span>33,900원</span>
					</div>
					
				</div>
			</div>
		</div>





<!-- 		<div class="r_basket_footer">
			<div class="r_basket_footer_left">총 상품금액</div>
			<div class="r_basket_footer_right">306,600원</div>
			<div class="r_basket_footer_left">총 배송비</div>
			<div class="r_basket_footer_right">+ 0원</div>
			<div class="r_basket_footer_left">총 할인금액</div>
			<div class="r_basket_footer_right">- 143,000원</div>
			<div class="r_basket_footer_l">결제금액</div>
			<div class="r_basket_footer_r">163,600원</div>
			<div class="r_basket_footer_btn">
			<span>5개 <b>163,600원</b></span><button>바로구매</button>
			</div>
		</div> -->
	</div>
   </section>
     <div id = "progress_loading2">
		<img src="/resources/images/progress_loading.gif"/>
	</div>
</body>
<!-- body end -->
</html>