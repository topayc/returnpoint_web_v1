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
<body class="p_customer_notice">
	<header>
		<nav>
			<div class="group_wrap">
				<div class="nav-brand">
					<a href="./index.jsp"><img src="../images/logo.png" /></a>
				</div>
				<ul>
					<li><a href="./service_member.jsp"><i class="fas fa-sort-down"></i>서비스안내</a></li>
					<li><a href="./company_identity.jsp"><i	class="fas fa-sort-down"></i>회사소개</a></li>
					<li><a href="./point.jsp"><i class="fas fa-sort-down"></i>포인트조회</a></li>
					<li class="active"><a href="./customer_notice.jsp"><i class="fas fa-sort-down"></i>고객센터</a></li>
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
		<h4>Customer Center</h4>
	</header>
	<!-- content begin -->
	<ul class="submenu">
		<li class="active"><a href="./customer_notice.jsp">공지사항</a></li>
		<li><a href="./customer_help.jsp">회원문의</a></li>
	</ul>
	<section>
		<h4>공지사항</h4>
		<hr>
		<div class="txtarea">
			<i class="fas fa-headset"></i>
			<h3>admin @returnp.com</h3>
			<p>Returnp에 대한 궁금한 사항을 문의하세요 !</p>
			<span class="info_red">고객상담시간 : 평일 09:00 - 12:00 ~ 18:00(토/일/공휴일 휴무)</span>
		</div>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>번호</th>
					<th>제 목</th>
					<th>등록일</th>
				</tr>
			</thead>
			<tbody>
				<tr data-toggle="collapse" data-target="#demo1">
					<td class="number text-center">10</td>
					<td>신규 오픈사이트</td>
					<td class="date text-center">2018.06.15</td>
				</tr>
				<tr id="demo1" class="collapse">
					<td colspan="3">신규오픈사이트 내용입니다. <br /> 신규오픈사이트 내용입니다.</td>
				</tr>
			</tbody>
		</table>
		<ul class="pagination">
			<li class="previous"><a href="#"> 이전 </a></li>
			<li class="active"><a href="#">1</a></li>
			<li><a href="#">2</a></li>
			<li><a href="#">3</a></li>
			<li><a href="#">4</a></li>
			<li><a href="#">5</a></li>
			<li class="next"><a href="#">다음</a></li>
		</ul>
	</section>
	<!-- content end -->
	<footer>
		<div>Copyrightⓒreturnp All rights reserved.</div>
		<div>
			<span><a type="button" data-toggle="modal" data-target="#myprivacy">개인정보취급및처리방침</a></span> 
			<span><a type="button" data-toggle="modal" data-target="#myterms">이용약관</a></span> 
			<span>서울시 강남구 강남로 123-4567</span> <span>TEL : 02-888-8888</span> 
			<span>FAX : 	02-888-8888</span>
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