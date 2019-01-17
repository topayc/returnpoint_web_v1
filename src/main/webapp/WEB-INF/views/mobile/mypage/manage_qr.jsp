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
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="format-detection" content="telephone=no"/>
<!-- css   -->
<!-- font -->
<link rel="stylesheet" href="/resources/css/m_common.css">
<!-- js -->
<script type="text/javascript" src="/resources/js/lib/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/m_common.js"></script>
<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript">
function genQR(qr_cmd){
	var url = "./m_gen_qr_code.do?qr_cmd=" + qr_cmd;
	if (qr_cmd == "10000") {
		alertOpen("확인", "현재 로그인 되어 있는 계정의 QR을 생성합니다", true, true,function(){movePage(url);}, null);
	}else {
		movePage(url);
	}
	return false;
	
/* 	switch(genQRCode){
		case "10000": //추천인 자동 설정 회원 가입 QR 생성
			alertOpen("확인", "현재 로그인 되어 있는 계정의 QR를 생성합니다", true, false,function(){location.href=url;}, null);
			break;
		case "10001": //상품 QR 생성
			alertOpen("확인", "현재 로그인 되어 있는 계정의 QR를 생성합니다", true, false,function(){location.href=url;}, null);
			break;
		case "10002": //선물 이체 QR 생성
			alertOpen("확인", "현재 로그인 되어 있는 계정의 QR를 생성합니다", true, false,function(){location.href=url;}, null);
			break;
	} */
}

$(document).ready(function(){
});
</script>

</script>	
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_mypage">
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4><spring:message code="label.manage_qr_code" /></h4>
	</header> 
	<!-- content begin -->	
		<section>
		<div class="listS02">
			<div class="list_title"><i class="fas fa-qrcode">&nbsp;</i><spring:message code="label.gen_qr_code" /></div>
			<div class="list_li" >
				<a onclick = "genQR('10000')">
					<span class ="item_title"><spring:message code="label.gen_join_qr_code" /></span></br>
					<span class ="item_des"><spring:message code="label.gen_join_qr_code_des" /></span></br>
				</a>
			</div>
			
			<div class="list_li" >
				<a onclick = "genQR('10001')">
					<span class ="item_title"><spring:message code="label.gen_product_qr_code" /></span></br>
					<span class ="item_des"><spring:message code="label.gen_product_qr_code_des" /></br></span>
				</a>
			</div>
			
			<div class="list_li" >
				<a onclick = "genQR('10002')">
					<span class ="item_title"><spring:message code="label.gen_gift_qr_code" /></span></br>
					<span class ="item_des"><spring:message code="label.gen_gift_qr_code_des" /></br></span>
				</a>
			</div>
		</div>
	</section>
	<!-- content end -->
</div>	
</body>
<!-- body end -->
</html>