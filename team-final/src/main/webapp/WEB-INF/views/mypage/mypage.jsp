<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="javatime" uri="http://sargue.net/jsptags/time" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/mypage/mypage.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/menu.jsp" />
	<div id="wrapper">
		<jsp:include page="/WEB-INF/views/include/mypage-menu.jsp" />
		<div class="col-md-10 col-sm-10 col-xs-12">
			<h2>내 정보 수정</h2>
			<div class="info-box">
				<div id="myAlert" class="alert fade in alert-danger hide">
					<a href="#" class="close" data-dismiss="alert"> &times; </a> <strong>경고!</strong><span id="alt"></span>
				</div>
				<form action="/mypage/infoUpdate" id="memInfo" method="post" name="memInfo">
					<table>
						<tr>
							<td class="align-right">
								<label for="id">아이디</label>
							</td>
							<td>
								<input type="text" class="input input-id" name="id" id="id" value="${ memberVo.id }" readonly>
							</td>
						</tr>
						<tr>
							<td class="align-right">
								<label for="passwd">비밀번호</label>
							</td>
							<td>
								<input type="password" class="input" name="passwd" id="passwd" value="${ memberVo.passwd }">
							</td>
							<td></td>
						</tr>
						<tr>
							<td class="align-right">
								<label for="passwd2">
									비밀번호 <br>확인
								</label>
							</td>
							<td>
								<input type="password" class="input" name="passwd2" id="passwd2" value="${ memberVo.passwd }">
							</td>
							<td>
								<span id="passwdMessage"></span>
							</td>
						</tr>
						<tr>
							<td class="align-right">
								<label for="name">이름</label>
							</td>
							<td>
								<input type="text" class="input" name="name" id="name" value="${ memberVo.name }">
							</td>
							<td></td>
						</tr>
						<tr>
							<td class="align-right">
								<label for="birth">생년월일</label>
							</td>
							<td>
								<input type="text" class="input birth" maxlength="10" name="birth" id="birth" placeholder="YYYY-MM-DD" value="${ memberVo.birth }">
							</td>
							<td></td>
						</tr>
						<tr>
							<td class="align-right">
								<label>성별</label>
							</td>
							<td>
								<c:choose>
									<c:when test="${ memberVo.gender eq '남자'}">
										<input type="radio" class="input" name="gender" id="male" value="남자" checked>
										<label for="male"></label>남자
										<input type="radio" class="input" name="gender" id="female" value="여자">
										<label for="female"></label>여자
								</c:when>
									<c:otherwise>
										<input type="radio" class="input" name="gender" id="male" value="남자">
										<label for="male"></label>남자
									<input type="radio" class="input" name="gender" id="female" value="여자" checked>
										<label for="female"></label>여자
								</c:otherwise>
								</c:choose>
							</td>
							<td></td>
						</tr>
						<tr>
							<td class="align-right">
								<label for="email">이메일</label>
							</td>
							<td>
								<input type="email" class="input" name="email" id="email" value="${ memberVo.email }">
							</td>
							<td></td>
						</tr>
						<tr>
							<td class="align-right">
								<label for="address">주소</label>
							</td>
							<td class="address">
								<input type="text" class="input postCode" name="address" id="address" placeholder="우편번호" value="" readonly>
								<input type="text" class="input addr" name="address" id="address" placeholder="주소" readonly>
							</td>
						</tr>
						<tr>
							<td></td>
							<td>
								<input type="text" class="input detailAddr" name="address" id="address" placeholder="상세주소">
							</td>
							<td>
								<button type="button" onclick="execDaumPostcode()">검색하기</button>
							</td>
						</tr>
						<tr>
							<td class="align-right">
								<label for="tel">
									전화번호<br>(집)
								</label>
							</td>
							<td>
								<input type="text" class="input phoneNum" maxlength="13" name="tel" id="tel" value="${ memberVo.phone }">
							</td>
						</tr>
						<tr>
							<td class="align-right">
								<label for="phone">
									전화번호<br>(휴대)
								</label>
							</td>
							<td>
								<input type="text" class="input phoneNum" maxlength="13" name="phone" id="phone" value="${ memberVo.tel }">
							</td>
						</tr>
						<tr>
							<td colspan="2" class="align-right button-box">
								<button type="button" id="btn" class="button-custom">수정하기</button>
							</td>
							<td></td>
						</tr>
					</table>
				</form>
			</div>
			<h2>내 문의</h2>
			<div class="book-loan-status">
					<table class="table3">
								<thead style="text-align: center;">
									<tr>
										<td id="br-li">번호</td>
										<td>제목</td>
										<td>작성일자</td>
										<td>답변상태</td>
									</tr>
								</thead>
								<tbody class="myInquireList" style="cursor:pointer; text-align: center;" >
									<tr>
										<td>1</td>
										<td class="subject">도서명</td>
										<td>아무개</td>
										<td>2020.09.04</td>
										<td>답변 대기중</td>
									</tr>
									<tr>
										<td>2</td>
										<td>도서명</td>
										<td>아무개</td>
										<td>2020.09.04</td>
										<td>답변 대기중</td>
									</tr>
									<tr>
										<td>3</td>
										<td>도서명</td>
										<td>아무개</td>
										<td>2020.09.04</td>
										<td>답변 대기중</td>
									</tr>
									<tr>
										<td>4</td>
										<td>도서명</td>
										<td>아무개</td>
										<td>2020.09.04</td>
										<td>답변 대기중</td>
									</tr>
									<tr>
										<td>5</td>
										<td>도서명</td>
										<td>아무개</td>
										<td>2020.09.04</td>
										<td>답변 대기중</td>
									</tr>
								</tbody>

							</table>
			</div>
			<div style=" margin-top: -30px;" id = "inquireBlock" class="text-center"></div>
			<!-- 내 신청 도서 -->
			<h2 style="margin-top:40px">희망도서 신청 목록</h2>
			<h3 style="font-size: 15px;">※ 처리상태 항목 안내</h3>
						<ul>
							<li style="font-size: 12px;">▪ <b>신청중</b>: 담당자 검토 중</li>
							<li style="font-size: 12px;">▪ <b>처리중</b> : 선정되어 주문 중이거나 입수되어 정리중</li>
							<li style="font-size: 12px;">▪ <b>취소됨</b>: 선정 제외됨 (클릭시 취소사유 확인가능)</li>
							<li style="font-size: 12px;">▪ <b>소장완료</b>: 입수되어 비치됨.</li>
						</ul>
			<div class="book-loan-status">
				<table class="table3">
							<thead style="text-align: center;">
								<tr>
									<td id="br-li">번호</td>
									<td class="subject">도서명</td>
									<td>저자</td>
									<td>신청일자</td>
									<td>처리상태</td>
								</tr>
							</thead>
							<tbody style="cursor:pointer; text-align: center" class="myApplyList">
								<tr>
									<td>1</td>
									<td>도서명</td>
									<td>아무개</td>
									<td>2020.09.04</td>
									<td>신청중</td>
								</tr>
								<tr>
									<td>2</td>
									<td>도서명</td>
									<td>아무개</td>
									<td>2020.09.04</td>
									<td>신청중</td>
								</tr>
								<tr>
									<td>3</td>
									<td>도서명</td>
									<td>아무개</td>
									<td>2020.09.04</td>
									<td>신청중</td>
								</tr>
								<tr>
									<td>4</td>
									<td>도서명</td>
									<td>아무개</td>
									<td>2020.09.04</td>
									<td>신청중</td>
								</tr>
								<tr>
									<td>5</td>
									<td>도서명</td>
									<td>아무개</td>
									<td>2020.09.04</td>
									<td>신청중</td>
								</tr>
							</tbody>

						</table>
				</div>
				<div style=" margin-top: -30px; margin-bottom: 30px;" id = "applyBlock" class="text-center"></div>
			</div>
		</div>
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<!-- footer -->
	<script src="/script/jquery-3.5.1.js"></script>
	<script src="/script/bootstrap.js"></script>
	<script src="/script/mypage/infoUpdateCheck.js"></script>
	<script src="/script/menuActive.js"></script>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="/script/member/findAddr.js"></script>
	<script>
	$( document ).ready(function() {
		var addr = '<c:out value="${ memberVo.address }"/>';
		var addrArr = addr.split(",");

		$(".postCode").attr('value', addrArr[0]);
		$(".addr").attr('value', addrArr[1]);
		$(".detailAddr").attr('value', addrArr[2]);

	})
	</script>
	
	
	
	<script>
	
	//나의 요청글 블록페이지 함수
	function showInquireBlock(myInquireCnt) {

		console.log("inquireCnt: " + myInquireCnt)

		// 한 페이지에 보여지는 댓글 갯수
		var pageSize = 5;
		// 총 페이지 갯수
		var pageCount = Math.ceil(myInquireCnt / pageSize);
		console.log("pageCount: " + typeof(pageCount))
		console.log("pageCount: " + pageCount)
		// 한개의 페이지블록 당 요소갯수
		var pageBlock = 5;


		// 페이지 블록의 시작페이지
		var startPage = (Math.floor((pageNum - 1) / pageBlock)) * pageBlock + 1;
		// 페이지 블록의 끝페이지
		var endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) {
			endPage = pageCount;
		}

		var prev = startPage > pageBlock;
		var next = endPage < pageCount;

		
		var str = '';
		
 		str += '<ul style="margin:0" class="pagination">'
 		str += '	<li class="page-item"><a class="page-link" href="'+ 1 +'"><<</a></li>';
		if (prev) {
			str += '<li class="page-item"><a class="page-link" href="' + (startPage - pageBlock) + '">이전</a></li>';
		} else {
			str += '<li class="page-item disabled"><a class="page-link" href="#">이전</a></li>';
		}
 		

		for (let i=startPage; i<=endPage; i++) {
			
			var active = (pageNum == i) ? 'active' : '';
			
			str += '<li class="' + active + '"><a class="page-link" href="'+ i +'">'+ i +'</a></li>'
			
			}

		if (next) {
			str += '<li class="page-item"><a class="page-link" href="'+ (startPage + pageBlock) +'">다음</a></li>';
		} else {
			str += '<li class="page-item disabled"><a class="page-link" href="#">다음</a></li>';
		}
		str += '	<li class="page-item"><a class="page-link" href="'+ pageCount +'">>></a></li>';
		str += '</ul>'

		$('#inquireBlock').html(str);

	}// showInquireBlock()
	
	

	//나의 요청글 목록 가져오는 함수
	function showInquireList(myInquireCnt, list) {

		console.log("myInquireCnt: " + myInquireCnt);
		console.log("list: " + list)
		
		var i = 1;
		var str = '';

		if (list == null || list.length == 0) {

			str += '	<tr>';
			str += '		<td colspan="5"></td>';
			str += '	</tr>';
			

			$('.myInquireList').html(str);
			return;
		}


		for (let inquire of list) {
			str += '	<tr data-num="' + inquire.num + '"> ';
			str += '		<td>'+ i +'</td>';
			str += '		<td style="text-align: left;" class="subject">'+ inquire.subject +'</td>';
			str += '		<td>'+ inquire.regDate +'</td>';
			if (inquire.status == 1) {
				str += '	<td>답변 대기중</b>';	
			} else if(inquire.status == 2) {
				str += '	<td>답변완료</b>';
			} 
			str += '		</td>';
			str += '	</tr>';

			i++;
		} // for

		$('.myInquireList').html(str);

		showInquireBlock(myInquireCnt); 

	} // showInquireList()



	// 요청글 정보 가져오는 함수
	function getMyInquireData(pageNum) {

		$.ajax({
			url: '/board/myList/' + pageNum ,
			method: 'GET',
			success: function (result) {
				console.log(typeof result);
				console.log("result.myInquireCnt: " + result.inquireCnt);
				console.log("result:list: " + result.list)
				
				showInquireList(result.inquireCnt, result.list);
				
			},
			error: function () {
				alert('댓글 리스트 가져오기 오류 발생...');
			}
		});
	} // getMyInquireData()
	
	var pageNum = 1;
	getMyInquireData(1);



	// 요청리스트 블록 페이지 이동 이벤트
	$('#inquireBlock').on('click', 'li a', function (event) {

		// a태그의 기본기능 하이퍼링크 막기
		event.preventDefault();
		
		var targetPageNum = $(this).attr('href');
		console.log('targetPageNum : ' + targetPageNum);

		if (targetPageNum == '#') {
			return;
		}
		
		pageNum = targetPageNum;

		getMyInquireData(pageNum);
	});

	

	// 요청글 클릭시 글내용으로 이동 이벤트
	$('.myInquireList').on('click', 'tr', function (event) {

		var num = $(this).data('num');
		location.href='/board/inquireContent?num='+ num;
	});

	</script>
