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
<script type="text/javascript">
$(document).ready(function(){
	var pageContextlocale = '${pageContext.response.locale}';
	$("#sel1").val(pageContextlocale);
	
	var p = getParams();
	var alertView = (p["alertView"]);
	var Message  = (p["Message"]);
	var message = "";
	var title = "확인";
	if(Message =="1"){
		message = "이미 정회원 신청을 하셨습니다.";
	}else if(Message =="2"){
		message = "관리자에게 접수되었습니다.";
	}
	if(alertView =="t"){
		var alertMessageHtml = "";
		var alertTitleHtml = "";
		document.getElementById('alertView').style.display='flex';	
		alertMessageHtml += "<p>"+message+"</p>";
		$('#alertMassage').html(alertMessageHtml);
		alertTitleHtml += "<strong><i class='fas fa-info-circle'></i>"+title+"</strong>";
		$('#alertTitle').html(alertTitleHtml);
		$('#alert_ok').show();
		$('#alert_cancel').hide();
	}
});
</script>
<script type="text/javascript">
function regularMemberSubmit() {
	var f = document.Frm2;
	var m_email 	= $("#m_email").val();
	var m_name 		= $("#m_name").val();
	var m_bank		= $("#m_bank").val();
	if(m_email == "" || m_name == "" || m_bank == ""){
		//alert("이메일, 입금자, 은행정보선택 은 필수입니다.");
		alertOpen("확인", "이메일, 입금자, 은행정보선택 은 필수입니다.", true, false, null, null);
		return false;
	}
	f.target = "";
	f.action = "/m/member/regular_member.do";
	f.submit();
}	

function goPaymentStatusUpdate(){
	var f = document.Frm2;
	f.target = "";
	f.action = "/m/member/updatePaymentStatus.do";
	f.submit();
}

function goPaymentStatusUpdateAlert(){
	alertOpen("확인", "입금완료 요청이 안료되었습니다.", true, false, null, null);
	return false;
}

</script>
</head>
<!-- header end -->
<!-- body begin -->
<body>	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4><spring:message code="label.mapplicationForFullMembership"/></h4>
	</header> 	
	<section>
		<form name="Frm2">
			<div class="modal-body">
				<div class="form-group">
					<label for="email"><spring:message code="label.memail"/></label> <input type="email" class="form-control" id="m_email" name="m_email" value="${model.mypageMyinfo.memberEmail}" disabled>
				</div>
				<div class="form-group">
					<label for="name"><spring:message code="label.mdepositor"/></label> <input type="text" class="form-control" id="m_name" name="m_name" placeholder="홍길동">
				</div>
				<div class="form-group">
				<!-- <label for="phone">입금 할 은행명</label> <input type="text" class="form-control" id="bank" placeholder="국민은행 (000 000 0000)"> -->
					<select class="form-control" id="m_bank" name="m_bank"> 
					<c:forEach var="item" items="${model.selectCompanyBankList}" varStatus="loop">
					    <option value="${item.companyBankAccountNo}" >${item.bankName} : ${item.bankOwnerName} (${item.bankAccount})</option>
					</c:forEach>
					</select>
				</div>
				<p class="info_red">&nbsp; * <spring:message code="label.mpleaseSpecifyTheActualDepositorName"/></p>
			</div>
			<button type="button" class="btn btn-submit"  onclick="regularMemberSubmit();"><spring:message code="label.mapplicationForFullMembership"/></button>
		</form>
     </section>	
</div>
</body>
<!-- body end -->
</html>
