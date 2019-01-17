/* 안드로이드 브릿지 관련 코드 */
var bridge = (function () {
	var callbackFunc;
	
	function init(){
		callbackFunc = null;
	}
	
	/* 큐알 코드 스캐너 시작*/
	function startQRCodeScan(func){
		callbackFunc = func;
		window.returnpAndroidBridge.scanQRCode();
	}

	/* 디바이스 전화번호 가져오기*/
	function getPhoneNumber(func) {
		callbackFunc = func;
		window.returnpAndroidBridge.getPhoneNumber();
	}

	/* 디바이스 화면 크기 가져오기*/
	function getDeviceSize(func) {
		callbackFunc = func;
		window.returnpAndroidBridge.getDeviceSize();
	}

	/* 디바이스 세션 설정*/
	function setDeviceSession(userName, userEmail , userAuthToken, func) {
		callbackFunc = func;
		var session = [userName, userEmail, userAuthToken].join(":");
		window.returnpAndroidBridge.setDeviceSession(session);
	}
	
	/* 디바이스 세션 모두 삭제*/
	function clearDeviceSession(func) {
		callbackFunc = func;
		window.returnpAndroidBridge.clearUserSession();
	}
	
	/* 해당 키의 세션 밸류 가져오기*/
	function getSessionValue(key, func){
		callbackFunc = func;
		window.returnpAndroidBridge.getSessionValue(key);
	}
	
	/* 해당 키의 세션 밸류 가져오기*/
	function loadUrl(url, func){
		callbackFunc = func;
		window.returnpAndroidBridge.loadUrl(url);
	}
	
	/*  안드로이드 Bridge 호출후 앱에서 호출되는 콜백*/
	function jsBridgeCallback(result) {
		if (callbackFunc) callbackFunc(result)
	}
	
	function toast(messge){
		window.returnpAndroidBridge.toast(messge);
	}
	
	function getSesssionAndDeviceInfo(func){
		callbackFunc = func;
		window.returnpAndroidBridge.getSesssionAndDeviceInfo();
	}
	/*
	 * 안드로이드, IOS 여부에 따라 모듈 함수 세팅
	 * ( 이부분은 차후 진행, 일단 안드로이드만 제공)
	 * */
	var exportFunc = {
		startQRCodeScan : startQRCodeScan,
		getPhoneNumber : getPhoneNumber,
		getDeviceSize : getDeviceSize,
		jsBridgeCallback : jsBridgeCallback,
		setDeviceSession : setDeviceSession,
		clearDeviceSession : clearDeviceSession,
		getSessionValue : getSessionValue,
		getSesssionAndDeviceInfo : getSesssionAndDeviceInfo,
		loadUrl : loadUrl,
		toast : toast
	}
	return exportFunc;
})();

function unsupportedService(){
	bridge.toast("아직 지원되지 않는 기능입니다. 곧 추가될 예정입니다.");
}

function startPointBack(){
	$("#progress_loading").show();
	var param = {};
	$('.returnp_qr').each(function(){
		param[$(this).attr("id")]  = $(this).val().trim().replace(",","");
	});
	bridge.getSesssionAndDeviceInfo(function(info){
		info = JSON.parse(info);
		param["memberEmail"] = info.user_email;
		param["memberName"] = info.user_name;
		param["phoneNumber"] = info.phoneNumber;
		param["phoneNumberCountry"]  = info.phoneNumberCountry;
		param["key"]  = "AIzaSyB-bv2uR929DOUO8vqMTkjLI_E6QCDofb8";
		for (key in param){
			if (param.hasOwnProperty(key)) {
				param[key] = encodeURIComponent(param[key]);
			}
		}
		
		/*실제 운영 포인트 백 서버 */
		var  pointBackUrl = window.location.protocol + "//" + window.location.host + "/qr/qrAcc.do";
		//ert(JSON.stringify(param));
		$.ajax({
           	type: "POST",
               url: pointBackUrl,
               data: param,
               success: function (result) {
            	   if (result && typeof result !="undefined") {
            		  $("#progress_loading").hide();
            		   /* result obj 설명
               		  * resultCode : 성공 실패 값(100 이 아니면 실패)
               		  * message : 메시지
               		  * url : 이동할 URL 
               		  */ 
            		 var alertText = "";
            		 if (result.resultCode  == "100") {
            			 alertText = result.message
            		 }else {
            			 alertText = result.resultCode + " : " + result.message
            		 }
            		 
            		 alertOpen("확인", 
            			alertText, 
            			true, 
            			false, 
            			function(){
            			 if (result.resultCode == "100") {
            				 document.location.href = window.location.protocol + "//" + window.location.host + "/mypage/newpoint.do";
            			 }
            		 	}, 
            			null);
               	 }else{
               		alertOpen("알림", "네트워트 장애 발생. 다시 시도해주세요.", true, false, null, null);
               	 }
               },
               error : function(request, status, error){
            	   $("#progress_loading").hide();
            	   alertOpen("알림 ", "네트워트 장애 발생. 다시 시도해주세요", true, false, null, null);
               },
               dataType: 'json'
           });
		//var qrInfoUrl = window.location.protocol + "//pb.retunp.com + "/qr/qrinfo.do?data=" + url;
	});	
}

function startQRScan(){
	if (appInfo.access != "APP")  {
		alertOpen("알립", "해당 기능은 APP에서 실행해야 합니다", true, false, null, null);
		return;
	}
	bridge.startQRCodeScan(function(url){
		if (!url || url == 'null' || url == '') {
			return;
		}else {
		 
			if (checkUrlForm(url)) {
				/* 구매후 포인트 적립 요청 QR */
				if (url.indexOf("PB.RETURNP.COM") > 0) {
					/*QR code Base64 인코딩 전송*/
					var qrInfoUrl = window.location.protocol + "//" + window.location.host + "/qr/qrinfo.do?qr_data=" + btoa(unescape(encodeURIComponent(url)));
					//alert(qrInfoUrl)
					webview_redirect(qrInfoUrl);
					return;
				}else if (url.indexOf("www.returnp.com/member/join.do") > 0) {
					webview_redirect(url);
					return;
				}else {
					//alert("유효하지 않는 QR Code 입니다");
					alertOpen("확인", "유효하지 않는 QR Code 입니다.", true, false, null, null);
				}
			}else {
				bridge.getPhoneNumber(function(phone){
					alert(phone);
					phone = JSON.parse(phone);
					var phoneNumber = phone.phoneNumber;
					var phoneNumberCountry = phone.phoneNumberCountry;
					var qrInfoUrl = window.location.protocol + "//" + window.location.host + "/qr/qrinfo.do?data=" + url;
					webview_redirect(qrInfoUrl);
				});	
			}
		}
	});
}

function webview_redirect(uri) {
    if(navigator.userAgent.match(/Android/i)){ 
        document.location=uri;
    }else if(navigator.userAgent.match(/iPhone|iPod/i)){
        window.location.replace(uri);
    }else if(navigator.userAgent.match(/iPad/i)){
        window.location.replace(uri);
    }else{
        window.location.href=uri;
    }
}