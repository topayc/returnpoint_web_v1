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
<body class="p_company_identity">	
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
	<!-- hidden menu
	<ul class="submenu">
		<li class="active"><a href="./company_identity.jsp">기업의 정신</a></li>
		<li><a href="./company_business.jsp">사업의 목적</a></li>
		<li><a href="./company_value.jsp">기업의 방향</a></li>
	</ul>
	-->
	<section>
		<div class="txtarea">
			<h3>미래를 지향하는 안정된 기업 신뢰와 성실로 최선을 다하는 returnp는</h3>
			<p>차별화된 서비스로 정성을 다할 것을 약속드립니다. 저희 returnp를 찾아 주시고 성원에 주신 고객 여러분께 진심으로 감사드립니다.</p>
		</div>
		<ul>
			<li><img src="../images/company01.jpg" /><p>고객과 구성원<br />중심의 경영</p></li>
			<li><img src="../images/company02.jpg" /><p>시장을 선도하는<br />세계 최고의 회사</p></li>
			<li><img src="../images/company03.jpg" /><p>합리적인 사고와<br />열린 조직 문화</p></li>
			<li><img src="../images/company04.jpg" /><p>언제나 새롭게<br />도전하는 조직</p></li>
		</ul>
		<p>회원 여러분들에게 항상 감사하는 마음으로 </p>
		<span>여러분의 지원과 성원에 조금이나마 보탬이 되는 기업으로 기억되기 위하여 항상 최선의 노력과 열정으로 연구개발에 게을리 하지 않을 것입니다. <br />우리들의 목표가 달성되는 그날까지 힘차게 도약할 수 있도록 지속적인 관심과 협력을 부탁 드립니다.</span>
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