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
<script type="text/javascript" src="/resources/js/lib/jquery-number.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var pageContextlocale = '${pageContext.response.locale}';
	$("#sel1").val(pageContextlocale);
	
	/* alert(getParams()['uploadMethod']); */
	$("#payAmount").blur(function(){
		
		var payAmount = $(this).val().trim();
		if (!$.isNumeric(payAmount)) {
			alertOpen("확인", "숫자만 입력가능합니다", true, false, null, null);
			return false;
		}
		payAmount = parseInt(payAmount);
		$(".upload_conbox_p").text( $.number(payAmount * 0.15) + ' 원');
		$(".accPoint").text( $.number(payAmount) + ' 원');
		
		$('#depositAmount').val($.number(payAmount * 0.15));
		$('#accPointAmount').val($(this).val(payAmount));
	})

	$("#selectPhoneImage").click(function(){
		selectImage();
	})

	$("#selectCameraImage").click(function(){
		selectCameraImage();
	})
	
	$("#receipt_submit").click(function(){
		var data = {
			receiptFile : $('#receiptFile').val().trim(),
			payAmount : $('#payAmount').val().trim(),
			accAmount : $('#accPointAmount').val().trim(),
			depositAmount : $('#depositAmount').val().trim(),
			depositBankAccount : $('#depositBankAccount').val().trim(),
			depositor: $('#depositor').val().trim()
			
		};
		
		var nameMapper = {
			payAmount : "결제 금액",
			depositBankAccount : "입금 은행 정보",
			accAmount : "적립 금액",
			depositAmount : "적립 금액",
			depositor : "입금자",
			receiptFile : "영수증"	
		}
		
		for (var prop in data){
			if (data.hasOwnProperty(prop)) {
				if (data[prop] == '' || data[prop].length < 1) {
					var message = prop == "receiptFile" ? " 파일이 등록되지 않았습니다.</br>갤러리와 카메라로 영수증 파일을 등록할 수 있습니다. ": " 항목이 입력되지 않았습니다.";
					alertOpen("알림", nameMapper[prop] + message, true, false, null, null); 
					return;
				}
			}
		}
		
			
		$.ajax({
	       	   type: "POST",
	              url: "/m/pointCoupon/uploadReceipt.do",
	               data: data,
	               success: function (result) {
	            	  console.log(result);
	            	   if (result && typeof result !="undefined") {
	            	   		if (result.result.code == 0) {
	            	   			alertOpen("알림", result.result.msg, true, false,function(){location.href = "/m/pointCoupon/index.do"}, null); 
							}else {
								alertOpen("알림", result.result.msg, true, false, null, null); 
							}
		               }else{
		              		alertOpen("알림", "1.장애 발생. 다시 시도해주세요.", true, false, null, null);
		           	   }
	               },
	               error : function(request, status, error){
	            	   alertOpen("알림 ", "2.장애 발생. 다시 시도해주세요", true, false, null, null);
	               },
	               dataType: 'json'
	       });
	})

	$("#cancel").click(function(){history.go(-1); });
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
		<h4>영수증 올리기</h4>
	</header> 
	<section>
	<div class="upload_receipt">
		<div class="upload_conbox">
				<p style = "font-weight:550;">영수증 가져올 방법을 선택해주세요</p>
				<div class="receipt_imgbox">
					<button class="recv_method" id = "selectPhoneImage" style="border-right:none;"><img src="/resources/images/gallery_img.png">&nbsp;&nbsp;&nbsp;&nbsp;갤러리</button>
					<button class = "recv_method"  id = "selectCameraImage"><img src="/resources/images/camera_img.png">&nbsp;&nbsp;&nbsp;&nbsp;카메라 촬영</button>
					<div class="bg_img">
							<img id = "receipt_img"  >
					</div>
				</div> 
			
				<p style = "font-weight:550;margin-top:20px">결제 영수증상의 결제 금액 합계를 입력해주세요.</p>
				<input type="number"  name = "payAmount" id = "payAmount"" style = "font-size:15px" / >
				<input type = "hidden" name = "receiptFile" id = "receiptFile" />
				<input type = "hidden" name= "accPointAmount" id = "accPointAmount" />
				<input type = "hidden" name= "depositBankAccount" id = "depositBankAccount" value = "국민은행:10000-11111:안영철"/>
				<input type = "hidden" name= "depositAmount" id = "depositAmount"  />
				
				<div style = "margin-top:5px">
				<p style = "font-weight:550">적립 받을 포인트(100%) </p>
				<p class="upload_conbox_p accPoint" style = "background-color : #eee; border:1px solid #ccc;color : #555;margin-top:10px;font-size : 15px;font-weight:400;">&nbsp;</p>
				</div>
			
				<div style = "margin-top:20px">
					<p style = "font-weight:550">회원님이 입금하셔야 할 금액(결제금액의 15%)</p>
					<p class="upload_conbox_p" style = "background-color : #eee; border:1px solid #ccc;color : #555;margin-top:10px;font-size : 15px;font-weight:400;">&nbsp;</p>
				</div>
						
				<p style = "margin-top:20px;font-weight:550">입금자명</p>
				<input type="text"  name = "depositor"  id = "depositor" style = "font-size:16px" value = ""/>
			
			
				<p style = "margin-top:7px;font-weight:550">15% 금액 입금 계좌</p>
				<div style = "font-size:15px;border:1px solid #ddd;margin-top:10px;width: 100%; border:1px solid #ccc; padding: 4% 2%; text-align: center;margin-bottom:70px">
				 국민은행    10000-11111    예금주 : 안영철 
				</div>
		</div>
		<div class="bottom_btn">
			<div class="bottom_btn1"  id = "receipt_submit">올리기</div>
			<div class="bottom_btn2" id = "cancel">취소</div>
		</div>
		<%-- <div class="btns2">
			<button type="button" class="btn btn-submit" onclick = "startPointBack()"><spring:message code="label.ok" /></button>
			<button type="button" class="btn btn-submit-cancel"  onclick = "history.back()"><spring:message code="label.cancel" /></button>
		</div> --%>
	</div>
   </section>
</body>
<!-- body end -->
</html>