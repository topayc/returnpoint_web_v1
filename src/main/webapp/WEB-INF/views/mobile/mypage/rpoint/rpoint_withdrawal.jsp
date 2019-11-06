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
<script type="text/javascript" src="/resources/js/lib/m_common.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('.del_account').click(function(){
		var target = $(this);
		alertOpen(
			"확인", 
			"정말로 계좌를 삭제하시겠습니까? ", 
			true, 
			true, 
			function(){deleteAccount(target.attr('memberBankNo').trim());}, 
			null);
		
	})
});

function deleteAccount(memberBankAccountNo) {
	  bridge.getSessionValue('PREF_ALL_SESSION', function(result){
		  var userAuthToken;
		  var ajax;
		  if (!result) {
			  ajax = true;
		  }else {
			  result = JSON.parse(result)
			  userAuthToken = result.user_auth_token;
		  }
		  
		$.ajax({
			method : "get",
			url    : "/m/mypage/m_delete_bank_account.do",
			dataType: "json",
			data   : {
				memberBankAccountNo : memberBankAccountNo
			},
			 beforeSend : function(xhr){
			     if (!userAuthToken) {
					 xhr.setRequestHeader("AJAX","true");
			     }else {
			    	 xhr.setRequestHeader("user_auth_token",userAuthToken);
			     }
			 },
			success: function(data) {
				if (data.result.code == 0 ) {
					alertOpen("확인", "계좌 삭제 완료", true, false, function(){location.reload();}, null);
				}else{
					alertOpen("확인", data.result.msg, false, true, null, null);
				}
			},
			error: function (request, status, error) {
				alertOpen("확인", data.result.msg, false, true, null, null);
			}
			});
	  });
}

</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_recommend">	
	<!-- nav -->
	<jsp:include page="../../common/topper.jsp" />
	<!-- nav -->
		<h4>R 포인트 출금</h4>
	</header> 
	<!-- content begin -->
	<section>
		<div class="rpoint_withdrawal">
			<div>
				<div class="rpoint_withdrawal01">
					<ul>
						<li>이달의 결제내역 〉</li>
						<li>11월 (11.01~오늘)</li>
					</ul>
				</div>
				<div class="rpoint_withdrawal02">
					<span>0</span>
					<span>원</span>
				</div>
			</div>
			<div>
				<div class="rpoint_withdrawal01">
					<ul>
						<li>출금가능한금액 〉</li>
						<li>총 출금가능한 금액</li>
					</ul>
				</div>
				<div class="rpoint_withdrawal02">
					<button>출금 리스트</button>
				</div>
			</div>
			<div>
				<div class="rpoint_withdrawal01">
					<ul>
						<li>출금 금액 〉</li>
						<li>출금 리스트</li>
					</ul>
				</div>
				<div class="rpoint_withdrawal02">
					<button>출금 리스트</button>
				</div>
			</div>
			<div class="rpoint_withdrawal_button">
				<button>출금리스트보기</button>
				<button>출금등록하기</button>
			</div>
		</div>
	</section>
	<!-- content end -->
</body>
<!-- body end -->
</html>