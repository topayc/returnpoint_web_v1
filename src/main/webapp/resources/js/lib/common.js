function comma(str) {
	str = String(str);
	return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

//Empty체크
function isEmpty(obj){
	if(typeof obj.value.trim() == "undefined" || obj.value.trim() == null || obj.value.trim() == ""){
		return true
	}else{
		return false
	}
}


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

//locale설정
function changeLang(value){
	location.href="/locale/change.do?lang=" + value.trim() + "&returnUrl="+ location.href;
}

//공지사항상세->공지사항목록
function moveNoticeList(){
	document.noticeList.action = "/board/notice.do";
    document.noticeList.submit();
}

//FAQ상세->FAQ목록
function moveFaqList(){
	document.faqList.action = "/board/faq.do";
    document.faqList.submit();
}

//page reload
function refresh(){
	location.reload();
}

//제휴문의 Validation Alert View
function commonAlert(message, bool, func){	
	var commonAlertFrame = ""; //전체 frame
	var commonAlertMessage = ""; //message text
	commonAlertMessage = message;
	commonAlertFrame += "<div class='modal fade modal3' data-backdrop='static' tabindex='-1' role='dialog' aria-hidden='true' id='modal3'>";
	commonAlertFrame += "<div class='modal-dialog modal-lg'>";
	commonAlertFrame += "<div class='modal-content2 col-lg-6 col-lg-offset-3'>";
	commonAlertFrame += "<div class='modal_top'>";
	commonAlertFrame += "<button type='button' class='close' data-dismiss='modal' aria-label='Close'><span class='modal_close' aria-hidden='true'>&times;</span></button>";
	commonAlertFrame += "<p class='modal3_text1'>ReturnP</p>";
	commonAlertFrame += "</div>";
	commonAlertFrame += "<div class='modal3_conbox'>";
	commonAlertFrame += "<p class='modal3_text2'><img src='/resources/web_images/icon.png'>확인</p>";
	commonAlertFrame += "<p class='modal3_text3'>"+commonAlertMessage+"</p>";
	commonAlertFrame += "</div>";
	commonAlertFrame += "<div class='modal_button'>";
	if(bool){
		commonAlertFrame += "<a href='#' onclick='"+func+";'>" +"<button type='button' class='btn btn-primary btn-lg partner1_button' style='margin: auto;'>true확인</button></a>";
	}else{
		commonAlertFrame += "<button type='button' class='btn btn-primary btn-lg partner1_button' data-dismiss='modal' aria-label='Close' style='margin: auto;'>확인</button>";
	}
	commonAlertFrame += "</div>";
	commonAlertFrame += "</div>";
	commonAlertFrame += "</div>";
	commonAlertFrame += "</div>";
	$('#commonAlertFrame').html(commonAlertFrame);
}

//제휴문의 개인정보 수집 및 약관 동의 checkbox Validation
function gbCheck(obj){
	var checkboxVal=$("input[name='gb']:checked").val();
	if(checkboxVal != 'on'){
		$("#gbval").val('');	
	}else{
		if(obj == 'Y'){
			$('input:checkbox[id="gbn"]').prop("checked", false);
			$("#gbval").val(obj);
		}else{
			$('input:checkbox[id="gby"]').prop("checked", false);
			$("#gbval").val(obj);
		}	
	}
}

//이메일 형식 체크 
function checkEmail(str) {
	var pattern = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
	if (str.match(pattern) != null) {
		return true;
	} else {
		return false;
	}
} 

//제휴문의 신청하기 저장
function partnerAskSave(){ 
	event.preventDefault();
	
	var f = document.partnerAskSaveForm;
	var bbsType2 = $("#bbsType2 option:selected").val();
	if(bbsType2 == null || bbsType2 ==""){
		commonAlert('질문 유형을 선택해 주세요.', false, null);
		$("#modal3").modal('show');
		return false;
	}
	if (isEmpty(f.rerv1)) {
		commonAlert('상호명을 입력해주세요.', false, null);
		$("#modal3").modal('show');
		return false;
	}
 	if (isEmpty(f.rerv2)) {
		commonAlert('대표자명을 입력해주세요.', false, null);
		$("#modal3").modal('show');
		return false;
	}
	if (isEmpty(f.rerv3)) {
		commonAlert('주소를 입력해주세요.', false, null);
		$("#modal3").modal('show');
		return false;
	}
	if (isEmpty(f.rerv4)) {
		commonAlert('담당자를 입력해주세요.', false, null);
		$("#modal3").modal('show');
		return false;
	}
	if (isEmpty(f.rerv5)) {
		commonAlert('연락처를 입력해주세요.', false, null);
		$("#modal3").modal('show');
		return false;
	}
	if (isEmpty(f.rerv6)) {
		commonAlert('이메일 입력해주세요.', false, null);
		$("#modal3").modal('show');
		return false;
	}
	var rerv6 = $("#rerv6").val();
	if (!checkEmail(rerv6)){
		commonAlert('올바른 이메일주소를 입력해주세요.', false, null);
		$("#modal3").modal('show');
		return false;
	} 
	if (isEmpty(f.title)) {
		commonAlert('제목을 입력해주세요.', false, null);
		$("#modal3").modal('show');
		return false;
	}
	if (isEmpty(f.content)) {
		commonAlert('문의사항을 입력해주세요.', false, null);
		$("#modal3").modal('show');
		return false;
	}
    var isBbsTypeChk = false; 
   	var arr_bbsType2 = document.getElementsByName("gb");
    for(var i=0;i<arr_bbsType2.length;i++){
        if(arr_bbsType2[i].checked == true) {
        	isBbsTypeChk = true;
            break;
        }
    }
    if(!isBbsTypeChk){
        commonAlert('개인정보 수집 및 약관동의(필수)"예"를 하셔야 문의신청이 가능합니다.', false, null);
		$("#modal3").modal('show');
        return false;
    }
    var gbval = $("#gbval").val();
    if(gbval != 'Y'){
        commonAlert('개인정보 수집 및 약관동의(필수)에 "예" 를 하셔야 문의신청이 가능합니다.', false, null);
		$("#modal3").modal('show');    	
        return false;
    }
    var params = jQuery("#partnerAskSaveForm").serialize(); // serialize() : 입력된 모든Element(을)를 문자열의 데이터에 serialize 한다.
	$.ajax({
		method : "post",
		url    : "/board/partnerAskSave.do",
		dataType: "json",
		data   :  params,
		contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
		success: function(data) {
			if (data.code == 1 ) {
				 commonAlert("제휴문의에 등록이 완료되었습니다.", true, 'refresh()');
				 $("#modal3").modal('show');  
			}
		},
		error: function (request, status, error) {
			commonAlert("잠시후에 다시 시도해주세요.", true, 'refresh()');
			$("#modal3").modal('show');  
		}
	})
}

//공지사항목록 조회
function searchNoticeList(){
	document.viewList.action = "/board/notice.do";
    document.viewList.submit();
}

//공지사항목록->공지사항상세
function moveNoticeContent(mainBbsNo){
	$("#mainBbsNo").val(mainBbsNo);
	document.viewList.action = "/board/notice_content.do";
    document.viewList.submit();
}

//FAQ목록->FAQ상세
function moveFaqContent(mainBbsNo){
	$("#mainBbsNo").val(mainBbsNo);
	document.viewList.action = "/board/faq_content.do";
    document.viewList.submit();
}

//FAQ목록(분류)탭 조회
function searchFaqTapList(bbsType2){
	$("#bbsType2").val(bbsType2);
	document.faqform.action = "/board/faq.do";
    document.faqform.submit();
}

//FAQ목록 조회
function searchFaqList(){
	document.viewList.action = "/board/faq.do";
    document.viewList.submit();
}


