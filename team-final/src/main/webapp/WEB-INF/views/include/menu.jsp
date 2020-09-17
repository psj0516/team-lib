<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${ not empty cookie.id.value }">
	<c:set var="id" value="${ cookie.id.value }" scope="session" />
</c:if>
<div id="header-wrapper">
	<div id="header">
		<nav class="navbar navbar-default" role="navigation">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
				<div id="logo" onclick="location.href='/'">
					<h1>
						<i class="fas fa-book-reader"></i><span>&nbsp;중앙도서관</span>
					</h1>
				</div>
			</div>
			<div class="collapse navbar-collapse navbar-ex1-collapse">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="/board/intro">도서관 소개</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">도서관 이용</a>
						<ul class="dropdown-menu">
							<li><a href="/library/seatRes">좌석예약</a></li>
							<li><a href="/libraryService/bookList">도서조회</a></li>
							<li><a href="/library/apply">도서신청</a></li>
						</ul></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">열린 공간</a>
						<ul class="dropdown-menu">
							<li><a href="/notice/list">공지사항</a></li>
							<li><a href="/board/inquire">문의하기</a></li>
						</ul></li>
					<c:choose>
						<c:when test="${ not empty sessionScope.id and sessionScope.id eq 'admin' }">
							<li><a href="/admin/bookManage">관리페이지</a></li>
							<li><a href="/member/logout">로그아웃</a></li>
						</c:when>
						<c:when test="${ not empty sessionScope.id }">
							<li><a href="/mypage/mypageCheck">마이페이지</a></li>
							<li><a href="/member/logout">로그아웃</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="/member/login">로그인 </a></li>
							<li><a href="/member/join">회원가입</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</nav>
	</div>
</div>