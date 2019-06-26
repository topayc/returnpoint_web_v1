<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="f" uri="/WEB-INF/tld/f.tld" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<body>
    <div class="error">
        <div class="error_img">
            <img src="/resources/web_images/logo.png">
        </div>
        <div class="error_text col-lg-12">
            <p class="error_text1">찾을 수 없는 페이지 입니다.</p>
            <p class="error_text2">서비스 이용에 불편을 드려서 대단히 죄송합니다.</p>
        </div>
        <div class="error_text_box">
            <p class="error_text2">입력하신 페이지의 주소가 잘못입력되었거나, 변경
                또는 삭제되어 요청하신 페이지를 찾을 수 없습니다.</p>
            <p class="error_text2">다시 한번 입력하신 주소가 정확한지 확인해주시기
                바랍니다.</p>
            <div class="error_button">
                <a href="javascript:history.back()"><button type="button" class="btn btn-warning col-lg-4 col-lg-offset-4 col-xs-12">이전페이지로 이동</button></a>
            </div>
        </div>
    </div>    
</body>
</html>