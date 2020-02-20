<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
 <meta charset="utf-8">
    <meta http-equiv="Content-type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <title>서비스안내</title>  
	<link rel="stylesheet" href="/resources/css/m_common.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script type="text/javascript" src="/resources/js/lib/m_common.js"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
     <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
	<script>
		var height  = window.screen.height - 90;
	    var width = window.screen.width
	
	    if (isApp()) {
	    	getDeviceResolution(function(result){
				if (result) {
		 			result = JSON.parse(result);
		 			if (result.result == "100"){
						height = Number(result.deviceHeight ) / window.devicePixelRatio;
					}
				}
			}) 
	 	}  
	
	</script>
</head>

<body>
    <div class="r_login">
    
		<div class="r_login_page1 join_slide">
			<div class="top_main">
				<div class="logo_img">
					<img src="/resources/images/logo_img.png">
				</div>
				<div class="rpoint_text">
					<ul>
						<li><b>RPOINT</b></li>
						<li>소비가 저축이 되는</br>똑똑한 앱</li>
					</ul>
				</div>
			</div>
			<button>계정 만들기</button>
			<div class="login_text">
				<span>이미 R POINT 계정이 있으신가요</span>
				<span>|</span>
				<span><b>로그인</b></span>
			</div>
			<div class="facebook_btn"><img src="/resources/images/facebook_logo.png">페이스북으로 회원가입</div>
		</div>
		<div class="r_login_page2 join_slide">
			<div class="top_main">
				<div class="logo_img">
					<img src="/resources/images/logo_img.png">
				</div>
				<div class="rpoint_text">
					<ul>
						<li><b>RPOINT</b></li>
						<li>소비가 저축이 되는</br>똑똑한 앱</li>
					</ul>
				</div>
			</div>
			<div class="input_box">
				<input type="text" name="전화번호" placeholder="전화번호">
				<input type="text" name="비밀번호" placeholder="비밀번호">
			</div>
			<button>로그인</button>
			<input type="checkbox" id="cb"><label for="cb">아이디 저장</label>
			<div class="sign_text">
				<span>회원가입</span>
				<span>|</span>
				<span>아이디 비밀번호 찾기</span>
				<span>|</span>
				<span>추천인QR로 가입하기</span>
			</div>
		</div>
		<div class="r_login_page3 join_slide">
			<p><b>R POINT</b> 앱은 핸드폰 번호를 회원님의 아이디로 사용합니다.</p>
			<p>아래의 인증 과정을 진행해 주시기 바랍니다.</p>
			<h5>휴대폰 인증</h5>
			<div class="phone_input1">
				<span>KR +82</span>
				<input type="text" name="휴대폰 번호" placeholder="휴대폰번호">
			</div>
			<div class="phone_input2">
				<input type="text" name="인증번호 입력" placeholder="인증번호 입력">
				<button>인증요청</button>
			</div>
			<span>입력하신 번호로 인증번호 6자리가 발송되며, 아래 시간안에 입력하신 후 인증을 진행해주세요.</span>
			<div class="time">03:00</div>
			<button>인증하기</button>
		</div>

		<div class="r_login_page5 join_slide">
			<h3>기본 정보 입력</h3>
			<div class="r_id">
				<p>아이디</p>
				<span>아이디는 인증하신 핸드폰 번호가 설정됩니다.</span>
				<input type="text" name="아이디" placeholder="01012345678">
			</div>
			<div class="r_id">
				<p>비밀번호</p>
				<input type="password" name="비밀번호" placeholder="영문+숫자 10자리이상 설정해주세요.">
			</div>
			<div class="r_id">
				<p>비밀번호 확인</p>
				<input type="password" name="비밀번호 확인" placeholder="비밀번호 확인을 해주세요.">
			</div>
			<div class="r_id">
				<p>이메일 입력</p>
				<input type="text" name="이메일 입력" placeholder="이메일주소를 입력해주세요.">
			</div>
			<div class="r_id">
				<p>추천인 입력</p>
				<span>추천인은 선택입력사항이며, 추천인 입력은 추천인 검색을 통하여 등록해주세요.</span>
				<div class="r_id_input">
					<input type="text" name="추천인 등록">
					<button>추천인 검색</button>
				</div>
			</div>
			<button>가입하기</button>
		</div>
		<div class="r_login_page7 join_slide">
			<div class="top_main">
				<div class="logo_img">
					<img src="/resources/images/logo_img.png">
				</div>
				<div class="rpoint_text">
					<ul>
						<li><b>RPOINT</b></li>
						<li>소비가 저축이 되는</br>똑똑한 앱</li>
					</ul>
				</div>
			</div>
			<h1>가입을 축하합니다.</h1>
			<div class="r_home">R POINT 홈으로 가기</div>
		</div>
	</div>
	<div class="r_login_page6">
			<div class="r_name">
				<div class="r_name_box">
					<div class="r_name_left">
						<img src="/resources/images/name_left_img.png">
					</div>
					<input type="text" name="추천인 전화번호 혹은 이름 입력" placeholder="추천인 전화번호 혹은 이름 입력">
					<div class="r_name_right">
						<img src="/resources/images/name_right_img.png">
					</div>
				</div>
				<div class="r_name_text">
					<ul>
						<li>
							<span>차미라</span>
							<span>010-5845-0051</span>
							<span>mira0326@naver.com</span>
						</li>
						<li>
							<span>차미라</span>
							<span>010-5845-0051</span>
							<span>mira0326@naver.com</span>
						</li>
					</ul>
				</div>
			</div>
		</div>
				<div class="r_login_page4">
			<div class="cord_number">
				<h3>국가선택</h3>
				<div class="close_img">
					<img src="/resources/images/close_img.png">
				</div>
				<div class="cord_input">
					<div class="search_img">
						<img src="/resources/images/search_img.png">
					</div>
					<input type="text" name="국가 이름 또는 코드" placeholder="국가 이름 또는 코드">
				</div>
				<ul>
					<li>가나(+233)</li>
					<li>가봉(+241)</li>
					<li>가이아나()+592</li>
					<li>감비아(+220)</li>
					<li>건지(+44)</li>
				</ul>
			</div>
		</div>
<script type="text/javascript">
$(document).ready(function(){
	var current = 0;
	var $slides = $(".join_slide");
	var total = 5;

$slides.css("right","-100%");
$slides.eq(0).css("right","0px");

function setSlide(){
	if (current+1 >= total) move(0);
	else move(current + 1);
}

function move(idx){
	$slides.eq(current).animate({"right":"100%"});
	$slides.eq(idx).css({"right":"-100%"});
	$slides.eq(idx).animate({"right":"0px"});
	current=idx;
}
setInterval(setSlide,4000);
});
</script>
</body>
</html>