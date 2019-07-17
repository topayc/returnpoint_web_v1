function setCookie(name, value, expiredays) {
	var today = new Date();
	    today.setDate(today.getDate() + expiredays);
	    document.cookie = name + '=' + escape(value) + '; path=/; expires=' + today.toGMTString() + ';'
} 

function getCookie(name) {
    var cName = name + "="; 
    var x = 0; 
    while ( x <= document.cookie.length ) {
        var y = (x+cName.length); 
        if ( document.cookie.substring( x, y ) == cName ) 
        { 
            if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) 
                endOfCookie = document.cookie.length;
            return unescape( document.cookie.substring( y, endOfCookie ) ); 
        } 
        x = document.cookie.indexOf( " ", x ) + 1; 
        if ( x == 0 ) 
            break; 
    } 
    return ""; 
} 

function closePopupNotToday(elem){	             
	setCookie('notToday','Y', 1);
	$("#" + elem).hide('fade');
} 

function numberWithComma(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function movePage(url){
	window.location.href = url;
}

function changeLang(value){
	location.href="/main/index.do?lang=" + value + "&returnUrl="+window.location.href;  
}

function changeMobileLang(value){
	location.href="/m/main/index.do?lang=" + value
}

function changeLocalLang(value){
	location.href="/main/index.do?lang=" + value + "&returnUrl="+window.location.href;  
}

function openNav() {
document.getElementById("myNavbar").style.right = "0";
document.getElementById("myNavbarbg").style.display = "block";
}

function closeNav() {
document.getElementById("myNavbar").style.right = "-100%";
document.getElementById("myNavbarbg").style.display = "none";
}

function checkUrlForm(strUrl) {
    var expUrl = /^http[s]?\:\/\//i;
    return expUrl.test(strUrl);
}

function closeAlert(){
	$('#alert_wrap').show();
}
function alertOpen(title, message, okbutt, obcancle, f1, f2){
	
	var alertMessageHtml = "";
	var alertTitleHtml = "";
	document.getElementById('alertView').style.display='flex';	
	
	alertMessageHtml += "<p>"+message+"</p>";
	$('#alertMassage').html(alertMessageHtml);
	
	alertTitleHtml += "<strong><i class='fas fa-info-circle'></i>"+title+"</strong>";
	$('#alertTitle').html(alertTitleHtml);
	
	$('#alert_ok').unbind("click")
	$('#alert_cancel').unbind("click")
	$('#alert_ok').hide();
	$('#alert_cancel').hide();
	
	if (okbutt){ //ok(확인)버튼이 true이면
		$('#alert_ok').show();
		if ((typeof f1 == "function")){
			$('#alert_ok').bind("click", f1); //ok 버튼을 누르면 f1을 바인드
		}
	}else{
		$('#alert_ok').hide();
	}
	
	if (obcancle){ //ok(취소)버튼이 true이면
		$('#alert_cancel').show();
		if ((typeof f2 == "function")){
			$('#alert_ok').bind("click", f2);
		};
	}else{
		$('#alert_cancel').hide();
	}
}

function alertClose(elem){
	if (elem) {
		$('.' + elem ).hide();
	}else {
		document.getElementById('alertView').style.display='none';
	}
} 

function getParams() {
	// 파라미터가 담길 배열
	var param = new Array();
	// 현재 페이지의 url
	var url = decodeURIComponent(location.href);
	// url이 encodeURIComponent 로 인코딩 되었을때는 다시 디코딩 해준다.
	url = decodeURIComponent(url);
	var params;
	// url에서 '?' 문자 이후의 파라미터 문자열까지 자르기
	params = url.substring( url.indexOf('?')+1, url.length );
	// 파라미터 구분자("&") 로 분리
	params = params.split("&");

	// params 배열을 다시 "=" 구분자로 분리하여 param 배열에 key = value 로 담는다.
	var size = params.length;
	var key, value;
	for(var i=0 ; i < size ; i++){
 		key = params[i].split("=")[0];
		value = params[i].split("=")[1];
		param[key] = value;
	}
	return param;
}

var access = (function () {
	var filter = "win16|win32|win64|mac";
	if ( navigator.platform ) {
		if (filter.indexOf( navigator.platform.toLowerCase()) < 0 ) {
			if (window.navigator.userAgent.indexOf("APP_RETURNP_Android") > 0) {
				return  "APP";
			}else {
				return  "MOBILE";
			}
		}else {
			return  "PC";
		}
	}else {
		return  "UNKNOWN";
	}
})();


var host = window.location.protocol + "//" + window.location.host;
//var host = "http://124.49.211.77:9090";
var appInfo = {
	//appSchem : "intent://returnp?seq=67#Intent;scheme=rp;action=android.intent.action.VIEW;category=android.intent.category.BROWSABLE;package=com.returnp.app;end",
	appSchem : "rp://returnp",
	appPackage : "com.tophappyworld.returnpapp",
	access : access,
	deviceType : null,
	share : {
		title : 'R 포인트',
		description : '쓴 만큼 100% 돌려주는 R 포인트 , 언제 어디서나 쉽고 간편하게',
		imageUrl: host + '/resources/images/sns_url_link_img.png',
		link : {
			webUrl : {
				home : host + "/m/main/index.do",
				des :  host + "/m/company/service_member.do",
				join : host + "/m/member/join.do"
			},
			mobileUrl : {
				home : host + "/m/main/index.do",
				des :  host + "/m/company/service_member.do",
				join : host + "/m/member/join.do"
			}
		}
	},
	key : {
		kakao : "eb27d450ded4748d2b46aed0476fc69b"
			
	},
	permission : {
		CAMERA : "CAMERA",
		READ_PHONE_STATE : "READ_PHONE_STATE",
		READ_CONTACTS : "READ_CONTACTS",
		ACCESS_FINE_LOCATION : "ACCESS_FINE_LOCATION",
		SEND_SMS : "SEND_SMS"
		
	},
	
	permission_group : {
		CAMERA : "CAMERA",
		PHONE : "PHONE",
		CONTACTS : "CONTACTS",
		LOCATION : "LOCATION",
		SMS : "SMS"
		
	},
	permissionResult : {
		PERMITTEED : "0",
		NOT_PERMITTEED: "-1"
	}
};

function isApp(){
	if (appInfo && appInfo['access'] && appInfo['access'] == "APP"){
		return true;
	}else {
		return false;
	}
}

function isMobile(){
	if (appInfo['access'] == "MOBILE"){
		return true;
	}else {
		return false;
	}
}

function isPc(){
	if (appInfo['access'] == "PC"){
		return true;
	}else {
		return false;
	}
}

function getDeviceType(){
}

function getDeviceResolution(func){
	 if (window.returnpAndroidBridge.getDeviceResolution) {
		 bridge.getDeviceResolution(func);		 
	 }else {
		 func({result : 200});
	 }
}

function executeApp() {
	document.location.href = appInfo.appSchem;
}

function executeAppOrGoStore() {
	var openAt = new Date;
	 setTimeout(
	 	function() {
	 		if (new Date - openAt < 1000)
	 			alertOpen(
	 				"알립", 
	 				"해당 기능을 위해서는 앱을 설치해야 합니다. </br>확인을 누르시면 앱 설치 페이지로 이동합니다", 
	 				true, 
	 				true, 
	 				function(){
	 					goPlayStore();
	 				}, 
	 				null);
	 			
	 	}, 500);
	 executeApp();
}

function goPlayStore() {
	// id 뒤에 앱 패키지명
	storeURL = "https://play.google.com/store/apps/details?id="+appInfo.appPackage;
	location.replace(storeURL);
}

function goUpdatePlayStore() {
	// id 뒤에 앱 패키지명
	storeURL = "market://details?id=" + appInfo.appPackage;
	location.replace(storeURL);
}

function goAppStore() {
	// id 뒤에 앱 패키지명
	storeURL = 'http://itunes.apple.com/<country>/app/<app–name>/id<app-ID>?mt=8';
	location.replace(storeURL);
}


/*
 * 
 * 
 * */
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
	function setDeviceSession(session, func) {
		callbackFunc = func;
		//var session = [userName, userEmail, userAuthToken].join(":");
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
	
	/* 웹 뷰 로드 */
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
	
	function checkPermission(permission, func){
		callbackFunc = func;
		window.returnpAndroidBridge.checkPermission(permission);
	}

	function requestPermission(pemission, func){
		callbackFunc = func;
		window.returnpAndroidBridge.requestPermission(pemission);
	}
	
	function getDeviceContacts(func){
		callbackFunc = func;
		window.returnpAndroidBridge.getDeviceContacts();
	}
	
	function getMyLocation(func){
		callbackFunc = func;
		window.returnpAndroidBridge.getMyLocation();
	}

	function sendSMS(smsData, func){
		callbackFunc = func;
		window.returnpAndroidBridge.sendSMS(smsData);
	}
	
	function afterJoinComplete(func){
		callbackFunc = func;
		window.returnpAndroidBridge.afterJoinComplete();
	}
	
	function setSessionValue(key, value, func){
		callbackFunc = func;
		window.returnpAndroidBridge.setData(key,value);
	}

	function setPushToken(){
		window.returnpAndroidBridge.setPushToken();
	}
	
	function getData(key, defaultValue,  func){
		callbackFunc = func;
		window.returnpAndroidBridge.getData(key, defaultValue);
	}

	
	function getDeviceResolution(func){
		callbackFunc = func;
		window.returnpAndroidBridge.getDeviceResolution();
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
		setSessionValue :  setSessionValue,
		getSesssionAndDeviceInfo : getSesssionAndDeviceInfo,
		loadUrl : loadUrl,
		toast : toast,
		checkPermission : checkPermission,
		requestPermission : requestPermission,
		getDeviceContacts : getDeviceContacts,
		getMyLocation : getMyLocation,
		sendSMS : sendSMS,
		afterJoinComplete : afterJoinComplete,
		setPushToken : setPushToken,
		getDeviceResolution : getDeviceResolution
	}
	return exportFunc;
})();

