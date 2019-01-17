<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>ReturnP</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge"><!-- 0710 ie가 edge로 맞춰지는 메타 추가 -->
<meta name="format-detection" content="telephone=no"/><!-- 0710 edge상에서 전화번호 자동인식으로 인한 메타 추가 -->
<!-- css   -->
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/page.css">
<!-- js -->
<script src="../js/lib/jquery.min.js"></script>
<script src="../js/lib/bootstrap.min.js"></script>
<!-- font -->
<link rel="stylesheet" 	href="https://use.fontawesome.com/releases/v5.1.0/css/all.css" />
<link rel="stylesheet"	href="//fonts.googleapis.com/earlyaccess/jejugothic.css" />
<link rel="stylesheet"	href="//fonts.googleapis.com/earlyaccess/nanumgothic.css" />
<link rel="stylesheet"	href="//fonts.googleapis.com/css?family=Open+Sans:300,400,600,700|Raleway:500,700" />
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_mypage_out">	
	<header>
		<nav>
			<div class="group_wrap">
				<div class="nav-brand">
					<a href="./index.jsp"><img src="../images/logo.png" /></a>
				</div>
				<ul>
					<li><a href="./service_member.jsp"><i class="fas fa-sort-down"></i>서비스안내</a></li>
					<li><a href="./company_identity.jsp"><i class="fas fa-sort-down"></i>회사소개</a></li>
					<li><a href="./point.jsp"><i class="fas fa-sort-down"></i>포인트조회</a></li>
					<li><a href="./customer_notice.jsp"><i class="fas fa-sort-down"></i>고객센터</a></li>
					<!-- 로그인 전 
					<li class="member"><a href="./login.jsp"><i class="fas fa-sign-in-alt"></i> 로그인</a></li>
					<li class="member"><a href="./join.jsp"><i class="fas fa-user"></i> 회원가입</a></li>
					-->
					<li class="member"><a href="#"><i class="fas fa-sign-out-alt"></i> 로그아웃</a></li>    
					<li class="member"><a href="mypage_myinfo.jsp"><i class="fas fa-user"></i> 마이페이지</a></li> 
					<!-- language begin -->
					<li class="language">
					<select class="form-control" id="sel1">
						<option>KOR</option>
					    <option>CHA</option>
					</select>
					</li>	
					<!-- language end -->					 				 
				</ul>
			</div>
		</nav>
		<h4>Mypage</h4>
	</header>
	<!-- content begin -->
	<ul class="submenu"><li><a href="./mypage_myinfo.jsp">마이페이지</a></li><li><a href="./mypage_uselist.jsp">거래내역</a></li><li class="active"><a href="./mypage_out.jsp">회원탈퇴</a></li></ul>
	<section>
	<h4>회원탈퇴</h4>
	<hr>
	<form>
		<div class="txtarea">
			<i class="fas fa-user-minus"></i>
			<h3>지금까지 Returnp를 이용해 주셔서 감사합니다.</h3>
			<p>회원탈퇴를 신청하시면 즉시 탈퇴처리됩니다.<br />거래가 있는 회원님의 경우 거래정보는 관련법에 의거 5년간 보관됩니다.<br />
			<span class="info_red">탈퇴시 기존 returnp 통합포인트는 모두 소멸됩니다.</span>
			</p>
		</div>
		<div class="form-group">
			<label for="email">이메일</label> <input type="email"	class="form-control" id="email">
		</div>			
		<div class="form-group">
			<label for="pwd">비밀번호</label> <input type="password"	class="form-control" id="pwd">
		</div>		
		<button type="button" class="btn btn-submit"  data-toggle="modal" data-target="#mymemberout">탈퇴하기</button>
	</form>
	</section>
	<!-- content end -->
	<footer>
		<div>Copyrightⓒreturnp All rights reserved.</div>
		<div>
			<span><a type="button" data-toggle="modal" data-target="#myprivacy">개인정보취급및처리방침</a></span> 
			<span><a type="button" data-toggle="modal" data-target="#myterms">이용약관</a></span> 
			<span>서울시 강남구 강남로 123-4567</span> 
			<span>TEL : 02-888-8888</span> 
			<span>FAX : 02-888-8888</span>
		</div>
		<p>
			<a class="btn-info" href="./customer_notice.jsp">공지사항</a>
			<a class="btn-info" href="./customer_help.jsp">회원문의</a>
		</p>
	</footer>	
	
	<!-- privacy policy modal -->
	<jsp:include page="./m_privacypolicy.jsp" flush="false" />
	<!-- privacy policy modal end -->
	
	<!-- terms of ues modal -->
	<jsp:include page="./m_termsofuse.jsp" flush="false" />
	<!-- terms of ues modal end -->
	
	<!-- member out modal -->
	<jsp:include page="./m_memberout.jsp" flush="false" />
	<!-- member out modal end -->
	
</body>
<!-- body end -->
</html>