<%@page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@page import="com.returnp_web.utils.SessionManager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html> 
<html lang="en">
<head>
<title>ReturnP</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<!-- css   -->
<!-- font -->
<link rel="stylesheet" href="/resources/css/m_common.css">
<!-- js -->
<script src="/resources/js/lib/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/m_common.js"></script>

<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyB-bv2uR929DOUO8vqMTkjLI_E6QCDofb4&libraries=geometry,places"></script>

<script type="text/javascript" src="/resources/js/lib/markerwithlabel.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	var pageContextlocale = '${pageContext.response.locale}';
	$("#sel1").val(pageContextlocale);
});

google.maps.event.addDomListener(window, 'load', getCurrentPosition);
var current = {
   map:{},
   latLng:null,
   distance:0,  
   marker:null,
   markers:[],
   searchMarker:null,
   service:null,
   infowindow:null,
   secure:'${ pageContext.request.secure }'==''?false:'${pageContext.request.secure}',
   selected:false,
   request:{
      types: ['restaurant','cafe', 'bar','food'],
      /* query: ['restaurant','cafe', 'bar','food'], */
      radius:'1000',
      /* fields: ['photos', 'formatted_address', 'name', 'rating', 'opening_hours', 'geometry'], */
   },
   callback:function (results, status){
      
      if (status == google.maps.places.PlacesServiceStatus.OK || status == 100) {
         
         $("ul.storelist_area").empty();
         //$(".rpmap").addClass("noshop");
         
         if (current.marker != null) current.marker.setMap(null);
         $.each(current.markers,function(i,o){
            o.setMap(null);
         });
         
         $.each(results,function(i,o){
            current.addList(o);
            createMarker(o);
         });
         //$("ul.storelist_area").append('<button class="btn btn-submit" data-page="0" onclick="more(this)">+ 더보기</button>');
         //$(".storelist_area li.page"+o.memberNo).show();
         
      } else {
         
         alertOpen("확인", "주변 가맹점이 조회되지 않습니다.", true, false);
         return false;
         }                     
      return false;
   },
   
   addList: function(o){
      var photos= o.photos;
      var i = $(".storelist_area li").length;
      var paging = Math.floor((i)/3);
      var li = $("<li/>",{"class":"page" + o.memberNo });
      var imageSec = $("<div/>",{"class":"img_area"});
      var detailSec = $("<a/>",{href:"#"});
      var img = $("<img/>",{src:(photos!=undefined && photos.length> 0 )
         ?photos[0].getUrl({'maxWidth': 100, 'maxHeight': 100})
         :"https://search.pstatic.net/common/?autoRotate=true&amp;quality=95&amp;src=http%3A%2F%2Fblogfiles.naver.net%2F20160318_29%2Fcncmgm1_1458305454051BTUBK_JPEG%2FNaverBlog_20160318_215053_25.jpg%23740x555&amp;type=f82_82"});
      var detailArea = $("<div/>",{"class":"info_area"});
      var sec1 = $("<div/>",{"class":"info_tit"});
      var sec2 = $("<div/>",{"class":"info_sub ellp",text:o.jibunAddr});
      var sec5 = $("<div/>",{"class":"info_tel ellp",text: "Tel " + o.affiliateTel});
      var sec3 = $("<div/>",{"class":"info_tag ellp"});
      var sec4 = $("<div/>",{"class":"info_etc ellp"});
      
      $("<span/>",{"class":"name",text:o.affiliateName}).appendTo(sec1);
      $("<span/>",{"class":"cate",text:o.engAddr}).appendTo(sec1);
      $.each(o.types,function(i,t){
         /* 해시태그 */if(i<3) $("<span/>",{"class":"item",text:t}).appendTo(sec3);
         /* 해시태그 */else $("<span/>",{"class":"item",text:t}).appendTo(sec4);
      });
      
      sec1.appendTo(detailArea);
      sec2.appendTo(detailArea);
      sec5.appendTo(detailArea);
      sec3.appendTo(detailArea);
      sec4.appendTo(detailArea);
      
      detailArea.appendTo(detailSec);
      img.appendTo(imageSec);
      
      imageSec.appendTo(li);
      detailSec.appendTo(li);
      
      li.hide();
      $(".storelist_area").append(li);
      
   },
   findPlace:function(latLng){
      
      $(".rpmap").addClass("noshop");
      <!--
      /* select 
         memberAddressNo, memberNo, nodeNo, nodeType, roadFullAddr, roadAddrPart1, roadAddrPart2, 
          addrDetail, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, lat, lng, regAdminNo, 
          createTime, updateTime,
         (6371*acos(cos(radians(${lat}))*cos(radians(lat))*cos(radians(lng)
         -radians(${lng}))+sin(radians(${lat}))*sin(radians(lat))))
         AS distance
      from member_address
      having distance <= 0.3 //300m 예. 1= 1km, 100 =100km, 0.01=10m
      order by distance 
      limit 0,1000 */
      
      /* latLng.lat,latLng.lng 사용 */
      /* 여기에 가맹점 리스트 호출하여 매핑하고 콜백을 호출한다.results=datalist status=100으로 들어와야함. */
      /* current.callback(results, status) */ //-->
      
      /* 임시-맛집리스트 */
      /* var geocoder = new google.maps.Geocoder();
      
      geocoder.geocode({latLng:latLng}, function(results, status) {
         
         if (status == google.maps.GeocoderStatus.OK) {         
            current.request.location=current.map.getCenter();
            current.service = new google.maps.places.PlacesService(current.map);            
            current.service.nearbySearch(current.request,current.callback);
         }
      }); */ 
      
      /* $.ajax({
         method : "POST",
         url    : "/map/rpmapLoadAct.do",
         dataType: "json",
         data   : {
            //where 조건에 필요한 부분 알려주시면 처리할께요. 현재는 where 가 없는 전체 검색입니다.
            //nodeType = 5만 해당되서 쿼리에 포함시켰습니다.
            curLat      : latLng.lat,
            curLng      : latLng.lng,
            distance   : 15
         },
         success: function(data) {
            
            console.log(data);
            current.callback(data, "100")
            
         },
         error: function (request, status, error) {   
            console.log(request);
            alertOpen("장애", "위치 서비스를 사용할 수 없습니다.", true, false);   
            return false;
         }
      });  */
   }
};

