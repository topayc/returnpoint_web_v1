<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="modal fade m_point_transfer" id="gpoint_gift3" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title"><spring:message code="label.pointGift"/></h4>
			</div>
			<form name="Frm2">
				<div class="modal-body">
					<div class="listmember"><span class="node nd1"><spring:message code="label.mpartners"/></span>GPoint</div>
					<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointMap.affiliatePoint}" pattern="###,###,###,###"/></span></div>
					<div class="pointinput">
						<div class="gift_user"><input type="text" id="redPointGiftMemberEmail5" name="redPointGiftMemberEmail5" placeholder="<spring:message code="label.mpointGiftMemberEnter"/>" ><button type="button" onclick="searchPointGiftMemberEmail('5', 'gpoint_gift3');"><spring:message code="label.msearch"/></button></div>
						<input type="hidden" name="redPointGiftMemberEmailOri5" id="redPointGiftMemberEmailOri5">
						<input type="number" placeholder="<spring:message code="label.pointGiftAmount"/>" id="point5" name="point5" onblur="changeAttribute('point5', 1, 'gpoint_gift3');"/>			
						<button type="button" id="thousandwon5"><i class="fa fa-plus-circle"></i>1,000</button>
						<button type="button" id="tenthousandwon5"><i class="fa fa-plus-circle"></i>10,000</button>
						<button type="button" id="fiftythousandwon5"><i class="fa fa-plus-circle"></i>50,000</button>
						<button type="button" id="onehundredthousandwon5"><i class="fa fa-plus-circle"></i>100,000</button>				
					</div>
					<ul class="pointinfo">
						<li>- <spring:message code="label.mmemberSumGpoint"/> <fmt:formatNumber value="${model.myGreenPointSumInfo.greenPointAmountSum}" type="number"/> <spring:message code="label.mpoints"/></li>
						<li>- <spring:message code="label.mgpointMinTransforms"/> <fmt:formatNumber value="${model.selectPolicyMap.gPointMovingMinLimit}" type="number"/> <spring:message code="label.mpoints"/></li>
						<li>- <spring:message code="label.mgpointMaxTransforms"/> <fmt:formatNumber value="${model.selectPolicyMap.gPointMovingMaxLimit}" type="number"/> <spring:message code="label.mpoints"/></li>
					</ul>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-submit"  onclick="greenPointTransaction('5', '${model.myGreenPointMap.affiliatePoint}', '${model.myGreenPointMap.affiliate}', '${model.myGreenPointMap.affiliatePointNo}', 'gpoint_gift3');"><spring:message code="label.mpointGiftSend"/></button>
				</div>
			</form>
		</div>
	</div>
</div>