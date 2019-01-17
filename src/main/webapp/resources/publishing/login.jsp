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
<body class="p_login">	
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
					<li class="member"><a href="./login.jsp"><i class="fas fa-sign-in-alt"></i> 로그인</a></li>
					<li class="member"><a href="./join.jsp"><i class="fas fa-user"></i> 회원가입</a></li>
					<!-- 로그인 후
					<li class="member"><a href="#"><i class="fas fa-sign-out-alt"></i> 로그아웃</a></li>    
					<li class="member"><a href="mypage_myinfo.jsp"><i class="fas fa-user"></i> 마이페이지</a></li> 
					 -->	
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
		<h4>Member login</h4>
	</header>
	<!-- content begin -->
	<section>	
	<h4>로그인</h4>
	<hr>
	<form>
		<div class="form-group">
			<label for="email">이메일</label> <input type="email"	class="form-control" id="email">
		</div>
		<div class="form-group">
			<label for="pwd">비밀번호</label> <input type="password" class="form-control" id="pwd">
		</div>			
		<!-- 로그인 5회 실패시 출력되는 화면입니다. 
		<p class="forminfo">- 아래 인증버호를 확인하고 입력하세요. </p>
		<div class="form-group chptcha_img">
			<img src="../images/index_img01.jpg" />
			<div><button type="button" class="btn btn-basic">인증번호 재전송</button></div>
		</div>
		<div class="form-group">
			<label for="chptcha_area"><small>*</small> 인증번호 입력</label> <input type="password" class="form-control" id="chptcha_area">
		</div>	
		 -->
		<button type="submit" class="btn btn-submit">로그인</button>
		<ul class="checkbox">
			<li><label><input type="checkbox"> 아이디저장</label></li>
			<li><a href="./join.jsp">회원가입</a></li>
			<li><a href="./find_email.jsp">이메일,비밀번호 찾기</a></li>
		</ul>
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
	
	<!-- emailconfirm modal - 이메일 인증이 안되었을 경우 자동 출력되는 모달팝업입니다  -->	
	<jsp:include page="./m_emailconfirm.jsp" flush="false" />
	<!-- emailconfirm modal -->
	
</body>
<!-- body end -->
</html>