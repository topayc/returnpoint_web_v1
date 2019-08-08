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
	var pageContextlocale = '${pageContext.response.locale}';
	$("#sel1").val(pageContextlocale);  	
});

//공백 확인
String.prototype.stripspace = function() {
	return this.replace(/ /g, '');
}

function isEmpty(obj) {
	return (obj.value.stripspace()=='' ? true : false);
}

//제휴문의 신청하기 저장
function partnerAskSave(){ 
	event.preventDefault();
	
	var f = document.partnerAskSaveForm;
	var bbsType2 = $("#bbsType2 option:selected").val();
	if(bbsType2 == null || bbsType2 ==""){
		alertOpen( "알림", "질문 유형을 선택해 주세요", true, null, null, null);
		return false;
	}
	if (isEmpty(f.rerv1)) {
		alertOpen( "알림", "상호명을 입력해주세요", true, null, null, null);
		return false;
	}
 	if (isEmpty(f.rerv2)) {
 		alertOpen( "알림", "대표자명을 입력해주세요", true, null, null, null);
		return false;
	}
	if (isEmpty(f.rerv3)) {
 		alertOpen( "알림", "주소를 입력해주세요", true, null, null, null);
		return false;
	}
	if (isEmpty(f.rerv4)) {
 		alertOpen( "알림", "담당자를 입력해주세요", true, null, null, null);
		return false;
	}
	if (isEmpty(f.rerv5)) {
 		alertOpen( "알림", "연락처를 입력해주세요", true, null, null, null);
		return false;
	}
	if (isEmpty(f.rerv6)) {
 		alertOpen( "알림", "이메일 입력해주세요", true, null, null, null);
		return false;
	}
	var rerv6 = $("#rerv6").val();
	if (!checkEmail(rerv6)){
 		alertOpen( "알림", "올바른 이메일주소를 입력해주세요", true, null, null, null);
		return false;
	} 
	if (isEmpty(f.title)) {
 		alertOpen( "알림", "제목을 입력해주세요", true, null, null, null);
		return false;
	}
	if (isEmpty(f.content)) {
 		alertOpen( "알림", "문의사항을 입력해주세요", true, null, null, null);
		return false;
	}
/*     var isBbsTypeChk = false; 
   	var arr_bbsType2 = document.getElementsByName("gb");
    for(var i=0;i<arr_bbsType2.length;i++){
        if(arr_bbsType2[i].checked == true) {
        	isBbsTypeChk = true;
            break;
        }
    }
    if(!isBbsTypeChk){
        commonAlert('개인정보 수집 및 약관동의(필수)"예"를 하셔야 문의신청이 가능합니다.', false, null);
		$("#modal3").modal('show');
        return false;
    }
    var gbval = $("#gbval").val();
    if(gbval != 'Y'){
        commonAlert('개인정보 수집 및 약관동의(필수)에 "예" 를 하셔야 문의신청이 가능합니다.', false, null);
		$("#modal3").modal('show');    	
        return false;
    } */
    var params = jQuery("#partnerAskSaveForm").serialize(); // serialize() : 입력된 모든Element(을)를 문자열의 데이터에 serialize 한다.
	$.ajax({
		method : "post",
		url    : "/m/board/partnerAskSave.do",
		dataType: "json",
		data   :  params,
		contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
		success: function(data) {
			if (data.code == 1 ) {
				alertOpen( "알림", "제휴 문의에 등록이 완료되었습니다.", true, null, function(){location.href = "/m/mypage/mypage_myinfo.do"}, null);
			}
		},
		error: function (request, status, error) {
			alertOpen( "알림", "잠시후에 다시 시도해주세요.", true, null, null, null);
		}
	})
}
</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_qna">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4> <spring:message code="label.affiliated_inquiry_qna" /></h4>
	</header> 
	<!-- content begin -->
	<section>
		<div class="listS01">			
			<form name="partnerAskSaveForm" id="partnerAskSaveForm">
				<div class="form-group" style = "margin-top:10px">
					<select class="form-control qna_cate" id="bbsType2" name="bbsType2">
					    <option value="" >선택</option>
						<option value="1">일반 회원 문의</option>
                    	<option value="2">정회원 문의</option>
                    	<option value="3">영업 관리자 문의</option>
                    	<option value="4">협력업체 문의</option>
                    	<option value="5">대리점 문의</option>
                    	<option value="6">지사 문의</option>
                    	<option value="7">기타 제휴 문의</option>
					</select>
				</div>
				<div class="form-group">
					<label for="rerv1">상호명</label> 
					<input type="text"	class="form-control" name="rerv1" id="rerv1" maxlength="50" >
				</div>
				<div class="form-group">
					<label for="rerv2">대표자명</label> 
					<input type="text"	class="form-control" name="rerv2" id="rerv2" maxlength="50">
				</div>
				<div class="form-group">
					<label for="rerv3">지역(주소)</label> 
					<input type="text"	class="form-control" name="rerv3" id="rerv3" maxlength="50">
				</div>
				<div class="form-group">
					<label for="rerv4">담당자</label> 
					<input type="text"	class="form-control" name="rerv4" id="rerv4" maxlength="50">
				</div>
				<div class="form-group">
					<label for="rerv5">연락처</label> 
					<input type="text"	class="form-control" name="rerv5" id="rerv5" maxlength="50">
				</div>
				<div class="form-group">
					<label for="rerv6">이메일</label> 
					<input type="text"	class="form-control" name="rerv6" id="rerv6" maxlength="50" value = "${model.memberEmail}" readonly>
				</div>
				<!-- 조회목록이랑 테스트 디비에는 제목이 있는데 ui에는 제목이 없음. 우선은 포함하였으니. 최종 결정나시면 수정하시면 될듯요. 09.25 -->
				<div class="form-group">
					<label for="title">제목</label> 
					<input type="text"	class="form-control" id="title" name="title" maxlength="50">
				</div>
				<div class="form-group">
					<label for="content">문의사항</label> 
					<textarea rows="5" cols="50"  name="content" id="content" class="form-control"></textarea>
				</div>
			</form> 
		</div>
		<div class="btns2">
			<button type="button" class="btn btn-submit" onclick = "partnerAskSave()"><spring:message code="label.ok" /></button>
			<button type="button" class="btn btn-submit-cancel"  onclick = "history.back()"><spring:message code="label.cancel" /></button>
		</div>
		
	</section>
	<!-- content end -->
</div>
</body>
<!-- body end -->
</html>