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
<meta http-equiv="X-UA-Compatible" content="IE=edge"><!-- 0710 ie가 edge로 맞춰지는 메타 추가 -->
<meta name="format-detection" content="telephone=no"/><!-- 0710 edge상에서 전화번호 자동인식으로 인한 메타 추가 -->
<!-- css   -->
<!-- font -->
<link rel="stylesheet" href="/resources/css/common.css">
<!-- js -->
<script src="/resources/js/lib/jquery.min.js"></script>
<script src="/resources/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/common.js"></script>
<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var pageContextlocale = '${pageContext.response.locale}';
	$("#sel1").val(pageContextlocale);
	
	var p = getParams();
	var alertView = (p["alertView"]);
	var Message  = (p["Message"]);
	var message = "";
	var title = "확인";
	if(Message =="1"){
		message = "이미 정회원 신청을 하셨습니다.";
	}else if(Message =="2"){
		message = "관리자에게 접수되었습니다.";
	}
	if(alertView =="t"){
		var alertMessageHtml = "";
		var alertTitleHtml = "";
		document.getElementById('alertView').style.display='flex';	
		alertMessageHtml += "<p>"+message+"</p>";
		$('#alertMassage').html(alertMessageHtml);
		alertTitleHtml += "<strong><i class='fas fa-info-circle'></i>"+title+"</strong>";
		$('#alertTitle').html(alertTitleHtml);
		$('#alert_ok').show();
		$('#alert_cancel').hide();
	}
	
	/* 카카오 초기화 */
	Kakao.init(appInfo.key.kakao);
});
</script>
<script type="text/javascript">

function sendKakaoLink(recomEmail){
	recomEmail = btoa(encodeURIComponent(recomEmail));
	Kakao.Link.sendDefault({
		objectType: 'feed',
		content: {
        	title: appInfo.share.title,
         	description: appInfo.share.description,
          	imageUrl: appInfo.share.imageUrl,
          	link: {
          		mobileWebUrl: appInfo.share.link.mobileUrl.join + '?re=' + recomEmail,
           		webUrl: appInfo.share.link.webUrl.join + '?re=' + recomEmail
         	 }
        },
        buttons: [
          {
             title: '회원 가입',
             link: {
           		mobileWebUrl: appInfo.share.link.mobileUrl.join + '?re=' + recomEmail,
           		webUrl: appInfo.share.link.webUrl.join + '?re=' + recomEmail
              }
           }
        ]
      });	
}

function regularMemberSubmit() {
	var f = document.Frm2;
	var m_email 	= $("#m_email").val();
	var m_name 		= $("#m_name").val();
	var m_bank		= $("#m_bank").val();
	if(m_email == "" || m_name == "" || m_bank == ""){
		//alert("이메일, 입금자, 은행정보선택 은 필수입니다.");
		alertOpen("확인", "이메일, 입금자, 은행정보선택 은 필수입니다.", true, false, null, null);
		return false;
	}
	f.target = "";
	f.action = "/member/regular_member.do";
	f.submit();
}	

function goPaymentStatusUpdate(){
	var f = document.Frm2;
	f.target = "";
	f.action = "/member/updatePaymentStatus.do";
	f.submit();
}

function goPaymentStatusUpdateAlert(){
	alertOpen("확인", "입금완료 요청이 안료되었습니다.", true, false, null, null);
	return false;
}

