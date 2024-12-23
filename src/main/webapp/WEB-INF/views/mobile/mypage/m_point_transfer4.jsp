<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="modal fade m_point_transfer" id="point_transfer4" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title"><spring:message code="label.mswitchPoints"/></h4>
			</div>
			<form name="Frm2">
				<div class="modal-body">
					<div class="listmember"><strong><span class="node nd1"><spring:message code="label.magency"/></span>R-POINT</strong></div>
					<div class="listpoint"><strong><small>P</small>&nbsp;<span><fmt:formatNumber value="${model.myGreenPointMap.agancyPoint}" pattern="###,###,###,###"/></span></strong></div>
					<div class="pointinput">
						<input type="number" placeholder="<spring:message code="label.mrpointTransformEnter"/>" id="point4" name="point4" onblur="changeAttribute('point4', 1 'point_transfer4');"/>			
						<button type="button" id="thousandwon4"><i class="fa fa-plus-circle"></i>1,000</button>
						<button type="button" id="tenthousandwon4"><i class="fa fa-plus-circle"></i>10,000</button>
						<button type="button" id="fiftythousandwon4"><i class="fa fa-plus-circle"></i>50,000</button>
						<button type="button" id="onehundredthousandwon4"><i class="fa fa-plus-circle"></i>100,000</button>				
					</div>
					<ul class="pointinfo">
						<li>- <spring:message code="label.mtotalGPointsConvertedToRPointAre"/> <fmt:formatNumber value="${model.myGreenPointSumInfo.greenPointAmountSum}" type="number"/><spring:message code="label.is"/></li>
						<li>- <spring:message code="label.mgpointMagencySwitchToRPoint"/> <fmt:formatNumber value="${model.myGreenPointMap.agancyPoint}" type="number"/><spring:message code="label.is"/></li>
						<li id="policypointli"><!-- - 20,000 이상의 GPoint만 전환 가능합니다. --></li>
					</ul>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-submit"  onclick="pointTransaction('4', '${model.myGreenPointMap.agancyPoint}', '${model.myGreenPointMap.agancy}', '${model.myGreenPointMap.agancyPointNo}', 'point_transfer4');"><spring:message code="label.mswitchPoints"/></button>
				</div>
			</form>
		</div>
	</div>
</div>
