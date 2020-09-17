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
		<div class="col-md-10 col-sm-10 col-xs-12">
			<div style="margin-top: 50px;" class="main-box" id="main-box_inq">
				<h1 style="color:white">문의글작성</h1>
			<form action="/board/inquireWrite" method="post" name="frm">
				<input type="hidden" name="memNum" value="${ memNum }">
				<input type="hidden" name="id" value="${ id }">
				<input type="hidden" name="name" value="${ name }">
				<table class="table">
								<tbody>
									<tr>
										<th>제목</th>
										<td><input type="text" placeholder="제목을 입력하세요. "
											name="subject" class="form-control" /></td>
									</tr>
									<tr>
										<th>분류</th>
										<td>
											<select style="width:200px" class="form-control" name="type" required>
												<option value="" disabled selected hidden>게시판을 선택해 주세요.</option>
												<option value="1">오류신고</option>
												<option value="2">문의/건의사항</option>
											</select>
										</td>
									</tr>
									<tr>
										<th>공개 여부</th>
										<td>
											<input type="radio" id="public" name="secret" value="no" checked>
											<label for="public"></label>공개
											<input type="radio" id="private" name="secret" value="yes">
											<label for="private"></label>비공개
										</td>
									</tr>
									<tr>
										<th>문의내용</th>
										<td><textarea cols="10" placeholder="내용을 입력하세요. "
												name="content" class="form-control" style="height: 200px;"></textarea></td>
									</tr>
									<tr>
										<td colspan="2">
										<input type="submit" value="등록" id="w_btn1" /> 
										<input type="reset" value="초기화" id="w_btn2" /> 
										<input type="button" value="목록보기" id="w_btn3" onclick="location.href='/board/inquire?pageBum=${pageNum}'" /></td>
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