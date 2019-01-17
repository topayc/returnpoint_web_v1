<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="modal fade m_point_transfer" id="gpoint_gift5" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title"><spring:message code="label.pointGift"/></h4>
			</div>
			<form name="Frm2">
				<div class="modal-body">
					<div class="listmember"><span class="node nd1"><spring:message code="label.mbranch"/></span>GPoint</div>
					<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointMap.branchPoint}" pattern="###,###,###,###"/></span></div>
					<div class="pointinput">
						<div class="gift_user"><input type="text" id="redPointGiftMemberEmail3" name="redPointGiftMemberEmail3" placeholder="<spring:message code="label.mpointGiftMemberEnter"/>" ><button type="button" onclick="searchPointGiftMemberEmail('3', 'gpoint_gift5');"><spring:message code="label.msearch"/></button></div>
						<input type="hidden" name="redPointGiftMemberEmailOri3" id="redPointGiftMemberEmailOri3">
						<input type="number" placeholder="<spring:message code="label.pointGiftAmount"/>" id="point3" name="point3" onblur="changeAttribute('point3', 1, 'gpoint_gift5');"/>			
						<button type="button" id="thousandwon3"><i class="fa fa-plus-circle"></i>1,000</button>
						<button type="button" id="tenthousandwon3"><i class="fa fa-plus-circle"></i>10,000</button>
						<button type="button" id="fiftythousandwon3"><i class="fa fa-plus-circle"></i>50,000</button>
						<button type="button" id="onehundredthousandwon3"><i class="fa fa-plus-circle"></i>100,000</button>			
					</div>
					<ul class="pointinfo">
						<li>- <spring:message code="label.mmemberSumGpoint"/> <fmt:formatNumber value="${model.myGreenPointSumInfo.greenPointAmountSum}" type="number"/> <spring:message code="label.mpoints"/></li>
						<li>- <spring:message code="label.mgpointMinTransforms"/> <fmt:formatNumber value="${model.selectPolicyMap.gPointMovingMinLimit}" type="number"/> <spring:message code="label.mpoints"/></li>
						<li>- <spring:message code="label.mgpointMaxTransforms"/> <fmt:formatNumber value="${model.selectPolicyMap.gPointMovingMaxLimit}" type="number"/> <spring:message code="label.mpoints"/></li>
					</ul>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-submit"  onclick="greenPointTransaction('3', '${model.myGreenPointMap.branchPoint}', '${model.myGreenPointMap.branch}' , '${model.myGreenPointMap.branchPointNo}', 'gpoint_gift5');"><spring:message code="label.mpointGiftSend"/></button>
				</div>
			</form>
		</div>
	</div>
</div>