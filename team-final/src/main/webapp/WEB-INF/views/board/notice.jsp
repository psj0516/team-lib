<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="javatime" uri="http://sargue.net/jsptags/time" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/board/notice.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/menu.jsp" />
	<div id="wrapper">
		<jsp:include page="/WEB-INF/views/include/board-menu.jsp" />
		<div class="col-md-10 col-sm-10 col-xs-12">
			<div class="main-box" id="main-box_noti">
				<h2>공지사항</h2>
				<!-- 관리자에게 보이는 글쓰기 버튼 -->
				<c:if test="${ not empty id and id eq 'admin'}">
					<div class="notice-button-box">
						<button onclick="location.href='/notice/write?pageNum=${ pageNum }'">공지 작성</button>
					</div>
				</c:if>
				<!-- 관리자에게 보이는 글쓰기 버튼 -->
				<table id="noti_li">
					<thead style="text-align: center;  background: #efefef">
						<tr>
							<td id="br-li">번호</td>
							<td class="subject">제목</td>
							<td>작성자</td>
							<td>작성일</td>
							<td>조회수</td>
						</tr>
					</thead>
		<c:choose>
			<c:when test="${ pageDto.totalCount gt 0 }"> 
				<%--${ boardList.size() gt 0--> 불가능,  not empty boardList 는 size에서 배열요소가 0이거나 null이 아닐 경우. } --%>
				
				<c:forEach var="notice" items="${ noticeList }">
					<tr style="background: white; text-align: center;" onclick="location.href='/notice/content?num=${ notice.num }&pageNum=${ pageNum }'"> 
					 <c:choose>
						  <c:when test="${ notice.fix eq 0 }">
								<td class="col-md-1 cell-center">${ notice.num }</td>
						  </c:when>
						   <c:when test="${ notice.fix eq 1 }">
								<td class="col-md-1 cell-center"><img src="/images/ico_notice.png"></td>
						  </c:when>
					  </c:choose>
					<td style="text-align: left; padding-left: 20px;" class="left">
						<c:if test="${ notice.regDate eq date }">
							<img class="new" src="/images/ico_new.gif">
						</c:if>
						${ notice.subject }
						<c:if test="${ notice.file gt 0 }">
							<img style="width: 15px; margin-bottom: 4px" src="/images/file.png">
						</c:if>
						</td>
						<td>${ notice.writer }</td>
						<td>${ notice.regDate }</td>
						
						<td>${ notice.readcount }</td>	
					</tr>
				</c:forEach>
				
			</c:when>
		<c:otherwise>
				<tr>
					<td colspan="5">공지사항 글없음</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</table>
				<div id="table_search" class="table_search">
					<form action="/notice/list" method="get">
						<select name="category">
							<option value="contentAndSubject" ${ pageDto.category eq 'contentAndSubject' ? 'selected' : '' }>내용+제목</option>
							<option value="content" ${ pageDto.category eq 'content' ? 'selected' : '' }>내용</option>
							<option value="subject" ${ pageDto.category eq 'subject' ? 'selected' : '' }>제목</option>
							<option value="writer" ${ pageDto.category eq 'writer' ? 'selected' : '' }>작성자</option>
						</select>
						<input type="text" name="search" value="${ pageDto.search }" class="input_box">
						<button type="submit">검색</button>
					</form>
				</div>
				<div class="text-center">
					<ul class="pagination">
					<c:if test="${ pageDto.totalCount gt 0 }">
						<li class="page-item"><a class="page-link" href="/notice/list?pageNum=1&category=${pageDto.category}&search=${pageDto.search}"><<</a></li>
						<%-- [이전] --%>
						<c:choose>
							<c:when test="${ pageDto.startPage gt pageDto.pageBlock }">
								<li class="page-item"><a class="page-link" href="/notice/list?pageNum=${ pageDto.startPage - pageDto.pageBlock }&category=${pageDto.category}&search=${pageDto.search}">이전</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link">이전</a></li>
							</c:otherwise>
						</c:choose>


						<%-- 페이지블록 내에서의 시작페이지부터 끝페이지까지 번호출력 --%>
						<c:forEach var="i" begin="${ pageDto.startPage }"
							end="${ pageDto.endPage }" step="1">
								<li class="${ pageNum == i ? 'active' : '' }"><a class="page-link" href="/notice/list?pageNum=${ i }&category=${pageDto.category}&search=${pageDto.search}">${ i }</a></li>
						</c:forEach>


						<%-- [다음] --%>
						<c:choose>
							<c:when test="${ pageDto.endPage lt pageDto.pageCount }">
								<li class="page-item"><a class="page-link" href="/notice/list?pageNum=${ pageDto.startPage + pageDto.pageBlock }&category=${pageDto.category}&search=${pageDto.search}">다음</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link">다음</a></li>
							</c:otherwise>
						</c:choose>
						<li class="page-item"><a class="page-link" href="/notice/list?pageNum=${pageDto.pageCount}&category=${pageDto.category}&search=${pageDto.search}">>></a></li>
					</c:if>
					</ul>
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
</body>
</html>
