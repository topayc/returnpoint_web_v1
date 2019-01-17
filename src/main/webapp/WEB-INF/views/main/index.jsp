<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.returnp_web.utils.SessionManager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@page import="java.net.URL" %>
<!DOCTYPE html>
<html lang="en">
<head> 
<title>RETURNP</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<!-- sns url 링크시 표시되는 이미지와 텍스트내용들 테스트입니다.  -->
<meta property="og:url" content="http://returnp.com">
<meta property="og:title" content="ReturnP">
<meta property="og:type" content="website">
<meta property="og:image" content="/resources/images/sns_url_link_img.png">

<!-- css   -->
<!-- font -->
<link rel="stylesheet" href="/resources/css/common.css">
<!-- js -->
<script type="text/javascript" src="/resources/js/lib/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/jquery.cookie.js"></script>
<script type="text/javascript" src="/resources/js/lib/common.js"></script>
<script type="text/javascript">
if (appInfo.access =="MOBILE" || appInfo.access == "APP") {
	location.href = "/m/main/index.do";
}
$(document).ready(function(){
	var pageContextlocale = '${pageContext.response.locale}';
	pageContextlocale = pageContextlocale ? pageContextlocale : "ko";  
	if (pageContextlocale.indexOf("ko") > 0) {
	   pageContextlocale  = "ko";
    }
   $("#sel1").val(pageContextlocale);
   if($.cookie('joinCookie')) {
      $('#mjoincomplete').modal('show');
   }
   
   //회원가입 모달창 회원가입 버튼 이벤트
   $("#joincompletelogin").on("click", function(){
      location.href = '/member/login.do'; 
   });

   //회원가입 모달창 닫기 버튼 이벤트
   $("#joincompleteclose").on("click", function(){
      location.href = '/member/login.do';
   });
   
    //탈퇴완료 후 모달 호출
    if(location.href.match('form=out')){
       $("#mymemberout").modal({backdrop: 'static', keyboard: false});
    }
   
    //회원탈퇴 모달창 닫기 버튼
    $("#memberOutClose").on("click", function(){
       location.replace('/main/index.do');
    });
    
    //회원탈퇴 회원가입메뉴 이동버튼
    $("#memberJoin").on("click", function(){
       location.replace('/member/join.do');
    });
    
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
<body class="home">
   <!-- 0921 이벤트 노티 -->
   <div class="alert_wrap event" name="eventAlert" style = "display:none">
     <div class="alert alert-info">     
       <button type="button" class="close" id="alert_cancel" name="alertClose"  onclick='javascript:alertClose("event");'>&times;</button>
       <c:choose>
         <c:when
            test="${(sessionScope.memberEmail == null) || (sessionScope.memberEmail == '')}">
            <a href="/member/join.do" class="eventlink">회원가입<br />바로가기</a>
            <!-- 로그인 후 -->
         </c:when>
         <c:otherwise>
            <a href="/mypage/m_fullmember.do" class="eventlink">정회원<br />신청하기</a>
         </c:otherwise>
      </c:choose>
     </div> 
   </div>
   <!-- 0831 서버점검 노티 -->
   <c:if test="${SERVER_MANAGE.status.webServerStatus == '2' }">
   <div class="alert_wrap noti" id="alertView" name="alertView" ><!--  style 부분에 display:none;을 빼주심 활성화되요 -->
     <div class="alert alert-info">
       <div class="alert_body">   
          <i class="fas fa-exclamation-triangle"></i>       
           <div class="error_desk">
               <h2>Checking Server</h2>
               <h4>서버 임시 점검중입니다.</h4>
           </div>
       </div>
     </div> 
   </div>
   </c:if>
   <!-- nav -->
   <jsp:include page="/WEB-INF/views/common/topper.jsp" />
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
                     <li></li>   <li></li>   <li></li>   <li></li>
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
   <!-- join complete modal 회원가입 완료 후 출력되는 모달입니다. -->
   <jsp:include page="../member/m_joincomplete.jsp" flush="false" />
   <!-- join complete modal end -->
   <!-- member out modal -->
   <jsp:include page="../mypage/m_memberout.jsp" flush="false" />
   <!-- member out modal end -->
</body>
<!-- body end -->
</html>