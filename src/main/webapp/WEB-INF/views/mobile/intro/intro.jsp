<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
 <meta charset="utf-8">
    <meta http-equiv="Content-type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>서비스안내</title>  
	<link rel="stylesheet" href="/resources/css/swiper.min.css">
	<script type="text/javascript" src="/resources/js/lib/jquery-2.2.0.min.js"></script> 
	<script type="text/javascript" src="/resources/js/lib/m_common.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.0/js/swiper.min.js"></script>
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
	
		$(document).ready(function(){
			$('body').height(height + "px");
			new Swiper('.swiper-container', {
				pagination : {
			        el : '.swiper-pagination',
			        clickable : true,
			    },
	             calculateHeight:true,
	             autoHeight: true
			});
		});
	</script>
</head>

<body>
    <div class="swiper-container" style = "height: 100%">
        <div class="swiper-wrapper">
            <div class="swiper-slide swiper_text">
                <img src="/resources/images/intro/ser1.png">
                <p class = "title">똑똑한 소비 , 100% 포인트 적립</p>
                <div class="text_box">
                    <ul>
                        <li>R 포인트 가맹점 결제후 영수증의</li>
                        <li>QR 코드만 스캔하면 포인트가 100% 적립</li>
                    </ul>
                     <div class = "sub">
              			<span class = "point gpoint" style = "margin-bottom : 5px">G 포인트</span> 결제시 100% 적립되는 포인트</br></br>
              			<span class = "point rpoint">R 포인트</span> G 포인트는 매일 R 포인트로 전환
              		</div>
                </div>
             
            </div>
            <div class="swiper-slide swiper_text">
                <img src="/resources/images/intro/ser2.png">
                <p class = "title">R 포인트 결제</p>
                <div class="text_box">
                    <ul>
                     <li>뚱뚱한 지갑은 이제 그만</li>
                        <li>현금, 카드, 포인트 적립 카드 등</li>
                        <li>여러 카드를 꺼내지 않아도!</li>
                        <li>온라인, 오프라인 가맹점에서 </li>
                        <li>R 포인트로 결제해보세요.</li>
                    </ul>
                </div>
            </div>
            <div class="swiper-slide swiper_text">
                <img src="/resources/images/intro/ser3.png">
                <p class = "title">모바일 상품권</p>
                <div class="text_box">
                    <ul>
                    <li>R 포인트 상품권으로</li>
                        <li>100% 포인트가 적립되고,</li>
                        <li>가맹점에서 결제가 가능합니다.</li>
                    </ul>
                </div>
            </div>
            <div class="swiper-slide swiper_text">
                <img src="/resources/images/intro/ser4.png">
                <p class = "title">가맹점에서 R 포인트 결제</p>
                <div class="text_box" style ="margin-bottom:20px">
                    <ul>
                 <!--       <li>뚱뚱한 지갑은 이제 그만</li>
                       <li>현금, 카드, 포인트 적립 카드 등</li>
                       <li>여러 카드를 꺼내지 않아도!</li> -->
                       <li>온라인, 오프라인 가맹점에서 </li>
                       <li>R 포인트로 결제해보세요</li>
                       <li>R 포인트 가맹점에서 결제시</li>
                       <li>100% 포인트가 적립되고,</li>
                       <li>적립된 포인트로 편리하게 결제가 가능합니다.</li>
                    </ul>
                </div>
                <div class="swiper_text1"><a href="#" onclick = "joinMember()">가입하기</a></div>
                <div class="swiper_text2"><a href="#" onclick = "location.href = '/m/member/newLogin.do'">로그인</a></div>
            </div>
        </div>
        <div class="swiper-pagination"></div>
    </div>
    <input type = "hidden"  id = "recommender"  value = "${model.recommender}"/>
    <script>
    	var recommender = getParams()['recommender'];
    	if (recommender != null && recommender.trim().length != 0){
    		$("#recommender").val(recommender);
    	}
    	
    	function joinMember(){
    		var recommender = $("#recommender").val().trim();
    		var url = "/m/member/newJoinProcess.do?recommender=" + recommender;
    		location.href = url;
    	}
    </script>
</body>

</html>