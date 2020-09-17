<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/board/write-form.css" rel="stylesheet" type="text/css" media="all" />
<link href="/css/library/apply-content.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/menu.jsp" />
	<div id="wrapper">
		<div class="col-md-12 col-sm-10 col-xs-12">
			<h2>신청상태 수정</h2>
			<div class="main-box" id="main-box_inq">
				<form action="/library/statusModify" method="post">
					<!-- 회원정보 넘어가게 hidden 입력 -->
					<input type="hidden" name="num" value="${ applyVo.num }">
					<table class="table">
						<tbody>
							<tr>
								<th>책제목</th>
								<td>
									<span>${ applyVo.bookname }</span>
								</td>
							</tr>
							<tr>
								<th>저자</th>
								<td>
									<span>${ applyVo.author }</span>
								</td>
							</tr>
							<tr>
								<th>출판사</th>
								<td>
									<span>${ applyVo.publisher }</span>
								</td>
							</tr>
							<tr>
								<th>출판년도</th>
								<td>
									<span>${ applyVo.pubYear }</span>
								</td>
							</tr>
							<tr>
								<th>비고</th>
								<td>
									<p>${ applyVo.content }</p>
								</td>
							</tr>

							<tr>
								<th>처리상태</th>
								<td>
									<select id="status" onchange="cancel()" style="width:200px" class="form-control" name="status" required>
										<option value="0" ${ applyVo.status eq 0 ? 'selected' : '' }>신청중</option>
										<option value="1" ${ applyVo.status eq 1 ? 'selected' : '' }>처리중</option>
										<option value="2" ${ applyVo.status eq 2 ? 'selected' : '' }>취소됨</option>
										<option value="3" ${ applyVo.status eq 3 ? 'selected' : '' }>소장완료</option>
									</select>
								</td>
							</tr>
							<tr id="reason" style="display:none">
								<th>취소사유</th>
								<td>
									<textarea cols="10" class="form-control" name="reason"></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<div class="button-box">
										<button type="submit" id="w_btn1">등록</button>
										<button type="reset" id="w_btn2">초기화</button>
										<button type="button" id="w_btn3" onClick="location.href='/library/apply'">글목록</button>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
		</div>
	</div>
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<!-- footer 끝 -->
	<script src="/script/jquery-3.5.1.js"></script>
	<script src="/script/bootstrap.js"></script>
	<script src="/script/menuActive.js"></script>
	<script>

	function cancel(){

		var status = document.getElementById("status");

		var text = status.options[status.selectedIndex].text;

		if(text == "취소됨"){

			$('#reason').show();

		} else {

			$('#reason').hide();
		}
	
	}


	</script>
</body>
</html>