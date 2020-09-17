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
<link href="/css/board/inquire.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/menu.jsp" />
	<div id="wrapper">
		<jsp:include page="/WEB-INF/views/include/board-menu.jsp" />
		<div class="col-md-10 col-sm-10 col-xs-12">
			<div class="inq_li">
				<h2>자주 묻는 질문</h2>
			</div>
			<div id="accordion">
				<div class="panel panel-custom">
					<div class="panel-heading">
						<h4 class="panel-title">
							<a data-toggle="collapse" data-parent="#accordion" href="#q-one">Q. 도서관을 처음 이용하려고 합니다. 어떤 절차로 이용해야 하나요?</a>
						</h4>
					</div>
					<div id="q-one" class="panel-collapse collapse">
						<div class="panel-body">
							A.&nbsp;&nbsp;신분증을 지참하고 1층 이용증 발급실에서 이용자 등록(이용자 등록은 인터넷으로도 가능)및 이용증을 발급 받으신 후,<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;필기구 이외의 개인 소지품은 1층 물품보관실에 보관하시고 이용하시면 됩니다.<br> <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;또한 도서관 소장 자료는 도서관 내에서만 이용하실 수 있으며, 개인 책을 가지고 공부할 수 있는 일반열람실은 운영하지 않습니다.
						</div>
					</div>
				</div>
				<div class="panel panel-custom">
					<div class="panel-heading">
						<h4 class="panel-title">
							<a data-toggle="collapse" data-parent="#accordion" href="#q-two">Q. 희망도서 신청은 어떻게 해야 하나요?</a>
						</h4>
					</div>
					<div id="q-two" class="panel-collapse collapse">
						<div class="panel-body">
							A.&nbsp;&nbsp;자료검색에서 찾고자 하는 자료가 검색결과에 없을경우 "도서신청" 클릭을 통해 신청하실 수 있습니다.<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;신청하시고자 하는 자료명, 저자명, 출판사 등을 입력하시면 됩니다.
						</div>
					</div>
				</div>
				<div class="panel panel-custom">
					<div class="panel-heading">
						<h4 class="panel-title">
							<a data-toggle="collapse" data-parent="#accordion" href="#q-three">Q. 도서관 방문시 승용차 이용이 가능한가요?</a>
						</h4>
					</div>
					<div id="q-three" class="panel-collapse collapse">
						<div class="panel-body">
							A.&nbsp;&nbsp;도서관 방문시 승용차 이용은 가능하나, 한정된 주차공간으로 인해 만차되는 경우가 많으니 도서관 방문시 가급적 대중교통을 이용해 주시기 바랍니다.<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;주차공간이 협소하고 고유가 지속으로 경제가 어려워지고 있어 다른 공공기관들과 같이 스용차 요일제를 실시하오니 승용차 끝번호를 확인하시어 출입제한을 받는 일이 없도록 하시기 바랍니다.<br> <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;월 /1,6&nbsp;&nbsp;화/2,7&nbsp;&nbsp;수/3,8&nbsp;&nbsp;목/4,9&nbsp;&nbsp;금/5,0
						</div>
					</div>
				</div>
			</div>
			<div class="main-box" id="main-box_inq">
				<h2>문의하기</h2>
				<div id="n_btn">
					<button onclick="location.href='/board/inquireWrite'">문의글쓰기</button>
				</div>
				<table id="qna_li">
					<thead style="text-align: center;">
								<tr>
									<td id="br-li">번호</td>
									<td class="subject">제목</td>
									<td>작성자</td>
									<td>작성일</td>
								</tr>
					</thead>
					<tbody style="text-align: center;">
						<c:choose>
							<c:when test="${ pageDto.totalCount gt 0 }">
								<c:forEach var="board" items="${ boardList }">
									<tr style="background-color:white" class="content">
										<td class="boardId" style="display:none" >${ board.id }</td>
										<td class="boardSecret" style="display:none" ><b>${ board.secret }</b></td>
										<td class="boardNum col-md-1 cell-center">${ board.num }</td>
										<td style="text-align: left;" class="boardSubject col-md-8">
											<c:if test="${ board.reLev gt 0 }">
												<img src="/images/level.gif" width="${ board.reLev * 10 }" height="13">
												<img src="/images/ico_reply.gif">
											</c:if>
											<c:if test="${ board.secret eq 'yes' }">
												<img src="/images/ico_lock.gif">
											</c:if>
											<c:if test="${ board.regDate eq date }">
												<img class="new" src="/images/ico_new.gif">
											</c:if>
											${ board.subject }
										</td>
										<td class="boardName col-md-3 cell-right">${ board.name eq '도서관 관리자' ? board.name : (board.name).substring(0, 1)+= "**" }</td>
										<td class="boardTime col-md-1 cell-right">${ board.regDate }</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="5">게시판 글없음</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<div style="margin-top: 10px;" id="table_search">
					<form action="/board/inquire" method="get">
						<select name="category">
							<option value="contentAndSubject"
								${ pageDto.category eq 'contentAndSubject' ? 'selected' : '' }>내용+제목</option>
							<option value="content"
								${ pageDto.category eq 'content' ? 'selected' : '' }>내용</option>
							<option value="subject"
								${ pageDto.category eq 'subject' ? 'selected' : '' }>제목</option>
							<option value="name"
								${ pageDto.category eq 'name' ? 'selected' : '' }>작성자</option>
						</select> <input type="text" name="search" value="${ pageDto.search }"
							class="input_box">
								<button type="submit">검색</button>
					</form>
						
				</div>
				<div class="text-center">
					<ul class="pagination">
					<c:if test="${ pageDto.totalCount gt 0 }">
						<li class="page-item"><a class="page-link" href="/board/inquire?pageNum=1&category=${pageDto.category}&search=${pageDto.search}"><<</a></li>
						<%-- [이전] --%>
						<c:choose>
							<c:when test="${ pageDto.startPage gt pageDto.pageBlock }">
								<li class="page-item"><a class="page-link" href="/board/inquire?pageNum=${ pageDto.startPage - pageDto.pageBlock }&category=${pageDto.category}&search=${pageDto.search}">이전</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link">이전</a></li>
							</c:otherwise>
						</c:choose>


						<%-- 페이지블록 내에서의 시작페이지부터 끝페이지까지 번호출력 --%>
						<c:forEach var="i" begin="${ pageDto.startPage }"
							end="${ pageDto.endPage }" step="1">
								<li class="${ pageNum == i ? 'active' : '' }"><a class="page-link" href="/board/inquire?pageNum=${ i }&category=${pageDto.category}&search=${pageDto.search}">${ i }</a></li>
						</c:forEach>


						<%-- [다음] --%>
						<c:choose>
							<c:when test="${ pageDto.endPage lt pageDto.pageCount }">
								<li class="page-item"><a class="page-link" href="/board/inquire?pageNum=${ pageDto.startPage + pageDto.pageBlock }&category=${pageDto.category}&search=${pageDto.search}">다음</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link">다음</a></li>
							</c:otherwise>
						</c:choose>
						<li class="page-item"><a class="page-link" href="/board/inquire?pageNum=${pageDto.pageCount}&category=${pageDto.category}&search=${pageDto.search}">>></a></li>
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
	<script>
	$('#write').on('click',function() {
	
	
			var id = "${id}";
			var pageNum = ${ pageNum }
			console.log("세션값: " + id);
			console.log("페이지번호: " + pageNum);
			
		 
		if(id == ""){
			alert('글쓰기는 회원만 가능합니다. 로그인해주세요.');
		} else { 
			location.href='/board/write?pageNum=pageNum'
	
		}; 
	 
	})
	
	 $('.content').on('click',function() {
	
		var id = "${id}";
		var boardId = $(this).find('.boardId').text();
		var num = parseInt($(this).find('.boardNum').text());
		var pageNum = ${ pageNum }
	
	
	 	 if($(this).find('.boardSecret').text() == "yes"){
		
			console.log(pageNum);
			console.log("id: " + id);
			console.log("boardId: " + boardId);
		
		    if(id == boardId || id == "admin"){
		    	location.href='/board/inquireContent?num=' + num + '&pageNum=' + pageNum;
				
			} else { 
				alert('비밀글입니다.');
				
			}
	
			  
		} else {
	
			location.href='/board/inquireContent?num=' + num + '&pageNum=' + pageNum;
		}  
	
	 })
	</script>
</body>
</html>