function more(obj){
   
   var page = Number($(obj).data("page"));
   page +=1;
   $(obj).data("page",page);
   
   //console.log($(obj).data("page"));
   
   $(".storelist_area li.page"+$(obj).data("page")).show();
}


function initLocation(latLng) {
   
   var mapOptions = {
	  center: latLng,
      zoom: 15,
      panControl: false,
      zoomControl: false,
      scaleControl: false,
      mapTypeControl: false,
      mapTypeId: google.maps.MapTypeId.ROADMAP
   };
   current.map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
   var center = current.map.getCenter();
   google.maps.event.trigger(current.map, "resize");
   
   current.searchMarker = new google.maps.Marker({
        map: current.map,  
        position: latLng,
      icon:"/resources/images/marker_spot.png"
    });
   
   current.map.addListener('bounds_changed', function() {
	   
	   if(current.selected){
		   return;
	   }
	   
	   $(".rpmap").addClass("noshop");
	   
       var bounds =  current.map.getBounds();
       var ne = bounds.getNorthEast();
       var sw = bounds.getSouthWest();
       //do whatever you want with those bound
       var distance = google.maps.geometry.spherical.computeDistanceBetween (current.map.getCenter(), ne) / 1000.0;
       var distance2 = google.maps.geometry.spherical.computeDistanceBetween (current.map.getCenter(), sw) / 1000.0;
       
       console.log(distance);
       console.log(distance2);
       
       var avg = Number((distance+ distance2)/2);
       if(current.distance> avg){
    	   return;
       }
       current.distance = avg;
   	   $.ajax({
         method : "POST",
         url    : "/m/map/rpmapLoadAct.do",
         dataType: "json",
         data   : {
            //where 조건에 필요한 부분 알려주시면 처리할께요. 현재는 where 가 없는 전체 검색입니다.
            //nodeType = 5만 해당되서 쿼리에 포함시켰습니다.
            curLat      : current.map.getCenter().lat,
       		curLng      : current.map.getCenter().lng,
            distance   : current.distance
         },
         success: function(data) {
            
        	if(data.length < 1){
        		return false;
        	}
            console.log(data);
            current.callback(data, "100")
            
         },
         error: function (request, status, error) {   
            console.log(request);
            alertOpen("확인", "위치 서비스를 사용할 수 없습니다.", true, false);   
            return false;
         }
      });
      
       
   });
   current.map.addListener('zoom_changed', function() {
	   current.selected = false;
   });
}

