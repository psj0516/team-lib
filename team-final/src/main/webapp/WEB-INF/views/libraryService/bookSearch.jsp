<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="javatime" uri="http://sargue.net/jsptags/time"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/library/search.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/menu.jsp" />
	<div id="wrapper">
		<jsp:include page="/WEB-INF/views/include/lib-menu.jsp" />
		<div class="col-md-10 col-sm-10 col-xs-12">
			<form action="/libraryService/bookList" method="get">
				<div class="b_search_bar">
					<select name="category" class="b_category" style="text-align-last: center">
						<option value="allSearch" ${ pageDto.category eq 'allSearch' ? 'selected' : '' }>통합검색</option>
						<option value="bookname" ${ pageDto.category eq 'bookName' ? 'selected' : '' }>도서명</option>
						<option value="publisher" ${ pageDto.category eq 'publisher' ? 'selected' : '' }>출판사</option>
						<option value="author" ${ pageDto.category eq 'author' ? 'selected' : '' }>저자</option>
					</select>
					<input type="text" name="search" value="${ pageDto.search }" placeholder="도서 이름, 출판사, 저자를 입력하세요."></input>
					<button type="submit">검색</button>
				</div>
			</form>
			<div class="main-box" id="main-box_b_sch">
				<!-- 검색시 책 정보 나오는 곳 -->
				<div class="book-info">
					<h4>검색결과 : ${requestScope.pageDto.totalCount}</h4>
					<table class="books-box">
						<!-- 책 한권 정보 시작 -->
						<c:choose>
							<c:when test="${ pageDto.totalCount gt 0 }">
								<c:forEach var="book" items="${bookList}">
									<tr>
										<td rowspan="2" class="thumb last-row">
											<img onclick="location.href='/libraryService/searchContent?pageNum=${pageNum}&bookCode=${book.bookCode}'" alt="책 썸네일" src="/images/main/bookimg.png">
										</td>
										<td class="book-title">
											<h4 onclick="location.href='/libraryService/searchContent?pageNum=${pageNum}&bookCode=${book.bookCode}'">
												<b class="title">${book.bookName}</b>
											</h4>
										</td>
									</tr>
									<tr class="last-row">
										<td class="book-dt">${book.author}<br>출판사 : ${book.publisher}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;출판년도 : ${book.pubYear}&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;소장도서관 : 중앙도서관<br> <br>
											<button class="infoButton" onclick="location.href='/libraryService/searchContent?pageNum=${pageNum}&bookCode=${book.bookCode}'">자세히보기</button>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="5">일치하는 도서 없음</td>
								</tr>
							</c:otherwise>
						</c:choose>
						<!-- 책 한권 정보 끝 -->
					</table>
				</div>
			</div>
			<!-- 페이지네이션 -->
			<div class="text-center">
				<ul class="pagination" id="bsh">
					<c:if test="${ pageDto.totalCount gt 0 }">
						<%-- [이전] --%>
						<li class="page-item"><a class="page-link" href="/libraryService/bookList?pageNum=1&category=${ pageDto.category }&search=${ pageDto.search }"><<</a></li>
						<li class="page-item"><c:choose>
								<c:when test="${ pageDto.startPage > pageDto.pageBlock }">
									<a class="page-link" href="/libraryService/bookList?pageNum=${ pageDto.startPage - pageDto.pageBlock }&category=${ pageDto.category }&search=${ pageDto.search }">이전</a>
								</c:when>
								<c:otherwise>
									<a class="page-link disabled" href="#">이전</a>
								</c:otherwise>
							</c:choose></li>
						<%-- 페이지블록 내에서의 시작페이지부터 끝페이지까지 번호출력 --%>
						<c:forEach var="i" begin="${ pageDto.startPage }" end="${ pageDto.endPage }" step="1">
							<li class="${ pageNum == i ? 'active' : '' }"><a class="page-link" href="/libraryService/bookList?pageNum=${ i }&category=${ pageDto.category }&search=${ pageDto.search }"> ${ i } </a></li>
						</c:forEach>
						<%-- [다음] --%>
						<li class="page-item"><c:choose>
								<c:when test="${ pageDto.endPage < pageDto.pageCount }">
									<a class="page-link" href="/libraryService/bookList?pageNum=${ pageDto.startPage + pageDto.pageBlock }&category=${ pageDto.category }&search=${ pageDto.search }">다음</a>
								</c:when>
								<c:otherwise>
									<a class="page-link disabled" href="#">다음</a>
								</c:otherwise>
							</c:choose></li>
						<li class="page-item"><a class="page-link" href="/libraryService/bookList?pageNum=${ pageDto.pageCount }&category=${ pageDto.category }&search=${ pageDto.search }">>></a></li>
					</c:if>
				</ul>
			</div>
		</div>
		<!-- 검색시 책 정보 나오는 곳 -->
	</div>
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<!-- footer 끝 -->
	<script src="/script/jquery-3.5.1.js"></script>
	<script src="/script/bootstrap.js"></script>
	<script src="/script/menuActive.js"></script>
</body>
</html>
