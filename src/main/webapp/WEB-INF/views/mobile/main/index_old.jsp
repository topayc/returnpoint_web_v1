<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.returnp_web.utils.SessionManager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@page import="java.net.URL" %>
<!DOCTYPE html>
<html lang="en">
<head> 
<title>ReturnP</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<!-- css   -->
<!-- font -->
<link rel="stylesheet" href="/resources/css/m_common.css">
<!-- js -->
<script type="text/javascript" src="/resources/js/lib/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/jquery.cookie.js"></script>
<script type="text/javascript" src="/resources/js/lib/m_common.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var pageContextlocale = '${pageContext.response.locale}';
	if(pageContextlocale == "ko"){
	      $("#sel1").val("ko");
	}else{
		 $("#sel1").val("ch");
	}  
	/* if($.cookie('joinCookie')) {
 		location.href = '/m/member/m_joincomplete.do';
	} */
	
	/*회원가입 모달창 회원가입 버튼 이벤트
	$("#joincompletelogin").on("click", function(){
		location.href = '/m/member/login.do'; 
	});

	회원가입 모달창 닫기 버튼 이벤트
	$("#joincompleteclose").on("click", function(){
		location.href = '/m/member/login.do';
	});	
	*/
	
 	//탈퇴완료 후 모달 호출
	if(location.href.match('form=out')){
 		location.href = '/m/mypage/m_memberout.do';
 	}
	
	/*탈퇴완료 후 모달 호출
 	if(location.href.match('form=out')){
 		$("#mymemberout").modal({backdrop: 'static', keyboard: false});
 	}
	
 	회원탈퇴 모달창 닫기 버튼
 	$("#memberOutClose").on("click", function(){
 		location.replace('/main/index.do');
 	});
 	
 	회원탈퇴 회원가입메뉴 이동버튼
 	$("#memberJoin").on("click", function(){
 		location.replace('/member/join.do');
 	});
 	*/
 	
 	
	if (appInfo && appInfo['access'] && appInfo['access'] == "APP") {
		var p = getParams();
		var mbrE = (p["mbrE"]);
		var userAT = (p["userAT"]);
		if (typeof mbrE != "undefined" && typeof userAT != "undefined") {
			bridge.setDeviceSession(mbrE, mbrE, userAT, function(result) {
				bridge.getSessionValue('PREF_ALL_SESSION', function(result){
				});
			});
		}
	}
	
	var p = getParams();
	var alertView = (p["alertView"]);
	var Message  = (p["Message"]);
	var message = "";
	var title = "확인";
	if(Message =="1"){
		message = "잘못된 경로입니다.";
	}else if(Message =="2"){
		message = "이메일 인증이 완료된 고객입니다.";
	}else if(Message =="3"){
		message = "이메일 인증완료되었습니다.";
	}else if(Message =="4"){
		message = "미인증 고객입니다. 이메일인증완료후 사용해주세요.";
	}else if(Message =="5"){
		message = "가입하신 이메일로 발송이 완료되었습니다.";
	}
		
	if(alertView =="t"){
		var alertMessageHtml = "";
		var alertTitleHtml = "";
		document.getElementById('alertView').style.display='flex';	
		alertMessageHtml += "<p>"+message+"</p>";
		$('#alertMassage').html(alertMessageHtml);
		alertTitleHtml += "<strong><i class='fas fa-info-circle'></i>"+title+"</strong>";
		$('#alertTitle').html(alertTitleHtml);
		$('#alert_ok').show();
		$('#alert_cancel').hide();
	}
});

/* 	if (window.addEventListener)
		window.addEventListener("load", setDeviceSession, false);
	else if (window.attachEvent)
		window.attachEvent("onload", setDeviceSession);
	else
		window.onload = setDeviceSession;

	function setDeviceSession(){
		if (appInfo && appInfo['access'] && appInfo['access'] == "APP") {
			var p = getParams();
			var mbrE = (p["mbrE"]);
			var userAT = (p["userAT"]);
			if (typeof mbrE != "undefined" && typeof userAT != "undefined") {
				bridge.setDeviceSession(mbrE, mbrE, userAT, function(result) {
					alert("bridge callback")
				});
			}
		}
	} */

</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="home">
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
	</header>
	<!-- main begin -->
	<section> 
		<div id="main-carousel" class="carousel slide" data-ride="carousel">
			<div class="carousel-inner">			
				<div class="item active "></div>
				<div class="item"></div>
				<div class="item"></div>
				<ol class="carousel-indicators">
					<li data-target="#main-carousel" data-slide-to="0" class="active"></li>
					<li data-target="#main-carousel" data-slide-to="1"></li>
					<li data-target="#main-carousel" data-slide-to="2"></li>
				</ol>
				<div class="txt_group">
					<div class="txt_wrap">
						<ul>
							<li></li>	<li></li>	<li></li>	<li></li>
						</ul>
						<h2 class="home_title">
							MAKE IT <span>SHOW</span>
						</h2>
						<p class="home_stitle">
							<spring:message code="label.homeStitle" />
						</p>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- main end -->
</div>
</body>
<!-- body end -->
</html>






<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.returnp_web.utils.SessionManager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@page import="java.net.URL" %>
<!DOCTYPE html>
<html lang="en">
<head> 
<title>ReturnP</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<!-- css   -->
<!-- font -->
<link rel="stylesheet" href="/resources/css/m_common.css">
<!-- js -->
<script type="text/javascript" src="/resources/js/lib/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/jquery.cookie.js"></script>
<script type="text/javascript" src="/resources/js/lib/m_common.js"></script>

<!-- 가맹점롤링 --><script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
<!-- 가맹점롤링 --><script type="text/javascript" src="/resources/js/lib/m_slick.js"></script>
  
