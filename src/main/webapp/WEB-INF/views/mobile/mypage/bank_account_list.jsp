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
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4><spring:message code="label.manage_bank_account"/></h4>
	</header> 
	<!-- content begin -->
	
	
	<c:choose>
		<c:when test = "${empty model.memberBankAccounts }">
			<section class="qr_nodata"><!-- 0824 -->
				<div> <i class="fas fa-exclamation-triangle"></i><spring:message code="label.desc_no_bank_account"/></div>
				<button type="button" class="btn btn-submit"  onclick = "movePage('/m/mypage/m_mybank_account_form.do')"><spring:message code="label.regist_bank_account"/></button>
			</section>
		</c:when>
		<c:otherwise>
			<section>
				<div class="listS01" id = "account_list_frame">
					<div class="list_title">
						<i class="fas fa-building"></i> 계좌 목록 
					</div>
					<c:forEach var="account"  items="${model.memberBankAccounts}"  >
						<div class="list_li" style = "display:flex">
					    <div style = "width:20%">${account.bankName} </div>
					    <div style = "width:20%">${account.accountOwner}</div>
					    <div style = "width:45%">${account.bankAccount}</div>
					    <div style = "width:15%" onclick = "movePage('/m/mypage/m_mybank_account_form.do?action=modify&memberBankAccountNo=' + ${account.memberBankAccountNo})"  ><i class="fas fa-edit"></i><spring:message code="label.edit"/></div>
					</div>		
					</c:forEach>
					<div class="r_bank">
						<div class="coupon_code_page2">
			        	<ul>
			      			<li>
			      				<ul>
			      					<li class="code_text2">
										<div class="code_bank1">국민은행</div>
										<div class="code_bank2">2019-12-09 등록</div>
			      					</li>
			      					<li class="code_text1">계좌번호 : <span>1001-9087-0191212</span></li>
			      					<li class="code_text1">계좌 주 : <span>안영철</span></li>
			      					<button>수정</button>
			      				</ul>
			      			</li>
			      			<li>
			      				<ul>
			      					<li class="code_text2">
										<div class="code_bank1">국민은행</div>
										<div class="code_bank2">2019-12-09 등록</div>
			      					</li>
			      					<li class="code_text1">계좌번호 : <span>1001-9087-0191212</span></li>
			      					<li class="code_text1">계좌 주 : <span>안영철</span></li>
			      					<button>수정</button>
			      				</ul>
			      			</li>
			      		</ul>
			        </div>
			       </div>
				</div>
				<a class="btn btn-submit"  onclick = "movePage('/m/mypage/m_mybank_account_form.do?action=create')" >
					<i class="fas fa-sign-out-alt"></i>
					<spring:message code="label.regist_bank_account"/>
				</a>
			</section>	
		</c:otherwise>
	</c:choose>
	<!-- content end -->
</body>
<!-- body end -->
</html>