function unsupportedService(){
	alertOpen("알림", "해당 기능은 곧 지원 예정입니다", true, false, null, null);
	return;
	//bridge.toast("아직 지원되지 않는 기능입니다. 곧 추가될 예정입니다.");
}

/*상품권 QR 요청 처리*/
function startGiftCardProcess(cmd, giftCardStatus, accableStatus, payableStatus){
	if (giftCardStatus == "5" ) {
		alertOpen( "알림", "해당 상품권은 사용기간이 만료된 상품권입니다", true, null, null,null);
		return;
	}
	
	if (cmd == "900") {
		if (giftCardStatus == "2" ||  giftCardStatus == "3") {
			alertOpen( "알림", "해당 상품권은 현재 적립이 중지된 상품권입니다", true, null, null,null);
			return;
		}
		
		if (accableStatus == "N") {
			alertOpen( "알림", "해당 상품권은 이미 적립 처리가 완료된 상품권입니다", true, null, null,null);
			return;
		}
	}
	
	if (cmd == "901") {
		if (giftCardStatus == "2" ||  giftCardStatus == "4") {
			alertOpen( "알림", "해당 상품권은 현재 결제가 중지된 상품권입니다", true, null, null, null);
			return;
		}
		
		if (payableStatus == "N") {
			alertOpen( "알림", "해당 상품권은 이미 결제 처리가 완료된 상품권입니다", true, null, null,null);
			return;
		}
	}
	//var qrData = $("#giftCardQrData").val().trim();
	var pinNumber= $("#pinNumber").val().trim();
	var qrParams = {
		qr_cmd :  cmd,
		pinNumber : pinNumber.trim()
	}
	bridge.getSesssionAndDeviceInfo(function(data){
		data = JSON.parse(data);
		if (result.result != "100")  {
			alertOpen("알림", "앱 오류 발생", true, false, null, null);
			return;
		}
		
		qrParams["memberEmail"] = data.user_email;
		qrParams["memberName"] = data.user_name;
		qrParams["memberPhone"] = data.phoneNumber;
		qrParams["memberPhoneCountry"]  = data.phoneNumberCountry;
		qrParams["key"]  = "AIzaSyB-bv2uR929DOUO8vqMTkjLI_E6QCDofb8";
		var sendQrData = encodeURIComponent(btoa(JSON.stringify(qrParams)));
	
		var  giftCardQrControlUrl = window.location.protocol + "//" + window.location.host + "/m/mypage/m_gift_card_command.do";
		$.ajax({
           	type: "POST",
               url: giftCardQrControlUrl,
               data: {qrData : sendQrData },
               success: function (result) {
            	   $("#progress_loading").hide();
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
            				 document.location.href = window.location.protocol + "//" + window.location.host + "/m/mypage/newpoint.do";
            			 }
            		 	}, 
            			null);
               	 }else{
               		 alertOpen("알림", "네트워트 장애 발생1. 다시 시도해주세요.", true, false, null, null);
               	 }
               },
               error : function(request, status, error){
            	   $("#progress_loading").hide();
            	   alertOpen("알림 ", "네트워트 장애 발생2  다시 시도해주세요", true, false, null, null);
               },
               dataType: 'json'
           });
		//var qrInfoUrl = window.location.protocol + "//pb.retunp.com + "/qr/qrinfo.do?data=" + url;
	});	
}

