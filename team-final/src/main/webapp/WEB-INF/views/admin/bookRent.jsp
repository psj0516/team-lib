<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/mypage/book-detail.css" rel="stylesheet" type="text/css" media="all" />
<script src="https://kit.fontawesome.com/f31fb562ea.js" crossorigin="anonymous"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/menu.jsp" />
	<div id="wrapper">
		<div class="col-md-9 col-sm-12">
			<h2>대출이력</h2>
			<table class="books-box">
				<!-- 책 한권 정보 시작 -->
				<tr>
					<td rowspan="2" class="thumb last-row">
						<img alt="책 썸네일" src="/images/main/bookimg.png">
					</td>
					<td>
						<span class="title">책 제목</span>
					</td>
				</tr>
				<tr class="last-row">
					<td>
						홍길동<br>ㅇㅇ출판사<br>발행연도
					</td>
				</tr>
				<!-- 책 한권 정보 끝 -->
				<tr>
					<td rowspan="2" class="thumb last-row">
						<img alt="책 썸네일" src="/images/main/bookimg.png">
					</td>
					<td>
						<span class="title">책 제목</span>
					</td>
				</tr>
				<tr class="last-row">
					<td>
						홍길동<br>ㅇㅇ출판사<br>발행연도
					</td>
				</tr>
				<tr>
					<td rowspan="2" class="thumb last-row">
						<img alt="책 썸네일" src="/images/main/bookimg.png">
					</td>
					<td>
						<span class="title">책 제목</span>
					</td>
				</tr>
				<tr class="last-row">
					<td>
						홍길동<br>ㅇㅇ출판사<br>발행연도
					</td>
				</tr>
				<tr>
					<td rowspan="2" class="thumb last-row">
						<img alt="책 썸네일" src="/images/main/bookimg.png">
					</td>
					<td>
						<span class="title">책 제목</span>
					</td>
				</tr>
				<tr class="last-row">
					<td>
						홍길동<br>ㅇㅇ출판사<br>발행연도
					</td>
				</tr>
				<tr>
					<td rowspan="2" class="thumb last-row">
						<img alt="책 썸네일" src="/images/main/bookimg.png">
					</td>
					<td>
						<span class="title">책 제목</span>
					</td>
				</tr>
				<tr class="last-row">
					<td>
						홍길동<br>ㅇㅇ출판사<br>발행연도
					</td>
				</tr>
			</table>
			<!-- 글 페이지 번호 -->
			<div class="text-center">
				<ul class="pagination">
					<li class="page-item"><a class="page-link" href="#">이전</a></li>
					<li class="page-item"><a class="page-link" href="#">1</a></li>
					<li class="page-item"><a class="page-link" href="#">2</a></li>
					<li class="page-item"><a class="page-link" href="#">3</a></li>
					<li class="page-item"><a class="page-link" href="#">4</a></li>
					<li class="page-item"><a class="page-link" href="#">5</a></li>
					<li class="page-item"><a class="page-link" href="#">다음</a></li>
				</ul>
			</div>
			<!-- 글 페이지 번호 -->
		</div>
	</div>
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<!-- footer -->
	<script src="/script/jquery-3.5.1.js"></script>
	<script src="/script/bootstrap.js"></script>
	<script src="/script/mypage/infoUpdateCheck.js"></script>
	<script src="/script/menuActive.js"></script>
</body>
</html>