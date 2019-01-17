<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="modal fade m_point_transfer" id="rpoint_gift" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">포인트 선물</h4>
			</div>
			<form name="Frm2">
				<div class="modal-body">
					<div class="listmember">RPoint</div>
					<div class="listpoint"><small>P</small><span>1,000,000</span></div>
					<div class="pointinput">
						<div class="gift_user"><input type="text" placeholder="선물 받을 회원을 입력하세요." ><button>조회</button></div>
						<input type="number" placeholder="RPoint로 전환할 포인트를 입력해 주세요">			
						<button><i class="fa fa-plus-circle"></i>1,000</button>
						<button><i class="fa fa-plus-circle"></i>10,000</button>
						<button><i class="fa fa-plus-circle"></i>50,000</button>
						<button><i class="fa fa-plus-circle"></i>100,000</button>			
					</div>
					<ul class="pointinfo">
						<li>- 회원의 총 RPoint는 1,000,000Point입니다..</li>
						<li>- 선물 가능한 RPoint 최소 단위는 30,000Point입니다.</li>
						<li>- 선물 가능한 RPoint 최소 단위는 10,000,000Point입니다.</li>
					</ul>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-submit" data-dismiss="modal" onclick="regularMemberSubmit();">포인트 선물하기</button>
				</div>
			</form>
		</div>
	</div>
</div>
