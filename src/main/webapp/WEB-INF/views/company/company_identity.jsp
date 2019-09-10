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
    <div class="_company page_title">
        <p class="_company_text1">Company</p>
        <p class="_company_text2"><spring:message code="label.web.companyIdentityTitle"/></p>	
    </div>
    <div class="_company1 img-responsive center-block"></div>
    <div class="_company2 container">
        <div class="col-lg-4 col-md-12 col-xs-12">
            <p class="_company_text3">Solidarity</p>
            <p class="_company_text4"><spring:message code="label.web.companyIdentityContent1"/></p>
        </div>
        <div class="col-lg-4 col-md-12 col-xs-12">
            <p class="_company_text3">Passion</p>
            <p class="_company_text4"><spring:message code="label.web.companyIdentityContent2"/></p>
        </div>
        <div class="col-lg-4 col-md-12 col-xs-12">
            <p class="_company_text3">Integrity</p>
            <p class="_company_text4"><spring:message code="label.web.companyIdentityContent3"/></p>
        </div>
    </div>
    <div class="_company3 img-responsive center-block"></div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>