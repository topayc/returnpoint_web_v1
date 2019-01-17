//이메일 형식 체크 
function checkEmail(str) { 
	var pattern=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/; 
	return pattern.test(str) ;
} 

	// 공백 체크
function checkSpace(str) { 
	return (str.search(/\s/) != -1) ;
} 

//비밀번호 패턴 체크 (8자 이상, 문자, 숫자, 포함여부 체크) 
function checkPasswordPattern(str) { 
	var pattern1 = /[0-9]/;	// 숫자 
	var pattern2 = /[a-zA-Z]/;	// 문자 
	//var pattern3 = /[~!@#$%^&*()_+|<>?:{}]/;	// 특수문자
	if(!pattern1.test(str) || !pattern2.test(str) || str.length < 8 || str.length > 12) { 
		return false; 
	} else { 
		return true; 
	} 
}		

//휴대폰 숫자 체크
function checkPhonePattern(str) { 
	var pattern1 = /[0-9]/;	// 숫자
	return pattern1.test(str) ;
}

//선물받을 회원정보조회-memberEmail
function searchPointGiftMemberEmail(postfixId, id){
	var memberEmail= $("#redPointGiftMemberEmail"+postfixId).val();
	// 추천인 입력값 유효성 체크
	if(!memberEmail|| memberEmail.length == 0){
		//alert("이메일을 입력해주세요.");
		alertOpen("확인", "이메일을 입력해주세요.", true, false, null, null);
		return false;
	} else if (!checkEmail(memberEmail)){
		//alert("올바른 이메일을 입력해주세요.");
		alertOpen("확인", "올바른 이메일을 입력해주세요.", true, false, null, null);
		return false;
	} 
	$.ajax({
		method : "POST",
		url    : "/member/select_view_member_information.do",
		dataType: "json",
		data   : {
			memberEmail		: memberEmail
		},

		success: function(data) {
			if (data.result.code > 0) {
				//alert(data.result.msg);
				alertOpen("확인", data.result.msg, true, false, null, null);
				if ( data.result.code == 1 ){
					$('#redPointGiftMemberEmailOri'+postfixId).val(memberEmail);
					return false;
				}	
			}
		},
		error: function (request, status, error) {
			alert(request.responseText);
			return false;
		}
	});
}

//가격 정책 조회
function selectPolicy(){	
	var pointtranslimit = "";
	var policypoint = "";
	$.ajax({
		method : "POST",
		url    : "/member/policyPointTransLimit.do",
		dataType: "json",
		data   : {
			pointtranslimit		: pointtranslimit
		},
		success: function(data){
			if (data.json_arr.length > 0){
				for (var i=0; i<data.json_arr.length; i++){
					//rpoint
					$('#rPointMovingMinLimit').val(data.json_arr[i].rPointMovingMinLimit);
					$('#rPointMovingMaxLimit').val(data.json_arr[i].rPointMovingMaxLimit);
					//gpoint
					$('#gPointMovingMinLimit').val(data.json_arr[i].gPointMovingMinLimit);
					$('#gPointMovingMaxLimit').val(data.json_arr[i].gPointMovingMaxLimit);
				}
			}
		},
		error: function (request, status, error) {
			//location.reload();
			return false;
		}
	});
}

//천단위 콤마 처리
function numberFormat(number) {
    var string = number.toString();
    var length = string.length;
    var standard = (length % 3 === 0) ? 3 : length % 3;
    var arr = [];
    var start = 0;
    while(true){
    	var temp = string.substr(start, standard);
        if (temp === "") break;
        arr.push(temp);
        start = start + standard;
        standard = 3;
    }
    var result = arr.join(",");
    return result;
}

//숫자만 입력가능
function regExpCheck(str, pattern){
    var pattern1 = "[^-0-9 ]";  
    var rxSplit;
    switch (pattern) {
    case 1:
        rxSplit = new RegExp(pattern1);
        break;
    }
	if (rxSplit.test(str)) {return false;} else {return true;}
}

//숫자만 입력가능
function changeAttribute(attribute, pattern, id){
	var message = "숫자만 입력가능합니다.";
    /* 
        1 = 숫자만
    */      
    if(!regExpCheck(document.getElementById(attribute).value, pattern)){
    	//if (message != ''){
            //alert(message);
            alertOpen("확인", message, true, false, null, null);
        //}
        document.getElementById(attribute).value = "";
        document.getElementById(attribute).focus();
        return;
    }
}

