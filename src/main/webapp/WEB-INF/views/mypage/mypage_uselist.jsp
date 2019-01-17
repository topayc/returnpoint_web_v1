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
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<!-- css   -->
<!-- font -->ㅇ
<link rel="stylesheet" href="/resources/css/common.css">
<!-- js -->
<script src="/resources/js/lib/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/common.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var pageContextlocale = '${pageContext.response.locale}';
	$("#sel1").val(pageContextlocale); 
});
</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_mypage">	
	<!-- nav -->
	<jsp:include page="/WEB-INF/views/common/topper.jsp" />
	<!-- nav -->
		<h4>Mypage</h4>
	</header> 
	<!-- content begin -->
	<ul class="submenu"><li><a href="/mypage/mypage_myinfo.do">마이페이지</a></li><!-- <li class="active"><a href="./mypage_uselist.do">거래내역</a></li> --><li><a href="/mypage/mypage_out.do">회원탈퇴</a></li></ul>
<!-- 	<section>
	<h4>카드 거래 내역 
	<select class="form-control" id="sel1">
    <option>전체카드</option>
    <option>카드종류1</option>
    <option>카드종류2</option>
    <option>카드종류3</option>
  </select>
	</h4>
		<hr>
		<table class="table table-hover">
		    <thead>
		      <tr>
		        <th>카드</th>
		        <th>사용처</th>
		        <th>사용금액</th>
		        <th>사용날짜</th>
		      </tr>
		    </thead>
		    <tbody>
		      <tr>
		        <td>[BC] 국민 BC 카드</td>
		        <td>(주)식당</td>
		        <td class="text-right">23,000원</td>
		        <td class="text-center">2018.06.15</td>
		      </tr>
		      <tr>
		        <td>[BC] 국민 BC 카드</td>
		        <td>(주)식당이름이 아주 되게되게 길어요</td>
		        <td class="text-right">23,000원</td>
		        <td class="text-center">2018.06.15</td>
		      </tr>
		      <tr>
		        <td>[BC] 국민 BC 카드</td>
		        <td>(주)식당</td>
		        <td class="text-right">23,000원</td>
		        <td class="text-center">2018.06.15</td>
		      </tr>
		    </tbody>
		  </table>	
		<button type="button" class="btn btn-submit" data-toggle="modal" data-target="#myaddcard">카드등록</button>
	</section> -->
	<!-- content end -->
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<!-- footer -->	
</div>
  	<!-- privacy policy modal -->
	<jsp:include page="../company/m_privacypolicy.jsp" flush="false" />
	<!-- privacy policy modal end -->
	<!-- terms of ues modal -->
	<jsp:include page="../company/m_termsofuse.jsp" flush="false" />
	<!-- terms of ues modal end -->	
	<!-- addcard modal 카드등록 모달입니다.-->
	<jsp:include page="./m_addcard.jsp" flush="false" />
	<!-- addcard modal end -->
	<div class="modal fade" id="myaddcard" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">신용카드 추가</h4>
			</div>
			<form name="cardList">
				<div class="modal-body">
					<div class="form-group">
						<label for="email">카드사</label> <input type="email"	class="form-control" id="email" placeholder="KB 국민카드">
					</div>
					<div class="form-group">
						<label for="name">카드번호</label> <input type="text" class="form-control" id="name" placeholder="8888-8888-****-****">
					</div>
					<div class="form-group">
						<label for="phone">월 / 년도</label> <input type="text" class="form-control" id="bank" placeholder="08 / 2017">
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-submit" data-dismiss="modal">저장</button>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
<!-- body end -->
</html>