/*서버로 푸시 토큰 전송*/ 
function sendPushTokenToServer(data){
	data = JSON.parse(data);
	if (data.result != "100" ) {
		alertOpen("알림", "앱 오류 발생", true, false, null, null);
		return;
	}
	
	var  url = window.location.protocol + "//" + window.location.host + "/m/device/registPushToken.do";
	$.ajax({
       	type: "POST",
        url: url,
        data: data,
        success: function (result) {
        	if (result.resultCode  == "100") {
        		//$.messager.alert('알림', result.message);
        	}else {
        		//$.messager.alert('알림', result.message);
        	}
        },
        error : function(request, status, error){
        	alertOpen("알림 ", "네트워트 장애 발생!  다시 시도해주세요", true, false, null, null);
        },
        dataType: 'json'
       });

} 
function startPointBack(){
	//$("#progress_loading").show();
	var param = {};
	$('.returnp_qr').each(function(){
		param[$(this).attr("id")]  = $(this).val().trim().replace(",","");
	});
	function execPointback(){
		bridge.getSesssionAndDeviceInfo(function(data){
			data = JSON.parse(data);
			
			if (data.result != "100")  {
				alertOpen("알림", "앱 오류 발생", true, false, null, null);
				return;
			}
			
			param["memberEmail"] = data.user_email;
			param["memberName"] = data.user_name;
			param["phoneNumber"] = data.phoneNumber;
			param["phoneNumberCountry"]  = data.phoneNumberCountry;
			param["key"]  = "AIzaSyB-bv2uR929DOUO8vqMTkjLI_E6QCDofb8";
			//console.log(param["phoneNumber"] + "</br>" + param["phoneNumberCountry"]);
			for (key in param){
				if (param.hasOwnProperty(key)) {
					param[key] = encodeURIComponent(param[key]);
				}
			}
			
			var  pointBackUrl;

			/* KICC 외의 일반 QR에 의한 적립 요청 주소 */
			if (param["paymentRouterType"] && param["paymentRouterType"].trim().length != 0 &&  param["paymentRouterType"] == "VAN"){
				if (param["paymentRouterName"] && param["paymentRouterName"].trim().length != 0 && param["paymentRouterName"] == "KFTC" ){
					pointBackUrl = window.location.protocol + "//" + window.location.host + "/m/qr/commonQrAcc.do";
				}
				/* KICC 전용 QR 에 의한 적립 요청 주소 */
				else if (param["paymentRouterName"] && param["paymentRouterName"].trim().length != 0 && param["paymentRouterName"] == "KICC" ){
					pointBackUrl = window.location.protocol + "//" + window.location.host + "/m/qr/kiccQrAcc.do";
				} 
				else {
					 alertOpen("알림", "잘못된 QR 정보입니다. <br/>관리자에게 문의해주세요", true, false, null, null);
				}
				
			}
			
			$.ajax({
	           	type: "POST",
	               url: pointBackUrl,
	               data: param,
	               success: function (result) {
	            	   $("#progress_loading").hide();
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
	            				 document.location.href = window.location.protocol + "//" + window.location.host + "/m/mypage/newpoint.do";
	            			 }
	            		 	}, 
	            			null);
	               	 }else{
	               		 alertOpen("알림", "네트워트 장애 발생. 다시 시도해주세요.", true, false, null, null);
	               	 }
	               },
	               error : function(request, status, error){
	            	   $("#progress_loading").hide();
	            	   alertOpen("알림 ", "네트워트 장애 발생!  다시 시도해주세요", true, false, null, null);
	               },
	               dataType: 'json'
	           });
			//var qrInfoUrl = window.location.protocol + "//pb.retunp.com + "/qr/qrinfo.do?data=" + url;
		});	
	}
	
	bridge.checkPermission(appInfo.permission.READ_PHONE_STATE, function(data){
		data = JSON.parse(data);
		if (data.result == "100") {
			if (data.permissionState == appInfo.permissionResult.PERMITTEED) {
				execPointback();
			}else {
				bridge.requestPermission(appInfo.permission.READ_PHONE_STATE, function(data){
					data = JSON.parse(data);
					if (data.permissionState == appInfo.permissionResult.PERMITTEED) {
						execPointback();
					}else {
						 alertOpen("확인", result.permissionName + " 권한을 허용하셔야 적립이 가능합니다", true, false, null, null);
					}
				});
			}
		}else {
			alertOpen("알림", "앱 오류 발생", true, false, null, null);
			return;
		}
	});
}

