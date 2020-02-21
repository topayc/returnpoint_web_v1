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
   <div class="r_join_ok">
      <div class="r_login_page2">
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
         <div class="input_box">
            <input type="text" name="전화번호" placeholder="전화번호"> <input
               type="text" name="비밀번호" placeholder="비밀번호">
         </div>
         <button>로그인</button>
         <input type="checkbox" id="cb"><label for="cb">아이디 저장</label>
         <div class="sign_text">
            <ul>
               <li>회원가입</li>
               <li>아이디 비밀번호 찾기</li>
               <li>추천인QR로 가입하기</li>
            </ul>
         </div>
         <div class="facebook_btn">
            <img src="/resources/images/facebook_logo.png">페이스북으로 회원가입
         </div>
      </div>
   </div>
</body>
</html>