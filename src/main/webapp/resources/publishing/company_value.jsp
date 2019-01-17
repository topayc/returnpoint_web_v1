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
<body class="p_company_value">	
	<header>
		<nav>
			<div class="group_wrap">
				<div class="nav-brand">
					<a href="./index.jsp"><img src="../images/logo.png" /></a>
				</div>
				<ul>
					<li><a href="./service_member.jsp"><i class="fas fa-sort-down"></i>서비스안내</a></li>
					<li class="active"><a href="./company_identity.jsp"><i class="fas fa-sort-down"></i>회사소개</a></li>
					<li><a href="./point.jsp"><i class="fas fa-sort-down"></i>포인트조회</a></li>
					<li><a href="./customer_notice.jsp"><i class="fas fa-sort-down"></i>고객센터</a></li>
					<!-- 로그인 전 
					<li class="member"><a href="./login.jsp"><i class="fas fa-sign-in-alt"></i> 로그인</a></li>
					<li class="member"><a href="./join.jsp"><i class="fas fa-user"></i> 회원가입</a></li>
					-->
					<li class="member"><a href="#"><i class="fas fa-sign-out-alt"></i> 로그아웃</a></li>    
					<li class="member"><a href="mypage_myinfo.jsp"><i class="fas fa-user"></i> 마이페이지</a></li> 
					<!-- language begin 0710 -->
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
		<h4>Company</h4>
	</header>
	<!-- content begin -->
	<ul class="submenu">
		<li><a href="./company_identity.jsp">기업의 정신</a></li>
		<li><a href="./company_business.jsp">사업의 목적</a></li>
		<li class="active"><a href="./company_value.jsp">기업의 방향</a></li>
	</ul>
	<section>
	기업의 방향
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
	
</body>
<!-- body end -->
</html>