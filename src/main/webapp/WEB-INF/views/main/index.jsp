<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="f" uri="/WEB-INF/tld/f.tld" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<script type="text/javascript">
	window.counter = function(){
		var span = this.querySelector('span');
		var current = parseInt(span.textContent);
		span.textContent = current + 1;
	};
	document.addEventListener('DOMContentLoaded', function(){
  		var trigger = new ScrollTrigger({
		addHeight: true
		});
	});
	$(document).ready(function(){
		//숨겨진 공지 모달 사용시, 아래 한줄
		//document.querySelector(".modal2").classList.toggle("show-modal");
	});
</script>
<body>
    <div class="modal2">
        <div class="modal-content col-lg-4 col-md-6 col-sm-6 col-xs-11">
            <span class="close-button">&times;</span>
            <p class="modal_text1">returnP</p>
            <p class="modal_text2">R-포인트 현금출금 수수료 조정 공지</p>
            <hr>
            <form action="#" method="POST">
                <p class="modal_text3 text-center">현행 6.3% 출금 수수료를 플랫폼 부가세 납부수준을
                    반영하여 13% ( 부가세 10% + 운영비 3% )로 부득불
                    시행됨을 알려드립니다.</p>
                <p class="modal_text4">시행일시 : 2019년 5월 15일 0시</p>
                <p class="modal_text4">대 상 : 위 시행일시부터 요청된 현금 출금</p>
                <input type="button" id="cancel" onclick="toggleModal();" value="창닫기">
            </form>
        </div>
    </div>
