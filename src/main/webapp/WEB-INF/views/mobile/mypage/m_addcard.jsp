<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<script type="text/javascript">
</script>
<div class="modal fade" id="myaddcard" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">신용카드 추가</h4>
			</div>
			<form name="Frm">
				<input type="text" id="name" name="name" />
				<div class="modal-body">
					<div class="form-group">
						<label for="email">카드사</label> <input type="email"	class="form-control" id="email" placeholder="KB 국민카드">
					</div>
					<div class="form-group">
						<label for="name">카드번호</label> <input type="text" class="form-control" id="name" placeholder="8888-8888-****-****">
					</div>
					<div class="form-group">
						<label for="phone">월 / 년도</label> <input type="text" class="form-control" id="bank" placeholder="08 / 2017">
					</div>
				</div>
				<div class="modal-footer">
					<button type="button"  class="btn btn-submit" >저장</button>
				</div>
			</form>
		</div>
	</div>
</div>