//green point 선물하기
function greenPointTransaction(postfixId, pointAmount, requestNodeTypeName, greenPointNo, id){
	var redPointGiftMemberEmailOri 	= $("#redPointGiftMemberEmailOri"+postfixId).val();
	var redPointGiftMemberEmail		= $("#redPointGiftMemberEmail"+postfixId).val();

	if((redPointGiftMemberEmailOri != redPointGiftMemberEmail)){ //조회한 email과 입력한 email의 일치여부 확인
		//alert("선물받을 회원을 조회해주세요.");
		alertOpen("확인", "선물받을 회원을 조회해주세요.", true, false, null, null);
		return false;
	}
	
	if (redPointGiftMemberEmail == null || redPointGiftMemberEmail.length == 0) {
		//alert("선물받을 회원을 조회해주세요.");
		alertOpen("확인", "선물받을 회원을 조회해주세요.", true, false, null, null);
		return false;
	}
	
	var pointTranVal = $('#point'+postfixId).val();
	var gPointMovingMinLimit = $('#gPointMovingMinLimit').val();
	var gPointMovingMaxLimit = $('#gPointMovingMaxLimit').val();
	
	//입력된 값이 숫자가 아니거나 마이너스이면 금액을 0으로 셋팅.
	if(isNaN(pointTranVal) || pointTranVal < 0 || pointTranVal=='') pointTranVal=0;
	pointTranVal = new Number(pointTranVal);
		//보유하고 있는 금액보다 크면 보유하고 있는 금액으로 셋팅
		if(Number(pointTranVal) > Number(pointAmount)) changeValue = Number(pointAmount);
		$('#point'+postfixId).val(pointTranVal); //재계산 후 입력   
		if(gPointMovingMinLimit > pointTranVal) { 
			//alert("최소"+ gPointMovingMinLimit +" P부터 선물하실수 있습니다.");
			alertOpen("확인", "최소"+ gPointMovingMinLimit +" P부터 선물하실수 있습니다.", true, false, null, null);
			return false;
		}
		if(gPointMovingMaxLimit < pointTranVal) { 
			//alert("최대"+ gPointMovingMaxLimit +" P까지 선물하실수 있습니다.");
			alertOpen("확인", "최대"+ gPointMovingMaxLimit +" P까지 선물하실수 있습니다.", true, false, null, null);
			return false;
		}
	if(Number(pointTranVal) > Number(pointAmount)){
		//alert("신청가능한 포인트를 확인해주세요.");
		alertOpen("확인", "신청가능한 포인트를 확인해주세요.", true, false, null, null);
		return false;
	}

	if(Number(pointAmount) == "0" || Number(pointAmount) == null){
		//alert("신청가능한 포인트를 확인해주세요.");
		alertOpen("확인", "신청가능한 포인트를 확인해주세요.", true, false, null, null);
		return false;
	}
	var movefun = function(){
		location.replace("/mypage/point_gift.do");
	}
	//if (confirm("green point 를 선물하시겠습니까?")) { 
		$.ajax({
			method : "POST",
			url    : "/mypage/greenPointTransactionAct.do",
			dataType: "json",
			data   : {
				nodeType				: postfixId , //nodeType
				convertPointAmount		: pointTranVal , //convertPointAmount -> transferPointAmount : 송금액
				requestNodeTypeName 	: requestNodeTypeName, //requestNodeTypeName
				pointAmount				: Number(pointAmount), //잔액
				pointType				: "2",
				redPointGiftMemberEmail : redPointGiftMemberEmail //선물받을 사람 이메일 주소 -> pointTransferer : 송금자 멤버 번호
			},
			success: function(data) {
				if (data.result.code == 0 ) {
					alertOpen("확인", "저장완료 하였습니다.", true, false, movefun, null);
				}else{
					alertOpen("확인", data.result.msg, false, true, null, movefun);
				}
			},
			error: function (request, status, error) {
				alertOpen("확인", data.result.msg, false, true, null, movefun);
			}
		});
	//}
}

