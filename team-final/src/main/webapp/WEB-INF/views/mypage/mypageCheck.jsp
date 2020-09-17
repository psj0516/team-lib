<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/mypage/mypage.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/menu.jsp" />
	<div id="wrapper">
		<div class="col-md-5 col-sm-5 col-xs-12">
			<h2>마이페이지</h2>
			<div class="info-box">
				<form action="/mypage/infoCheck" id="memInfo" method="post" name="memInfo">
					<table class="member-check">
						<tr>
							<td colspan="2" class="align-right check-info">
								<span>&nbsp; &#42; 비밀번호를 입력해주세요.</span>
								<input type="hidden" class="input input-id" name="id" id="id" value="${ memberVo.id }" readonly >
							</td>
						</tr>
						<tr>
							<td class="align-right">
								<label for="passwd">비밀번호</label>
							</td>
							<td>
								<input type="password" class="input" name="passwd" id="passwd">
							</td>
							<td></td>
						</tr>
						<tr>
							<td colspan="2" class="align-right button-box">
								<button type="submit" class="button-custom">확인</button>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<!-- footer -->
	<script src="/script/jquery-3.5.1.js"></script>
	<script src="/script/bootstrap.js"></script>
	<script src="/script/mypage/infoUpdateCheck.js"></script>
	<script src="/script/menuActive.js"></script>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="/script/member/findAddr.js"></script>
	<script>
		$(document).ready(function() {
			var addr = '<c:out value="${ memberVo.address }"/>';
			var addrArr = addr.split(",");

			$(".postCode").attr('value', addrArr[0]);
			$(".addr").attr('value', addrArr[1]);
			$(".detailAddr").attr('value', addrArr[2]);

		})
	</script>
</body>
</html>