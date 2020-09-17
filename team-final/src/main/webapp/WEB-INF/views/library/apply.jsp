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
<link href="/css/library/library.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/menu.jsp" />
	<div id="wrapper">
		<jsp:include page="/WEB-INF/views/include/lib-menu.jsp" />
		<div class="col-md-10 col-sm-10 col-xs-12">
			<div class="b_ap_li">
				<h2>도서신청</h2>
			</div>
			<div id="accordion">
				<div class="card">
					<div class="card-header" id="b_a_noti">
						<h3>신청안내</h3>
						<ul>
							<li>▪ 홈페이지에서 자료 검색 후 소장자료가 없을때만 신청 가능</li>
							<li>▪ 신청자료 수: 1인 월 5책 이내(단, 외국서는 연 20책 이내</li>
							<li>▪ 처리기간: 신청접수 후 우선처리<br>&nbsp;※ 신청자 본인이 아닌, 타인의 ID를 이용하여 신청 시 취소될 수 있음
							</li>
						</ul>
					</div>
				</div>
				<div class="card">
					<div class="card-header" id="b_a_noti">
						<h3>신청제한자료</h3>
						<ul>
							<li>▪ 도서관에 소장 되어있는 자료</li>
							<li>▪ 각종 수험서·문제집, 초중고 학습서, 강의·교재용 자료</li>
							<li>▪ 무협·판타지·애정 소설, 게임·만화 등 각종 오락용 자료</li>
							<li>▪ 50쪽 미만 또는 내용이 거의 없는 자료, 낱장제본 도서 등 일반적인 자료의 형태(구성요소)를 갖추고 있지 않은 자료</li>
							<li>▪ 품절 또는 절판 자료, 출판 예정 도서(또는 출판 미확인 자료)</li>
							<li>▪ ISBN 정보 또는 출판정보가 부정확한 자료</li>
							<li>▪ 신청일 기준 출판한 지 5년 경과 된 외국 도서 또는 외국에서 발행된 비도서</li>
							<li>▪ 「중앙도서관 장서개발지침」에 따라 도서관 자료로 적합하지 않은 자료 <br> &nbsp;※ 신청 자료 중, 유사한 자료의 통상적인 거래가격과 상당한 차이가 나는 자료는 도서관자료 심의위원회 심의를 통하여 신청이 제한 될 수 있음 (근거: 도서관법 시행령 제13조의4 ③항)
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="main-box" id="main-box_b_ap">
				<h2 style="margin-bottom: 20px">신청하기</h2>
				<table id="apply_li">
					<thead style="text-align: center;  background: #efefef">
						<tr>
							<td id="br-li">번호</td>
							<td class="subject">도서명</td>
							<td>신청자</td>
							<td>신청일</td>
							<td>처리상태</td>
						</tr>
					</thead>
					<c:choose>
					<c:when test="${ pageDto.totalCount gt 0 }"> 
						<%--${ boardList.size() gt 0--> 불가능,  not empty boardList 는 size에서 배열요소가 0이거나 null이 아닐 경우. } --%>
						
						<c:forEach var="apply" items="${ applyList }">
							<tr style="background: white; text-align: center" class="content"> 
								<td class="applyId" style="display:none" >${ apply.id }</td>
								<td class="applySecret" style="display:none" ><b>${ apply.secret }</b></td>
								<td class="applyNum col-md-1 cell-center">${ apply.num }</td>
								<td style="padding-left:20px; text-align: left" class="left">
									<c:if test="${ apply.secret eq 'yes' }">
										<img src="/images/ico_lock.gif">
									</c:if>
									<c:if test="${ apply.regDate eq date }">
										<img class="new" src="/images/ico_new.gif">
									</c:if>
									${ apply.bookname }
								</td>
								<td class="applyName col-md-2 cell-right">${ (apply.name).substring(0, 1)+= "**" }</td>
								<td>${ apply.regDate }</td>
								<c:choose>
									<c:when test="${ apply.status eq 0 }">
										<td class="col-md-2 cell-center">신청중</td>
									</c:when>
									<c:when test="${ apply.status eq 1 }">
										<td class="col-md-2 cell-center">처리중</td>
									</c:when>
									<c:when test="${ apply.status eq 2 }">
										<td class="col-md-2 cell-center">취소됨</td>
									</c:when>
									<c:when test="${ apply.status eq 3 }">
										<td class="col-md-2 cell-center">소장완료</td>
									</c:when>
								</c:choose>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="5">신청된 글없음</td>
						</tr>
					</c:otherwise>
				</c:choose>				
				</table>
				<div class="search-box">
					<form action="/library/apply" method="get">
						<select name="category">
							<option value="bookname" ${ pageDto.category eq 'bookname' ? 'selected' : '' }>책 제목</option>
							<option value="name" ${ pageDto.category eq 'name' ? 'selected' : '' }>신청자</option>
						</select>
						<input type="text" name="search" value="${ pageDto.search }"></input>
						<button type="submit">검색</button>
					</form>
				</div>
				<div class="text-center">
					<ul class="pagination">
					<c:if test="${ pageDto.totalCount gt 0 }">
						<li class="page-item"><a class="page-link" href="/library/apply?pageNum=1&category=${pageDto.category}&search=${pageDto.search}"><<</a></li>
						<%-- [이전] --%>
						<c:choose>
							<c:when test="${ pageDto.startPage gt pageDto.pageBlock }">
								<li class="page-item"><a class="page-link" href="/library/apply?pageNum=${ pageDto.startPage - pageDto.pageBlock }&category=${pageDto.category}&search=${pageDto.search}">이전</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link">이전</a></li>
							</c:otherwise>
						</c:choose>


						<%-- 페이지블록 내에서의 시작페이지부터 끝페이지까지 번호출력 --%>
						<c:forEach var="i" begin="${ pageDto.startPage }"
							end="${ pageDto.endPage }" step="1">
								<li class="${ pageNum == i ? 'active' : '' }"><a class="page-link" href="/library/apply?pageNum=${ i }&category=${pageDto.category}&search=${pageDto.search}">${ i }</a></li>
						</c:forEach>


						<%-- [다음] --%>
						<c:choose>
							<c:when test="${ pageDto.endPage lt pageDto.pageCount }">
								<li class="page-item"><a class="page-link" href="/library/apply?pageNum=${ pageDto.startPage + pageDto.pageBlock }&category=${pageDto.category}&search=${pageDto.search}">다음</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link">다음</a></li>
							</c:otherwise>
						</c:choose>
						<li class="page-item"><a class="page-link" href="/library/apply?pageNum=${pageDto.pageCount}&category=${pageDto.category}&search=${pageDto.search}">>></a></li>
					</c:if>
					</ul>
				</div>
				<div id="b_a_btn">
					<button id="write" onclick="location.href='/library/applyWrite'">신청하기</button>
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
			alert('도서신청은 회원만 가능합니다. 로그인해주세요.');
		} else { 
			location.href='/library/applyWrite'
		}; 
	 
	})
	
	 $('.content').on('click',function() {
	
		var id = "${id}";
		var applyId = $(this).find('.applyId').text();
		var num = parseInt($(this).find('.applyNum').text());
		var pageNum = ${ pageNum }
	
	
	 	 if($(this).find('.applySecret').text() == "yes"){
		
			console.log(pageNum);
			console.log("id: " + id);
		
		    if(id == applyId || id == "admin"){
		    	location.href='/library/applyContent?num=' + num + '&pageNum=' + pageNum;
				
			} else { 
				alert('비밀글입니다.');
			}
	
			  
		} else {
	
			location.href='/library/applyContent?num=' + num + '&pageNum=' + pageNum;
		}  
	
	 })
	</script>
</body>
</html>
