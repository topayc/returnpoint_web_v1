<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="com.returnp_web.utils.SessionManager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="f" uri="/WEB-INF/tld/f.tld" %>
<!DOCTYPE html>
<html lang="en"> 
<head> 
<title>ReturnP</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="format-detection" content="telephone=no"/>
<!-- css   -->
<!-- font -->
<link rel="stylesheet" href="/resources/css/m_common.css">
<!-- js -->
<script type="text/javascript" src="/resources/js/lib/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/bootstrap.min.js"></script>
<link rel="stylesheet" href="/resources/web_css/common.css">
<script type="text/javascript" src="/resources/js/lib/m_common.js"></script>

</head>
<!-- header end -->
<!-- body begin -->
<body class="affiliate_search_container" style="padding-top: 0px;">	
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4><spring:message code="label.franchise" /></h4>
	</header> 
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
	<jsp:include page="/WEB-INF/views/common/paging.jsp" />
	</section>
</body>
<!-- body end -->
</html>