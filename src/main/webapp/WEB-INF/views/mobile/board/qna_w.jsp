<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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
});

//공백 확인
String.prototype.stripspace = function() {
	return this.replace(/ /g, '');
}

function isEmpty(obj) {
	return (obj.value.stripspace()=='' ? true : false);
}

function saveQnaW(){
	event.preventDefault();
	
	var f = document.Frm;
	
	var boardCate = $("#boardCate option:selected").val();
	if(boardCate == null || boardCate ==""){
		alertOpen("확인", "질문 유형을 선택 주세요.", true, false, null, null);
		return false;
	}
	if (isEmpty(f.boardWriterName)) {
		alertOpen("확인", "이름을 입력해 주세요.", true, false, null, null);
		f.boardWriterName.focus();
		return false;
	}
	if (isEmpty(f.boardTitle)) {
		alertOpen("확인", "제목을 입력해 주세요.", true, false, null, null);
		f.boardTitle.focus();
		return false;
	}
	if (isEmpty(f.boardContent)) {
		alertOpen("확인", "내용을 입력해 주세요.", true, false, null, null);
		f.boardWriterName.focus();
		return false;
	}
	f.target = "";
	f.action = "/m/member/saveQnaW_act.do";
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
		<h4>Q & A</h4>
	</header> 
	<!-- content begin -->
	<section>
		<div class="listS01">			
			<div class="list_title"><i class="fas fa-pencil-alt"></i> RETURNP 일반 문의 </div><br />		
			<form name="Frm">
				<div class="form-group">
					<select class="form-control qna_cate" id="boardCate" name="boardCate"> 
					    <option value="" >선택</option>
					    <option value="1" >일반회원</option>
					    <option value="2" >회원정보</option>
					    <option value="3" >포인트</option>
					    <option value="4" >기타</option>
					</select>			  
				</div>				
				<div class="form-group">
					<label for="name">이름</label> 
					<input type="text"	class="form-control" id="boardWriterName" name="boardWriterName" maxlength="50">
				</div>
				<div class="form-group">
					<label for="subject">제목</label> 
					<input type="text"	class="form-control" id="boardTitle" name="boardTitle" maxlength="50">
				</div>
				<div class="form-group">
					<label for="contents">내용</label> 
					<textarea rows="10" cols="50"  id="boardContent" name="boardContent" class="form-control" maxlength="300"></textarea>
				</div>
			</form> 
		</div>
		<button type="button" class="btn btn-submit" onclick="saveQnaW();">글쓰기</button>  
	</section>
	<!-- content end -->	
</div>
</body>
<!-- body end -->
</html>