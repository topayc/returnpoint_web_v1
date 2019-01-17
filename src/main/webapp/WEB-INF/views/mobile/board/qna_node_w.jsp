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

function saveQnaNodeW(){
	event.preventDefault();
	
	var f = document.Frm;
	
	var boardCate = $("#boardCate option:selected").val();
	if(boardCate == null || boardCate ==""){
		alertOpen("확인", "회원 유형을 선택 주세요.", true, false, null, null);
		return false;
	}
	if (isEmpty(f.rerv1)) {
		alertOpen("확인", "상호명을 입력해 주세요.", true, false, null, null);
		f.rerv1.focus();
		return false;
	}
	if (isEmpty(f.rerv2)) {
		alertOpen("확인", "대표자명을 입력해 주세요.", true, false, null, null);
		f.rerv2.focus();
		return false;
	}
	if (isEmpty(f.rerv3)) {
		alertOpen("확인", "주소를 입력해 주세요.", true, false, null, null);
		f.rerv3.focus();
		return false;
	}
	if (isEmpty(f.rerv4)) {
		alertOpen("확인", "담당자를 입력해 주세요.", true, false, null, null);
		f.rerv4.focus();
		return false;
	}
	if (isEmpty(f.rerv5)) {
		alertOpen("확인", "연락처를 입력해 주세요.", true, false, null, null);
		f.rerv5.focus();
		return false;
	}
	if (isEmpty(f.rerv6)) {
		alertOpen("확인", "이메일을 입력해 주세요.", true, false, null, null);
		f.rerv6.focus();
		return false;
	}
	if (isEmpty(f.boardTitle)) {
		alertOpen("확인", "제목을 입력해 주세요.", true, false, null, null);
		f.boardTitle.focus();
		return false;
	}
	if (isEmpty(f.boardContent)) {
		alertOpen("확인", "문의사항을 입력해 주세요.", true, false, null, null);
		f.boardContent.focus();
		return false;
	}
	
	f.target = "";
	f.action = "/m/member/saveQnaNodeW_act.do";
	f.submit();
}
</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_qna">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4>Member Q & A</h4>
	</header> 
	<!-- content begin -->
	<section>
		<div class="listS01">			
			<div class="list_title"><i class="fas fa-pencil-alt"></i> RETURNP 제휴 문의</div><br />			
			<form name="Frm">
				<div class="form-group">
					<select class="form-control qna_cate" id="boardCate" name="boardCate">
					    <option value="" >선택</option>
					    <option value="1" >일반회원신청</option>
					    <option value="2" >정회원신청</option>
					    <option value="3" >지사신청</option>
					    <option value="4" >대리점신청</option>
					    <option value="5" >협력업체신청</option>
					    <option value="6" >영업관리자신청</option>
					    <option value="7" >총판신청</option>
					</select>
				</div>
				<div class="form-group">
					<label for="company">상호명</label> 
					<input type="text"	class="form-control" name="rerv1" id="rerv1" maxlength="50">
				</div>
				<div class="form-group">
					<label for="ceo">대표자명</label> 
					<input type="text"	class="form-control" name="rerv2" id="rerv2" maxlength="50">
				</div>
				<div class="form-group">
					<label for="add">지역(주소)</label> 
					<input type="text"	class="form-control" name="rerv3" id="rerv3" maxlength="50">
				</div>
				<div class="form-group">
					<label for="name">담당자</label> 
					<input type="text"	class="form-control" name="rerv4" id="rerv4" maxlength="50">
				</div>
				<div class="form-group">
					<label for="tel">연락처</label> 
					<input type="text"	class="form-control" name="rerv5" id="rerv5" maxlength="50">
				</div>
				<div class="form-group">
					<label for="mail">이메일</label> 
					<input type="text"	class="form-control" name="rerv6" id="rerv6" maxlength="50">
				</div>
				<!-- 조회목록이랑 테스트 디비에는 제목이 있는데 ui에는 제목이 없음. 우선은 포함하였으니. 최종 결정나시면 수정하시면 될듯요. 09.25 -->
				<div class="form-group">
					<label for="subject">제목</label> 
					<input type="text"	class="form-control" id="boardTitle" name="boardTitle" maxlength="50">
				</div>
				<div class="form-group">
					<label for="contents">문의사항</label> 
					<textarea rows="5" cols="50"  name="boardContent" id="boardContent" class="form-control"></textarea>
				</div>
			</form> 
		</div>
		<button type="button" class="btn btn-submit" onclick="saveQnaNodeW();">글쓰기</button>  
	</section>
	<!-- content end -->
</div>
</body>
<!-- body end -->
</html>