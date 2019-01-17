<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<div class="modal fade" id="mjoincomplete" role="dialog">
	<div class="modal-dialog">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" id="joincompleteclose">&times;</button>
				<h4 class="modal-title">
					<spring:message code="label.mcompletedMembership" />
				</h4>
			</div>
			<div class="modal-body m_txtarea">
				<i class="fas fa-envelope-open"></i>
				<h3 class="modal-title">
					<spring:message code="label.msignUpIsComplete" />
				</h3>
			<%-- 	<p>
					<spring:message code="label.mpleaseVerifyYourEmail" />
					<br />
					<spring:message code="label.mloginAndPointViewsAreAvailable" />
				</p> --%>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-submit" id="joincompletelogin">
					<spring:message code="label.login" />
				</button>
			</div>
		</div>
	</div>
</div>