function recommendSms(data){
	if (appInfo.access != "APP")  {
		executeAppOrGoStore();
		return;
	}
	
	bridge.checkPermission(appInfo.permission.READ_CONTACTS, function(result){
		result = JSON.parse(result);
		if (result.permission == appInfo.permissionResult.PERMITTEED) {
			location.href = "/mypage/recommend_sms.do?r=" +data;
		}else {
			bridge.requestPermission(appInfo.permission.READ_CONTACTS, function(result){
				result = JSON.parse(result);
				if (result.permission == appInfo.permissionResult.PERMITTEED) {
					location.href = "/mypage/recommend_sms.do?r=" +data;
				}else {
					 alertOpen("확인", result.permissionName + " 권한을 허용하셔야 해당 기능을 사용할 수  있습니다.", true, false, null, null);
				}
			});
		}
	});
	
	localtion.href = "/mypage/recommend_sms.do?r=" +data;
}
</script>	
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_mypage">	

	<!-- nav -->
	<jsp:include page="/WEB-INF/views/common/topper.jsp" />
	<!-- nav -->
		<h4 class="pc">Myinfo</h4>
		<h4 class="mobile">Setting</h4>
	</header> 
	<!-- content begin -->
	<ul class="submenu pc">
	<li class="active"><a href="./mypage_myinfo.do"><spring:message code="label.myPage" /></a></li><%-- <li><a href="../mypage/mypage_uselist.do"><spring:message code="label.mypageDesc01" /></a></li> --%><li><a href="./mypage_out.do"><spring:message code="label.mypageDesc02" /></a></li></ul>
	<section class  = "pc">
		<h4><spring:message code="label.mypageDesc03" /></a> 
		<button class="btn btn-sbasic" type="button" onclick="location.href='/mypage/mypage_myinfo_confirm.do' "><spring:message code="label.mypageDesc04" /></a></button></h4>
		<hr>		
		<ul class="mypage_info">
			<li class="email"><span><spring:message code="label.joinDesc03" /></a></span> 
			<i class="fas fa-user"></i>${model.mypageMyinfo.memberEmail}</li>
			<li>
			<span>회원타입</span>
			<c:if test="${!empty model.memberTypeInfo.memberNo}">
				<p class="node nd1">회원</p>
			</c:if>
			<c:if test="${!empty model.memberTypeInfo.recommenderNo}">
				<p class="node nd2">정회원</p>
			</c:if>
			<c:if test="${!empty model.memberTypeInfo.saleManagerNo}">
				<p class="node nd3">영업관리</p>
			</c:if>	
			<c:if test="${!empty model.memberTypeInfo.affiliateNo}">
				<p class="node nd4">협력업체</p>
			</c:if>
			<c:if test="${!empty model.memberTypeInfo.agencyNo}">
				<p class="node nd5">대리점</p>
			</c:if>
			<c:if test="${!empty model.memberTypeInfo.branchNo}">	
				<p class="node nd6">지사</p>
			</c:if>
			<c:if test="${!empty model.memberTypeInfo.soleDistNo}">
				<p class="node nd7">총판</p>
			</c:if>
			</li>			
			<li><span><spring:message code="label.mypageDesc05" /></span>${model.mypageMyinfo.createTime}</li>
			<li><span><spring:message code="label.joinDesc07" /></span>${model.mypageMyinfo.memberName}</li>
			<c:if test="${!empty model.mypageMyinfo.recoMemberEmail}">
				<li><span><spring:message code="label.joinDesc08"/></span>${model.mypageMyinfo.recoMemberEmail}</li>
			</c:if> 
			<c:if test="${empty model.mypageMyinfo.recoMemberEmail}">
				<li><span><spring:message code="label.joinDesc08"/></span>-</li>
			</c:if> 
			<li><span><spring:message code="label.joinDesc09" /></span>${model.mypageMyinfo.memberPhone}</li>
		</ul>	
