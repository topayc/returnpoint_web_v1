<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="modal fade" id="mymemberout" role="dialog">
    <div class="modal-dialog">         
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" id="memberOutClose">&times;</button>
          <h4 class="modal-title"><spring:message code="label.mwithdrawal"/></h4>
        </div>
        <div class="modal-body m_txtarea">
	     	  <i class="fas fa-envelope-open"></i>
	          <h3 class="modal-title"><spring:message code="label.mthankYouForUsingReturnpSoFar"/></h3>
	          <p><spring:message code="label.mtheMemberWithdrawalIsCompletedNormally"/></p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-submit" data-dismiss="modal" id="memberJoin"><spring:message code="label.msignUp"/></button>
        </div>
      </div>      
    </div>
  </div>