<!-- -------------------------------------------------------------------------------------------------------- -->	
 	
 	<script>

 	//나의 신청글 블록페이지 함수
	function showApplyBlock(myApplyCnt) {

		console.log("applyCnt: " + myApplyCnt)

		// 한 페이지에 보여지는 댓글 갯수
		var pageSize = 5;
		// 총 페이지 갯수
		var pageCount = Math.ceil(myApplyCnt / pageSize);
		console.log("pageCount2: " + typeof(pageCount))
		console.log("pageCount2: " + pageCount)
		

		// 한개의 페이지블록 당 요소갯수
		var pageBlock = 5;

		// 페이지 블록의 시작페이지
		var startPage = (Math.floor((pageNum - 1) / pageBlock)) * pageBlock + 1;
		// 페이지 블록의 끝페이지
		var endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) {
			endPage = pageCount;
		}

		var prev = startPage > pageBlock;
		var next = endPage < pageCount;

		
		var str = '';
		
 		str += '<ul style="margin:0" class="pagination">'
 		str += '	<li class="page-item"><a class="page-link" href="'+ 1 +'"><<</a></li>';
		if (prev) {
			str += '<li class="page-item"><a class="page-link" href="' + (startPage - pageBlock) + '">이전</a></li>';
		} else {
			str += '<li class="page-item disabled"><a class="page-link" href="#">이전</a></li>';
		}
 		

		for (let i=startPage; i<=endPage; i++) {

			var active = (pageNum == i) ? 'active' : '';
			
			str += '<li class="' + active + '"><a class="page-link" href="'+ i +'">'+ i +'</a></li>'
			
			}
		
		if (next) {
			str += '<li class="page-item"><a class="page-link" href="'+ (startPage + pageBlock) +'">다음</a></li>';
		} else {
			str += '<li class="page-item disabled"><a class="page-link" href="#">다음</a></li>';
		}
		str += '	<li class="page-item"><a class="page-link" href="'+ pageCount +'">>></a></li>';
		str += '</ul>'

		$('#applyBlock').html(str);

	}// showInquireBlock() 
	

 	 //나의 신청글 목록 가져오는 함수
	function showApplyList(myApplyCnt, list) {

		var i = 1;
		var str = '';

		if (list == null || list.length == 0) {

			str += '	<tr>';
			str += '		<td colspan="5"></td>';
			str += '	</tr>';
			

			$('.myApplyList').html(str); 
			return;
		}

		for (let apply of list) {
			str += '	<tr data-num="' + apply.num + '"> ';
			str += '		<td>'+ i +'</td>';
			str += '		<td style="text-align: left;" class="subject">'+ apply.bookname +'</td>';
			str += '		<td>'+ apply.author +'</td>';
			str += '		<td>'+ apply.regDate +'</td>';
			if (apply.status == 0) {
				str += '	<td>신청중</b>';	
			} else if(apply.status == 1) {
				str += '	<td>처리중</b>';
			} else if(apply.status == 2) {
				str += '	<td>취소됨</b>';
			} else {
				str += '	<td>소장완료</b>';
			}	
			str += '		</td>';
			str += '	</tr>';

			i++;
		} // for		

		$('.myApplyList').html(str);

		showApplyBlock(myApplyCnt); //나의 요청글 블록 출력하기 


	} // showApplyList() 
	
  
	// 나의 신청글 정보 가져오는 함수
	function getMyApplyData(pageNum) {

		$.ajax({
			url: '/library/myApplyList/' + pageNum ,
			method: 'GET',
			success: function (result) {
				console.log(typeof result);
				console.log("result1: " + result.applyCnt);
				console.log(result.list)
				
				showApplyList(result.applyCnt, result.list);
				
			},
			error: function () {
				alert('댓글 리스트 가져오기 오류 발생...');
			}
		});
	} // getMyApplyData() */

	getMyApplyData(1);

	// 신청리스트 블록 페이지 이동 이벤트
	$('#applyBlock').on('click', 'li a', function (event) {

		// a태그의 기본기능 하이퍼링크 막기
		event.preventDefault();
		
		var targetPageNum = $(this).attr('href');
		console.log('targetPageNum : ' + targetPageNum);

		if (targetPageNum == '#') {
			return;
		}
		
		pageNum = targetPageNum;

		getMyApplyData(pageNum);
	});

	

	// 신청글 클릭시 글내용으로 이동 이벤트
	$('.myApplyList').on('click', 'tr', function (event) {

		var num = $(this).data('num');
		location.href='/library/applyContent?num='+ num;
	});

	
	</script>
</body>
</html>
