<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="modal fade m_point_transfer" id="point_transfer1" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title"><spring:message code="label.mswitchPoints"/></h4>
			</div>
			<form name="Frm2">
				<div class="modal-body">
					<div class="listmember"><span class="node nd1"><spring:message code="label.mfullMembership"/></span>GPoint</div>
					<div class="listpoint"><small>P</small><span><fmt:formatNumber value="${model.myGreenPointMap.recommenderPoint}" pattern="###,###,###,###"/></span></div>
					<div class="pointinput">
						<input type="number" placeholder="<spring:message code="label.mrpointTransformEnter"/>" id="point2" name="point2" onblur="changeAttribute('point2', 1 'point_transfer1');"/>		
						<button type="button" id="thousandwon2"><i class="fa fa-plus-circle"></i>1,000</button>
						<button type="button" id="tenthousandwon2"><i class="fa fa-plus-circle"></i>10,000</button>
						<button type="button" id="fiftythousandwon2"><i class="fa fa-plus-circle"></i>50,000</button>
						<button type="button" id="onehundredthousandwon2"><i class="fa fa-plus-circle"></i>100,000</button>
					</div>
					<ul class="pointinfo">
						<li>- <spring:message code="label.mtotalGPointsConvertedToRPointAre"/> <fmt:formatNumber value="${model.myGreenPointSumInfo.greenPointAmountSum}" type="number"/><spring:message code="label.is"/></li>
						<li>- <spring:message code="label.mfullMembershipSwitchToRPointGPoint"/> <fmt:formatNumber value="${model.myGreenPointMap.recommenderPoint}" type="number"/><spring:message code="label.is"/></li>
						<li id="policypointli"></li>
					</ul>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-submit"  onclick="pointTransaction('2', '${model.myGreenPointMap.recommenderPoint}', '${model.myGreenPointMap.recommender}', '${model.myGreenPointMap.recommenderPointNo}', 'point_transfer1');"><spring:message code="label.mswitchPoints"/></button>
				</div>
			</form>
		</div>
	</div>
</div>
