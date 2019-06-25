<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="f" uri="/WEB-INF/tld/f.tld" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">
<head>
<script type="text/javascript" src="/resources/js/lib/common.js"></script>
<script>
function initMap() { 
	var code = '${params.code}';
	if(code == "error"){
		alert("가맹점 정보가 정확하지 않습니다. 고객센터로 문의두세요.");
		window.close();
	}
	var lat = '${affiliateGoogleMapView.lat}';
	var lng = '${affiliateGoogleMapView.lng}';
	var affiliateName = '${affiliateGoogleMapView.affiliateName}';
	
    // Initial location of a map 
    var curLatLng = { 
        lat: parseFloat(lat) , 
        lng: parseFloat(lng) 
    }; 

    // Creates a map object. 
    var map = new google.maps.Map(document.getElementById('map'), { 
        center: curLatLng, 
        scrollwheel: false, 
        zoom: 16 
    }); 

    // Creates a marker on the map. 
    var marker = new google.maps.Marker({ 
        position: curLatLng, 
        map: map, 
        title: affiliateName
    }); 
} 
</script>
<title>가맹점 상세정보-${affiliateGoogleMapView.affiliateName}</title>
</head>
<body>
<div id="map" style="height: 600px;width: 600px;"></div> 
<script src="https://maps.googleapis.com/maps/api/js?key=${params.key}&callback=initMap" async defer></script> 
</body>
</html>