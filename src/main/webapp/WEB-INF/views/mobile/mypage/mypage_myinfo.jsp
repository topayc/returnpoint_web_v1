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
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="format-detection" content="telephone=no"/>
<!-- css   -->
<!-- font -->
<link rel="stylesheet" href="/resources/css/m_common.css">
<!-- js -->
<!-- <script type="text/javascript" src="/resources/js/lib/jquery.min.js"></script> -->
<script type="text/javascript" src="/resources/js/lib/jquery-2.2.0.min.js"></script> 
<script type="text/javascript" src="/resources/js/lib/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/m_common.js"></script>
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
function changeMemberConfig(configName, value){
	bridge.getSessionValue('PREF_ALL_SESSION', function(result){
		  var userAuthToken;
		  var ajax;
		  if (!result) {
			  ajax = true;
		  }else {
			  result = JSON.parse(result)
			  userAuthToken = result.user_auth_token;
		  }
			value = value == true ? "Y": "N";
			var param = {memberConfigName : configName , value : value}
			var url = "/m/mypage/m_change_member_config.do"
				$.ajax({
					method : "get",
					url    : url,
					dataType: "json",
					data   :  param,
					
					beforeSend : function(xhr){
					     if (!userAuthToken) {
							 xhr.setRequestHeader("AJAX","true");
					     }else {
					    	 xhr.setRequestHeader("user_auth_token",userAuthToken);
					     }
					},
					
					success: function(data) {
						if (configName == "devicePush"  && value == "Y"){
							 bridge.setPushToken();
						} 
					},
					error: function (request, status, error) {
						alertOpen("확인", data.result.msg, false, true, null, null);
					}
				});
	  }); 
	

}
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
          		mobileWebUrl: appInfo.share.link.mobileUrl.join + '?recommender=' + recomEmail,
           		webUrl: appInfo.share.link.webUrl.join + '?recommender=' + recomEmail
         	 }
        },
        buttons: [
          {
             title: '회원 가입',
             link: {
           		mobileWebUrl: appInfo.share.link.mobileUrl.join + '?recommender=' + recomEmail,
           		webUrl: appInfo.share.link.webUrl.join + '?recommender=' + recomEmail
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
		if (result.permissionState == appInfo.permissionResult.PERMITTEED) {
			location.href = "/m/mypage/recommend_sms.do?recommender=" +data;
		}else {
			bridge.requestPermission(appInfo.permission.READ_CONTACTS, function(result){
				result = JSON.parse(result);
				if (result.permissionState == appInfo.permissionResult.PERMITTEED) {
					location.href = "/m/mypage/recommend_sms.do?r=" +data;
				}else {
					 alertOpen("확인", result.permissionName + " 권한을 허용하셔야 해당 기능을 사용할 수  있습니다.", true, false, null, null);
				}
			});
		}
	});
	
	//location.href = "/m/mypage/recommend_sms.do?r=" +data;
}
</script>	
</head>
<!-- header end -->
<!-- body begin -->
<body class="p_mypage">
	<!-- nav -->
	<jsp:include page="../common/topper.jsp" />
	<!-- nav -->
		<h4>설정</h4>
	</header> 
	<!-- content begin -->	
		<section>
		<div class="listS01">
			<!-- 내 정보 -->
			<div class="list_title"><i class="fas fa-user-cog"></i> &nbsp;<spring:message code="label.mypageMyInfo" /> </div>		
			<div data-toggle="collapse" data-target="#mypage_myinfo" class="list_li collapsed">
				<a><span class = "item_title"><spring:message code="label.mypageViewMemberInfo" /></span> <span><i class="fas fa-chevron-right list_blt"></i></span></a>
			</div>
			<div id="mypage_myinfo" class="list_toggle collapse" style = "margin-left : 7px;border-bottom: 1px solid #eeeeee;color:#555555;font-weight:405">
				<div class="member_node">
				<c:if test="${!empty model.memberTypeInfo.memberNo}">
					<p class="node nd1"><spring:message code="label.member" /></p>
				</c:if>
				<c:if test="${!empty model.memberTypeInfo.recommenderNo}">
					<p class="node nd2"><spring:message code="label.recommender" /></p>
				</c:if>
				<c:if test="${!empty model.memberTypeInfo.saleManagerNo}">
					<p class="node nd3"><spring:message code="label.saleManager" /></p>
				</c:if>	
				<c:if test="${!empty model.memberTypeInfo.affiliateNo}">
					<p class="node nd4"><spring:message code="label.affiliate" /></p>
				</c:if>
				<c:if test="${!empty model.memberTypeInfo.agencyNo}">
					<p class="node nd5"><spring:message code="label.agency" /></p>
				</c:if>
				<c:if test="${!empty model.memberTypeInfo.branchNo}">	
					<p class="node nd6"><spring:message code="label.branch" /></p>
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
				<p><span><spring:message code="label.country" /></span><img height="20" width="20" src= "/resources/flags/${fn:toLowerCase(model.mypageMyinfo.country)}.png"/>&nbsp;&nbsp;${fn:toLowerCase(model.mypageMyinfo.krName)}</p>
				<button class="btn btn-sbasic" type="button" onclick="location.href='/m/mypage/mypage_myinfo_confirm.do' "><spring:message code="label.mypageDesc04" /></button></h4>
			</div> 		
			
			<div class="list_li"  onclick = "movePage('./m_myMemberList.do?memberNo=${model.memberTypeInfo.memberNo}')">
				<span class = "item_title"><spring:message code="label.mypageMyMember" /></span><span><i class="fas fa-chevron-right" ></i></span>
			</div>
			
				<div class="list_li"  onclick = "movePage('/m/mypage/mypage_myinfo_confirm.do')">
				<span class = "item_title"><spring:message code="label.mypageConfirmDesc01" /></span><span><i class="fas fa-chevron-right" ></i></span>
			</div>
			
			<%-- <div class="list_li"  onclick = "movePage('./m_fullmember.do')">
				<span class = "item_title"><spring:message code="label.mypageDesc06" /></span><span><i class="fas fa-chevron-right" ></i></span>
			</div> --%>
			
			<div class="list_li" onclick = "movePage('./mypage_out.do')">
				<span class = "item_title"><spring:message code="label.mypageDesc02" /></span><span><i class="fas fa-chevron-right"></i></span>
			</div>
			
			<!-- 포인트 출금 및 은행 계좌 등록 -->
			<div class="list_title"><i class="fas fa-file-powerpoint"></i>&nbsp;<spring:message code="label.point" /></div>
			<div class="list_li"  onclick = "movePage('./m_mybank_account_list.do?memberNo=${model.memberTypeInfo.memberNo}')" >
				<span class = "item_title"><spring:message code="label.manage_bank_account" /></span><span><i class="fas fa-chevron-right" ></i></span>
			</div>
		<%-- 	<div class="list_li" onclick = "movePage('./m_rpay_use_manage.do?memberNo=${model.memberTypeInfo.memberNo}')" >
				<span class = "item_title"><spring:message code="label.rpay_use" /></span><span><i class="fas fa-chevron-right" ></i></span>
			</div> --%>
			
			<div class="list_li"  onclick = "movePage('/m/mypage/rpoint/rpoint_withdrawal.do?memberNo=${model.memberTypeInfo.memberNo}')">
				<span class ="item_title"><spring:message code="label.rpay_withdrawal" /></span><span><i class="fas fa-chevron-right" ></i></span></br>
				<span class ="item_des"><spring:message code="label.rpay_withdrawal_des" /></br></span>
			</div>

			<div class="list_li"  onclick = "movePage('./m_rpay_payment.do?memberNo=${model.memberTypeInfo.memberNo}')" >
				<span class ="item_title"><spring:message code="label.rpay_payment" /></span><i class="fas fa-chevron-right" ></i></span></br>
				<span class ="item_des"><spring:message code="label.rpay_payment_des" /></span></br>
			</div>

			<div class="list_li"  onclick = "movePage('./m_rpay_payment.do?memberNo=${model.memberTypeInfo.memberNo}')" >
				<span class ="item_title"><spring:message code="label.rpay_gift" /></span><i class="fas fa-chevron-right" ></i></span></br>
				<span class ="item_des"><spring:message code="label.rpay_gift_des" /></br></span>
			</div>
			
			<!-- 알림 설정 -->
			<div class="list_title"><i class="fas fa-bell"></i>&nbsp;<spring:message code="label.noticeService" /></div>
			<div class="list_li">
				<span class = "item_title"><spring:message code="label.pushNoti" /></span></br>
				<span class ="item_des"><spring:message code="label.pushNotiDes" /></span>
				<div class="switch_w"><label class="switch"><input onchange = "changeMemberConfig('devicePush', this.checked)" type="checkbox" <c:if test = "${model.memberConfig.devicePush == 'Y'}">checked </c:if>><span class="sslider round"></span></label></div>
			</div>
			<div class="list_li">
				<span class = "item_title"><spring:message code="label.emailNoti" /></span></br>
				<span class ="item_des"><spring:message code="label.emailDes" /></span>
				<div class="switch_w"><label class="switch"><input  onchange = "changeMemberConfig('emailReceive', this.checked)"  type="checkbox" <c:if test = "${model.memberConfig.emailReceive == 'Y'}">checked </c:if>><span class="sslider round"></span></label></div>
			</div>
			<div data-toggle="collapse" data-target="#recommend_app" class="list_li collapsed">
				<a>
					<span class = "item_title"><spring:message code="label.mypageRecommend" /></span><span><i class="fas fa-chevron-right list_blt"></i></span>
				</a>
			</div>
			<div id="recommend_app" class="list_toggle collapse">
				<div>
				<%-- 	<p class="list_li">
						<a id = "recommend_sms"  onclick = "recommendSms(' ${model.mypageMyinfo.memberEmail}')" ><i class="fas fa-envelope"></i> <spring:message code="label.mypageRecomBySms" /> </a>
					</p> --%>
					<p class="list_li" >
						<a id = "recommend_kakao" onclick = "sendKakaoLink('${model.mypageMyinfo.memberEmail}')" ><img src="/resources/images/kakao.png" /> <spring:message code="label.mypageRecomByKakao" /></a>
					</p>
				</div> 
			</div> 
			
			<!-- 언어 설정 -->
			<div class="list_title"><i class="fas fa-cog"></i>&nbsp;<spring:message code="label.topper.menu.my_page" /></div>
			<div class="list_li"  onclick = "movePage('./m_selectLanguage.do?memberNo=${model.memberTypeInfo.memberNo}')">
				<span class = "item_title"><spring:message code="label.mypageLanguage" /></span><span><i class="fas fa-chevron-right" ></i></span>
			</div>
	
			
		<%-- 	<div class="list_title"><i class="fas fa-bell"></i><spring:message code="label.point" /></div>
			<a href="./m_mybank_account_list.do?memberNo=${model.memberTypeInfo.memberNo}">
				<div class="list_li" ><spring:message code="label.manage_bank_account" /><span><i class="fas fa-chevron-right" ></i></span></div>
			</a>
			<a href="./m_point_withdrawal_list.do?memberNo=${model.memberTypeInfo.memberNo}" >
				<div class="list_li" ><spring:message code="label.point_withdraw_manage" /><span><i class="fas fa-chevron-right" ></i></span></div>
			</a>
			<a href="./m_rpay_payment.do?memberNo=${model.memberTypeInfo.memberNo}">
				<div class="list_li" ><spring:message code="label.rpay_use" /><span><i class="fas fa-chevron-right" ></i></span></div>
			</a>		 --%>	
		<%-- 	<a href="./m_withdrawl_point_form.do?memberNo=${model.memberTypeInfo.memberNo}" ><div class="list_li" ><spring:message code="label.point_withdraw" /><span><i class="fas fa-chevron-right" ></i></span></div></a> --%>
		<!-- 	<div  class="list_li">배지알림 받기 <label class="switch"><input type="checkbox"><span class="sslider round"></span></label></div>
			<div  class="list_li">알림 수신 신청 <label class="switch"><input type="checkbox"><span class="sslider round"></span></label></div> -->
		</div>
		<a class="btn btn-submit" href="/m/member/logout.do"><i class="fas fa-sign-out-alt"></i><spring:message code="label.logout" /></a>
	</section>
	<!-- content end -->
</div>	
</body>
<!-- body end -->
</html>