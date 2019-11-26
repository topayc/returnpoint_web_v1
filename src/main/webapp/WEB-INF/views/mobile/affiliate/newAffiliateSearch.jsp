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
<script type="text/javascript" src="/resources/js/lib/handlebars-v4.4.3.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/jquery.slick/1.6.0/slick.min.js"></script>
<script id="entry-template" type="text/x-handlebars-template">
	{{#affiliates}} 
	<li onclick = "movePage( '/m/affiliate/affiliateDetail.do?affiliateNo={{affiliateNo}}')" >
		<div class="list_img"><img src="/resources/images/list_img.png"></div>
		<div class="list_text">
			<p><span class="list_text_box">{{category2Name}}</span>&nbsp;<span class="list_text_title">{{affiliateName}}</span></p>
			<p>{{affiliatePhone}}</p>
			<p>{{affiliateAddress}}</p>
			<p>
		</div>
	</li>
	{{/affiliates}} 
</script>

<script id="entry-template-2-copy" type="text/x-handlebars-template">
	{{#affiliates}} 
	<li onclick = "movePage( '/m/affiliate/affiliateDetail.do?affiliateNo={{affiliateNo}}')" >
		<div class="list_img"><img src="/resources/images/list_img.png" width = "75" height = "75"></div>
		<div class="list_text">
			<p><span class="list_text_box">{{category2Name}}</span>&nbsp;<span class="list_text_title">{{affiliateName}}</span></p>
			<p>{{affiliatePhone}}</p>
			<p>{{affiliateAddress}}</p>
			<p>
			<span> <img src="/resources/images/guest.png" style = "display: inline"></span>&nbsp;<span>73명방문</span>&nbsp;&nbsp;
			<span><img src="/resources/images/location.png" style = "display: inline"></span>&nbsp;<span>121km</span></p>
		</div>
	</li>
	{{/affiliates}} 
</script>

<script type="text/javascript">
/*   if (isApp()) {
    checkVersion();
  }
   */
   var source,template;
   $(function () {
	 /* 스와이프 탭 초기화	 */
	  'use strict';
		var $swipeTabsContainer = $('.swipe-tabs'), 
			$swipeTabs = $('.swipe-tab'), 
			$swipeTabsContentContainer = $('.swipe-tabs-container'), 
			currentIndex = 0, 
			activeTabClassName = 'active-tab';
		var curCategory = 0;
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
			//$("ul[data-cate-list='"+$(this).data("tab-cate")+"']").empty();
			currentIndex = $(this).data('slick-index');
			$swipeTabs.removeClass(activeTabClassName);
			$('.swipe-tab[data-slick-index=' + currentIndex + ']').addClass( activeTabClassName);
			$swipeTabsContainer.slick('slickGoTo', currentIndex);
			$swipeTabsContentContainer.slick('slickGoTo', currentIndex);
			getAffiliatesByCate($(this).data("tab-cate"));
		});

		//initializes slick navigation tabs swipe handler
		$swipeTabsContentContainer.on('swipe',
				function(event, slick, direction) {
					currentIndex = $(this).slick('slickCurrentSlide');
					$swipeTabs.removeClass(activeTabClassName);
					$('.swipe-tab[data-slick-index=' + currentIndex + ']') .addClass(activeTabClassName);
					$('.swipe-tab[data-slick-index=' + currentIndex + ']').click();
				});

		 source = $("#entry-template").html(); 
		 template = Handlebars.compile(source); 
		 getAffiliatesByCate(18);
	});
   
   var curCategory1 = 18;
   
   function getAffiliatesByCate(cate){
	   var data = {category1No : cate};	
		$.getJSON("/m/affiliate/findAffiliateByCate.do", data, function (result) {
			if (result.length > 0) {
				curCategory1 = result[0].category1No;
				addAffiliateListItem(result)
			}else {
				
			}
        });
   }
   function addAffiliateListItem(list){
	   console.log(list);
	   var data = {affiliates : list};
	   if (!template ) {
		  source = $("#entry-template").html(); 
	      template = Handlebars.compile(source); 
	   }
	   var html = template(data);
	   var fHtml = $("<ul data-cate-list='"+ curCategory1 +"'></ul>");
	   fHtml.append(html)
	   $("ul[data-cate-list='"+curCategory1+"']").replaceWith(fHtml)
   }
</script>
</head>
<body class="index">
   <!-- nav -->
   <jsp:include page="../common/topper.jsp" />
   <!-- nav -->
   <a href="/m/main/index.do"><h4><spring:message code="label.n_returnp" /></h4></a>
   </header>
   <!-- main begin -->
   <c:choose>
   <c:when test="${fn:length(model.affiliateCategories) > 0}">
   <section >
	   <div class = "affiliate_category">
			<div class="sub-header ">
			  <div class="swipe-tabs">
			    <c:forEach var="category" items="${model.affiliateCategories}">
			    	<div class="swipe-tab"  data-tab-cate = "${category.categoryNo}">${category.categoryName}</div>
			    </c:forEach>
			  </div>
			</div>
			<div class="affiliate_tab_main-container"   >
			  <div class="swipe-tabs-container " >
			   	    <c:forEach var="category" items="${model.affiliateCategories}">
			    	<div class="swipe-tab-content" data-tab-content-cate = "${category.categoryNo}">
			    		<div class="r_list">
							<ul data-cate-list = "${category.categoryNo}">
							</ul>
						</div>
			     	</div>
			    	</c:forEach>
			  </div>
			</div>
   		</div>
   </section>
   </c:when>
	<c:otherwise>
		<section class="qr_nodata"><!-- 0824 -->
			<div> 
				<i class="fas fa-exclamation-triangle"></i>등록된 카테고리가 없습니다.
			</div>
	</section>
	</c:otherwise>
	</c:choose>
</div>
</body>
</html>