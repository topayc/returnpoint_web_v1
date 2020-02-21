<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
 <meta charset="utf-8">
    <meta http-equiv="Content-type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <title>서비스안내</title>  
	<link rel="stylesheet" href="/resources/css/m_common.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script type="text/javascript" src="/resources/js/lib/m_common.js"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
	<script>
		var height  = window.screen.height - 90;
	    var width = window.screen.width
	    if (isApp()) {
	    	getDeviceResolution(function(result){
				if (result) {
		 			result = JSON.parse(result);
		 			if (result.result == "100"){
						height = Number(result.deviceHeight ) / window.devicePixelRatio;
					}
				}
			}) 
	 	}  
	</script>
</head>

<body>
	<div class="r_login">
		<div class="r_login_page7 join_slide">
			<div class="top_main">
				<div class="logo_img">
					<img src="/resources/images/logo_img.png">
				</div>
				<div class="rpoint_text">
					<ul>
						<li><b>RPOINT</b></li>
						<li>소비가 저축이 되는 똑똑한 앱</br>100%적립</li>
					</ul>
				</div>
			</div>
			<h1>가입을 축하합니다.</h1>
			<div class="r_home">R POINT 홈으로 가기</div>
		</div>
	</div>
</body>
</html>