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
<script type="text/javascript" src="/resources/js/lib/jquery-number.js"></script>
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
	  $("#price_text").text($.number(productInfo.price));
	  if (productInfo.gPointRate != 0 ){
		  $("#gpoint_text").text($.number(productInfo.price * productInfo.gPointRate) + " GPOINT 적립") ;
	  }
	  
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
<!--     <div style="display:none;" id = "event_popup">
    	<div class="main_popuppage">
		<div class="popup_list" >
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
   </div> -->
     <div style="display:none;" id = "event_popup">
    	<div class="main_popuppage" style = "background-color : #fff;">
			<div class="popup_list" style = "border: 1px solid #000;" >
				<div>
					<div style = "padding: 10px 5px;font-size : 13px;color :#fff;background-color : #cc0000">회사 정상화를 위한 포인트 출자전환 및 출금관련 공지</div>
					<div style = "text-align:left;padding:20px 20px 10px 20px">
						<p style = "font-size : 14px; font-weight : 550">▶ 포인트 출자 전환 및 신규 증자 </p>
						<p style = "color : #555;margin-top:3px">- 조속한 회사 정상화를 위하여 현재 포인트의 출자 전환과 신규 증자 작업이 진행되고 있습니다.</p>
						<p style = "color : #555;margin-top:3px">- 많은 분들의 참여 바라며, 회사 정상화를 위하여 최선을 다하겠습니다.</p>
						</br>
						<p style = "font-size : 14px; font-weight : 550">▶ 출금 관련 처리 </p>
						<p style = "color : #555;margin-top:3px">- 포인트 출자 전환 및 증자 완료 후 출금 처리 가능</p>
						<p style = "color : #555;margin-top:3px">- 출금 가능 예상일 : 협의중</p>
						
						</br>
						<p style = "color : #000;margin-top:3px;font-weight: 500">자세한 내용을 보시려면 아래 버튼을 클릭해주세요</p>
						</br>
						<p style = "color : #555;margin-top:3px;text-align:center;">
							<a href = "/m/board/boardDetail.do?dType=mainBbs&mainBbsNo=118" style = "color : #fff;border: 1px solid #cc0000;padding:7px 15px;border-radius: 15px;background-color : #cc0000;font-size:12px">✓ 출자 전환신청 및 자세히보기</a>
						</p>
						</br>
						<p style = "color : #000;margin-top:3px;font-weight: 500;margin-top:12px">또한 회사 정상화 작업과 관련되어 한시적으로 부득이하게 아래의 조치를 취할 수 밖에 없음을 알려드리며, 회원님들의 양해 부탁드립니다</p>
						<p style = "color : #000;margin-top:3px;font-weight: bold">- 출금 신청 중지</p>
						<p style = "color : #000;margin-top:3px;font-weight: bold">- G 포인트 -> R 포인트로의 자동 전환 작업 중지</p>
						</br>
						<p style = "color : #000;margin-top:3px;font-weight: 500">조속한 정상화를 위해 최선의 노력을 다하겠습니다</p>
					</div>
				</div>
				<div class="popup_btn_box">
					<button style="border-top:1px solid #ccc;border-right:1px solid #ccc" onclick = "closePopupNotToday('alertView')">오늘 그만 보기</button>
					<button style="margin-left: -4.5px;border-top:1px solid #ccc;" onclick = "closeMainModal();return false">닫기</button>
				</div>
			</div>
		</div>
   </div>
