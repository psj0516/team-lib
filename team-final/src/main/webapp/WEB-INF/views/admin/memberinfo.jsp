<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="javatime" uri="http://sargue.net/jsptags/time"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/admin/memberinfo.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/menu.jsp" />
	<div id="wrapper">
		<div class="col-md-10 col-sm-10 col-xs-12">
			<h3>회원 상세 정보</h3>
			<div class="info-box">
				<table class="info-table">
					<tr>
						<th>회원번호</th>
						<td>${ memberVo.memNum }</td>
					</tr>
					<tr>
						<th>아이디</th>
						<td>${ memberVo.id }</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>${ memberVo.name }</td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td>${ memberVo.birth }</td>
					</tr>
					<tr>
						<th>성별</th>
						<td>${ memberVo.gender}</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>${ memberVo.email }</td>
					</tr>
					<tr>
						<th>전화번호(휴대)</th>
						<td>${ memberVo.phone }</td>
					</tr>
					<tr>
						<th>전화번호(집)</th>
						<td>${ memberVo.tel }</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>
							<span id="addr"></span>
						</td>
					</tr>
				</table>
				<div class="clearfix"></div>
			</div>
			<!-- 해당 멤버가 작성한 글 -->
			<div class="mem-book-info">
				<h3>작성글</h3>
				<div class="inquiry-box">
					<table>
						<tr>
							<td onclick="#">
								<p class="subject">글제목제목</p>
								<p class="date">2020.01.01</p>
							</td>
						</tr>
						<tr>
							<td>
								<p class="subject">글제목제목</p>
								<p class="date">2020.01.01</p>
							</td>
						</tr>
						<tr>
							<td>
								<p class="subject">글제목제목</p>
								<p class="date">2020.01.01</p>
							</td>
						</tr>
						<tr>
							<td>
								<p class="subject">글제목제목</p>
								<p class="date">2020.01.01</p>
							</td>
						</tr>
						<tr>
							<td>
								<p class="subject">글제목제목</p>
								<p class="date">2020.01.01</p>
							</td>
						</tr>
					</table>
					<span class="more-info"><a href="#">더보기>></a></span>
				</div>
				<!-- 해당 멤버가 작성한 글 끝 -->
				<!-- 해당 멤버의 도서이력 -->
				<h3>대출이력</h3>
				<div class="rent-box">
					<span class="rent-info">(대출 이력은 최근 3달까지만 보여집니다.)</span>
					<table>
						<!-- 책 한권 정보 시작 -->
						<tr>
							<td rowspan="2" class="thumb last-row">
								<img alt="책 썸네일" src="/images/main/book01.jpg">
							</td>
							<td colspan="2">
								<span class="title">책 제목</span>
							</td>
						</tr>
						<tr class="last-row">
							<td>
								홍길동<br>ㅇㅇ출판사<br>발행연도
							</td>
							<td class="book-ad">
								<span class="rent-date">대출일자: 2020.09.01</span>
							</td>
						</tr>
						<!-- 책 한권 정보 끝 -->
						<tr>
							<td rowspan="2" class="thumb last-row">
								<img alt="책 썸네일" src="/images/main/book01.jpg">
							</td>
							<td colspan="2">
								<span class="title">책 제목</span>
							</td>
						</tr>
						<tr class="last-row">
							<td>
								홍길동<br>ㅇㅇ출판사<br>발행연도
							</td>
							<td class="book-ad">
								<span class="rent-date">대출일자: 2020.09.01</span>
							</td>
						</tr>
					</table>
					<span class="more-info"><a href="/admin/bookRent">더보기>></a></span>
				</div>
				<h3>관심도서</h3>
				<div class="books-box">
					<table>
						<!-- 책 한권 정보 시작 -->
						<tr>
							<td rowspan="2" class="thumb last-row">
								<img alt="책 썸네일" src="/images/main/book01.jpg">
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
								<img alt="책 썸네일" src="/images/main/book01.jpg">
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
					<span class="more-info"><a href="/admin/bookLike">더보기>></a></span>
				</div>
				<h3>예약도서</h3>
				<div class="books-box">
					<table>
						<!-- 책 한권 정보 시작 -->
						<tr>
							<td rowspan="2" class="thumb last-row">
								<img alt="책 썸네일" src="/images/main/book01.jpg">
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
					</table>
					<span class="more-info"><a href="/admin/bookRes">더보기>></a></span>
				</div>
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
	// 주소 불러올때 재편성하는 자바스크립트 
		$(document).ready(function() {
			var addr = '<c:out value="${ memberVo.address }"/>';
			var newaddr = addr.replace(/,/g, ' ');

			document.getElementById('addr').innerHTML = newaddr;

		})
	</script>
</body>
</html>