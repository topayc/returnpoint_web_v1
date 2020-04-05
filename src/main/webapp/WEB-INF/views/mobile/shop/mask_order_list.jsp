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
		<c:forEach var="order" items="${model.orders}" varStatus="status">
		<div class="r_basket_page">
			<div class="r_basket_day">
			<span class="r_basket_day1">주문번호 : ${order.orderNumber}</span><span class="r_basket_day2"></span>
			</div>
			<div class="r_basket_box">
				<!-- <div class="r_basket_page_btn">
					<input type="checkbox" id="r_check">
					<label for="r_check"></label>
				</div> -->
				<div class="r_basket_con" data-toggle="collapse" data-target="#order_detail_${status.count}">
					<div class="r_basket_contents">
						<div class="r_basket_img">
							<img src="/resources/images/mask_img.png">
						</div>
						<div class="r_basket_contents_text">
							<ul>
								<li style = "font-size : 14px;font-weight : 500">${order.productName}</li>
								<li style = "font-size : 12px;color : #666">개당가격 : <fmt:formatNumber value="${order.productPrice}" pattern="###,###,###,###" />원 | 색상 : ${order.orderColor}</li>
								<li style = "font-size : 12px;color : #666">구매  :  ${order.orderUnit } 묶음 x ${order.orderQty}개 구매</li>
								<li>
										<c:choose>
									    	<c:when test = "${order.status == '1'}"><span style="padding:0 4px;font-size:13px;border-radius:20px;border:1px solid #33cccc">입금 확인중</span></c:when>
									    	<c:when test = "${order.status == '2'}"><span style="padding:0 4px;font-size:13px;border-radius:20px;border:1px solid #33cccc">입금 완료/배송전</span></c:when>
									    	<c:when test = "${order.status == '3'}"><span style="padding:0 4px;font-size:13px;border-radius:20px;border:1px solid #33cccc">배송중</span></c:when>
									    	<c:when test = "${order.status == '4'}"><span style="padding:0 4px;font-size:13px;border-radius:20px;border:1px solid #33cccc">배송 완료</span></c:when>
									    	<c:when test = "${order.status == '5'}"><span style="padding:0 4px;font-size:13px;border-radius:20px;border:1px solid #33cccc">주문 취소 </span></c:when>
									    	<c:when test = "${order.status == '6'}"><span style="padding:0 4px;font-size:13px;border-radius:20px;border:1px solid #33cccc">관리자 주문 취소</span></c:when>
									    </c:choose>
								</li>
							</ul>
						</div>
					</div>
					<div id="order_detail_${status.count}" class="list_toggle collapse" >
							<div class="r_table_box" >
							<p>계좌정보</p>
							<table>
								<tr>
									<td class="r_table1">은행명</td>
									<td class="r_table2">우리은행</td>
								</tr>
								<tr>
									<td class="r_table1">계좌번호</td>
									<td class="r_table2">1005-703-612321</td>
								</tr>
								<tr>
									<td class="r_table1">예금주</td>
									<td class="r_table2">주식회사 탑해피 월드</td>
								</tr>
								<tr>
									<td class="r_table1">입금금액</td>
									<td class="r_table2"><fmt:formatNumber value="${order.orderAmount}" pattern="###,###,###,###" />원</td>
								</tr>
							</table>
						</div>
						
						<div class="r_table_box">
							<p>결제정보</p>
							<table>
								<tr>
									<td class="r_table1">상품금액</td>
									<td class="r_table2"><fmt:formatNumber value="${order.totalPriceAmount}" pattern="###,###,###,###" />원</td>
									<td class="r_table1">결제방법</td>
									<td class="r_table2">무통장</td>
								</tr>
								<tr>
									<td class="r_table1">적립 GPOINT</td>
									<td class="r_table2"><fmt:formatNumber value="${order.gpointAmount}" pattern="###,###,###,###" />원 </td>
									<td class="r_table1">주문자</td>
									<td class="r_table2">${order.orderMemberName}</td>
								</tr>
								<tr>
									<td class="r_table1">선불배송비</td>
									<td class="r_table2"><fmt:formatNumber value="${order.deliveryCharge}" pattern="###,###,###,###" />원</td>
									<td class="r_table1">연락처</td>
									<td class="r_table2">${order.orderMemberPhone}</td>
								</tr>
								<tr>
									<td class="r_table1">결제금액</td>
									<td class="r_table2"><fmt:formatNumber value="${order.orderAmount}" pattern="###,###,###,###" />원</td>
								</tr>
							</table>
						</div>
						<div class="r_table_box" style="border:none;">
							<p>배송지 정보</p>
							<table>
								<tr>
									<td class="r_table1">수령인</td>
									<td class="r_table2">${order.receiverName}</td>
								</tr>
								<tr>
									<td class="r_table1">연락처</td>
									<td class="r_table2">${order.receiverPhone}</td>
								</tr>
								<tr>
									<td class="r_table1">주소</td>
									<td class="r_table2">${order.receiverAddress}</td>
								</tr>
								<tr>
									<td class="r_table1">배송메시지</td>
									<td class="r_table2">${order.reqMsg}</td>
								</tr>
							</table>
						</div>
				<!-- 		<div class="r_basket_goods">
							<h5>입금계좌 정보</h5>
							<span style = "font-size:13px">은행명 : 우리은행 </span>
							</br>
							<span style = "font-size:13px">계좌번호 :1005-703-612321</span>
							</br>
							<span style = "font-size:13px">예금주 : 주식회사 탑해피월드 </span>
							</br>
						</div> -->
					</div>
				</div>
			</div>
		</div>
		</c:forEach>
	</div>
   </section>
     <div id = "progress_loading2">
		<img src="/resources/images/progress_loading.gif"/>
	</div>
</body>
<!-- body end -->
</html>