<jsp:include page="/WEB-INF/views/common/topper.jsp" />
	<div class="wrap1">
        <!-----page1------------------------------------------------------------>
        <div class="main_page1 img-responsive center-block col-xs-12">
            <p class="text-center main_text1 " data-scroll="toggle(.scaleDownIn, .scaleDownOut)">About returnP</p>
            <p class="text-center main_text2 col-md-6 col-md-offset-3" data-scroll="toggle(.scaleDownIn, .scaleDownOut)"><spring:message code="label.web.indexTitleM1"/><br><spring:message code="label.web.indexTitleS1"/></p>
        </div>
        <!-----page2------------------------------------------------------------>
        <div class="main_page2 block">
            <div class="main_page2_sub1 pull-right col-xs-12 col-lg-7">
                <div class="main_event" data-scroll="toggle(.scaleDownIn, .scaleDownOut)">
                    <img src="/resources/web_images/main_page22.png">
                </div>
            </div>
            <div class="main_page2_sub2 pull-left col-xs-12 col-lg-4 col-lg-offset-1">
                <p class="main_text3" data-scroll="toggle(.scaleDownIn, .scaleDownOut)"><spring:message code="label.web.indexTitleM2"/><br> <spring:message code="label.web.indexTitleS2"/></p>
                <p class="main_text4" data-scroll="toggle(.scaleDownIn, .scaleDownOut)"><spring:message code="label.web.indexContent1"/><br><spring:message code="label.web.indexContent2"/></p>
                <p class="main_text4" data-scroll="toggle(.scaleDownIn, .scaleDownOut)"><spring:message code="label.web.indexContent3"/><br><spring:message code="label.web.indexContent4"/></p>
                 <p class="main_text4" data-scroll="toggle(.scaleDownIn, .scaleDownOut)"><spring:message code="label.web.indexContent5"/><br><spring:message code="label.web.indexContent6"/></p>
            </div>
        </div>
        <!-----page3------------------------------------------------------------>
        <div class="main_page3 block">
            <div class="main_page3_sub1 pull-left col-xs-12 col-lg-7">
                <div class="main_event" data-scroll="toggle(.scaleDownIn, .scaleDownOut)">
                    <img src="/resources/web_images/main_page3.png">
                </div>
            </div>
            <div class="main_page3_sub2 pull-left col-xs-12 col-lg-4">
                <p class="main_text5" data-scroll="toggle(.scaleDownIn, .scaleDownOut)"><spring:message code="label.web.indexTitleM3"/><br><spring:message code="label.web.indexTitleS3"/></p>
                <p class="main_text6" data-scroll="toggle(.scaleDownIn, .scaleDownOut)"><spring:message code="label.web.indexContent7"/><br><spring:message code="label.web.indexContent8"/></p>
                <p class="main_text6" data-scroll="toggle(.scaleDownIn, .scaleDownOut)"><spring:message code="label.web.indexContent9"/><br><spring:message code="label.web.indexContent10"/></p>
                <p class="main_text6" data-scroll="toggle(.scaleDownIn, .scaleDownOut)"><spring:message code="label.web.indexContent11"/><br><spring:message code="label.web.indexContent12"/></p>
            </div>
        </div>
        <!-----page4------------------------------------------------------------>
        <div class="main_page4 img-responsive center-block col-xs-12">
            <p class="main_text7 col-md-12 col-xs-12">Lifetime <span class="main_value">Value</span> Creator</p>
                <p class="main_text8 col-lg-5 col-lg-offset-7 col-xs-12"><spring:message code="label.web.indexContent13"/></p>
            <div class="main_page4_text_box">
                <p class="main_text9"><spring:message code="label.web.indexContent14"/></p>
                <p class="main_text9"><spring:message code="label.web.indexContent15"/></p>
                <p class="main_text9"><spring:message code="label.web.indexContent16"/></p>
                <p class="main_text9"><spring:message code="label.web.indexContent17"/></p>
            </div>
        </div>
        <!-----page5------------------------------------------------------------>
        <div class="main_page5_sub1 img-responsive center-block">
            <p class="main_text10 col-md-12" data-scroll="toggle(.scaleDownIn, .scaleDownOut)"><spring:message code="label.web.indexTitleM4"/></p>
            <div class="main_bottom_img img-responsive col-lg-6 col-lg-offset-3" data-scroll="toggle(.scaleDownIn, .scaleDownOut)">
                <img src="/resources/web_images/main_page88.png">
            </div>
            <div class="main_page5_sub2 col-lg-8 col-lg-offset-3 col-md-10 col-md-offset-2 col-xs-10 col-xs-offset-2">
                <div class="col-md-3 col-xs-10 pull-left main_text11" data-scroll="toggle(.scaleDownIn, .scaleDownOut)"><b>Discipline & Due Diligence</b><br><br><spring:message code="label.web.indexContent18"/>
                <br><spring:message code="label.web.indexContent19"/><br><br></div>
                <div class="col-md-3 col-xs-10 pull-left main_text11" data-scroll="toggle(.scaleDownIn, .scaleDownOut)"><b>Smart Trading</b><br><br><spring:message code="label.web.indexContent20"/>
                <br><br></div>
                <div class="col-md-3 col-xs-10 pull-left main_text11" data-scroll="toggle(.scaleDownIn, .scaleDownOut)"><b>Creative, Intensive, Open</b><br><br><spring:message code="label.web.indexContent21"/>
                <br><spring:message code="label.web.indexContent22"/><br><br></div>
                <div class="main_bottom_img img-responsive col-lg-9 col-xs-10" data-scroll="toggle(.scaleDownIn, .scaleDownOut)">
                    <img src="/resources/web_images/main_page8.png">
                </div>
            </div>
        </div>
    </div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script type="text/javascript">
    var modal = document.querySelector(".modal2");
    //var trigger = document.querySelector(".trigger");
    var closeButton = document.querySelector(".close-button");
    var cancelButton = document.querySelector("#cancel");

    function toggleModal() {
        modal.classList.toggle("show-modal");
    }

    function windowOnClick(event) {
        if (event.target === modal) {
            toggleModal();
        }
    }
    //trigger.addEventListener("click", toggleModal);
    closeButton.addEventListener("click", toggleModal);
    //cancel.addEventListener("click", toggleModal);
    //window.addEventListener("click", windowOnClick); //아무곳이나 클릭시 닫히도록 할꺼면 해당부분의 주석을 푼다. 19.06.21 kim
</script>
</body>
</html>