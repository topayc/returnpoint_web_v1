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
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/jquery.slick/1.6.0/slick.css"/>

<script type="text/javascript" src="/resources/js/lib/jquery-2.2.0.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/m_common.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/jquery.slick/1.6.0/slick.min.js"></script>

<script type="text/javascript">
  if (isApp()) {
    checkVersion();
  }
  
  $(function () {
		'use strict';
		var $swipeTabsContainer = $('.swipe-tabs'), 
			$swipeTabs = $('.swipe-tab'), 
			$swipeTabsContentContainer = $('.swipe-tabs-container'), 
			currentIndex = 0, 
			activeTabClassName = 'active-tab';
		$swipeTabsContainer.on('init', function(event, slick) {
			$swipeTabsContentContainer.removeClass('invisible');
			$swipeTabsContainer.removeClass('invisible');

			currentIndex = slick.getCurrent();
			$swipeTabs.removeClass(activeTabClassName);
			$('.swipe-tab[data-slick-index=' + currentIndex + ']').addClass(
					activeTabClassName);
		});

		$swipeTabsContainer.slick({
			//slidesToShow: 3.25,
			slidesToShow : 5,
			slidesToScroll : 1,
			arrows : false,
			infinite : false,
			swipeToSlide : true,
			touchThreshold : 10
		});

		$swipeTabsContentContainer.slick({
			asNavFor : $swipeTabsContainer,
			slidesToShow : 1,
			slidesToScroll : 1,
			arrows : false,
			infinite : false,
			swipeToSlide : true,
			draggable : false,
			touchThreshold : 10
		});

		$swipeTabs.on('click', function(event) {
			// gets index of clicked tab
			currentIndex = $(this).data('slick-index');
			$swipeTabs.removeClass(activeTabClassName);
			$('.swipe-tab[data-slick-index=' + currentIndex + ']').addClass(
					activeTabClassName);
			$swipeTabsContainer.slick('slickGoTo', currentIndex);
			$swipeTabsContentContainer.slick('slickGoTo', currentIndex);
		});

		//initializes slick navigation tabs swipe handler
		$swipeTabsContentContainer.on('swipe',
				function(event, slick, direction) {
					currentIndex = $(this).slick('slickCurrentSlide');
					$swipeTabs.removeClass(activeTabClassName);
					$('.swipe-tab[data-slick-index=' + currentIndex + ']')
							.addClass(activeTabClassName);
				});
	});
</script>
</head>
<body class="index">
   <!-- nav -->
   <jsp:include page="../common/topper.jsp" />
   <!-- nav -->
   <a href="/m/main/index.do"><h4><spring:message code="label.n_returnp" /></h4></a>
   </header>
   <!-- main begin -->
   <section >
	   <div class = "affiliate_category">
		   <div class="sub-header ">
			  <div class="swipe-tabs">
			    <div class="swipe-tab">의류</div>
			    <div class="swipe-tab">음식</div>
			    <div class="swipe-tab">유통</div>
			    <div class="swipe-tab">건설</div>
			    <div class="swipe-tab">배달</div>
			    
			     <div class="swipe-tab">유흥</div>
			    <div class="swipe-tab">노래방</div>
			    <div class="swipe-tab">오락</div>
			     <div class="swipe-tab">마트</div>
			    <div class="swipe-tab">편의점</div>
			  </div>
			</div>
			<div class="affiliate_tab_main-container"   >
			  <div class="swipe-tabs-container " >
			    <div class="swipe-tab-content">의류 컨텐트 </div>
			    <div class="swipe-tab-content">음식 컨텐트</div>
			    <div class="swipe-tab-content">유통 컨텐트</div>
			    <div class="swipe-tab-content">건설 컨텐트</div>
			    <div class="swipe-tab-content">배달 컨텐트</div>
			    
			    <div class="swipe-tab-content">유흥 컨텐트</div>
			    <div class="swipe-tab-content">노래방 컨텐트</div>
			    <div class="swipe-tab-content">오락 컨텐트</div>
			    <div class="swipe-tab-content">마트 컨텐트</div>
			    <div class="swipe-tab-content">편의점 컨텐트</div>
			  </div>
			</div>
   		</div>
   </section>
</div>
</body>
</html>