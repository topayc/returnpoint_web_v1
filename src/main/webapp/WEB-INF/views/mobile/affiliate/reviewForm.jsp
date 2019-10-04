<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="com.returnp_web.utils.SessionManager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="f" uri="/WEB-INF/tld/f.tld" %>
<!DOCTYPE html>
<html lang="en"> 
<head> 
<title>ReturnP</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="format-detection" content="telephone=no"/>
<!-- css   -->
<!-- font -->
<link rel="stylesheet" href="/resources/css/m_common.css">
<link rel="stylesheet" href="/resources/css/affiliate_detail.css">
<!-- js -->
<script type="text/javascript" src="/resources/js/lib/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/bootstrap.min.js"></script>
<link rel="stylesheet" href="/resources/web_css/common.css">
<script type="text/javascript" src="/resources/js/lib/m_common.js"></script>
<style >
nav { padding-top : 0px}
h4, .h4, h5, .h5, h6, .h6 {
    margin-top: 0px;
    margin-bottom: 10px;
}
* {color : #000;font-weight: 400}
</style>
</head>
<!-- header end -->
<!-- body begin -->
<body class="affiliate_search_container" style="padding-top: 0px;">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4>리뷰 작성</h4>
	</header> 
	<section>
	<div>
			<div class="review_name">
				<ul>
					<li><img src="/resources/images/profile_img.png"></li>
					<li>차미라</li>
				</ul>
			</div>
			<div class="form-group  review_inquire">
                <textarea class="form-control" rows="12" placeholder = "리뷰 내용을 입력해주세요"></textarea>
      </div>
      <div class="review_file">
	      <a href="#"><div>첨부된 파일<img src="/resources/images/trash.png"></div></a>
	      <a href="#"><div>+첨부파일 추가<img src="/resources/images/clip.png"></div></a>
	    </div>
	    <div class="review_warning">
	    * 비속어는 절대 금지합니다.
	    </div>

	</div>
	</section>
	<a style = "bottom: 0;border-radius: 0; background-color: #391dab; width: 100%; border: 1px solid #391dab; color: #fff;padding: 19px;z-index: 1;" class="btn btn-submit" href="">
		<spring:message code="label.ok" /></a>
</body>
<!-- body end -->
</html>