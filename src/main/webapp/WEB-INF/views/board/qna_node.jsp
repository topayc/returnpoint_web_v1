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
<meta http-equiv="X-UA-Compatible" content="IE=edge"><!-- 0710 ie가 edge로 맞춰지는 메타 추가 -->
<meta name="format-detection" content="telephone=no"/><!-- 0710 edge상에서 전화번호 자동인식으로 인한 메타 추가 -->
<!-- css   -->
<!-- font -->
<link rel="stylesheet" href="/resources/css/common.css">
<!-- js -->
<script src="/resources/js/lib/jquery.min.js"></script>
<script src="/resources/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/common.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var pageContextlocale = '${pageContext.response.locale}';
	$("#sel1").val(pageContextlocale);	}  	
});
</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_qna">	
	<!-- nav -->
	<jsp:include page="/WEB-INF/views/common/topper.jsp" />
	<!-- nav -->
		<h4 class="pc">Customer Center</h4>
		<h4 class="mobile">Member Q & A</h4>
	</header> 
	<!-- content begin -->
	<ul class="submenu pc">
		<li><a href="./faq.do">자주묻는질문</a></li>
		<li><a href="./notice.do">공지사항</a></li>
		<li><a href="./qna.do">일반상담</a></li>
		<li class="active"><a href="./qna_node.do">제휴상담</a></li>
	</ul>
	<section>
		<div class="listS01">			
			<div class="list_title"><i class="fas fa-pencil-alt"></i> RETURNP 제휴 상담. </div>			
			<div data-toggle="collapse" data-target="#faq1" class="list_li collapsed ellp">
				<small class="date"><i class="fas fa-calendar-alt"></i> 2018.09.06</small><small>김은영</small><small>정회원신청</small>
				<span>정회원신청합니다.</span>
			</div>
			<div id="faq1" class="list_toggle collapse">
				<p>회원가입시 정회원을 추천 할 수 있는 항목이 있습니다. 해당 항목에 추천하실 회원의 아이디를 입력해주시면됩니다. 회원가입이 된 상태시라면 마이페이지에 회원정보보기에 추천회원을 추가입력 할 수 있는 항목에 위와 같이 추천하실 회원의 아이디를 입력해 주시면 됩니다. </p>
			</div> 		
			<div data-toggle="collapse" data-target="#faq2" class="list_li collapsed ellp" >
				<small class="date"><i class="fas fa-calendar-alt"></i> 2018.09.06</small><small>김은영</small><small>지사신청</small>
				<span>지사신청합니다. 확인바래요</span>
			</div>				
			<div id="faq2" class="list_toggle collapse">
				<p>회원가입시 정회원을 추천 할 수 있는 항목이 있습니다. 해당 항목에 추천하실 회원의 아이디를 입력해주시면됩니다. 회원가입이 된 상태시라면 마이페이지에 회원정보보기에 추천회원을 추가입력 할 수 있는 항목에 위와 같이 추천하실 회원의 아이디를 입력해 주시면 됩니다. </p>
			</div> 
			
			<div data-toggle="collapse" data-target="#faq3" class="list_li collapsed ellp">
				<small class="date"><i class="fas fa-calendar-alt"></i> 2018.09.06</small><small>김은영</small><small>협렵업체신청</small>
				<span>협력업체신청 </span>
			</div>
			<div id="faq3" class="list_toggle collapse">
				<p>회원가입시 정회원을 추천 할 수 있는 항목이 있습니다. 해당 항목에 추천하실 회원의 아이디를 입력해주시면됩니다. 회원가입이 된 상태시라면 마이페이지에 회원정보보기에 추천회원을 추가입력 할 수 있는 항목에 위와 같이 추천하실 회원의 아이디를 입력해 주시면 됩니다. </p>
			</div> 
			
			<div data-toggle="collapse" data-target="#faq4" class="list_li collapsed ellp">
				<small class="date"><i class="fas fa-calendar-alt"></i> 2018.09.06</small><small>김은영</small><small>정회원신청</small>
				<span>정회원신청이요 !!! </span>
			</div>
			<div id="faq4" class="list_toggle collapse">
				<p>회원가입시 정회원을 추천 할 수 있는 항목이 있습니다. 해당 항목에 추천하실 회원의 아이디를 입력해주시면됩니다. 회원가입이 된 상태시라면 마이페이지에 회원정보보기에 추천회원을 추가입력 할 수 있는 항목에 위와 같이 추천하실 회원의 아이디를 입력해 주시면 됩니다. </p>
			</div> 	
			<!-- 리스트 내용이 많아지면 더보기버튼 활성화 <button type="submit" class="btn btn-basic">더보기</button> -->
		</div>
		<button type="submit" class="btn btn-submit" onclick="location='./qna_node_w.do'">글쓰기</button>  
	</section>
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
</body>
<!-- body end -->
</html>