//red point 선물하기
function redPointTransaction(postfixId, pointAmount, redPointNo, id){
	var redPointGiftMemberEmailOri 	= $("#redPointGiftMemberEmailOri"+postfixId).val();
	var redPointGiftMemberEmail		= $("#redPointGiftMemberEmail"+postfixId).val();
	if((redPointGiftMemberEmailOri != redPointGiftMemberEmail)){ //조회한 email과 입력한 email의 일치여부 확인
		//alert("선물받을 회원을 조회해주세요.");
		alertOpen("확인", "선물받을 회원을 조회해주세요.", true, false, null, null);
		return false;
	}
	
	if(redPointGiftMemberEmail == null || redPointGiftMemberEmail.length == 0){
		//alert("선물받을 회원을 조회해주세요.");
		alertOpen("확인", "선물받을 회원을 조회해주세요.", true, false, null, null);
		return false;
	}

	var pointTranVal = $('#rPoint'+postfixId).val();
	var rPointMovingMinLimit = $("#rPointMovingMinLimit").val();
	var rPointMovingMaxLimit = $("#rPointMovingMaxLimit").val();

	//입력된 값이 숫자가 아니거나 마이너스이면 금액을 0으로 셋팅.
	if(isNaN(pointTranVal) || pointTranVal < 0 || pointTranVal=='') pointTranVal=0;
		pointTranVal = new Number(pointTranVal);
		//보유하고 있는 금액보다 크면 보유하고 있는 금액으로 셋팅
		if(Number(pointTranVal) > Number(pointAmount)) changeValue = Number(pointAmount);
		$('#point'+postfixId).val(pointTranVal); //재계산 후 입력   
	if(rPointMovingMinLimit > pointTranVal){ 
		//alert("최소"+ rPointMovingMinLimit +" P부터 선물하실수 있습니다.");
		alertOpen("확인", "최소"+ rPointMovingMinLimit +" P부터 선물하실수 있습니다.", true, false, null, null);
		return false;
	}
	if(rPointMovingMaxLimit < pointTranVal){ 
		//alert("최대"+ rPointMovingMaxLimit +" P까지 선물하실수 있습니다.");
		alertOpen("확인", "최대"+ rPointMovingMaxLimit +" P까지 선물하실수 있습니다.", true, false, null, null);
		return false;
	}
	if(Number(pointTranVal) > Number(pointAmount)){
		alertOpen("확인", "신청가능한 포인트를 확인해주세요.", true, false, null, null);
		//alert("신청가능한 포인트를 확인해주세요.");
		return false;
	}
	if(Number(pointAmount) == "0" || Number(pointAmount) == null){
		//alert("신청가능한 포인트를 확인해주세요.");
		alertOpen("확인", "신청가능한 포인트를 확인해주세요.", true, false, null, null);
		return false;
	}
	var movefun = function(){
		location.replace("/mypage/point_gift.do");
	}
	//if (confirm("red point 를 선물하시겠습니까?")) {
		$.ajax({
			method : "POST",
			url    : "/mypage/redPointTransactionAct.do", 
			dataType: "json",
			data   : {
				convertPointAmount		: Number(pointTranVal) , //convertPointAmount -> transferPointAmount : 송금액
				redPointNo				: redPointNo, //greenPointNo
				pointAmount				: Number(pointAmount), //내 잔액
				pointType				: "2",
				redPointGiftMemberEmail : redPointGiftMemberEmail //선물받을 사람 이메일 주소 -> pointTransferer : 송금자 멤버 번호
			},
			success: function(data) {
				if (data.result.code == 0 ) {
					//alert("저장완료 하였습니다.");
					alertOpen("확인", "저장완료 하였습니다.", true, false, movefun, null);
				}else{
					//alert(data.result.msg);
					alertOpen("확인", data.result.msg, false, true, null, movefun);
				}
			},
			error: function (request, status, error) {
				//alert("새로고침후 진행해주세요.");
				alertOpen("확인", data.result.msg, false, true, null, movefun);
			}
		});
	//}
}

//red point reset
function resetRpointvalue(postfixId){
	$('#rPoint'+postfixId).val('');
	$('#redPointGiftMemberEmail'+postfixId).val('');
	$('#redPointGiftMemberEmailOri'+postfixId).val('');
}

//green point reset
function resetGpointvalue(postfixId){
	$('#point'+postfixId).val('');
	$('#redPointGiftMemberEmail'+postfixId).val('');
	$('#redPointGiftMemberEmailOri'+postfixId).val('');
}