<script type="text/javascript">
// 가맹점롤링 시작
$(document).on('ready', function() {     
    $(".center").slick({
      infinite: true,
      centerMode: true,
      arrows: false,
      slidesToShow: 4,
      slidesToScroll: 3,
      autoplay:true        
    });
  });
// 가맹점롤링 끝  
    
$(document).ready(function(){
	var pageContextlocale = '${pageContext.response.locale}';
	if(pageContextlocale == "ko"){
	      $("#sel1").val("ko");
	}else{
		 $("#sel1").val("ch");
	}  	
 	//탈퇴완료 후 모달 호출
	if(location.href.match('form=out')){
 		location.href = '/m/mypage/m_memberout.do';
 	}	 	
	if (appInfo && appInfo['access'] && appInfo['access'] == "APP") {
		var p = getParams();
		var mbrE = (p["mbrE"]);
		var userAT = (p["userAT"]);
		if (typeof mbrE != "undefined" && typeof userAT != "undefined") {
			bridge.setDeviceSession(mbrE, mbrE, userAT, function(result) {
				bridge.getSessionValue('PREF_ALL_SESSION', function(result){
				});
			});
		}
	}	
	var p = getParams();
	var alertView = (p["alertView"]);
	var Message  = (p["Message"]);
	var message = "";
	var title = "확인";
	if(Message =="1"){
		message = "잘못된 경로입니다.";
	}else if(Message =="2"){
		message = "이메일 인증이 완료된 고객입니다.";
	}else if(Message =="3"){
		message = "이메일 인증완료되었습니다.";
	}else if(Message =="4"){
		message = "미인증 고객입니다. 이메일인증완료후 사용해주세요.";
	}else if(Message =="5"){
		message = "가입하신 이메일로 발송이 완료되었습니다.";
	}		
	if(alertView =="t"){
		var alertMessageHtml = "";
		var alertTitleHtml = "";
		document.getElementById('alertView').style.display='flex';	
		alertMessageHtml += "<p>"+message+"</p>";
		$('#alertMassage').html(alertMessageHtml);
		alertTitleHtml += "<strong><i class='fas fa-info-circle'></i>"+title+"</strong>";
		$('#alertTitle').html(alertTitleHtml);
		$('#alert_ok').show();
		$('#alert_cancel').hide();
	}
});
</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="index">
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
	<h4>RETRUN<span>P</span></h4>
	</header>
	<!-- main begin -->
	<section class="nobtn"> 
	  <ul class="nav nav-tabs">
	    <li class="main_rpoint active"><a data-toggle="tab" href="#main_rpoint">RPAY</a></li>
	    <li class="main_gpoint"><a data-toggle="tab" href="#main_gpoint">RPOINT</a></li>
	  </ul>	
	  <div class="tab-content">
	    <div id="main_rpoint" class="tab-pane fade in active">
	      <h6>현재 은영님의 총 RPay입니다.</h6>
	      <p>10,500P <i class="fas fa-chevron-right"></i></p>
	      <ul>
	      	<li><a href=""><i class="fas fa-qrcode"></i> 구매하기</a></li>
	      	<li><a href="/m/mypage/point_gift.do"><i class="fas fa-gift"></i> 선물하기</a></li>
	      	<li><a href="/m/mypage/newpoint.do"><i class="fas fa-sync-alt"></i> 전환내역</a></li>
	      </ul>
	    </div>
	    <div id="main_gpoint" class="tab-pane fade">
	      <h6>현재 은영님의 총 RPoint입니다.</h6>
	      <p>12,500P <i class="fas fa-chevron-right"></i></p>
	      <ul>
	      	<li><a href="onclick="startQRScan()"><i class="fas fa-qrcode"></i> 적립하기</a></li>
	      	<li><a href="/m/mypage/point_gift.do"><i class="fas fa-gift"></i> 선물하기</a></li>
	      	<li><a href="/m/mypage/newpoint.do"><i class="fas fa-list-ul"></i> 적립내역</a></li>
	      </ul>
	    </div>
	  </div>	  
	  <div class="center store">
	    <div><img src="/resources/images/m_store01.jpg" /></div>
	    <div><img src="/resources/images/m_store02.jpg" /></div>
	    <div><img src="/resources/images/m_store03.jpg" /></div>
	    <div><img src="/resources/images/m_store04.jpg" /></div>
	    <div><img src="/resources/images/m_store05.jpg" /></div>
	    <div><img src="/resources/images/m_store06.jpg" /></div>
	    <div><img src="/resources/images/m_store07.jpg" /></div>
	    <div><img src="/resources/images/m_store08.jpg" /></div>
	  </div> 
	  <div class="search">	  
	  	<p class="searchbtn"><a href="/m/map/rpmap.do"><i class="fas fa-map-marker-alt"></i> 내주변에 가맹점 찾기</a></p>
		<input id="text_address" type="text" class="form-control" placeholder="ex)강남역, 시청역, 김포 ...">
		<i class="fas fa-search" onclick="searchMap()"></i>
      </div>
	  <ul class="banner">
	  	<li><a href="/m/board/event.do"><img src="/resources/images/m_banner01.jpg" /></a></li>
	  	<li><a href=""><img src="/resources/images/m_banner02.jpg" /></a></li>
	  	<li><a href=""><img src="/resources/images/m_banner02.jpg" /></a></li>
	  </ul>  
	  <div class="footinfo">
	  	<a href="/m/company/service_member.do">리턴포인트란</a><small>/</small>
	  	<a href="/m/board/qna_node.do">제휴문의</a><small>/</small>
	  	<a href="/m/board/faq.do">FAQ</a>
	  	<p>TOTAL<br /><span class="total">1234567명</span></p>
	  </div>
	</section>
	<!-- main end -->
</div>
</body>
<!-- body end -->
</html>