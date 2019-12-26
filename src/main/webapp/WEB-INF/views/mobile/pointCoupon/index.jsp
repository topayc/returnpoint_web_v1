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
	
	$(".cord_acc_btn").click(function(){
		var pointCode = $(this).attr("point_code");
		location.href = "/m/pointCoupon/pointCodeInfo.do?pointCode=" + pointCode
	});
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
		<h4>RETURNP</h4>
	</header> 
	
	<!-- 팝업창 -->
	<div id="popup">
	<div class="body">
		<div class="box">
			<div class="popup_top">영수증 업로드 방법을 선택해주세요.<img src="/resources/images/close.png"></div>
			<div class="popup_box">
				<div onclick = "movePage('/m/pointCoupon/uploadReceipt.do?receiptType=1')" class="popup_img_box" style="margin-bottom:5px;">
					<div class="popup_box1"><img src="/resources/images/popup_file.png"></div>
					<div class="popup_box2">
						<ul>
							<li class="popup_box2_text1">가맹점 영수증 올리기</li>
							<li class="popup_box2_text2">R POINT 가맹점 영수증을 올릴 수 있으며 업 로드시 기존 QR 스캔 절차와 동일한 방식으로 포인트가 적립됩니다.</li>
						</ul>
					</div>
				</div>
				<div onclick = "movePage('/m/pointCoupon/uploadReceipt.do?receiptType=2')" class="popup_img_box">
					<div class="popup_box1"><img src="/resources/images/popup_camera.png"></div>
					<div class="popup_box2">
						<ul>
							<li class="popup_box2_text1">비가맹점 영수증 올리기</li>
							<li class="popup_box2_text2">비 가맹점 영수증의 경우 올리신 회원분과 그 회원분의 2대까지 포인트가 적립됩니다.</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
  </div>
  
	<section>
		<ul class="coupon_tab">
		   <li class = "on"><a style="margin-left:2%;" id  = "first_tab"  tabcode = "1">홈</a>
		      <div class="coupon_contents">
		      	<div class="coupon_top">
		      		<div class="coupon_top1">
		      			<ul>
		      				<li class="code_text1">적립총액</li>
		      				<li class="code_text2">
		      					<c:choose>
		      					<c:when test = "${model.pointCodeSummary.totalAccPoint == 0.0}">0</c:when>
		      					<c:otherwise><fmt:formatNumber value="${model.pointCodeSummary.totalAccPoint}" pattern="###,###,###,###"/> </c:otherwise>
		      					</c:choose>
		      				</li>
		      			</ul>
		      		</div>
		      		<div class="coupon_top2">
		      			<ul>
		      				<li class="code_text1">적립가능</li>
		      				<li class="code_text2">${model.pointCodeSummary.usableCount}</li>
		      			</ul>
		      		</div>
		      		<div class="coupon_top3">
		      			<ul>
		      				<li class="code_text1">적립완료</li>
		      				<li class="code_text2">${model.pointCodeSummary.completeCount}</li>
		      			</ul>
		      		</div>
		      	</div>
		      	<div class="coupon_m">
		      		<div class="upload"  ><img src="/resources/images/upload.png">&nbsp;비가맹점 영수증 올리기</div>
		      		<!-- <div class="register"><a onclick = "movePage('/m/pointCoupon/help.do')"><img src="/resources/images/coupon_check.png">&nbsp;적립코드 등록하기</a></div> -->
		      	</div>
		      	<div class="coupon_code1">
		      		<p>비가맹점 영수증 적립서비스란</p>
		      		<span>R 포인트 가맹점에서 사용한 영수증만 적립이 가능한 서비스에서 이제는 R 포인트 가맹점이 아닌 비가맹점도 결제한 만큼 G 포인트를 100% 적립해 드리는 서비스 입니다.</span>
		      		<div class="coupon_btn1">
		      			<button onclick = "movePage('/m/pointCoupon/help.do')"><!-- <img src="/resources/images/receipt_search.png"> -->서비스 보기</button>
		      			<button onclick = "movePage('/m/pointCoupon/help2.do')" style="margin-left:10px;"><!-- <img src="/resources/images/receipt_search.png"> -->처리 규정</button>
		      		</div>
		      	</div>
		      	<div class="coupon_code2">
		      		<p>비가맹점 영수증 적립방법</p>
		      		<!-- <div>영수증 올리기 > 금액입금 > 입금확인 > 적립코드발송</div> -->
		      		<ul style="list-style-type:disc;">
		      			<li>1.영수증 올리기 : 상단의 비가맹점 올리기 버튼 클릭 후 진행</li>
		      			<li>2.금액 입금 : 영수증 총 결제 금액의 15% 입금</li>
		      			<li>3.임금 확인 : 15% 금액 입금 확인 </li>
		      			<li>4.적립코드 발행  :  100% G.POINT 적립코드 발행</li>
		      			<li style = "margin-top:10px">&#42; 자세한 사용방법을 확인하시려며 바로 위의  <span style = "color : #04B431;font-weight:bold">서비스보기</span> 를 클릭하세요</li>
		      		<!-- 	<li style = "margin-top:10px">&#42; 해당 금액을 입금한 후, 상단 탭 메뉴중 '영수증처리' 탭을 선택후 표시되는 영수증에서   <span style = "color : #2E9AFE;font-weight:500">입금확인 요청버튼</span>을 클릭하시면 더욱 빠른 처리가 가능합니다</li> -->
		      		</ul>
		      	</div>
		      	<div class="coupon_code3">
		      		<p>입금은행</p>
		      		<div>
		      			<!-- <img src="/resources/images/bank.png"> --><b>우리은행 &nbsp;&nbsp;999-9999-9999 &nbsp;&nbsp;예금주:안영철</b>
		      		</div>
		      	</div>
		    <!--   	<div class="coupon_code4">
		      		<p>비가맹점 적립 처리 규정</p>
		      		<ul style="list-style-type:none;">
		      			<li style="list-style-type:none">비가맹점 적립 처리와 관련한 입금 확인은 매일 오후 4시에 일괄 확인되며, 입금 확인된 건에 대하여 발송됩니다.</li>
		      			<li style="list-style-type:none;">코드 발송은 문자메시지,앱 푸시 메시지중 회원님이 영수증 업로드시 선택하신 방법에 의하여 발송됩니다.</li>
		      		</ul>
		      	</div> -->
		      </div>
		   </li>
		   <li><a tabcode = "2">영수증처리</a>
		      <div class="coupon_contents">
		        <div class="coupon_upload">
		        
		        	<c:choose>
					<c:when test = "${empty model.receipts }">
						<div class="list_none" style="width:70%;margin-left:15%;margin-top:27%;height:200px;" onclick = "movePage('/m/pointCoupon/receiptDetail.do?pointCodeIssueRequestNo=${receipt.pointCodeIssueRequestNo}')">
							<img src="/resources/images/list_none_img.png" width="80" height="80">
							<p>등록하신 영수증이 없습니다.</p>
						</div>
					</c:when>
					<c:otherwise>
						<c:forEach var="receipt"  items="${model.receipts}"  >
							<div style = "padding-bottom:28px" onclick = "movePage('/m/pointCoupon/receiptDetail.do?pointCodeIssueRequestNo=${receipt.pointCodeIssueRequestNo}')">
		        				<div class="coupon_img_box"><img src = "${receipt.uploadFile}"/></div>
		        				<p>
		        					<span>
		        						<fmt:parseDate value="${receipt.createTime}" var="createTime" pattern="yyyy-MM-dd HH:mm:ss"/>
										<fmt:formatDate value="${createTime}" pattern="yyyy년 MM월 dd일  HH시 mm분"/> 
		        					</span>
		        				</p>
		        				
		        				<p style = "margin-top:7px">
			        				<c:choose>
								    	<c:when test = "${receipt.status == '1'}"><span class = "check_deposit_1"  style = "color : #fff;">입급확인중</span></c:when>
								    	<c:when test = "${receipt.status == '2'}"><span class = "check_deposit_2" style = "color : #fff">입금확인 요청중</span></c:when>
								    	<c:when test = "${receipt.status == '3'}"><span class = "check_deposit_3" style = "color : #fff">입금확인 완료</span></c:when>
								    	<c:when test = "${receipt.status == '4'}"><span class = "check_deposit_4" style = "color : #fff">적립코드 발급완료</span></c:when>
								    	<c:when test = "${receipt.status == '5'}"><span class = "check_deposit_5" style = "color : #fff">입금취소 </span></c:when>
								    	<c:when test = "${receipt.status == '6'}"><span class = "check_deposit_6" style = "color : #fff">처리불가 </span></c:when>
							    	</c:choose>
						    	</p>
		        			</div>
						</c:forEach>
					</c:otherwise>
					</c:choose>
		        </div>
		      </div>
		   </li>
		   <li><a style="left:50%;" tabcode = "3">적립가능</a>
				<div class="coupon_contents">
			    <c:choose>
					<c:when test = "${empty model.useablePointCodes }">
						<div class="list_none">
							<img src="/resources/images/list_none_img.png" width="80" height="80">
							<p>적립 가능한 적립코드가 없습니다.</p>
						</div>
					</c:when>
					<c:otherwise>
				        <div class="coupon_code_page2">
				        	<ul>
				      		<c:forEach var="useablePointCode"  items="${model.useablePointCodes}"  >
				      			<li>
				      				<ul>
				      					<li class="code_text2">${useablePointCode.pointCode}</li>
				      					<li class="code_text1" style = "font-weight:500;font-size">
				      						<fmt:parseDate value="${useablePointCode.createTime}" var="createTime1" pattern="yyyy-MM-dd HH:mm:ss"/>
											<fmt:formatDate value="${createTime1}" pattern="yyyy년 MM월 dd일  HH시 mm분"/> 
				      					</li>
				      					<li class="code_text1">기준금액 : <fmt:formatNumber value="${useablePointCode.payAmount}" pattern="###,###,###,###"/> </li>
				      					<li class="code_text1">적립금액 : <fmt:formatNumber value="${useablePointCode.accPointAmount}" pattern="###,###,###,###"/>(적립율 100%)</li>
				      					<button class = "cord_acc_btn" point_code = "${useablePointCode.pointCode}" >적립</button>
				      				</ul>
				      			</li>
				      			</c:forEach>
				      		</ul>
				        </div>
			    	</c:otherwise>
				</c:choose>
		      </div>
				
		   </li>
		   <li><a style="left:75%;margin-right:2%;" tabcode = "4">적립완료</a>
		      <div class="coupon_contents">
		           <c:choose>
					<c:when test = "${empty model.completePointCodes }">
						<div class="list_none">
							<img src="/resources/images/list_none_img.png" width="80" height="80">
							<p>적립 완료된 적립코드가 없습니다.</p>
						</div>
					</c:when>
					<c:otherwise>
		        <div class="coupon_code_page1">
		        	<ul>
						<c:forEach var="completePointCode"  items="${model.completePointCodes}"  >
			      			<li>
			      				<ul>
			      					<li class="code_text2">${completePointCode.pointCode}</li>
			      					<li class="code_text1" style = "font-weight:500;">
			      						<fmt:parseDate value="${completePointCode.createTime}" var="createTime2" pattern="yyyy-MM-dd HH:mm:ss"/>
										<fmt:formatDate value="${createTime2}" pattern="yyyy년 MM월 dd일  HH시 mm분"/> 
			      					</li>
			      					<li class="code_text1">기준금액 : <fmt:formatNumber value="${completePointCode.payAmount}" pattern="###,###,###,###"/></li>
			      					<li class="code_text1">적립금액 : <fmt:formatNumber value="${completePointCode.accPointAmount}" pattern="###,###,###,###"/>(적립율 100%)</li>
			      				</ul>
			      			</li>
			      			</c:forEach>
		      		</ul>
		        </div>
		           	</c:otherwise>
				</c:choose>
		      </div>
		      
		   </li>
		</ul>
   </section>
     <div id = "progress_loading2">
		<img src="/resources/images/progress_loading.gif"/>
	</div>
<script>
	$(".coupon_tab > li > a ").click(function(){
	   $(this).parent().addClass("on").siblings().removeClass("on");
	   /* alert($(this).attr("tabcode")); */
	   return false;
	});
	
$(".coupon_m .upload").click(function(){
		$("#popup").addClass("active");
		});
		$("#popup img").click(function(){
		$("#popup").removeClass("active");
		}); 
	
	</script>
</body>
<!-- body end -->
</html>