<!-- 		<h4>최근 카드 사용 내역</h4>
		<hr> -->
		<!-- <table class="table table-hover">
		    <thead>
		      <tr>
		        <th>카드</th>
		        <th>사용처</th>
		        <th>사용금액</th>
		        <th>사용날짜</th>
		      </tr>
		    </thead>
		    <tbody>
		      <tr>
		        <td>[BC] 국민 BC 카드</td>
		        <td>(주)식당</td>
		        <td class="text-right">23,000원</td>
		        <td class="text-center">2018.06.15</td>
		      </tr>
		      <tr>
		        <td>[BC] 국민 BC 카드</td>
		        <td>(주)식당이름이 아주 되게되게 길어요</td>
		        <td class="text-right">23,000원</td>
		        <td class="text-center">2018.06.15</td>
		      </tr>
		      <tr>
		        <td>[BC] 국민 BC 카드</td>
		        <td>(주)식당</td>
		        <td class="text-right">23,000원</td>
		        <td class="text-center">2018.06.15</td>
		      </tr>
		    </tbody>
		  </table>	 -->
		<c:if test="${model.membershipRequestPaymentStatus.paymentStatus eq 1}">
			<button class="btn btn-submit" type="button" onclick="javascript:goPaymentStatusUpdate();" >입금확인 요청</button>
		</c:if>
		<c:if test="${model.membershipRequestPaymentStatus.paymentStatus eq 6}">
			<button class="btn btn-submit" type="button" onclick="javascript:goPaymentStatusUpdateAlert();">입금확인 요청 완료</button>
		</c:if>
		<c:if test="${model.membershipRequestPaymentStatus.paymentStatus eq 2 }">
		
		</c:if>
		<c:if test="${model.membershipRequestPaymentStatus.paymentStatus ne 1 && model.membershipRequestPaymentStatus.paymentStatus ne 6 && model.membershipRequestPaymentStatus.paymentStatus ne 2}">
			<button class="btn btn-submit" type="button" data-toggle="modal" data-target="#myfullmember"><spring:message code="label.mypageDesc06" /></button>
		</c:if>
	</section>
	
		<section class  = "mobile">
		<div class="listS01">
			<div class="list_title"><i class="fas fa-user-cog"></i> 내 정보 </div>		
			<div data-toggle="collapse" data-target="#mypage_myinfo" class="list_li collapsed">회원정보보기 <span><i class="fas fa-chevron-right list_blt"></i></span></div>						
			<div id="mypage_myinfo" class="list_toggle collapse">
				<div class="member_node">
				<c:if test="${!empty model.memberTypeInfo.memberNo}">
					<p class="node nd1">회원</p>
				</c:if>
				<c:if test="${!empty model.memberTypeInfo.recommenderNo}">
					<p class="node nd2">정회원</p>
				</c:if>
				<c:if test="${!empty model.memberTypeInfo.saleManagerNo}">
					<p class="node nd3">영업관리</p>
				</c:if>	
				<c:if test="${!empty model.memberTypeInfo.affiliateNo}">
					<p class="node nd4">협력업체</p>
				</c:if>
				<c:if test="${!empty model.memberTypeInfo.agencyNo}">
					<p class="node nd5">대리점</p>
				</c:if>
				<c:if test="${!empty model.memberTypeInfo.branchNo}">	
					<p class="node nd6">지사</p>
				</c:if>
				</div> 
				<p class="email"><span><spring:message code="label.joinDesc03" /></a></span> <i class="fas fa-user"></i>${model.mypageMyinfo.memberEmail}</p>
				<p><span><spring:message code="label.mypageDesc05" /></span>${model.mypageMyinfo.createTime}</p>
				<p><span><spring:message code="label.joinDesc07" /></span>${model.mypageMyinfo.memberName}</p>
				<c:if test="${!empty model.mypageMyinfo.recoMemberEmail}">
					<p><span><spring:message code="label.joinDesc08"/></span>${model.mypageMyinfo.recoMemberEmail}</p>
				</c:if> 
				<c:if test="${empty model.mypageMyinfo.recoMemberEmail}">
					<p><span><spring:message code="label.joinDesc08"/></span>-</p>
				</c:if> 
				<p><span><spring:message code="label.joinDesc09" /></span>${model.mypageMyinfo.memberPhone}</p>
				<button class="btn btn-sbasic" type="button" onclick="location.href='/mypage/mypage_myinfo_confirm.do' "><spring:message code="label.mypageDesc04" /></button></h4>
			</div> 		
			<div class="list_li" data-toggle="modal" data-target="#myfullmember"><spring:message code="label.mypageDesc06" /><span><i class="fas fa-chevron-right" ></i></span></div>		
			<a href="./mypage_out.do"><div class="list_li"><spring:message code="label.mypageDesc02" /><span><i class="fas fa-chevron-right"></i></span></div></a>
			<div class="list_title"><i class="fas fa-bell"></i> 알림</div>
			<div class="list_li">푸시알림 받기  <div class="switch_w"><label class="switch"><input type="checkbox" checked><span class="sslider round"></span></label></div></div>
			<div data-toggle="collapse" data-target="#recommend_app" class="list_li collapsed">추천 하기  <span><i class="fas fa-chevron-right list_blt"></i></span></div>
			<div id="recommend_app" class="list_toggle collapse">
				<div>
					<p class="list_li"><a id = "recommend_sms"  onclick = "recommendSms(' ${model.mypageMyinfo.memberEmail}')" ><i class="fas fa-envelope"></i> 문자로 추천하기 </a></p>
					<p class="list_li" ><a id = "recommend_kakao" onclick = "sendKakaoLink('${model.mypageMyinfo.memberEmail}')" ><img src="/resources/images/kakao.png" /> 카카오톡으로 추천하기</a></p>
				</div> 
			</div> 				
		<!-- 	<div  class="list_li">배지알림 받기 <label class="switch"><input type="checkbox"><span class="sslider round"></span></label></div>
			<div  class="list_li">알림 수신 신청 <label class="switch"><input type="checkbox"><span class="sslider round"></span></label></div> -->
		</div>
		<a class="btn btn-submit" href="/member/logout.do"><i class="fas fa-sign-out-alt"></i><spring:message code="label.logout" /></a>
	</section>
	<!-- content end -->
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<!-- footer -->	
</div>
	<!-- privacy policy modal -->
	<jsp:include page="../company/m_privacypolicy.jsp" flush="false" />
	<!-- privacy policy modal end -->
	<!-- terms of ues modal -->
	<jsp:include page="../company/m_termsofuse.jsp" flush="false" />
	<!-- terms of ues modal end -->
	<!-- fullmember modal - 정회원신청 모달 -->
	<jsp:include page="./m_fullmember.jsp" flush="false" />
	<!-- terms of ues modal end -->
</body>
<!-- body end -->
</html>