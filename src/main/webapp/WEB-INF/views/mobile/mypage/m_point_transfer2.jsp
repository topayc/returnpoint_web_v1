<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="modal fade m_point_transfer" id="point_transfer2" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title"><spring:message code="label.mswitchPoints"/></h4>
			</div>
			<form name="Frm2">
				<div class="modal-body">
					<div class="listmember"><strong><span class="node nd1"><spring:message code="label.msalesManager"/></span>R-POINT</strong></div>
					<div class="listpoint"><strong><small>P</small>&nbsp;<span><fmt:formatNumber value="${model.myGreenPointMap.saleManagerPoint}" pattern="###,###,###,###"/></span></strong></div>
					<div class="pointinput">
						<input type="number" placeholder="<spring:message code="label.mrpointTransformEnter"/>" id="point6" name="point6" onblur="changeAttribute('point6', 1 'point_transfer2');"/>			
						<button type="button" id="thousandwon6"><i class="fa fa-plus-circle"></i>1,000</button>
						<button type="button" id="tenthousandwon6"><i class="fa fa-plus-circle"></i>10,000</button>
						<button type="button" id="fiftythousandwon6"><i class="fa fa-plus-circle"></i>50,000</button>
						<button type="button" id="onehundredthousandwon6"><i class="fa fa-plus-circle"></i>100,000</button>			
					</div>
					<ul class="pointinfo">
						<li>- <spring:message code="label.mtotalGPointsConvertedToRPointAre"/> <fmt:formatNumber value="${model.myGreenPointSumInfo.greenPointAmountSum}" type="number"/><spring:message code="label.is"/></li>
						<li>- <spring:message code="label.mgPointAsalesmanagerSwitchToRPoint"/> <fmt:formatNumber value="${model.myGreenPointMap.saleManagerPoint}" type="number"/><spring:message code="label.is"/></li>
						<li id="policypointli"></li>
					</ul>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-submit"  onclick="pointTransaction('6', '${model.myGreenPointMap.saleManagerPoint}', '${model.myGreenPointMap.saleManager}' , '${model.myGreenPointMap.saleManagerPointNo}', 'point_transfer2');"><spring:message code="label.mswitchPoints"/></button>
				</div>
			</form>
		</div>
	</div>
</div>
