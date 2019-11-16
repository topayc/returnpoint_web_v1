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
<script type="text/javascript" src="/resources/js/lib/jquery.animateNumber.min.js"></script>
<script type="text/javascript">
  if (isApp()) {
    checkVersion();
  }
  $(document).ready(function(){
	var comma_separator_number_step = $.animateNumber.numberStepFactories.separator(',')

	var rs = ${model.myRedPointSumInfo.redPointAmountSum};
	$('#r_PointSum').animateNumber({
			number : rs,
			numberStep : comma_separator_number_step
		});

	var ps = ${model.myGreenPointSumInfo.greenPointAmountSum};
	$('#g_PointSum').animateNumber({
			number : ps,
			numberStep : comma_separator_number_step
		});
  })
</script>
</head>
<!-- header end -->
<!-- body begin -->
<body class="index">
   <!-- nav -->
   <jsp:include page="../common/topper.jsp" />
   <!-- nav -->
   <a href="/m/main/index.do"><h4><spring:message code="label.point" /></h4></a>
   </header>
   <section class="nobtn" id = "main">
<ul class="tab_menu">
   <li class="on" ><a href="#">R 포인트</a>
      <div class="contents">
         <div class="point_detail_info">
            <div class="top_detail r_contents">
                  <ul>
                     <li>${sessionScope.memberName} 님의 보유 R POINT</li>
                     <li><span id = "r_PointSum"></span>&nbsp;P</li>
                     <li></li>
                     <li style = "font-weight:300;color : #fff"><p>* 매일 1:00 G 포인트가 일정 비율로 R 포인트로 전환됩니다</p></li>
                  </ul>
               </div>
               <div class="main_link">
                  <ul>
                     <li onclick = "movePage('/m/mypage/rpoint/rpoint_withdrawal.do?memberNo=${model.memberTypeInfo.memberNo}')"><img src="/resources/images/r_cash.png"><span><p>R POINT</p>출금하기</span></li>
                     <li onclick="movePage('/m/mypage/newpay.do')"><img style="top:15px;"src="/resources/images/r_list.png"><span style="left:65px;"><p>R POINT</p>적립내역 조회</span></li>
                  </ul>
               </div>
            </div>
      </div>
   </li>
   <li><a href="#">G 포인트</a>
      <div class="contents">
         <div class="point_detail_info">
            <div class="top_detail g_contents">
                  <ul>
                     <li>${sessionScope.memberName}  보유 G POINT</li>
                     <li><span id = "g_PointSum">${model.myGreenPointSumInfo.greenPointAmountSum}</span> &nbsp;P</li>
                      <li style = "font-weight:300;color : #fff"><p>* 영수증 큐알 코드 스캔시 G 포인트가 실시간 적립됩니다</p></li>
                  </ul>
               </div>
<<<<<<< HEAD
               <div class="main_link g_link" >
=======
               <div class="main_link g_link">
>>>>>>> branch 'master' of https://github.com/topayc/returnpoint_web_v1.git
                  <ul>
                     <li onclick="startQRScan()"><img src="/resources/images/r_qr.png"><span><p>R POINT</p>적립QR 스캔</span></li>
                     <li onclick="movePage('/m/mypage/newpoint.do')"><img style="top:15px;"src="/resources/images/r_list.png"><span style="left:65px;"><p>R POINT</p>적립내역 조회</span></li>
                  </ul>
               </div>
            </div>
      </div>
      </div>
   </li>
</ul>

<%--     <footer>
      <ul style = "font-weight:300">
         <li><small>(주)</small> <b>탑해피월드</b></li>
         <li>서울특별시 구로구 구로동 170-5 우림 이비지센터 806호</li>
         <li>대표자 : 윤동욱&nbsp;&nbsp; <spring:message code="label.biz_number" /> : 754-86-01056</li>
         <li><spring:message code="label.web.tophappyworldCustomerCenterOperationHours" /> : 10시 ~ 12시 30분, 13시 30분 ~ 18시</li>
         <li>
            <span><a href="/m/customer/customerCenter.do"><spring:message code="label.web.companyIntroduction" /></a>&nbsp;</span>&nbsp;
            <span><a href="/m/company/service_member.do"><spring:message code="label.what_return_point" /></a>&nbsp;</span>&nbsp;
            <span><a href="/m/company/m_termsofuse.do"><spring:message code="label.web.termsAndConditions" /></a>&nbsp; </span>&nbsp;
            <span><a href="/m/company/m_privacypolicy.do"><spring:message code="label.web.personalInformationHandlingAndHandlingPolicy" /></a>&nbsp;</span>&nbsp;</li>
      </ul>
   </footer> --%>
   </section>
</div>
<script>
	$(".tab_menu > li > a ").click(function(){
	   $(this).parent().addClass("on").siblings().removeClass("on");
	   return false;
	});</script>
</body>
<!-- body end -->
</html>