<!--    <div style="display:none;" id = "event_popup">
    	<div class="main_popuppage">
		<div class="popup_list1" >
		<img src="/resources/images/event_popup_notice.png">
			<div class="list_box2">
				<ul>
					<li><h3>영수증 적립 서비스 계좌변경</h3></li>
					<li>부득이하게 계좌변경됨을 양해부탁드립니다.</li>
					<li>변경계좌 : 우리은행 000-000-000 예금주:안영철</li>
				</ul>
			</div>
			<div class="list_box">
				<ul>
					<li><span onclick = "movePage('/m/pointCoupon/index.do')">자세히보기</span></li>
				</ul>
			</div>
			<div class="popup_btn_box1">
				<button style="border-top:1px solid #fff;border-right:1px solid #fff" onclick = "closePopupNotToday('alertView')">오늘 그만 보기</button>
				<button style="margin-left: -4.5px;border-top:1px solid #fff;" onclick = "closeMainModal();return false">닫기</button>
			</div>
		</div>
	</div>
   </div> -->
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
					<!-- <li>
						<span style = "font-weight:bold;color: #666">일반 영수증 적립 서비스 OPEN! </span></br>
						<span style = "color: #777;font-size : 14px;font-weight:350">결제 영수증 이젠 버리지 마세요</span></li>
					<li style = "font-size : 14px;color : #777;font-weight:350">일반 가맹점 영수증도<br>이젠 <b>100% G 포인트</b>를 드려요!</li>
					 -->
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
	<c:if test = "${! empty notice}">
	<div class="m_noti">
		<span> 
			<a  href = "/m/board/boardDetail.do?dType=mainBbs&mainBbsNo=${notice.mainBbsNo}">
				<c:choose>
					<c:when test="${fn:length(notice.title) gt 35}">
				        <span style = "color : #000;font-weight:700;">공지</span>
				        <span style = "color : #666"><c:out value="${fn:substring(notice.title, 0, 35)}"></c:out>...</span>
				    </c:when>
				    <c:otherwise>
				        <span style = "color : #000;font-weight:700;">공지</span>
				        <span style = "color : #666"><c:out value="${notice.title}"> </c:out></span>
				    </c:otherwise>
				</c:choose>	
			</a>
		
		</span>
		
		 <c:set var="now" value="<%=new java.util.Date()%>"/>
         <fmt:parseNumber value="${now.time / (1000*60*60*24)}" integerOnly="true" var="today"></fmt:parseNumber>
		 <fmt:parseDate value="${notice.createTime}" var="noticePostDate" pattern="yyyy-MM-dd "/>
          <fmt:parseNumber value="${noticePostDate.time / (1000*60*60*24)}" integerOnly="true" var="postData"></fmt:parseNumber>
		<c:if test="${today - postData <= 7}">
		<span class = "new_notice"> NEW</span>
		</c:if>
	</div>
	</c:if>
	<c:if test = "${! empty affiliateNotices}">
		<c:forEach var="affiliateNotice" items="${affiliateNotices}" varStatus = "status">
		<div class="m_noti">
			<span> 
				<a  href = "/m/board/boardDetail.do?dType=mainBbs&mainBbsNo=${affiliateNotice.mainBbsNo}">
					<c:choose>
						<c:when test="${fn:length(affiliateNotice.title) gt 35}"> 
							<c:set var = "affiliateNoticeTitle" value = "${fn:substring(affiliateNotice.title, 0, 35)}"/> </c:when>
					    <c:otherwise> 
					    	<c:set var= "affiliateNoticeTitle" value = "${affiliateNotice.title}"/> 
					    </c:otherwise>
					</c:choose>	
					 
					 <span style = "color : #000;font-weight:700;">가맹점 공지</span>
					 <c:choose>
						<c:when test="${status.first}"> 
						 <span style = "color : #EC2491;font-weight:600"><c:out value="${affiliateNoticeTitle}"/></span>
						</c:when>
					    <c:otherwise> 
					    	 <span style = "color : #666"><c:out value="${affiliateNoticeTitle}"/></span>
					    </c:otherwise>
					</c:choose>	
				</a>
			 	<c:set var="now1" value="<%=new java.util.Date()%>"/>
	        	 <fmt:parseNumber value="${now1.time / (1000*60*60*24)}" integerOnly="true" var="today1"></fmt:parseNumber>
			 	<fmt:parseDate value="${affiliateNotice.createTime}" var="affiliateNoticePostDate" pattern="yyyy-MM-dd "/>
	          	<fmt:parseNumber value="${affiliateNoticePostDate.time / (1000*60*60*24)}" integerOnly="true" var="postData1"></fmt:parseNumber>
				<c:if test="${today1 - postData1 <= 7}">
				<span class = "new_notice"> NEW</span>
				</c:if>
			</span>
		</div>		
		</c:forEach>
	</c:if>
	<div class="r_shop" style="border-top:none;">

			<div class="r_shop_list" onclick = "movePage('/m/shop/productDetail.do')">
				<div class="r_shop_list_img">
					<img src="/resources/images/mask_img.png">
				</div>
				<div class="r_shop_list_text">
					<ul>
						<li style = "font-szie:8px">재사용 가능한 KN 99 고기능</li>
						<li><h5>은나노 마스크 Silver Nano Mask</h5></li>
						<li style = "font-weight:600;font-size : 16px"><img src="/resources/images/list_star.png"><span id = "price_text"></span>원</li>
						<li style = "color : #33cccc;font-weight: 500"><span id = "gpoint_text"></span> </li>
					</ul>
				</div>
			</div>
			</div>
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
			<c:if test = "${not empty affiliate}">
			<div class="r_fran_btn" onclick = "movePage('/m/affiliate/affiliateMain.do?affiliateNo=${affiliate.affiliateNo}')" >
				<img src="/resources/images/r_fran_btn_img.png"><span style = "font-weight:bold;font-size:14px">${affiliate.affiliateName}</span> 가맹점 페이지</div>
			</c:if>
			<div class="r_fran_left"  onclick = "movePage('/m/affiliate/newAffiliateSearch.do')">업종별 가맹점</div>
			<div class="r_fran_right" onclick = "movePage('/m/affiliate/affiliateSearchList.do')">지역별 가맹점</div>
		</div>
	</div>
	<div class = "m_main_banner"> 
		<div class="m_banner" onclick = "movePage('/m/board/boardDetail.do?dType=mainBbs&mainBbsNo=107')"> <img class = "m_banner_img" src="/resources/banner/capital.png"></div>
		<div class="m_banner" onclick = "movePage('http://rp.umallok.com')"> <img class = "m_banner_img" src="/resources/images/r_umall.jpg"></div>
		<div class="m_banner" onclick = "movePage('http://yourental.co.kr/index.do')"> <img class = "m_banner_img" src="/resources/images/r_umall_rental.jpg"></div>
	<!-- 	<div class="m_banner" style ="margin-top:7px;" onclick = "movePage('http://returnpoint.net ')"> <img class = "m_banner_img" src="/resources/images/r_wamall.png"></div> --> 
	</div>
	 <footer>
      <ul style = "font-weight:300">
         <li><small>(주)</small> <b>탑해피월드</b></li>
         <li>서울특별시 구로구 구로동 170-5 우림 이비지센터 1차 806호</li>
         <li>대표자 : 안성열&nbsp;&nbsp; <spring:message code="label.biz_number" /> : 754-86-01056</li>
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