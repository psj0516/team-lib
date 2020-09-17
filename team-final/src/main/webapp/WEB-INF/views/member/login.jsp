<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/member/login.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/menu.jsp" />
	<div id="wrapper">
		<h2>로그인</h2>
		<div class="login-box">
			<form action="/member/login" id="loginForm" method="post" name="loginForm">
				<div class="input-box">
					<div id="myAlert" class="alert fade in alert-danger hide">
						<a href="#" class="close" data-dismiss="alert"> &times; </a> <strong>경고!</strong><span id="alt"></span>
					</div>
					<table>
						<tr>
							<td class="align-right"><label for="id">아이디</label></td>
							<td><input type="text" class="input engOnly" class="id" name="id" id="id"></td>
						</tr>
						<tr>
							<td class="align-right"><label for="passwd">비밀번호</label></td>
							<td><input type="password" class="input" name="passwd" id="passwd"></td>
						</tr>
						<tr>
							<td></td>
							<td><input type="checkbox" name="keepLogin" id="keepLogin"> <label class="checkbox-label" for="keepLogin"></label><span>&nbsp;로그인 유지</span></td>
						</tr>
						<tr>
							<td colspan="2" class="align-right">
								<button type=button onclick="location.href='/member/join'">회원가입</button>
								<button type=button id="btn">로그인</button>
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
	</div>
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<!-- footer -->
	<script src="/script/jquery-3.5.1.js"></script>
	<script src="/script/bootstrap.js"></script>
	<script src="/script/member/loginCheck.js"></script>
</body>
</html>
