<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="javatime" uri="http://sargue.net/jsptags/time"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/admin/member.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/menu.jsp" />
	<div id="wrapper">
		<jsp:include page="/WEB-INF/views/include/admin-menu.jsp" />
		<div class="col-md-10 col-sm-10 col-xs-12">
			<h3>회원 목록</h3>
			<table class="member-table">
				<tr>
					<th class="col-md-1">회원번호</th>
					<th class="col-md-3">이름</th>
					<th class="col-md-2">생년월일</th>
					<th class="col-md-2">휴대전화</th>
					<th class="col-md-2">가입일자</th>
					<th class="col-md-2">상세정보</th>
				</tr>
				<c:choose>
					<c:when test="${ pageDto.count gt 0 }">
						<c:forEach var="member" items="${ memberList }">
							<tr>
								<td class="col-md-1">${ member.memNum }</td>
								<td class="col-md-3">${ member.name }</td>
								<td class="col-md-2">${ member.birth }</td>
								<td class="col-md-2">${ member.phone }</td>
								<td class="col-md-2">
									<javatime:format value="${ member.regDate }" pattern="yyyy.MM.dd" />
								</td>
								<td class="col-md-2">
									<a href="/admin/memberinfo?memNum=${member.memNum}">상세정보</a>
								</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="6">회원 정보 없음</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</table>
			<div class="text-center">
				<ul class="pagination">
					<c:if test="${pageDto.count gt 0}">
						<c:if test="${pageDto.startPage gt pageDto.pageBlock }">
							<li class="page-item"><a class="page-link" href="/admin/memberManage?pageNum=${ pageDto.startPage - pageDto.pageBlock }">이전</a></li>
						</c:if>
						<c:forEach var="i" begin="${ pageDto.startPage }" end="${ pageDto.endPage }" step="1">
							<li class="page-item"><a class="page-link" href="/admin/memberManage?pageNum=${ i }"> <c:choose>
										<c:when test="${ i eq pageNum }">
											<span style="font-weight: bold;">${ i }</span>
										</c:when>
										<c:otherwise>
									${ i }
								</c:otherwise>
									</c:choose>
							</a></li>
						</c:forEach>
						<c:if test="${ pageDto.endPage gt pageDto.count }">
							<li class="page-item"><a href="/admin/memberManage?pageNum=${ pageDto.startPage + pageDto.pageBlock }">다음</a></li>
						</c:if>
					</c:if>
				</ul>
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