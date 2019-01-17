<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="modal fade" id="myfullmember" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">정회원신청</h4>
			</div>
			<form>
				<div class="modal-body">
					<div class="form-group">
						<label for="email">이메일</label> <input type="email"	class="form-control" id="email" value="guest@urturnp.com" disabled>
					</div>
					<div class="form-group">
						<label for="name">입금자</label> <input type="text" class="form-control" id="name" placeholder="홍길동">
					</div>
					<div class="form-group">
						<label for="phone">입금 할 은행명</label> <input type="text" class="form-control" id="bank" placeholder="국민은행 (000 000 0000)">
					</div>
					<p class="info_red">* 실제 입금자 성명을 적어주세요.</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-submit" data-dismiss="modal">정회원 신청</button>
				</div>
			</form>
		</div>
	</div>
</div>
