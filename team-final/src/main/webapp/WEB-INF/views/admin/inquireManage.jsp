<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/admin/book.css" rel="stylesheet" type="text/css"
	media="all" />

</head>
<body>
	<jsp:include page="/WEB-INF/views/include/menu.jsp" />
	<div id="wrapper">
		<jsp:include page="/WEB-INF/views/include/admin-menu.jsp" />
		<div class="col-md-10 col-sm-10 col-xs-12">
			<div class="tab-box">
				<ul class="nav nav-tabs">
					<li class="active"><a href="#home" data-toggle="tab">문의/건의사항</a></li>
					<li><a href="#tab1" data-toggle="tab">오류신고</a></li>
				</ul>

				<div class="tab-content">
					<div class="tab-pane active" id="home">
						<div class="book-reservation">
							<h3>문의/건의사항</h3>
							<table class="table4">
								<thead style="text-align: center;">
									<tr>
										<td id="br-li">번호</td>
										<td>제목</td>
										<td>작성자</td>
										<td>작성일자</td>
										<td>답변상태</td>
									</tr>
								</thead>
								<tbody style="text-align: center; cursor:pointer" class="inquireList">
									<tr>
										<td>1</td>
										<td>도서명</td>
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
							<div id="inquireBlock" class="text-center">
								<ul class="pagination" id="bsh">
									<li class="page-item"><a class="page-link" href="#">이전</a></li>
									<li class="page-item"><a class="page-link" href="#">1</a></li>
									<li class="page-item"><a class="page-link" href="#">2</a></li>
									<li class="page-item"><a class="page-link" href="#">3</a></li>
									<li class="page-item"><a class="page-link" href="#">4</a></li>
									<li class="page-item"><a class="page-link" href="#">5</a></li>
									<li class="page-item"><a class="page-link" href="#">다음</a></li>
								</ul>
							</div>
						</div>
					</div>
					<div class="tab-pane" id="tab1">
						<div class="book-loan-status">
							<h3>오류신고</h3>
							<table class="table3">
								<thead style="text-align: center;">
									<tr>
										<td id="br-li">번호</td>
										<td>제목</td>
										<td>작성자</td>
										<td>작성일자</td>
										<td>답변상태</td>
									</tr>
								</thead>
								<tbody style="text-align: center; cursor:pointer" class="errorList">
									<tr>
										<td>1</td>
										<td>도서명</td>
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
							<div class="text-center">
								<ul id="errorBlock" class="pagination" id="bsh">
									<li class="page-item"><a class="page-link" href="#">이전</a></li>
									<li class="page-item"><a class="page-link" href="#">1</a></li>
									<li class="page-item"><a class="page-link" href="#">2</a></li>
									<li class="page-item"><a class="page-link" href="#">3</a></li>
									<li class="page-item"><a class="page-link" href="#">4</a></li>
									<li class="page-item"><a class="page-link" href="#">5</a></li>
									<li class="page-item"><a class="page-link" href="#">다음</a></li>
								</ul>
							</div>
						</div>
					</div>
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

	function showInquireBlock(inquireCnt) {

		// 한 페이지에 보여지는 댓글 갯수
		var pageSize = 5;
		// 총 페이지 갯수
		var pageCount = Math.ceil(inquireCnt / pageSize);
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
	
	
	function showInquireList(inquireCnt, list) {

		var str = '';

		if (list == null || list.length == 0) {

			str += '	<tr>';
			str += '		<td colspan="5"></td>';
			str += '	</tr>';
			

			$('.inquireList').html(str); 
			return;
		}


		for (let inquire of list) {
			str += '	<tr data-num="' + inquire.num + '"> ';
			str += '		<td>'+ inquire.num +'</td>';
			str += '		<td style="width:400px; text-align: left;">'+ inquire.subject +'</td>';
			str += '		<td>'+ inquire.name +'</td>';
			str += '		<td>'+ inquire.regDate +'</td>';
			if (inquire.status == 1) {
				str += '	<td>답변 대기중</b>';	
			} else if(inquire.status == 2) {
				str += '	<td>답변완료</b>';
			} 
			str += '	</tr>';
		} // for

		$('.inquireList').html(str);

		 showInquireBlock(inquireCnt); //관리자페이지 신청목록 블록 출력하기  

	} // showInquireList() 


	function getInquireData(pageNum) {

		$.ajax({
			url: '/board/inquireList/' + pageNum ,
			method: 'GET',
			success: function (result) {
				console.log(typeof result);
				console.log("result.inquireCnt: " + result.inquireCnt);
				console.log("result:list: " + result.list)
				
				showInquireList(result.inquireCnt, result.list);
				
			},
			error: function () {
				alert('관리자 신청 리스트 가져오기 오류 발생...');
			}
		});
	} // getInquireData()
	
	var pageNum = 1;
	getInquireData(1);


	$('#inquireBlock').on('click', 'li a', function (event) {

		// a태그의 기본기능 하이퍼링크 막기
		event.preventDefault();
		
		var targetPageNum = $(this).attr('href');
		console.log('targetPageNum : ' + targetPageNum);

		if (targetPageNum == '#') {
			return;
		}
		
		pageNum = targetPageNum;

		getInquireData(pageNum);
	});

	
	$('.inquireList').on('click', 'tr', function (event) {

		var num = $(this).data('num');
		console.log("num: " + num);
		 location.href='/board/inquireContent?num='+ num; 
	});
	
	</script>
	
	<script>

	function showErrorBlock(errorCnt) {

		// 한 페이지에 보여지는 댓글 갯수
		var pageSize = 5;
		// 총 페이지 갯수
		var pageCount = Math.ceil(errorCnt / pageSize);
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

		$('#errorBlock').html(str);

	}// showInquireBlock() 
	
	function showErrorList(errorCnt, list) {

		var str = '';

		if (list == null || list.length == 0) {

			str += '	<tr>';
			str += '		<td colspan="5"></td>';
			str += '	</tr>';
			

			$('.errorList').html(str); 
			return;
		}


		for (let error of list) {
			str += '	<tr data-num="' + error.num + '"> ';
			str += '		<td>'+ error.num +'</td>';
			str += '		<td style="width:400px; text-align: left;">'+ error.subject +'</td>';
			str += '		<td>'+ error.name +'</td>';
			str += '		<td>'+ error.regDate +'</td>';
			if (error.status == 1) {
				str += '	<td>답변 대기중</b>';	
			} else if(error.status == 2) {
				str += '	<td>답변완료</b>';
			} 
			str += '	</tr>';
		} // for

		$('.errorList').html(str);

		 showErrorBlock(errorCnt); //관리자페이지 신청목록 블록 출력하기  

	} // showErrorList() 
	

	function getErrorData(pageNum) {

		$.ajax({
			url: '/board/errorList/' + pageNum ,
			method: 'GET',
			success: function (result) {
				console.log(typeof result);
				console.log("result.errorCnt: " + result.inquireCnt);
				console.log("result:list: " + result.list)
				
				showErrorList(result.inquireCnt, result.list);
				
			},
			error: function () {
				alert('관리자 신청 리스트 가져오기 오류 발생...');
			}
		});
	} // getErrorData()

	getErrorData(1);


	$('#errorBlock').on('click', 'li a', function (event) {

		// a태그의 기본기능 하이퍼링크 막기
		event.preventDefault();
		
		var targetPageNum = $(this).attr('href');
		console.log('targetPageNum : ' + targetPageNum);

		if (targetPageNum == '#') {
			return;
		}
		
		pageNum = targetPageNum;

		getErrorData(pageNum);
	});

	
	$('.errorList').on('click', 'tr', function (event) {

		var num = $(this).data('num');
		console.log("num: " + num);
		 location.href='/board/inquireContent?num='+ num; 
	});



	</script>
</body>
</html>