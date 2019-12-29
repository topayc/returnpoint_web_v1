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
<script type="text/javascript" src="/resources/js/lib/jquery.mobile.js.js"></script>

<!-- 가맹점롤링 -->
<!-- <script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script> -->

<!-- 가맹점롤링 -->
<script type="text/javascript" src="/resources/js/lib/m_slick.js"></script>
<script type="text/javascript" src="/resources/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/jquery.cookie.js"></script>
<script type="text/javascript" src="/resources/js/lib/m_common.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<style>
.modal {
 background:none;
 text-align : center;
 box_shadow : none;
 padding : 0;
 -webkit-box-shadow : none;
 width:100%;
}
</style>
<script type="text/javascript">
   
if (isApp()) {
    checkVersion();
  }
 $(document).on('ready', function() {
	 $("#event_popup").modal({
		  escapeClose: false,
		  clickClose: false,
		  showClose: false,
		  fadeDuration: 90
		});  
	  if(getCookie("notToday")=="Y"){
		  closeMainModal();
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
   <!-- 0831 서버점검 노티 -->
<%--    <c:if test="${SERVER_MANAGE.status.webServerStatus == '2' }"> --%>
    <div style="display:none;" id = "event_popup">
    	<div class="main_popuppage">
		<div class="popup_list" >
			
			<!-- 이벤트 OPEN 예정 팝업 -->
		<!-- 	<img src="/resources/images/event_popup1.png">
			<div class="list_box1">
				<ul>
					<li>시행일시 : <span>2019.12.18</span></li>
				</ul>
			</div> -->
			<!-- 이벤트 OPEN후 주석 풀어주세요 -->
			
			<img src="/resources/images/event_popup2.png">
			<div class="list_box">
				<ul>
					<li><span onclick = "movePage('/m/pointCoupon/index.do')">자세히보기</span></li>
				</ul>
			</div>
			
			
			<div class="popup_btn_box">
				<button style="border-top:1px solid #ff83c5;border-right:1px solid #ff83c5" onclick = "closePopupNotToday('alertView')">오늘 그만 보기</button>
				<button style="margin-left: -4.5px;border-top:1px solid #ff83c5;" onclick = "closeMainModal();return false">닫기</button>
			</div>
		</div>
	</div>
   </div>
   <%-- </c:if> --%>
   <!-- nav -->
   <jsp:include page="../common/topper.jsp" />
   <!-- nav -->
   <a href="/m/main/index.do"><h4><spring:message code="label.n_returnp" /></h4></a>
   </header>
   <section class="nobtn" id = "main">
    <div class="main">
		<div class="slide" onclick = "movePage('/m/pointCoupon/index.do')">
			<img src="/resources/images/event_banner2.png"/>
			<!-- 이벤트 OPEN시 아래 한줄 주석풀어주세요 -->
			
			<div class="main_text2">
				<ul>
					<li>
						<span style = "font-weight:bold;color: #666">일반 영수증 적립 서비스 OPEN! </span></br>
						<span style = "color: #777;font-size : 14px;font-weight:350">결제 영수증 이젠 버리지 마세요</span></li>
					<li style = "font-size : 14px;color : #777;font-weight:350">일반 가맹점 영수증도<br>이젠 <b>100% G 포인트</b>를 드려요!</li>
					
					<li><span  class="main_text3" style = "font-size:12px;">자세히보기</span></li>
				</ul>
			</div>
		</div>
		<div class="slide">
			<img src="/resources/images/slide2.png"/>
			<div class="main_text1">
				<ul>
					<li><span style = "font-weight:bold;color: #fff;font-size:16px;top:5px">소비가 저축이 되는 R POINT</span></li>
					<li><span style = "font-weight:400;color: #fff;font-size:14px">R POINT 가맹점에서 결제 후 <br> 영수증 QR 코드를 스캔만 하면 <br> 결제 금액의 100% 포인트<br>  실시간 적립!</span></li>
				</ul>
			</div>
		</div>
	</div>
	<div class="main_point">
		<div class="main_rpoint">
			<span style="color:#ff0066;"><span class="circle_text" style="color:#ff0066;border:1px solid #ff0066;">R</span><fmt:formatNumber value="${model.myRedPointSumInfo.redPointAmountSum}" pattern="###,###,###,###"/></span>
		</div>
		<div class="main_gpoint">
			<span style="color:#33cccc;"><span class="circle_text" style="color:#33cccc;border:1px solid #33cccc;">G</span><fmt:formatNumber value="${model.myGreenPointSumInfo.greenPointAmountSum}" pattern="###,###,###,###"/></span>
		</div>
	</div>
	
	<!-- 공지사항 -->
	<c:if test = "${! empty model.notice}">
	<div class="m_noti">
		<span> 
			<a  href = "/m/board/boardDetail.do?dType=mainBbs&mainBbsNo=${model.notice.mainBbsNo}">
				<c:choose>
					<c:when test="${fn:length(model.notice.title) gt 35}">
				        <c:out value="${fn:substring(model.notice.title, 0, 35)}"></c:out>...
				    </c:when>
				    <c:otherwise>
				        <c:out value="${model.notice.title}"> </c:out>
				    </c:otherwise>
				</c:choose>	
			</a>
		
		</span>
		
		 <c:set var="now" value="<%=new java.util.Date()%>"/>
         <fmt:parseNumber value="${now.time / (1000*60*60*24)}" integerOnly="true" var="today"></fmt:parseNumber>
		 <fmt:parseDate value="${model.notice.createTime}" var="noticePostDate" pattern="yyyy-MM-dd "/>
          <fmt:parseNumber value="${noticePostDate.time / (1000*60*60*24)}" integerOnly="true" var="postData"></fmt:parseNumber>
		<c:if test="${today - postData <= 5}">
		<span> NEW</span>
		</c:if>
	</div>
	</c:if>
	
	<div class="main_img_box">
		<div onclick="startQRScan()"><img src="/resources/images/r_qrcode.png"><p><spring:message code="label.qrcode_acc" /></p></div>
		<div onclick = "movePage('/m/pointCoupon/index.do')"><img src="/resources/images/r_receipt.png"><p><spring:message code="label.n_reciept_acc" /></p></div>
		<!-- <div onclick = "movePage('/m/coupon/point_coupon_reg.do')"><img src="/resources/images/r_receipt.png"><p>적립권등록</p></div> -->
		<div onclick = "movePage('/m/point/pointInfo.do')"><img src="/resources/images/r_point.png"><p><spring:message code="label.n_point" /></p></div>
		<div onclick = "movePage('/m/mypage/rpoint/rpoint_withdrawal.do?memberNo=${model.memberTypeInfo.memberNo}')"><img src="/resources/images/r_money.png"><p><spring:message code="label.n_withdrawal" /></p></div>
		<div onclick = "movePage('/m/mypage/m_mybank_account_list.do?memberNo=${model.memberTypeInfo.memberNo}')" ><img src="/resources/images/r_phone.png"><p><spring:message code="label.n_bank_account" /></p></div>
		<div onclick = "movePage('/m/giftCard/giftCardList.do')"><img src="/resources/images/r_credit.png"><p><spring:message code="label.n_gift_card" /></p></div>
		<div onclick = "movePage('/m/map/rpmap.do')"><img src="/resources/images/r_search.png"><p><spring:message code="label.n_my_affiliate" /></p></div>
		<div onclick = "movePage('/m/mypage/mypage_myinfo.do')"><img src="/resources/images/r_my.png"><p><spring:message code="label.n_myinfo" />/<spring:message code="label.n_settings" /></p></div>
		<div onclick = "movePage('/m/mypage/manage_qr.do')"><img src="/resources/images/r_qr_manage.png"><p><%-- <spring:message code="label.create_recom_qr" /> --%>추천QR생성</p></div>
	</div>
	<div style="background-color:#f1f1f1;padding:1px 0;">
		<%-- <div class="m_search" onclick = "movePage('/m/affiliate/affiliateSearchList.do')"> 
			<span><spring:message code="label.n_search_affiliate" /></span><span><img src="/resources/images/r_bottom_search.png"></span>
		</div> --%>
		<div class="r_fran_page">
			<div class="r_fran_left"  onclick = "movePage('/m/affiliate/newAffiliateSearch.do')">업종별 가맹점</div>
			<div class="r_fran_right" onclick = "movePage('/m/affiliate/affiliateSearchList.do')">지역별 가맹점</div>
		</div>
	</div>
	<div class = "m_main_banner"> 
		<div class="m_banner" onclick = "movePage('http://rp.umallok.com')"> <img class = "m_banner_img" src="/resources/images/r_umall.jpg"></div>
		<div class="m_banner" onclick = "movePage('http://yourental.co.kr/index.do')"> <img class = "m_banner_img" src="/resources/images/r_umall_rental.jpg"></div>
		<div class="m_banner" style ="margin-top:7px;" onclick = "movePage('http://returnpoint.net ')"> <img class = "m_banner_img" src="/resources/images/r_wamall.png"></div> 
	</div>
	 <footer>
      <ul style = "font-weight:300">
         <li><small>(주)</small> <b>탑해피월드</b></li>
         <li>서울특별시 구로구 구로동 170-5 우림 이비지센터 1차 806호</li>
         <li>대표자 : 윤동욱&nbsp;&nbsp; <spring:message code="label.biz_number" /> : 754-86-01056</li>
         <li><spring:message code="label.web.tophappyworldCustomerCenterOperationHours" /> : 10시 ~ 12시 30분, 13시 30분 ~ 18시</li>
         <li><spring:message code="label.topper.menu.customer_center" /> : 02-585-5993</li>
         <li>
         	<span><a href="/m/customer/customerCenter.do"><spring:message code="label.web.companyIntroduction" /></a>&nbsp;</span>&nbsp;
         	<span><a href="/m/company/service_member.do"><spring:message code="label.what_return_point" /></a>&nbsp;</span>&nbsp;
         	<span><a href="/m/company/m_termsofuse.do"><spring:message code="label.web.termsAndConditions" /></a>&nbsp; </span>&nbsp;
         	<span><a href="/m/company/m_privacypolicy.do"><spring:message code="label.web.personalInformationHandlingAndHandlingPolicy" /></a>&nbsp;</span>&nbsp;</li>
      </ul>
   </footer>
   </section>
</div>
<script type="text/javascript">
$(document).ready(function(){
	var current = 0;
	var $slides = $(".slide");
	var total = 2;

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