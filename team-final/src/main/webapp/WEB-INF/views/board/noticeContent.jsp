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
			<div class="main-box" id="main-box_con_l">
				<a class="b_n_con">공지사항</a><span class="b_con_title">${noticeVo.subject }</span>
				<hr class="con_line1">
				<div class="con_info_area">
					<ul class="con_info_list">
						<li class="con_info_item"><span class="info_tittle">작성자: </span><span class="info_date">${noticeVo.writer }</span></li>
						<li class="con_info_item"><span class="info_tittle">|&nbsp&nbsp등록일: </span><span class="info_date">${noticeVo.regDate }</span></li>
						<li class="con_info_item"><span class="info_tittle">|&nbsp&nbsp조회수: </span><span class="info_hits">${noticeVo.readcount }</span></li>
					</ul>
				</div>
				<hr class="con_line2">
				<div class="board_contents">
					<div class="contens_c">
						${noticeVo.content }
					</div>
				</div>
				<hr class="con_line3">
				<div class="con_info_area">
					<ul class="con_info_list">
						<c:if test="${ noticeVo.file gt 0}">
							<li class="con_info_item"><span class="info_tittle">첨부파일: </span>
								<c:forEach var="file" items="${ noticefileList }">
										<c:choose>
											<c:when test="${ (file.filename).substring((file.filename).lastIndexOf('.')+1) eq 'jpg'}">
												<img class="jpg" src="/images/jpg.gif">
											</c:when>
											<c:when test="${ (file.filename).substring((file.filename).lastIndexOf('.')+1) eq 'png'}">
												<img class="jpg" src="/images/png.gif">
											</c:when>
											<c:when test="${ (file.filename).substring((file.filename).lastIndexOf('.')+1) eq 'hwp'}">
												<img class="jpg" src="/images/hwp.gif">
											</c:when>
											<c:when test="${ (file.filename).substring((file.filename).lastIndexOf('.')+1) eq 'pdf'}">
												<img class="jpg" src="/images/pdf.gif">
											</c:when>
											<c:when test="${ (file.filename).substring((file.filename).lastIndexOf('.')+1) eq 'bmp'}">
												<img class="jpg" src="/images/bmp.gif">
											</c:when>
										</c:choose>
										<a href="/notice/download?uuid=${ file.uuid }">
											${ file.filename }&nbsp
										</a>
								</c:forEach>
							</li>
						</c:if>
					</ul>
				</div>
				<div id="con_btn" align="center">
					<c:if test="${ not empty id and id eq 'admin' }"> <!-- id만 적으면 setAttribute 순서대로  자동으로 찾는다. -->
						<button type="button" onclick="location.href='/notice/modify?pageNum=${pageNum }&num=${noticeVo.num }'">수정</button>
						<button type="button" onclick="remove()">삭제</button>
					</c:if>
					<button onclick="location.href='/notice/list'">목록</button>
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
	function remove() {
		var result = confirm('글을 정말 삭제하시겠습니까?');
		if (result) {
			location.href = '/notice/delete?num=${ noticeVo.num }&pageNum=${ pageNum }';
		} else {

		return;
			
		}

	} // remove()
	
	</script>
</body>
</html>
