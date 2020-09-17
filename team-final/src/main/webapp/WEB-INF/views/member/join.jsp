<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/member/join.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/menu.jsp" />
	<div id="wrapper">
		<h2>회원가입</h2>
		<div class="join-box">
			<form action="/member/join" id="joinForm" method="post" name="joinForm">
				<div class="input-box">
					<div id="myAlert" class="alert fade in alert-danger hide">
						<a href="#" class="close" data-dismiss="alert"> &times; </a> <strong>경고!</strong><span id="alt"></span>
					</div>
					<table>
						<tr>
							<td class="align-right"><label for="id">아이디</label></td>
							<td><input type="text" class="input engOnly" class="id" name="id" id="id"></td>
							<td><button type="button" onclick="winopen()">ID 중복확인</button></td>
						</tr>
						<tr>
							<td class="align-right"><label for="passwd">비밀번호</label></td>
							<td><input type="password" class="input" name="passwd" id="passwd"></td>
							<td></td>
						</tr>
						<tr>
							<td class="align-right"><label for="passwd2">비밀번호 <br>확인
							</label></td>
							<td><input type="password" class="input" name="passwd2" id="passwd2"></td>
							<td><span id="passwdMessage"></span></td>
						</tr>
						<tr>
							<td class="align-right"><label for="name">이름</label></td>
							<td><input type="text" class="input" name="name" id="name"></td>
							<td></td>
						</tr>
						<tr>
							<td class="align-right"><label for="birth">생년월일</label></td>
							<td><input type="text" class="input birth" maxlength="10" name="birth" id="birth" placeholder="YYYY-MM-DD"></td>
							<td></td>
						</tr>
						<tr>
							<td class="align-right"><label>성별</label></td>
							<td><input type="radio" class="input" name="gender" id="male" value="남자" checked> <label for="male"></label>남자 <input type="radio" class="input" name="gender" id="female" value="여자"> <label for="female"></label>여자</td>
							<td></td>
						</tr>
						<tr>
							<td class="align-right"><label for="email">이메일</label></td>
							<td><input type="email" class="input" name="email" id="email"></td>
							<td></td>
						</tr>
						<tr>
							<td class="align-right"><label for="address">주소</label></td>
							<td class="address"><input type="text" class="input postCode" name="address" id="address" placeholder="우편번호" readonly> <input type="text" class="input addr" name="address" id="address" placeholder="주소" readonly></td>
						</tr>
						<tr>
							<td></td>
							<td><input type="text" class="input detailAddr" name="address" id="address" placeholder="상세주소"></td>
							<td>
								<button type="button" onclick="execDaumPostcode()">검색하기</button>
							</td>
						</tr>
						<tr>
							<td class="align-right"><label for="tel">전화번호<br>(집)
							</label></td>
							<td><input type="text" class="input telNum" maxlength="12" name="tel" id="tel"></td>
						</tr>
						<tr>
							<td class="align-right"><label for="phone">전화번호<br>(휴대)
							</label></td>
							<td><input type="text" class="input phoneNum" maxlength="13" name="phone" id="phone"></td>
						</tr>
						<tr>
							<td colspan="2" class="align-right button-box">
								<button type="button" id="btn" class="button-custom">가입하기</button>
							</td>
							<td></td>
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
	<script src="/script/member/formCheck.js"></script>
	<script src="/script/member/formTemplete.js"></script>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="/script/member/findAddr.js"></script>
</body>
</html>