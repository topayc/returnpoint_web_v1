<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="com.returnp_web.utils.SessionManager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html lang="en"> 
<head>
<title>ReturnP</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge"><!-- 0710 ie가 edge로 맞춰지는 메타 추가 -->
<meta name="format-detection" content="telephone=no"/><!-- 0710 edge상에서 전화번호 자동인식으로 인한 메타 추가 -->
<!-- css   -->
<!-- font -->
<link rel="stylesheet" href="/resources/css/m_common.css">
<!-- js -->
<script type="text/javascript" src="/resources/js/lib/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/jquery.cookie.js"></script>
<script type="text/javascript" src="/resources/js/lib/m_member.js"></script>
<script type="text/javascript" src="/resources/js/lib/m_common.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	if (isApp()) {
		var p = getParams();
		var mbrE = (p["mbrE"]);
		var userAT = (p["userAT"]);
		
		if (typeof mbrE != "undefined" && typeof userAT != "undefined") {
	   	   var session = {userName :mbrE , userEmail : mbrE, userAuthToken : userAT }
	       bridge.setDeviceSession(JSON.stringify(session), function(result) {
	    	   result = JSON.parse(result);
	    	   if (result.result == "100") {
	   			 bridge.setPushToken();
	        	 location.href = "/m/main/index.do";
	         }else {
	        	 alertOpen("알림", "앱 오류 발생", true, false, null, null);
	         }
	       });
		}
   }else {
	   location.href = "/m/main/index.do"
   }
});
</script>
</body>
</html>