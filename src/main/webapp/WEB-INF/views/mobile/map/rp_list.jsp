<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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
<script type="text/javascript" src="/resources/js/lib/common.js"></script>
<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyB-bv2uR929DOUO8vqMTkjLI_E6QCDofb4&libraries=places"></script>
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
	marker:null,
	markers:[],
	searchMarker:null,
	service:null,
	infowindow:null,
	request:{
		types: ['restaurant','cafe', 'bar','food'],
		/* query: ['restaurant','cafe', 'bar','food'], */
		radius:'1000',
		/* fields: ['photos', 'formatted_address', 'name', 'rating', 'opening_hours', 'geometry'], */
	},
	callback:function (results, status){
		
		if (status == google.maps.places.PlacesServiceStatus.OK || status == 100) {
			
			$("ul.storelist_area").empty();
			if (current.marker != null) current.marker.setMap(null);
			$.each(current.markers,function(i,o){
				o.setMap(null);
			});
			
			$.each(results,function(i,o){
				current.addList(o);
				createMarker(o);
			});
			$("ul.storelist_area").append('<button class="btn btn-submit" data-page="0" onclick="more(this)">+ 더보기</button>');
			$(".storelist_area li.page0").show();
			
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
		var li = $("<li/>",{"class":"page" + paging });
		var imageSec = $("<div/>",{"class":"img_area"});
		var detailSec = $("<a/>",{href:"#"});
		var img = $("<img/>",{src:(photos!=undefined && photos.length> 0 )
			?photos[0].getUrl({'maxWidth': 100, 'maxHeight': 100})
			:"https://search.pstatic.net/common/?autoRotate=true&amp;quality=95&amp;src=http%3A%2F%2Fblogfiles.naver.net%2F20160318_29%2Fcncmgm1_1458305454051BTUBK_JPEG%2FNaverBlog_20160318_215053_25.jpg%23740x555&amp;type=f82_82"});
		var detailArea = $("<div/>",{"class":"info_area"});
		var sec1 = $("<div/>",{"class":"info_tit"});
		var sec2 = $("<div/>",{"class":"info_sub ellp",text:o.referrence});
		var sec3 = $("<div/>",{"class":"info_tag ellp"});
		var sec4 = $("<div/>",{"class":"info_etc ellp"});
		
		$("<span/>",{"class":"name",text:o.name}).appendTo(sec1);
		$("<span/>",{"class":"cate",text:o.vicinity}).appendTo(sec1);
		$.each(o.types,function(i,t){
			/* 해시태그 */if(i<3) $("<span/>",{"class":"item",text:t}).appendTo(sec3);
			/* 해시태그 */else $("<span/>",{"class":"item",text:t}).appendTo(sec4);
		});
		
		sec1.appendTo(detailArea);
		sec2.appendTo(detailArea);
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
		
		$("#searchAreaWrap").css("display","none");
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
		var geocoder = new google.maps.Geocoder();
		
		geocoder.geocode({latLng:latLng}, function(results, status) {
			
			if (status == google.maps.GeocoderStatus.OK) {			
				current.request.location=current.map.getCenter();
				current.service = new google.maps.places.PlacesService(current.map);				
				current.service.nearbySearch(current.request,current.callback);
			}
		}); 
		
		/* $.ajax({
			method : "POST",
			url    : "/map/rpmapLoadAct.do",
			dataType: "json",
			data   : {
				//where 조건에 필요한 부분 알려주시면 처리할께요. 현재는 where 가 없는 전체 검색입니다.
				//nodeType = 5만 해당되서 쿼리에 포함시켰습니다.
				curLat		: latLng.lat,
				curlng		: latLng.lng,
				distance	: $("#distance").val()
			},
			success: function(data) {
				
				for(i=0; i<data.json_arr.length; i++) {
					value1 = data.json_arr[i].rpmapLoadList.컬럼명 
				}
				
				current.callback(data, "100")
				
			},
			error: function (request, status, error) {
				alert("오류발생");
				return false;
			}
		}); */
	}
};

function more(obj){
	
	var page = Number($(obj).data("page"));
	page +=1;
	$(obj).data("page",page);
	
	console.log($(obj).data("page"));
	
	$(".storelist_area li.page"+$(obj).data("page")).show();
}

