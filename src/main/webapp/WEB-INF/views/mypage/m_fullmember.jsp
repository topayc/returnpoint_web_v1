<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="modal fade" id="myfullmember" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title"><spring:message code="label.mapplicationForFullMembership"/></h4>
			</div>
			<form name="Frm2">
				<div class="modal-body">
					<div class="form-group">
						<label for="email"><spring:message code="label.memail"/></label> <input type="email" class="form-control" id="m_email" name="m_email" value="${model.mypageMyinfo.memberEmail}" disabled>
					</div>
					<div class="form-group">
						<label for="name"><spring:message code="label.mdepositor"/></label> <input type="text" class="form-control" id="m_name" name="m_name" placeholder="홍길동">
					</div>
					<div class="form-group">
						<!-- <label for="phone">입금 할 은행명</label> <input type="text" class="form-control" id="bank" placeholder="국민은행 (000 000 0000)"> -->
							<select class="form-control" id="m_bank" name="m_bank"> 
							<c:forEach var="item" items="${model.selectCompanyBankList}" varStatus="loop">
							    <option value="${item.companyBankAccountNo}" >${item.bankName} : ${item.bankOwnerName} (${item.bankAccount})</option>
							</c:forEach>
							  </select>
					</div>
					<p class="info_red">* <spring:message code="label.mpleaseSpecifyTheActualDepositorName"/></p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-submit"  onclick="regularMemberSubmit();"><spring:message code="label.mapplicationForFullMembership"/></button>
				</div>
			</form>
		</div>
	</div>
</div>