function createMarker(o){
   var photos = o.photos;
   var i = current.markers.length;
   var content = '<div class="store_point"><i class="fas fa-sort-down"></i>'+o.affiliateName+'</div>'; // 말풍선 안에 들어갈 내용
   current.markers[i] = new MarkerWithLabel({
      position: new google.maps.LatLng(o.lat, o.lng),
       map: current.map,
       draggable: false,
       raiseOnDrag: false,   
       labelInBackground: false,
       icon: "/resources/images/marker.png",
       zIndex: 1,
       labelContent:content,
       labelAnchor: new google.maps.Point(5*o.affiliateName.length,56)
   });
   
   current.markers[i].addListener('click', function(e) { 
	current.selected = true;
      if($(".rpmap").hasClass("noshop"))$(".rpmap").removeClass("noshop");
      $(".storelist_area li").hide();
      $(".storelist_area li.page"+o.memberNo).show();
      setMapCenter(i, new google.maps.LatLng(o.lat, o.lng));
      
   });
}


function getOriginalCurrentPosition(){
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(
			function(position) {
				current.latLng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);         
				initLocation(current.latLng);         
				current.findPlace(current.latLng);         
			}, 
			function(error) {         
				alertOpen("확인", "현재 위치를 찾을 수 없습니다.[" + error.message + "]", true, false);         
		        current.latLng = new google.maps.LatLng({lat: 37.5665675, lng: 126.976396});
		        initLocation(current.latLng);         
		        current.map.setCenter(current.latLng);
		        current.findPlace(current.latLng);
		      },
	      { timeout: 10000 });
   } else {
      alertOpen("확인", "위치 서비스를 사용할 수 없습니다.", true, false);   
   }
}

function getDeviceMyLocation(){
	bridge.getMyLocation(function(position){
		position = JSON.parse(position);
		current.latLng = new google.maps.LatLng(position.latitude, position.longitude);         
		initLocation(current.latLng);         
		current.findPlace(current.latLng);    
	});	
}

/*
 */

 function getCurrentPosition2(){
	bridge.checkPermission(appInfo.permission.ACCESS_FINE_LOCATION, function(result){
		result = JSON.parse(result);
		if (result.permission == appInfo.permissionResult.PERMITTEED) {
			getDeviceMyLocation();
		}else {
			bridge.requestPermission(appInfo.permission.ACCESS_FINE_LOCATION, function(result){
				result = JSON.parse(result);
				if (result.permission == appInfo.permissionResult.PERMITTEED) {
					getDeviceMyLocation();
				}else {
					 alertOpen("확인", result.permissionName + " 권한을 허용하셔야 해당 기능을 사용할 수  있습니다.", true, false, null, null);
				}
			});
		}
	});
}

function getCurrentPosition() {
	
	if (appInfo.access == "APP") {
		if(current.secure == 'false'){
			getCurrentPosition2();
		}else {
			getOriginalCurrentPosition();
		}
	}else {
		getOriginalCurrentPosition();
	}
}