/* 터치 슬라이드 */
function touchMove(event) {
	
	var y = event.touches[0].clientY;
	var winH = window.screen.height;
	var bottomY = winH - y;
	var rpmapListH = document.getElementById("rpmapListWrap").clientHeight - 80;  
	if( bottomY > 0 ){
		if( rpmapListH > bottomY ){
			document.getElementById("rpmap_list").style.bottom = bottomY + "px";		
		}else{
			document.getElementById("rpmap_list").style.bottom = rpmapListH + "px";
		}
	}else{  
		document.getElementById("rpmap_list").style.bottom = "0px";
	}	 
}
function initLocation(latlng) {
	
	var mapOptions = {
		center: latlng, 
		zoom: 15,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	};
	current.map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
	var center = current.map.getCenter();
	google.maps.event.trigger(current.map, "resize");
	
	current.searchMarker = new google.maps.Marker({
        map: current.map,
        label: "현재위치",
	    labelContent: '<i class="fas fa-circle point_me"></i>',
	    labelAnchor: new google.maps.Point(8, 34),	   
	    labelStyle: { backgroundColor: "#a6b8b8",color:"#ffffff" },
        position: latlng
    });
	
	var content = '<div class="point_box"><strong>A </strong><span class="name">현재위치</span> <span class="cate">다른지역도 검색해보세요!!</span></div>'; // 말풍선 안에 들어갈 내용
	
	// 마커를 클릭했을 때의 이벤트.
	current.infowindow = new google.maps.InfoWindow();
	google.maps.event.addListener(current.searchMarker, "click", function() {
		if(current.infowindow!=null)current.infowindow.close();
		current.infowindow.setContent(content);
		current.infowindow.open(current.map,this);
		//$(current.infowindow.content).addClass="point_box_wrap";
	});
}

function createMarker(o){
	
	var photos = o.photos;
  
	var i = current.markers.length;
	var content = '<div class="point_box" style="right:-10px;"><strong>A </strong><span class="name">'+o.name+'</span> <span class="cate">'+o.vicinity+'</span></div>'; // 말풍선 안에 들어갈 내용
	current.markers[i] = new MarkerWithLabel({
		placeId : o.place_id,
		position: o.geometry.location,
	    map: current.map,
	    draggable: false,
	    raiseOnDrag: false,	
	    labelInBackground: false,
	    icon: "/resources/images/marker.png",
	    zIndex: 1
	});
	
	current.markers[i].addListener('click', function(e) {
		current.infowindow.close();		
		current.infowindow.setContent(content);
		current.infowindow.open(current.map,this);
		setMapCenter(i, o.geometry.location);
		
	});
}

function hideAllInfoWindows(map) {
	
   current.markers.forEach(function() {
	   console.log(this);
	   this.alertClose();
  }); 
}

function getCurrentPosition() {
	
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(function(position) {
			current.latLng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);			
			initLocation(current.latLng);			
			current.findPlace(current.latLng);			
		}, function(error) {			
			alertOpen("확인", "현재 위치를 찾을 수 없습니다.[" + error.message + "]", true, false);			
			var latLng = new google.maps.LatLng({lat: 37.5665675, lng: 126.976396});
			current.map.setCenter(latLng);
			current.marker = new google.maps.Marker({
				map: current.map,
				icon: '/resources/images/marker_of.png',
				position: latLng
			});
		},{
			timeout: 10000
		});
	} else {
		alertOpen("확인", "위치 서비스를 사용할 수 없습니다.", true, false);	
	}
}

function setMapCenter(seq, latLng) {
	
	$.each(current.markers,function(i,o){
		o.setIcon(i==seq?'/resources/images/marker_on.png':'/resources/images/marker_of.png');
		o.setZIndex(i==seq?2:1);
		o.setOptions({ labelStyle: { backgroundColor: i==seq?"#00b9f1":"#a6b8b8" } });
	});
	current.marker= current.markers[seq];
	current.map.setCenter(latLng);
}

