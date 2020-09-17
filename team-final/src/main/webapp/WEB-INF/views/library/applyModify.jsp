<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/board/write-form.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/menu.jsp" />
	<div id="wrapper">
		<div class="col-md-12 col-sm-10 col-xs-12">
			<h2>도서신청 수정</h2>
			<div class="main-box" id="main-box_inq">
				<form action="/library/applyModify" method="post">
					<!-- 회원정보 넘어가게 hidden 입력 -->
					<input type="hidden" name="num" value="${ applyVo.num }">
					<table class="table">
						<tbody>
							<tr>
								<th>책 제목 *</th>
								<td>
									<input type="text" class="form-control" name="bookname" value="${ applyVo.bookname }" required/>
								</td>
							</tr>
							<tr>
								<th>저자 *</th>
								<td>
									<input type="text" class="form-control" name="author" value="${ applyVo.author }" required/>
								</td>
							</tr>
							<tr>
								<th>출판사 *</th>
								<td>
									<input type="text" class="form-control" name="publisher" value="${ applyVo.publisher }" required/>
								</td>
							</tr>
							<tr>
								<th>출판년도</th>
								<td>
									<input type="text" class="form-control" name="pubYear" value="${ applyVo.pubYear }"/>
								</td>
							</tr>
							<tr>
								<th>공개 여부</th>
								<td>
									<input type="radio" id="public" name="secret" value="no" ${ applyVo.secret eq 'no' ? 'checked' : '' }>
									<label for="public"></label>공개
									<input type="radio" id="private" name="secret" value="yes" ${ applyVo.secret eq 'yes' ? 'checked' : '' }>
									<label for="private"></label>비공개
								</td>
							</tr>
							<tr>
								<th>비고</th>
								<td>
									<textarea cols="10" class="form-control" name="content">${ applyVo.content }</textarea>
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
</body>
</html>