function setMapCenter(seq, latLng) {
   
   $.each(current.markers,function(i,o){
      
      o.setIcon(i==seq?'/resources/images/marker_on.png':'/resources/images/marker_of.png');
      o.labelContent=i==seq?o.labelContent.split('class="store_point"').join('class="store_point store_spot"'):o.labelContent.split('store_spot').join("");
      o.setZIndex(i==seq?3:1);
      o.labelStyle = { "z-index": (i==seq?3:1) };  
   });
   current.marker= current.markers[seq];
   current.map.setCenter(latLng);
}

function searchMap() {
         
   var request = {
       query: $("#text_address").val(),
       fields: ['photos', 'formatted_address', 'name', 'rating', 'opening_hours', 'geometry'],
   };   
   
   current.request.location=current.map.getCenter();
   current.service = new google.maps.places.PlacesService(current.map);   
   current.service.findPlaceFromQuery(request, function(results, status) {
      
      if (status == google.maps.places.PlacesServiceStatus.OK) {
         
         
         if(results.length>0){
            current.latLng = results[0].geometry.location;   
            current.map.setCenter(current.latLng);
            initLocation(current.latLng);  
            //current.findPlace(current.latLng);   
         }
         
      } else {
         alertOpen("확인", "검색된 결과가 없습니다.", true, false);   
         }
      return false;
   });
}
</script>

</head>
<!-- header end -->
<!-- body begin -->
<body class="p_rpmap">   
   <input type="hidden" value="4"/>
   <!-- nav -->
   <jsp:include page="../common/topper.jsp" />
   <!-- nav -->
      <h4>내 주변 가맹점</h4>
   </header> 
   <!-- content begin -->   
   <section>
      <div class="rpmap_wrap">      
      <div class="rpmap noshop" id="map_canvas"></div>
<!-- <div class="store_point" style="top: 103px; left: 160px;"><i class="fas fa-sort-down"></i>아고라</div>
<div class="store_point" style="top: 126px; left: 101px;"><i class="fas fa-sort-down"></i>포마토</div>
<div class="store_point" style="top: 108px; left: 238px;"><i class="fas fa-sort-down"></i>리턴포인트</div>
 -->      
 <!-- <div class="store_point store_spot"><i class="fas fa-sort-down"></i>리턴포인트</div> --><!-- class에 store_spot 추가시 선택된 스토어가 보여짐 -->
<!-- 지도 들어가는곳  -->   <!-- class에 nolist 추가시 높이가 리스트가 없는 사이즈로 조절됩니다-->
<!-- 선택되지 않은 포인트  --><!-- <i class="fas fa-map-marker-alt point_on"></i>    -->
<!-- 선택된 포인트  -->     <!-- <i class="fas fa-circle point_off"></i> -->
<!-- 내위치 포인트  -->     <!-- <i class="fas fa-map-pin point_me"></i> -->
<!-- 선택된 상점 정보  -->   <!-- <div class="point_box_wrap"><div class="point_box"><strong>A </strong><span class="name">교대곱창</span> <span class="cate">흑돼지 삼겹살 신선한</span></div></div> -->
         
         <div class="rpmap_list" id="rpmap_list">
            <div id="rpmapListWrap" >
               <div class="searchAreaWrap" style="display:none;">                  
                  <ul class="areaList" id="areaList"></ul>
               </div>   
               <div class="myplace">
                  <i class="fas fa-map-marker-alt"></i>
                  <a class="ellp"><input id="text_address" type="text" class="form-control" placeholder="ex)강남역, 시청역, 김포한강로 ..."></a>
                  <i class="fas fa-search" onclick="searchMap()"></i>
               </div>
               <ul class="storelist_area" >
                  
               </ul>   
            </div>
         </div>
      </div>
   </section>
   <!-- content end -->
</div> 
</body>
<!-- body end -->
</html>