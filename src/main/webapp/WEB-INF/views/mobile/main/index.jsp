<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.returnp_web.utils.SessionManager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page import="java.net.URL" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>ReturnP</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<!-- sns url 링크시 표시되는 이미지와 텍스트내용들 테스트입니다.  -->
<meta property="og:url" content="https://www.returnp.com">
<meta property="og:title" content="ReturnP">
<meta property="og:type" content="website">
<meta property="og:image" content="/resources/images/sns_url_link_img.png">

<link rel="stylesheet" href="/resources/css/m_common.css">
<!-- <script type="text/javascript" src="/resources/js/lib/jquery.min.js"></script> -->
<script type="text/javascript" src="/resources/js/lib/jquery-2.2.0.min.js"></script>

<!-- 가맹점롤링 -->
<!-- <script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script> -->

<!-- 가맹점롤링 -->
<script type="text/javascript" src="/resources/js/lib/m_slick.js"></script>
<script type="text/javascript" src="/resources/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/jquery.cookie.js"></script>
<script type="text/javascript" src="/resources/js/lib/m_common.js"></script>
<script type="text/javascript">
  if (isApp()) {
    checkVersion();
  }

  $(document).on('ready', function() {
       if(getCookie("notToday")=="Y"){
        $("#alertView").hide();
       }
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


       //$("#alertView").hide();

      if (isApp()) {
          var mbrE = (p["mbrE"]);
          var userAT = (p["userAT"]);
          if (typeof mbrE != "undefined" && typeof userAT != "undefined") {
             var session = {userName :mbrE , userEmail : mbrE, userAuthToken : userAT }
            bridge.setDeviceSession(JSON.stringify(session), function(result) {
             });
          }
       }
  });
</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="index">
   <!-- 0921 이벤트 노티 -->
<%--    <div class="alert_wrap event" id="eventAlert" name="eventAlert" style = "display:none">
     <div class="alert alert-info">
       <button type="button" class="close" id="alert_cancel" name="alertClose"  onclick='javascript:alertClose("event");'>&times;</button>
       <c:choose>
         <c:when
            test="${(sessionScope.memberEmail == null) || (sessionScope.memberEmail == '')}">
            <a href="/m/member/join.do" class="eventlink"><spring:message code="label.join_member" /><br /><spring:message code="label.shortcut" /></a>
            <!-- 로그인 후 -->
         </c:when>
         <c:otherwise>
            <a href="/m/mypage/m_fullmember.do" class="eventlink"><spring:message code="label.regular_member" /><br /><spring:message code="label.apply" /></a>
         </c:otherwise>
      </c:choose>
     </div>
   </div>   --%>
   <!-- 0831 서버점검 노티 -->
   <c:if test="${SERVER_MANAGE.status.webServerStatus == '2' }">
    <div class="alert_wrap noti" id="alertView" name="alertView"  ><!--  style 부분에 display:none;을 빼주심 활성화되요 -->
     <div class="alert alert-info">
        <button type="button" class="close" id="alertClose" name="alertClose"  onclick='javascript:alertClose("noti");' style = "color : #000000">&times;</button>
       <div class="alert_body">
         <!--   <i class="fas fa-volume-up"></i> -->
           <div class="error_desk" style = "font-family: 'Nanum Gothic', sans-serif;'">
               <p style = "margin-bottom : 1px">
                  <span style = "font-size : 20px; font-weight : bold;color :#DF01A5 ;font-family: 'Nanum Gothic', sans-serif;'" >'100% R포인트 캐시백'</span></br>
                  <span style = "font-size : 20px; font-weight : bold;color :#DF01A5;font-family: 'Nanum Gothic', sans-serif;'">U 몰 (쇼핑몰)오픈</span>

                </p>
        <!-- <p style = "font-size : 15px; font-weight : bold;font-family: 'Nanum Gothic', sans-serif;'">R 포인트 U몰(쇼핑몰)  오픈!</p> -->
        <p style = "font-size : 15px; font-weight : bold;font-family: 'Nanum Gothic', sans-serif;'">네이버의 동일 제품과 가격  비교해 보시고 제휴사 U몰을 많이 이용해 주시기 바랍니다</p>
        <p style = "font-size : 15px; font-weight : bold;font-family: 'Nanum Gothic', sans-serif;'">감사합니다</p>
        <p style = "font-size : 15px; font-weight : bold;font-family: 'Nanum Gothic', sans-serif;'">주식회사 탑해피월드 임직원 일동</p>
        <p style = "font-size : 15px; font-weight : bold;font-family: 'Nanum Gothic', sans-serif;'"><a class = "reverse_text1" href = "javascript:closePopupNotToday('alertView')" ><span class ="reverse_text"><%-- <spring:message code="label.not_view_today" /> --%>그만 보기</span></a></p>

           </div>
       </div>
     </div>
   </div>
   </c:if>
   <!-- nav -->
   <jsp:include page="../common/topper.jsp" />
   <!-- nav -->
   <a href="/m/main/index.do"><h4>RETURNP</h4></a>
   </header>
   <!-- main begin -->
   <section class="nobtn" id = "main">
   <!-- 이벤트 관련 슬라이드 이미지 스크립트 -->
   <script type="text/javascript">
	   $(document).ready(function(){
			var current = 0;
			var $slides = $(".slide");
			var total = 2;
	
		$slides.css("right","-500px");
		$slides.eq(0).css("right","0px");
	
		function setSlide(){
			if (current+1 >= total) move(0);
			else move(current + 1);
		}
	
		function move(idx){
			$slides.eq(current).animate({"right":"500px"});
			$slides.eq(idx).css({"right":"-500px"});
			$slides.eq(idx).animate({"right":"0px"});
			current=idx;
		}
		setInterval(setSlide,2500);
	});
   </script>
   <!-- 이벤트 관련 슬라이드 이미지 -->
    <div class="main">
		<div class="slide"><img src="/resources/images/slide1.png"/></div>
		<div class="slide"><img src="/resources/images/slide2.png"/></div>
		<div class="slide"><img src="/resources/images/slide3.png"/></div>
	</div>
	<div class="main_point">
		<div class="main_rpoint"><span>R 포인트</span><span>98,000</span></div>
		<div class="main_gpoint"><span>G 포인트</span><span>98,000</span></div>
	</div>
	<!-- 공지사항 -->
	<div class="m_noti">
		<span>[공지]현금 영수증 G 포인트 적립 개시</span><span>NEW</span><span>2019-11-11</span>
	</div>
	<div class="main_img_box">
		<div><img src="/resources/images/r_point.png"><p>포인트</p></div>
		<div><img src="/resources/images/r_money.png"><p>포인트 출금/계좌</p></div>
		<div><img src="/resources/images/r_qrcode.png"><p>QR 코드스캔</p></div>
		<div><img src="/resources/images/r_receipt.png"><p>포인트 적립권</p></div>
		<div><img src="/resources/images/r_credit.png"><p>R POINT 상품권</p></div>
		<div><img src="/resources/images/r_set.png"><p>환경설정</p></div>
		<div><img src="/resources/images/r_my.png"><p>내정보</p></div>
		<div><img src="/resources/images/r_search.png"><p>가맹점검색</p></div>
		<div><img src="/resources/images/r_phone.png"><p>고객센터</p></div>
	</div>
	<div style="background-color:#f1f1f1;padding:1px 0;">
		<div class="m_search">
			<span>가맹점 검색</span><span><img src="/resources/images/r_bottom_search.png"></span>
		</div>
	</div>
	<div class="m_banner">
		<img src="/resources/images/r_banner.png">
	</div>



   </section>
</div>

</body>
<!-- body end -->
</html>