<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="f" uri="/WEB-INF/tld/f.tld" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<body>
<jsp:include page="/WEB-INF/views/common/topper.jsp" />
    <hr class="top_line">
    <div class="ser_img">
        <p class="ser_text1 col-lg-7 col-lg-offset-1 col-md-7 col-md-offset-2">Service</p>
        <p class="ser_text2 col-lg-7 col-lg-offset-1 col-md-7 col-md-offset-2"><spring:message code="label.web.serviceinfo"/></p>
    </div>
    <div class="ser_page1 block">
        <div class="ser_page1_sub1 col-xs-10 col-xs-offset-1 col-lg-5 col-lg-offset-1">
        </div>
        <div class="ser_page1_sub2 pull-right col-md-6 col-md-offset-6 col-xs-12 col-lg-5 col-lg-offset-1">
            <p class="ser_text3"><spring:message code="label.web.serviceinfoTitleM1"/><br><spring:message code="label.web.serviceinfoTitleS1"/></p>
            <p class="ser_text4"><spring:message code="label.web.serviceinfoContent1"/></p>
            <p class="ser_text4"><spring:message code="label.web.serviceinfoContent2"/></p>
            <p class="ser_text4"><spring:message code="label.web.serviceinfoContent3"/></p>
        </div>
    </div>
    <div class="ser_page2 block">
        <div class="ser_page2_sub1 col-xs-10 col-xs-offset-1 col-lg-5 col-lg-offset-1">
            <div class="main_event">
                <img src="/resources/web_images/ser_img3.png">
            </div>
        </div>
        <div class="ser_page2_sub2 col-xs-12 col-lg-5">
            <p class="ser_text5"><spring:message code="label.web.serviceinfoTitleM2"/></p>
            <p class="ser_text6"><spring:message code="label.web.serviceinfoContent4"/><br><spring:message code="label.web.serviceinfoContent5"/></p>
            <p class="ser_text6"><spring:message code="label.web.serviceinfoContent6"/><br><spring:message code="label.web.serviceinfoContent7"/></p>
        </div>
    </div>
    <div class="ser_page3 block">
        <div class="ser_pageq_sub1 col-xs-10 col-xs-offset-1 col-lg-5 col-lg-offset-1">
            <div class="main_event">
                <img src="/resources/web_images/ser_img4.png">
            </div>
        </div>
        <div class="ser_page3_sub2 col-xs-12 col-lg-5"">
            <p class="ser_text3"><spring:message code="label.web.serviceinfoTitleM3"/></p>
            <p class="ser_text4"><spring:message code="label.web.serviceinfoContent8"/></p>
            <p class="ser_text4"><spring:message code="label.web.serviceinfoContent9"/><br><spring:message code="label.web.serviceinfoContent10"/></p>
        </div>
    </div>
    <div class="ser_page4 block">
        <div class="ser_page3_sub1 col-xs-10 col-xs-offset-1 col-lg-5 col-lg-offset-1">
            <div class="main_event">
                <img src="/resources/web_images/ser_img5.png">
            </div>
        </div>
        <div class="ser_page3_sub2 col-xs-12 col-lg-5">
            <p class="ser_text5"><spring:message code="label.web.serviceinfoTitleM4"/></p>
            <p class="ser_text6"><spring:message code="label.web.serviceinfoContent11"/></p>
            <p class="ser_text6"><spring:message code="label.web.serviceinfoContent12"/><br><spring:message code="label.web.serviceinfoContent13"/></p>
            <p class="ser_text6"><spring:message code="label.web.serviceinfoContent14"/><br><spring:message code="label.web.serviceinfoContent15"/></p>
        </div>
    </div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>