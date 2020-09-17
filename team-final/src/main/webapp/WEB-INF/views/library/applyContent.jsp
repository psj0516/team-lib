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
<link href="/css/library/apply-content.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/menu.jsp" />
	<div id="wrapper">
		<div class="main-box" id="main-box_inq_con_li">
			<h2>도서 신청</h2>
			<hr class="inq_con_line" />
			<div class="main-box" id="main-box_inq">
					<table class="table">
						<tbody>
							<tr>
								<th>책제목</th>
								<td>
									<span>${ applyVo.bookname }</span>
								</td>
							</tr>
							<tr>
								<th>저자</th>
								<td>
									<span>${ applyVo.author }</span>
								</td>
							</tr>
							<tr>
								<th>출판사</th>
								<td>
									<span>${ applyVo.publisher }</span>
								</td>
							</tr>
							<tr>
								<th>출판년도</th>
								<td>
									<span>${ applyVo.pubYear }</span>
								</td>
							</tr>
							<tr>
								<th>신청자</th>
								<td>
									<p>${ applyVo.name }</p>
								</td>
							</tr>
							<tr>
								<th>비고</th>
								<td>
									<p>${ applyVo.content }</p>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<div class="button-box">
									<c:if test="${ not empty id and id eq 'admin' }">
										<button type="button" onclick="location.href = '/library/statusModify?num=${ applyVo.num }'">상태 수정</button>
									</c:if>
									<c:if test="${ not empty id and (id eq applyVo.id or id eq 'admin')}">
										<c:if test="${ applyVo.status eq 0 }">
											<button type="button" onclick="location.href = '/library/applyModify?num=${ applyVo.num }&pageNum=${ pageNum }'">수정</button>
											<button onclick="cancel()">취소</button>
										</c:if>
									</c:if>
										<button type="button" onClick="location.href='/library/apply?pageNum=${ pageNum }'">목록</button>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
					
					<c:if test="${applyVo.status eq 2 }">
					<div class="main-box">	
						<h2>처리 내용</h2>
						<hr style="margin-bottom:0" class="inq_con_line" />
						<table class="table">
							<tbody>
								<tr>
									<th>처리상태</th>
									<td>
										<span>선정불가</span>
									</td>
								</tr>
								<tr>
									<th>불가사유</th>
									<td>
										<span>취소(부적합)</span>
									</td>
								</tr>
								<tr>
									<th>관리자 주기사항</th>
									<td>
										<span>${ applyVo.reason }</span>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					</c:if>
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
	//글 삭제 함수
	function cancel() {
		var result = confirm('신청을 정말 취소하겠습니까?');
	
			if (result) {
				location.href = '/library/cancelApply?num=${ applyVo.num }&pageNum=${ pageNum }';
				
			} 
	} // remove()

	</script>
</body>
</html>
