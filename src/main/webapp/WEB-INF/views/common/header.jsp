<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="f" uri="/WEB-INF/tld/f.tld" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head> 
<title>RETURNP</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta property="og:url" content="https://www.returnp.com">
<meta property="og:title" content="ReturnP">
<meta property="og:type" content="website">
<meta property="og:image" content="https://www.returnp.com/resources/images/sns_url_link_img.png">
<link rel="stylesheet" href="/resources/web_css/common.css">
<script type="text/javascript" src="/resources/js/lib/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/jquery.cookie.js"></script>
<script type="text/javascript" src="/resources/js/lib/common.js"></script>
<script type="text/javascript" src="/resources/js/lib/ScrollTrigger.min.js"></script><!-- 메인 스크롤 이벤트 -->
<script type="text/javascript">
$(document).ready(function(){
	//locale lang 설정
	var pageContextlocale = '${pageContext.response.locale}';
	pageContextlocale = pageContextlocale ? pageContextlocale : "ko";  
	if(pageContextlocale.indexOf("ko") > 0){
		pageContextlocale = "ko";
	}
	$("#sel1").val(pageContextlocale);
	var url = window.location.href;
	var result = url.search("index.do"); //찾는 값이 없으면 -1 리턴
});
</script>
</head>