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
			<div class="main-box" id="main-box_inq">
				<h1>문의글 수정</h1>
			<form action="/board/modify" method="post" name="frm">
				<input type="hidden" name="num" value="${ boardVo.num }">
				<input type="hidden" name="pageNum" value="${ pageNum }">
				<table class="table">
								<tbody>
									<tr>
										<th>제목</th>
										<td>
										<input type="text" name="subject" class="form-control" value="${ boardVo.subject }"/></td>
									</tr>
									<tr>
										<th>공개 여부</th>
										<td>
											<input type="radio" id="public" name="secret" value="no" ${ boardVo.secret eq 'no' ? 'checked' : '' }>
											<label for="public"></label>공개
											<input type="radio" id="private" name="secret" value="yes" ${ boardVo.secret eq 'yes' ? 'checked' : '' }>
											<label for="private"></label>비공개
										</td>
									</tr>
									<tr>
										<th>내용</th>
										<td>
										<textarea cols="10" name="content" class="form-control" style="height: 200px;">${ boardVo.content }</textarea>
										</td>
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