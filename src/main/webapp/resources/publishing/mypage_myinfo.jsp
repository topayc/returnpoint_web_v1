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
<body class="p_mypage">	
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
	<ul class="submenu"><li class="active"><a href="./mypage_myinfo.jsp">마이페이지</a></li><li><a href="./mypage_uselist.jsp">거래내역</a></li><li><a href="./mypage_out.jsp">회원탈퇴</a></li></ul>
	<section>
		<h4>회원정보 
		<button class="btn btn-sbasic" type="button" onclick="location.href='./mypage_myinfo_confirm.jsp' ">수정</button></h4>
		<hr>
		<ul class="mypage_info">
			<li class="email"><span>이메일</span> <i class="fas fa-user"></i> guest@returmp.com</li>
			<li><span>가입일</span>2018.06.15 오전 11:36:52</li>
			<li><span>이름</span>홍길동</li>
			 
			<li><span>추천인</span><!--man01@returnp.com --></li>
			
			<li><span>핸드폰</span>01012345678</li>
		</ul>	
		<h4>최근 카드 사용 내역</h4>
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
		<button class="btn btn-submit" type="button" data-toggle="modal" data-target="#myfullmember">정회원 신청</button>
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
	
	<!-- fullmember modal - 정회원신청 모달 -->
	<jsp:include page="./m_fullmember.jsp" flush="false" />
	<!-- terms of ues modal end -->
	
</body>
<!-- body end -->
</html>