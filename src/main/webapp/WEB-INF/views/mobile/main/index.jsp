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
   <a href="/m/main/index.do"><h4>RETURN<span>P</span> </h4></a>
   </header>
   <!-- main begin -->
   <section class="nobtn">
     <ul class="nav nav-tabs">
       <li class="main_rpoint active"><a data-toggle="tab" href="#main_rpoint"><span style = "font-size : 11pt"><spring:message code="label.rpoint" /></span></a></li>
       <li class="main_gpoint"><a data-toggle="tab" href="#main_gpoint"><span style = "font-size : 11pt"><spring:message code="label.gpoint" /></span></a></li>
     </ul>
     <div class="tab-content">
       <div id="main_rpoint" class="tab-pane fade in active">
         <h5><spring:message code="label.rpay_summary"  arguments = "${sessionScope.memberName}"/></h5>
         <p><fmt:formatNumber value="${model.myRedPointSumInfo.redPointAmountSum}" pattern="###,###,###,###"/>P</p>
         <ul>
            <li><a onclick = "movePage('/m/mypage/m_rpay_use_manage.do?memberNo=${model.memberTypeInfo.memberNo}')" ><i class="fas fa-qrcode"></i>&nbsp;<spring:message code="label.use" /></a></li>
           <%--  <li><a href="/m/mypage/pay_gift.do"><i class="fas fa-gift"></i>&nbsp;<spring:message code="label.gift" /></a></li> --%>
            <li><a href="/m/mypage/newpay.do"><i class="fas fa-list-ul"></i>&nbsp;<spring:message code="label.transition_history" /></a></li>
         </ul>
       </div>
       <div id="main_gpoint" class="tab-pane fade">
         <h5><spring:message code="label.rpoint_summary"  arguments = "${sessionScope.memberName}"/></h5>
         <p><fmt:formatNumber value="${model.myGreenPointSumInfo.greenPointAmountSum}" pattern="###,###,###,###"/>P</p>
         <ul>
            <li><a onclick="startQRScan()"><i class="fas fa-qrcode"></i>&nbsp;<spring:message code="label.accumulate" /></a></li>
            <li><a href="/m/mypage/point_gift.do"><i class="fas fa-gift">&nbsp;</i><spring:message code="label.gift" /></a></li>
            <li><a href="/m/mypage/newpoint.do"><i class="fas fa-list-ul">&nbsp;</i><spring:message code="label.transition_history" /></a></li>
         </ul>
       </div>
     </div>
     
     <div class="center store">
       <div style = "width:20%" ><img width = "58" height = "58" src="/resources/images/m_store01.jpg"  /></div>
       <div style = "width:20%" ><img width = "58" height = "58" src="/resources/images/m_store01.jpg" /></div>
       <div style = "width:20%" ><img width = "58" height = "58" src="/resources/images/m_store01.jpg" /></div>
       <div style = "width:20%" ><img width = "58" height = "58" src="/resources/images/m_store01.jpg" /></div>
       <div style = "width:20%" ><a href="https://sincar.co.kr/UID=rp4282"><img width = "58" height = "58" src="/resources/banner/new_car_mall_circle.png" ></a></div>
     </div>

     <div class="search">
       <p class="searchbtn"><a href="/m/map/rpmap.do"><i class="fas fa-map-marker-alt"></i> <spring:message code="label.find_merchants" /></a></p>
      <input id="text_address" type="text" class="form-control" placeholder="ex)강남역, 시청역, 김포 ...">
      <i class="fas fa-search" onclick="searchMap()"></i>
      </div>
      <c:if test = "${! empty model.notice}">
            <div class="main_notice">
              <span class = "notice_title"><a href = "/m/board/boardDetail.do?dType=mainBbs&mainBbsNo=${model.notice.mainBbsNo}">${model.notice.title}</a></span>
              
              <c:set var="now" value="<%=new java.util.Date()%>"/>
              <fmt:parseNumber value="${now.time / (1000*60*60*24)}" integerOnly="true" var="today"></fmt:parseNumber>
              
              <fmt:parseDate value="${model.notice.createTime}" var="noticePostDate" pattern="yyyy-MM-dd "/>
              <fmt:parseNumber value="${noticePostDate.time / (1000*60*60*24)}" integerOnly="true" var="postData"></fmt:parseNumber>
			  <c:if test="${today - postData <= 6}">
			  	<span class ="badge" style = "border : 1px solid #04B404; background-color: #fff;color : #088A08;display : inline;font-weight : 400;font-size: 10px">new</span>
			   </c:if> 
              
              <span class = "notice_time">
              	 <fmt:formatDate value="${noticePostDate}" pattern="yyyy-MM-dd"/>
              	</span>  
            </div>
        </c:if>
    
   <ul class="banner">
   <li><a href="http://rp.umallok.com"><img src="/resources/banner/umall.jpg" /></a></li>
        <li><a href="http://nowpay.80port.net/allpay/bbs/board.php?bo_table=qo3"><img src="/resources/banner/gift_card_banner.jpg" /></a></li>
        <li><a href="http://nowpay.80port.net/allpay/bbs/board.php?bo_table=qo1"><img src="/resources/banner/20190502_133801490.jpg" /></a></li>
      <!--  <li><a href="http://nowpay.80port.net/allpay/bbs/board.php?bo_table=qo2"><img src="/resources/banner/insurance_banner.jpg" /></a></li> -->
     </ul>
     <div class="footinfo">
        <a href="/m/company/service_member.do"><spring:message code="label.what_return_point" /></a><small>|</small>
          <a href="/m/board/boardList.do?bbsType1=1"><spring:message code="label.notice" /></a><small>|</small>
        <a href="/m/board/boardList.do?bbsType1=4"><spring:message code="label.affiliated_inquiry" /></a><small>|</small>
        <a href="/m/board/boardList.do?bbsType1=2&&bbsType2=0"><spring:message code="label.web.faq" /></a>
      <%--   <p>TOTAL<br /><span class="total">${model.memberTotal} </span></p> --%>
     </div>
   </section>
</div>
<script>
  $(".center").slick({
      infinite: true,
      centerMode: true,
      arrows: false,
      slidesToShow: 4,
      slidesToScroll: 3,
      autoplay:true
    });
</script>
</body>
<!-- body end -->
</html>