function checkVersion(){
	var data = {};
	var  url = window.location.protocol + "//" + window.location.host + "/m/device/getVersion.do";
	$.ajax({
       	type: "GET",
        url: url,
        data: data,
        success: function (sVersionInfo) {
        	var sVersion = sVersionInfo.split(":")[0];
        	var sVersionApply = sVersionInfo.split(":")[1];
        	if (sVersion != null && sVersion != "" && sVersionApply == "Y") {
        		bridge.getSessionValue("version", function(data){
        			if (data.result == "100"){
        				if (data == null || data == "" || Number(data['version']) < Number(sVersion)){
        					alertOpen(
        						"업데이트 알림", 
        						"새로운 버젼의 앱이 출시되었습니다.<br> 전체적인 시스템 수정으로 인하여 <br>업데이트를 받으셔야 원할한 서비스 제공이 가능합니다<br> 확인을 누르시면 업데이트 페이지로 이동합니다.",
        						true, 
        						false, 
        						function(){goPlayStore()},
        						null);	
        				}
        			}else {
        				alertOpen("알림", "앱 오류 발생", true, false, null, null);
        			}
        		})
        	}
        },
        error : function(request, status, error){
        	alertOpen("알림 ", "네트워트 장애 발생!  다시 시도해주세요", true, false, null, null);
        },
        dataType: 'text'
       });
}
function startQRScan(){
	if (!isApp())  {
		executeAppOrGoStore();
		return;
	}
	var qrInfoUrl; 
	bridge.startQRCodeScan(function(qrData){
		if (!qrData || qrData == 'null' || qrData== '') {
			//alertOpen("확인", "QR Code로 부터 읽어들인 데이타가 없습니다" , true, false, null, null);
		}else {
			if (checkUrlForm(qrData)) {
				/*KICC 전용 QR 포맷에 의한 적립 요청*/
				if (qrData.indexOf("PB.RETURNP.COM") > 0) {
					/*QR code Base64 인코딩 전송*/
					qrInfoUrl = window.location.protocol + "//" + window.location.host + "/m/qr/kiccQrinfo.do?qr_data=" + btoa(unescape(encodeURIComponent(qrData)));
					webview_redirect(qrInfoUrl);
					return;
				} 
				
				/*KICC 외의 다른 밴사로 부터 온 QR 요청*/
				else if (qrData.indexOf("ppb.rp.com") > 0) {
					qrInfoUrl = window.location.protocol + "//" + window.location.host + "/m/qr/commonQrinfo.do?qr_data=" + btoa(unescape(encodeURIComponent(qrData)));
					webview_redirect(qrInfoUrl);
				} 
				
				/*회원 가입 QR */
				else if (qrData.indexOf("intro.do") > 0) {
					webview_redirect(qrData);
					return;
				}else {
					alertOpen("확인", "908 유효하지 않은 QR 코드 입니다. </br> 관리자에게 문의 해주세요", true, false, null, null);
				}
			}else{
				/*큐알로 부터 읽어들인 데이타가 URL 형태가 아닌 경우 RETURNP 자체  큐알 명령 */
				accumulateGiftCardQr(qrData);
			}
		}
	});
}

