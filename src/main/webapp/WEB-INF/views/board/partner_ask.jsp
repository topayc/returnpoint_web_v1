<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="f" uri="/WEB-INF/tld/f.tld" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<script type="text/javascript">
function refresh(){
	location.reload();
}

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
</script>
<body>
<jsp:include page="/WEB-INF/views/common/topper.jsp" />
    <hr class="top_line">
    <div class="partnership container">
     <form name="partnerAskSaveForm" id="partnerAskSaveForm">
        <div class="fran_text1"><spring:message code="label.web.contactUs"/></div>
        <div class="partnership1">
            <hr class="fran_line" style="margin-bottom: 7%;">
            <p class="partner_text1">업체정보</p>
            <div class="fran2 col-lg-3">
                <select class="form-control" id="bbsType2" name="bbsType2">
                    <option value="">선택</option>
                    <option value="1">일반 회원 문의</option>
                    <option value="2">정회원 문의</option>
                    <option value="3">영업 관리자 문의</option>
                    <option value="4">협력업체 문의</option>
                    <option value="5">대리점 문의</option>
                    <option value="6">지사 문의</option>
                    <option value="7">기타 제휴 문의</option>
                </select>
            </div>
            <div class="form-group col-lg-9" style="margin-top: 0.6%;">
                <input type="text" id="rerv1" name="rerv1" class="form-control" maxlength="30" placeholder="상호명">
            </div>
            <div class="form-group col-lg-3">
                <input type="text" id="rerv2" name="rerv2" class="form-control" maxlength="30" placeholder="대표자명">
            </div>
            <div class="form-group col-lg-9">
                <input type="text" id="rerv3" name="rerv3" class="form-control" maxlength="80" placeholder="주소">
            </div>
            <div class="form-group col-lg-3">
                <input type="text" id="rerv4" name="rerv4" class="form-control" maxlength="30" placeholder="담당자">
            </div>
            <div class="form-group col-lg-4">
                <input type="text" id="rerv5" name="rerv5" class="form-control" maxlength="30" placeholder="연락처">
            </div>
            <div class="form-group col-lg-5">
                <input type="text" id="rerv6" name="rerv6" class="form-control" maxlength="30" placeholder="이메일">
            </div>
            <div class="form-group col-lg-12">
                <input type="text" id="title" name="title" class="form-control" maxlength="30" placeholder="제목">
            </div>
            <div class="form-group col-lg-12">
                <textarea class="form-control" id="content" name="content" rows="3" maxlength="100" placeholder="문의사항"></textarea>
            </div>
            <div class="partner_text2"><spring:message code="label.web.collectionAndUseOfPersonalInformation"/><br><br>
                • - <spring:message code="label.web.purposeOfProcessing"/> : <spring:message code="label.web.consultationReceptionAndProcessing"/><br>
                • - <spring:message code="label.web.processingItems"/> : <spring:message code="label.web.nameEmailAddressPhonenumber"/><br>
                • - <spring:message code="label.web.retentionPeriod"/> : <spring:message code="label.web.atTheEnd"/><br><br>
                <spring:message code="label.web.partnerAskContent1"/>
            </div>
            <div class="check">
                <input type="checkbox" style="width: 15px; height: 15px;" name="gb" id="gby" onclick='gbCheck("Y");'><spring:message code="label.web.yes"/>
                <input type="checkbox" style="width: 15px; height: 15px;" name="gb" id="gbn" onclick='gbCheck("N");'><spring:message code="label.web.no"/>
                <input type="hidden" id="gbval" name="gbval"/>
            </div>
            <hr class="fran_line">
            <button type="button" class="btn btn-primary btn-lg partner_button" onclick="partnerAskSave();"><spring:message code="label.web.apply"/></button>
        </div>
        </form>
    </div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>