function searchMap() {
	
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(function(position) {
			var latLng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
			var geocoder = new google.maps.Geocoder();
			
			geocoder.geocode({ latLng: latLng }, function(results, status) {
				if (status == google.maps.GeocoderStatus.OK) {
					var addrs = results[3].formatted_address;
					var addr = addrs.split(" ");
					addr = addr[1].substring(0,2) + "% " + addr[2].substring(0,addr[2].length-1);
					var request = {
					    query: $("#text_address").val(),
					    fields: ['photos', 'formatted_address', 'name', 'rating', 'opening_hours', 'geometry'],
						};						
						current.service.findPlaceFromQuery(request, function(results, status) {
							console.log(status);
							if (status == google.maps.places.PlacesServiceStatus.OK) {
								$.each(results,function(i,o){
									var place = o;
									console.log(place);
									var item = $("<a/>",{text:place.name,href:"#"});
									$("#areaList").append("<li/>");
									$("#areaList li").append(item);
									item.bind("click",function(e){
										
										current.latLng = place.geometry.location;										
										current.findPlace(current.latLng);	
									});
									
									if(i==0){
										
										current.latLng = place.geometry.location;
										current.findPlace(current.latLng);	
									}
									
								});
								
								$("#searchAreaWrap").css("display",results.length > 1);
							} else {
								alertOpen("확인", "검색된 결과가 없습니다.", true, false);	
					      	}
							return false;
						});
						
					}
				})
			
			
		}, function(error) {
			alertOpen("확인",JSON.stringify(error), true, false);
			
		},{
			timeout: 5000
		});
	}
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
		<h4>Search for Store</h4>
	</header> 
	<!-- content begin -->	
	<section>
		<h4>내 주변 가맹점</h4>
		<hr>
		<div class="rpmap_wrap">		
<!-- 지도 들어가는곳  -->   <div class="rpmap" id="map_canvas"></div>
<!-- 선택되지 않은 포인트  --><!-- <i class="fas fa-map-marker-alt point_on"></i>	 -->
<!-- 선택된 포인트  -->     <!-- <i class="fas fa-circle point_off"></i> -->
<!-- 내위치 포인트  -->     <!-- <i class="fas fa-map-pin point_me"></i> -->
<!-- 선택된 상점 정보  -->   <!-- <div class="point_box_wrap"><div class="point_box"><strong>A </strong><span class="name">교대곱창</span> <span class="cate">흑돼지 삼겹살 신선한</span></div></div> -->
			<div class="rpmap_list" id="rpmap_list" ontouchmove="touchMove(event)">
				<div id="rpmapListWrap" >
					<p class="mobile"><i class="fas fa-arrow-up"></i> Store List</p>	
					<div class="searchAreaWrap" style="display:none;">
						<h3 class="search-tit">원하시는 위치를 선택해주세요</h3>
						<ul class="areaList" id="areaList"></ul>
					</div>	
					<div class="myplace">
						<i class="fas fa-map-marker-alt"></i>
						<a class="ellp"><input id="text_address" type="text" class="form-control" placeholder="ex)강남역, 시청역, 김포한강로 ..."></a>
						<i class="fas fa-search" onclick="searchMap()"></i>
					</div>
					<div class="filter_area">		
						<div class="dropdown">
							 <button class="btn btn-default dropdown-toggle" type="button" id="menu1" data-toggle="dropdown">정렬   <span class="caret"></span></button>
						    <ul class="dropdown-menu">
						    	<li><a href="#">관련도순</a></li>
						    	<li><a href="#">거리순</a></li>
						    	<li><a href="#">리뷰순</a></li>			    	
						    	<li><a href="#">평점순</a></li>
							</ul>
						</div>
						<div class="dropdown">
							 <button class="btn btn-default dropdown-toggle" type="button" id="menu1" data-toggle="dropdown">종류   <span class="caret"></span></button>
						    <ul class="dropdown-menu">
						    	<li><a href="#">한식</a></li>
						    	<li><a href="#">양식</a></li>
						    	<li><a href="#">중식</a></li>
							</ul>
						</div>  
						<div class="dropdown">
							 <button class="btn btn-default dropdown-toggle" type="button" id="menu1" data-toggle="dropdown">테마   <span class="caret"></span></button>
						    <ul class="dropdown-menu">
						    	<li><a href="#">조용한</a></li>
						    	<li><a href="#">젊고캐쥬얼한</a></li>
						    	<li><a href="#">아이와함께</a></li>
							</ul>
						</div>  
						<div class="dropdown">
							 <button class="btn btn-default dropdown-toggle" type="button" id="menu1" data-toggle="dropdown">연령 <span class="caret"></span></button>
						    <ul class="dropdown-menu">
						    	<li><a href="#">10대</a></li>
						    	<li><a href="#">20대</a></li>
						    	<li><a href="#">30대</a></li>
							</ul>
						</div>  
					</div>					
					<ul class="storelist_area">
						
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