function accumulateGiftCardQr(data){
	var data  = encodeURIComponent(data);
	console.log(data);
	qrInfoUrl = window.location.protocol + "//" + window.location.host + "/m//qr/giftcard_qrinfo.do?qr_data=" + data;
	webview_redirect(qrInfoUrl);
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

$.fn.serializeObject = function () {
    "use strict";
    var result = {};
    var extend = function (i, element) {
        var node = result[element.name];
        if ('undefined' !== typeof node && node !== null) {
           if ($.isArray(node)) {
               node.push(element.value);
           } else {
               result[element.name] = [node, element.value];
           }
        } else {
            result[element.name] = element.value;
        }
    };
 
    $.each(this.serializeArray(), extend);
    return result;
};

/*var uAgent = navigator.userAgent.toLowerCase();
//아래는 모바일 장치들의 모바일 페이지 접속을위한 스크립트
var mobilePhones = new Array('iphone', 'ipod', 'ipad', 'android', 'blackberry', 'windows ce','nokia', 'webos', 'opera mini', 'sonyericsson', 'opera mobi', 'iemobile');
for(var i = 0; i < mobilePhones.length; i++){
	if(uAgent.indexOf(mobilePhones[i]) != -1){
		location.href="/m/main/index.do";
	}
};*/

/*앱인 경우 브릿지 로드*/
//if (appInfo.access == "APP")  {
	//document.write('<script type="text/javascript" src="/resources/js/lib/android_bridge.js"></script>');
//}

