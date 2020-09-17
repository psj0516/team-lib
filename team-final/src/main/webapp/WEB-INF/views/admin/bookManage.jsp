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
					<li class="active"><a href="#home" data-toggle="tab">도서 관리</a></li>
					<li><a href="#tab1" data-toggle="tab">대출 현황</a></li>
					<li><a href="#tab2" data-toggle="tab">예약 현황</a></li>
					<li><a href="#tab3" data-toggle="tab">신청 현황</a></li>
					<li><a href="#tab4" data-toggle="tab">희망도서 현황</a></li>
					<li><a href="#tab5" data-toggle="tab">월별 대출</a></li>
				</ul>

				<div class="tab-content">
					<div class="tab-pane active" id="home">
						<h3 class="mw-title">도서 등록</h3>
						<div class="m-book-box" id="m-book-box_write">
							<form action="/libraryService/addBook" method="post" name="frm">
								<!-- 회원정보 넘어가게 hidden 입력 -->
								<input type="hidden" value="#">
								<table class="table">
									<tbody>
										<tr>
											<th>도서명</th>
											<td><input type="text" name="bookName" class="form-control" required />
											</td>
										</tr>
										<tr>
											<th>저자</th>
											<td><input type="text" name="author" class="form-control" required /></td>
										</tr>
										<tr>
											<th>출판사</th>
											<td><input type="text" name="publisher" class="form-control" required /></td>
										</tr>
										<tr>
											<th>출판년도</th>
											<td><input type="text" name="pubYear" class="form-control" required /></td>
										</tr>
										<tr>
											<th>책설명</th>
											<td><textarea cols="10" name="description" class="form-control" required></textarea>
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<div class="m-button-box">
													<button type="button" onclick="addBook()" id="mb_btn1">등록</button>
													<button type="reset" id="mb_btn2">초기화</button>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</form>
						</div>

						<h3>도서 추가/삭제</h3>
						<div class="book-update-delete">
							<div class="mw_search_bar">
								<input name="search" type="text" placeholder="도서 이름, 출판사, 저자를 입력하세요."></input>
								<button type="button" onclick="searchBook()">검색</button>
							</div>
							<!-- 검색시 책 정보 나오는 곳 -->
							<div class="book-info">
								<table class="books-box bookList">
									<!-- 책 한권 정보 시작 -->
								</table>
								<!-- 페이지네이션 -->
								<div style="margin-top:20px" class="text-center" id="mw-page"></div>
							</div>
						</div>

						<div class="book-reservation">
							<h3>사용중지 도서 현황</h3>
							<table class="table4">
								<thead style="text-align: center;">
									<tr>
										<td id="br-li">번호</td>
										<td>도서번호</td>
										<td>시리얼번호</td>
										<td>도서명</td>
										<td>대출자</td>
										<td>대출일자</td>
										<td>반납일자</td>
										<td>도서상태</td>
									</tr>
								</thead>
								<tbody style="text-align: center;" class="notAvailableList">
									<tr>
										<td>1</td>
										<td>1</td>
										<td>도서명</td>
										<td>아무개</td>
										<td>2020.09.04</td>
										<td>2020.09.04</td>
										<td>도서 미반납</td>
									</tr>
									<tr>
										<td>1</td>
										<td>1</td>
										<td>도서명</td>
										<td>아무개</td>
										<td>2020.09.04</td>
										<td>2020.09.04</td>
										<td>사용중지</td>
									</tr>
									<tr>
										<td>1</td>
										<td>1</td>
										<td>도서명</td>
										<td>아무개</td>
										<td>2020.09.04</td>
										<td>2020.09.04</td>
										<td>도서 미반납</td>
									</tr>
								</tbody>
							</table>
							<div id="notAvailableBlock" class="text-center"></div>
						</div>
					</div>
					<div class="tab-pane" id="tab1">

						<div class="book-loan-status">
							<h3>대출 현황</h3>
							<table class="table3">
								<thead style="text-align: center;">
									<tr>
										<td id="bl-li">번호</td>
										<td>도서번호</td>
										<td>도서명</td>
										<td>대출자</td>
										<td>대출일자</td>
										<td>반납예정</td>
										<td>기능</td>
									</tr>
								</thead>
								<tbody style="text-align: center;" class="rentList">
									<tr>
										<td>1</td>
										<td>1</td>
										<td>도서명</td>
										<td>아무개</td>
										<td>2020.09.04</td>
										<td>2020.09.11</td>
										<td><button type="button" onclick="return()">도서반납</button></td>
									</tr>
									<tr>
										<td>2</td>
										<td>2</td>
										<td>도서명</td>
										<td>아무개</td>
										<td>2020.09.04</td>
										<td>2020.09.11</td>
										<td><button type="button" onclick="return()">도서반납</button></td>
									</tr>
									<tr>
										<td>3</td>
										<td>3</td>
										<td>도서명</td>
										<td>아무개</td>
										<td>2020.09.04</td>
										<td>2020.09.11</td>
										<td><button type="button" onclick="return()">도서반납</button></td>
									</tr>
									<tr>
										<td>4</td>
										<td>4</td>
										<td>도서명</td>
										<td>아무개</td>
										<td>2020.09.04</td>
										<td>2020.09.11</td>
										<td><button type="button" onclick="return()">도서반납</button></td>
									</tr>
									<tr>
										<td>5</td>
										<td>5</td>
										<td>도서명</td>
										<td>아무개</td>
										<td>2020.09.04</td>
										<td>2020.09.11</td>
										<td><button type="button" onclick="return()">도서반납</button></td>
									</tr>
								</tbody>

							</table>
							<div id="rentBookBlock" class="text-center"></div>
						</div>

					</div>
					
					
					
					<div class="tab-pane" id="tab2">
						<div class="book-reservation">
							<h3>예약 현황</h3>
							<table class="table4">
								<thead style="text-align: center;">
									<tr>
										<td id="br-li">번호</td>
										<td id="br-li">도서번호</td>
										<td>도서명</td>
										<td>예약자</td>
										<td>예약일자</td>
										<td>종료일자</td>
										<td>우선순위</td>
										<td>예약상태</td>
									</tr>
								</thead>
								<tbody style="text-align: center;" class="reserveList">
									<tr>
										<td>1</td>
										<td>1</td>
										<td>도서명</td>
										<td>아무개</td>
										<td>2020.09.04</td>
										<td>2020.09.04</td>
										<td>1순위</td>
										<td>예약대기중<td>
									</tr>
									<tr>
										<td>1</td>
										<td>1</td>
										<td>도서명</td>
										<td>아무개</td>
										<td>2020.09.04</td>
										<td>2020.09.04</td>
										<td>1순위</td>
										<td>예약대기중<td>
									</tr>
									<tr>
										<td>1</td>
										<td>1</td>
										<td>도서명</td>
										<td>아무개</td>
										<td>2020.09.04</td>
										<td>2020.09.04</td>
										<td>1순위</td>
										<td>예약대기중<td>
									</tr>
									<tr>
										<td>1</td>
										<td>1</td>
										<td>도서명</td>
										<td>아무개</td>
										<td>2020.09.04</td>
										<td>2020.09.04</td>
										<td>1순위</td>
										<td>예약대기중<td>
									</tr>
									<tr>
										<td>1</td>
										<td>1</td>
										<td>도서명</td>
										<td>아무개</td>
										<td>2020.09.04</td>
										<td>2020.09.04</td>
										<td>1순위</td>
										<td>예약대기중<td>
									</tr>
								</tbody>
							</table>
							<div id="reserveBookBlock" class="text-center"></div>
						</div>
					</div>
					<div class="tab-pane" id="tab3">
						<div class="book-reservation">
							<h3>신청 현황</h3>
							<table class="table4">
								<thead style="text-align: center;">
									<tr>
										<td id="br-li">번호</td>
										<td>도서번호</td>
										<td>도서명</td>
										<td>신청자</td>
										<td>신청일자</td>
										<td>기능</td>
									</tr>
								</thead>
								<tbody style="text-align: center;" class="bookApplyList">
									<tr>
										<td>1</td>
										<td>1</td>
										<td>도서명</td>
										<td>아무개</td>
										<td>2020.09.04</td>
										<td><button type="button" onclick="rent()">대출</button></td>
									</tr>
									<tr>
										<td>2</td>
										<td>2</td>
										<td>도서명</td>
										<td>아무개</td>
										<td>2020.09.04</td>
										<td><button type="button" onclick="rent()">대출</button></td>
									</tr>
									<tr>
										<td>3</td>
										<td>3</td>
										<td>도서명</td>
										<td>아무개</td>
										<td>2020.09.04</td>
										<td><button type="button" onclick="rent()">대출</button></td>
									</tr>
									<tr>
										<td>4</td>
										<td>4</td>
										<td>도서명</td>
										<td>아무개</td>
										<td>2020.09.04</td>
										<td><button type="button" onclick="rent()">대출</button></td>
									</tr>
									<tr>
										<td>5</td>
										<td>5</td>
										<td>도서명</td>
										<td>아무개</td>
										<td>2020.09.04</td>
										<td><button type="button" onclick="rent()">대출</button></td>
									</tr>
								</tbody>
							</table>
							<div id="applyBookBlock" class="text-center"></div>
						</div>
					</div>
					<div class="tab-pane" id="tab4">
						<div class="book-reservation">
							<h3>희망도서 현황</h3>
							<table class="table4">
								<thead style="text-align: center;">
									<tr>
										<td id="br-li">번호</td>
										<td>도서명</td>
										<td>신청자</td>
										<td>예약일자</td>
										<td>처리상태</td>
									</tr>
								</thead>
								<tbody style="cursor:pointer; text-align: center" class="applyList">
									<tr>
										<td>1</td>
										<td>도서명</td>
										<td>아무개</td>
										<td>2020.09.04</td>
										<td>신청 중</td>
									</tr>
									<tr>
										<td>2</td>
										<td>도서명</td>
										<td>아무개</td>
										<td>2020.09.04</td>
										<td>신청 중</td>
									</tr>
									<tr>
										<td>3</td>
										<td>도서명</td>
										<td>아무개</td>
										<td>2020.09.04</td>
										<td>신청 중</td>
									</tr>
									<tr>
										<td>4</td>
										<td>도서명</td>
										<td>아무개</td>
										<td>2020.09.04</td>
										<td>신청 중</td>
									</tr>
									<tr>
										<td>5</td>
										<td>도서명</td>
										<td>아무개</td>
										<td>2020.09.04</td>
										<td>신청 중</td>
									</tr>
								</tbody>
							</table>
							<div id="applyBlock" class="text-center"></div>
						</div>
					</div>
					<div class="tab-pane" id="tab5">
						<div class="book-reservation">
							<h3>월별 대출</h3>
							<table class="table4">
								<thead style="text-align: center;">
									<tr>
										<td id="br-li">번호</td>
										<td>도서번호</td>
										<td>시리얼 번호</td>
										<td>도서명</td>
										<td>대출자</td>
										<td>대출일자</td>
										<td>반납일자</td>
									</tr>
								</thead>
								<tbody style="cursor:pointer; text-align: center" class="rentRecord">
									<tr>
										<td>1</td>
										<td>1</td>
										<td>도서명</td>
										<td>2020.09.04</td>
										<td>2020.09.04</td>
									</tr>
									<tr>
										<td>1</td>
										<td>1</td>
										<td>도서명</td>
										<td>2020.09.04</td>
										<td>2020.09.04</td>
									</tr>
									<tr>
										<td>1</td>
										<td>1</td>
										<td>도서명</td>
										<td>2020.09.04</td>
										<td>2020.09.04</td>
									</tr>
									<tr>
										<td>1</td>
										<td>1</td>
										<td>도서명</td>
										<td>2020.09.04</td>
										<td>2020.09.04</td>
									</tr>
									<tr>
										<td>1</td>
										<td>1</td>
										<td>도서명</td>
										<td>2020.09.04</td>
										<td>2020.09.04</td>
									</tr>
								</tbody>
							</table>
							<div id="rentRecordBlock" class="text-center"></div>
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

	function useStop(serialNum){

		var result = confirm('해당도서의 사용을 중지하시겠습니까?');
		
			if(result){
			$.ajax({
				url: '/libraryService/useStop/' + serialNum ,
				method: 'GET',
				success: function (result) {
	
					alert(result);
					getApplyBookData(pageNum)
					
				}
			});
		}
	}

	function available(serialNum){

		var result = confirm('해당도서가 다시 사용 가능하도록 하시겠습니까?');
		
			if(result){
			$.ajax({
				url: '/libraryService/available/' + serialNum ,
				method: 'GET',
				success: function (result) {
	
					alert(result);
					getApplyBookData(pageNum)
					
				}
			});
		}
	}

	/* 도서 축가함수 */
	function addBook() {
		
		var result = confirm('도서를 추가하시겠습니까?');

		if(result){

			document.frm.submit();
		}

	}

	/* 도서 상세페이지로 이동 */
	function bookContent(bookcode) {

		location.href='/libraryService/searchContent?bookCode='+ bookcode +'';
	}

	</script>
	<script>

	//관리자 페이지 사용중지 리스트 블록페이지 함수
	function shownotAvailableBlock(bookSubCnt) {

		console.log("inquireCnt: " + bookSubCnt)

		// 한 페이지에 보여지는 댓글 갯수
		var pageSize = 5;
		// 총 페이지 갯수
		var pageCount = Math.ceil(bookSubCnt / pageSize);
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

		$('#notAvailableBlock').html(str);

	}// showBookBlock()

	 //관리자 페이지 사용중지 리스트 가져오는 함수
	function showNotAvailableList(bookSubCnt, list) {

		var str = '';
		var i = 1;

		if (list == null || list.length == 0) {

			str += '	<tr>';
			str += '		<td colspan="6"></td>';
			str += '	</tr>';
			

			$('.notAvailableList').html(str); 
			return;
		}

		for (let stop of list) {
			if(stop.status == 2){
				str += '	<tr>';
				str += '		<td>'+ i +'</td>';
				str += '		<td>'+ stop.bookcode +'</td>';
				str += '		<td>'+ stop.serialNum +'</td>';
				str += '		<td style="width:400px; text-align: left;">'+ stop.bookname +'</td>';
				str += '		<td>'+ stop.renter +'</td>';
				str += '		<td>'+ stop.rentStart +'</td>';
				str += '		<td>'+ stop.rentEnd +'</td>';
				str += '		<td>도서 미반납</td>';
				str += '	</tr>';
			} else {
				str += '	<tr>';
				str += '		<td>'+ i +'</td>';
				str += '		<td>'+ stop.bookcode +'</td>';
				str += '		<td>'+ stop.serialNum +'</td>';
				str += '		<td style="width:400px; text-align: left;">'+ stop.bookname +'</td>';
				str += '		<td></td>';
				str += '		<td></td>';
				str += '		<td></td>';
				str += '		<td>사용중지</td>';
				str += '	</tr>';
			} 
			
			i++
		} // for

		$('.notAvailableList').html(str);

		shownotAvailableBlock(bookSubCnt); //관리자페이지 신청목록 블록 출력하기   

	} // showApplyList() 
	

	// 사용불가 도서 리스트 가져오는 함수
	function getnotAvailableList(pageNum) {

		$.ajax({
			url: '/libraryService/getnotAvailableList/' + pageNum ,
			method: 'GET',
			success: function (result) {
				console.log(typeof result);
				console.log("result.bookSubCnt: " + result.bookSubCnt);
				console.log("result:list: " + result.list)
				
				showNotAvailableList(result.bookSubCnt, result.list);
				
			},
			error: function () {
				alert('관리자 신청 리스트 가져오기 오류 발생...');
			}
		});
	} // getMyInquireData()
	
	getnotAvailableList(1);

	// 신청리스트 블록 페이지 이동 이벤트
	$('#notAvailableBlock').on('click', 'li a', function (event) {

		// a태그의 기본기능 하이퍼링크 막기
		event.preventDefault();
		
		var targetPageNum = $(this).attr('href');
		console.log('targetPageNum : ' + targetPageNum);

		if (targetPageNum == '#') {
			return;
		}
		
		pageNum = targetPageNum;

		getnotAvailableList(pageNum);
	});


	</script>
	
	<!-- 월별대출 가져오기 -->
	<script>
		
	//관리자 페이지 책리스트 블록페이지 함수
	function showRentRecordBlock(rentRecordCnt) {

		console.log("inquireCnt: " + rentRecordCnt)

		// 한 페이지에 보여지는 댓글 갯수
		var pageSize = 5;
		// 총 페이지 갯수
		var pageCount = Math.ceil(rentRecordCnt / pageSize);
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

		$('#rentRecordBlock').html(str);

	}// showInquireBlock()
	
	 //관리자 페이지 월별대출 가져오는 함수
	function showRentRecordList(rentRecordCnt, list) {

		var str = '';
		var i = 1;

		if (list == null || list.length == 0) {

			str += '	<tr>';
			str += '		<td colspan="6"></td>';
			str += '	</tr>';
			

			$('.rentRecord').html(str); 
			return;
		}


		for (let record of list) {
			str += '	<tr>';
			str += '		<td>'+ i +'</td>';
			str += '		<td>'+ record.bookcode +'</td>';
			str += '		<td>'+ record.serialNum +'</td>';
			str += '		<td style="width:400px; text-align: left;">'+ record.bookname +'</td>';
			str += '		<td>'+ record.renter +'</td>';
			str += '		<td>'+ record.rentStart +'</td>';
			str += '		<td>'+ record.returnDate +'</td>';
			str += '	</tr>';
			i++
		} // for

		$('.rentRecord').html(str);

		showRentRecordBlock(rentRecordCnt); //관리자페이지 신청목록 블록 출력하기    

	} // showApplyList() 
	
	
	// 대출기록 가져오는 함수
	function getRentRecord(pageNum) {

		$.ajax({
			url: '/libraryService/getRentRecord/' + pageNum ,
			method: 'GET',
			success: function (result) {
				console.log(typeof result);
				console.log("result.RentRecordCnt: " + result.rentRecordCnt);
				console.log("result:list: " + result.list)
				
				showRentRecordList(result.rentRecordCnt, result.list);
				
			},
			error: function () {
				alert('관리자 신청 리스트 가져오기 오류 발생...');
			}
		});
	} // getMyInquireData()
	
	getRentRecord(1);

	// 신청리스트 블록 페이지 이동 이벤트
	$('#rentRecordBlock').on('click', 'li a', function (event) {

		// a태그의 기본기능 하이퍼링크 막기
		event.preventDefault();
		
		var targetPageNum = $(this).attr('href');
		console.log('targetPageNum : ' + targetPageNum);

		if (targetPageNum == '#') {
			return;
		}
		
		pageNum = targetPageNum;

		getRentRecord(pageNum);
	});

	</script>
	
<!-- 관리자 모든도서 정보 가져오기 -->	

	<script>

	//관리자 페이지 책리스트 블록페이지 함수
	function showBookBlock(bookCnt) {

		console.log("inquireCnt: " + bookCnt)

		// 한 페이지에 보여지는 댓글 갯수
		var pageSize = 5;
		// 총 페이지 갯수
		var pageCount = Math.ceil(bookCnt / pageSize);
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

		$('#mw-page').html(str);

	}// showInquireBlock()

	
	
	 //관리자 페이지 책 목록 가져오는 함수
	function showBookList(bookCnt, list) {

		var str = '';

		if (list == null || list.length == 0) {

			str += '	<tr>';
			str += '		<td colspan="6"></td>';
			str += '	</tr>';
			

			$('.bookList').html(str); 
			return;
		}


		for (let book of list) {
			str += '	<tr onclick="bookContent('+ book.bookCode +')">';
			str += '		<td rowspan="2" class="thumb last-row">	';
			str += '			<img alt="책 썸네일" src="/images/main/bookimg.png">';
			str += '		</td>';
			str += '		<td class="book-title">';
			str += '			<h4><b class="title">'+ book.bookName +'</b></h4>';
			str += '		</td>';
			str += '	</tr>';
			str += '	<tr class="last-row">';
			str += '		<td class="book-detail">저자:'+ book.author +'<br>출판사 : '+ book.publisher +'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;출판년도 : '+ book.pubYear +'&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;소장일자 : '+ book.holdDate +'<br>';
			str += '		<br><button onclick="addSubBook('+ book.bookCode +')" class="infoButton">도서추가</button>&nbsp;&nbsp;<button onclick="removeBook('+ book.bookCode +')" class="infoButton">도서삭제</button>';
			str += '	</tr>';
		} // for

		$('.bookList').html(str);

		  showBookBlock(bookCnt); //관리자페이지 신청목록 블록 출력하기   

	} // showApplyList() 
	
	
	// 관리자 페이지 도서 정보 가져오는 함수
	function getBooksData(pageNum,search) {

		console.log("검색값: " + search);
		
		$.ajax({
			url: '/libraryService/getBooksData/' + pageNum ,
			data: search ,
			method: 'GET',
			contentType: 'application/json; charset=utf-8',
			success: function (result) {
				console.log(typeof result);
				console.log("관리자 북 리스트 갯수: " + result.bookCnt);
				console.log("관리자 북 리스트: " + result.list)
				
				showBookList(result.bookCnt, result.list);
				
			},
			error: function () {
				alert('관리자 북 리스트 가져오기 오류 발생...');
			}
		});
	} // getReserveBookData()
	
	// 검색어로 도서 찾기 함수
	function searchBook() {

		search = { search: $('input[name=search]').val() };
		console.log("검색값 버튼: " + search);
		
		getBooksData(1,search);
		return;

	}

	var search = "";
	getBooksData(1,search);


	// 신청리스트 블록 페이지 이동 이벤트
	$('#mw-page').on('click', 'li a', function (event) {

		// a태그의 기본기능 하이퍼링크 막기
		event.preventDefault();
		
		var targetPageNum = $(this).attr('href');
		console.log('targetPageNum : ' + targetPageNum);

		if (targetPageNum == '#') {
			return;
		}
		
		pageNum = targetPageNum;

		getBooksData(pageNum, search);
	});


	function addSubBook(bookcode){
	
	
			var bookcode = bookcode;
	
			console.log("서브책 번호: " + bookcode);
	
			var result = confirm('해당도서를 한권 추가하시겠습니까? \n※ 추가시 사용가능한 해당도서가 한권 추가됩니다.');
	
				if(result){
				 	$.ajax({
						url: '/libraryService/addSubBook/' + bookcode,
						method: 'GET',
						success: function (result) {
							
							alert(result);
							getBooksData(pageNum, search);
							
							
						}, 
						error: function () {
							alert('선택하신 도서는 추가가 불가능합니다. 다시 선택해주세요.');
							getBooksData(pageNum, search);

						}
					});
				} 

			} 


	function removeBook(bookcode){
	
	
			var bookcode = bookcode;
	
			console.log("서브책 번호: " + bookcode);
	
			var result = confirm('해당도서와 관련된 모든 도서를 삭제하시겠습니까? ');
	
				if(result){
				 	$.ajax({
						url: '/libraryService/removeBook/' + bookcode,
						method: 'GET',
						success: function (result) {
							
							alert(result);
							getBooksData(pageNum, search);
							
							
						}, 
						error: function () {
							alert('선택하신 도서는 추가가 불가능합니다. 다시 선택해주세요.');
							getBooksData(pageNum, search);

						}
					});
				} 

			} 

	</script>
	
	
<!-- 희망도서 신청현황-->	
	<script>
	
	function showApplyBlock(applyListCnt) {

		// 한 페이지에 보여지는 댓글 갯수
		var pageSize = 5;
		// 총 페이지 갯수
		var pageCount = Math.ceil(applyListCnt / pageSize);
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

	}// showApplyBlock() 
	
	
	 //희망도서 신청글 목록 가져오는 함수
	function showApplyList(applyListCnt, list) {

		var str = '';

		if (list == null || list.length == 0) {

			str += '	<tr>';
			str += '		<td colspan="6"></td>';
			str += '	</tr>';
			

			$('.applyList').html(str); 
			return;
		}


		for (let apply of list) {
			str += '	<tr data-num="' + apply.num + '"> ';
			str += '		<td>'+ apply.num +'</td>';
			str += '		<td style="width:400px; text-align: left;">'+ apply.bookname +'</td>';
			str += '		<td>'+ apply.name +'</td>';
			str += '		<td>'+ apply.regDate +'</td>';
			if (apply.status == 0) {
				str += '<td>신청중</b>';	
			} else if(apply.status == 1) {
				str += '<td>처리중</b>';
			} 
			str += '	</tr>';
		} // for

		$('.applyList').html(str);

		 showApplyBlock(applyListCnt); //관리자페이지 신청목록 블록 출력하기  

	} // showApplyList() 


	// 희망도서신청 정보 가져오는 함수
	function getApplyData(pageNum) {

		$.ajax({
			url: '/library/applyList/' + pageNum ,
			method: 'GET',
			success: function (result) {
				console.log(typeof result);
				console.log("result.myInquireCnt: " + result.applyCnt);
				console.log("result:list: " + result.list)
				
				showApplyList(result.applyCnt, result.list);
				
			},
			error: function () {
				alert('관리자 신청 리스트 가져오기 오류 발생...');
			}
		});
	} // getMyInquireData()
	
	var pageNum = 1;
	getApplyData(1);


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

		getApplyData(pageNum);
	});

	
	// 신청글 클릭시 글내용으로 이동 이벤트
	$('.applyList').on('click', 'tr', function (event) {

		var num = $(this).data('num');
		location.href='/library/applyContent?num='+ num;
	});
	

	</script>
	
	<!--  도서신청 현황 리스트-->	
	<script>

	// 도서신청 취소 버튼 클릭시 신청하기
	 function applyCancel(result) {

			console.log("눌름");
	
			var serialNum = result;
	
			console.log("서브책 번호: " + serialNum);
	
			var result = confirm('해당도서 신청을 취소하시겠습니까?');
	
				if(result){
				 	$.ajax({
						url: '/libraryService/applyCancel/' + serialNum,
						method: 'GET',
						success: function (result) {
							
							alert(result);
							getApplyBookData(pageNum);
							
						}, 
						error: function () {
							alert('선택하신 도서 신청 취소가 불가능합니다. 다시 선택해주세요.');
							getApplyBookData(pageNum);
						}
					});
				} 

		} 
	
	getApplyBookData(1);

	function showApplyBookBlock(bookSubCnt) {

		// 한 페이지에 보여지는 댓글 갯수
		var pageSize = 5;
		// 총 페이지 갯수
		var pageCount = Math.ceil(bookSubCnt / pageSize);
		console.log("페이지갯수: " + pageCount)
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

		$('#applyBookBlock').html(str);

	}// showApplyBlock() 

	
	 //신청도서 목록 가져오기
	function showApplyBookList(bookSubCnt, list) {

		var str = '';
		var i = 1;
		console.log("신청현황2: " + bookSubCnt);

		if (list == null || list.length == 0) {

			str += '	<tr>';
			str += '		<td colspan="6"></td>';
			str += '	</tr>';
			

			$('.bookApplyList').html(str); 
			return;
		}


		for (let apply of list) {
			str += '	<tr>';
			str += '		<td>'+ i +'</td>';
			str += '		<td>'+ apply.serialNum +'</td>';
			str += '		<td style="width:400px; text-align: left;">'+ apply.bookname +'</td>';
			str += '		<td>'+ apply.applyer +'</td>';
			str += '		<td>'+ apply.applyStart +'</td>';
			if(apply.status == 0){
				str += '        <td><button type="button" class="ls_btn2" onclick="rent('+ apply.serialNum +')"><b style="font-size: 12px">도서대출</b></button>';
				str += '        &nbsp;<button type="button" class="ls_btn2" onclick="useStop('+ apply.serialNum +')"><b style="font-size: 12px">사용중지</b></button>';	
				str += '        &nbsp;<button type="button" class="ls_btn2" onclick="applyCancel('+ apply.serialNum +')"><b style="font-size: 12px">신청취소</b></button></td>';
			} else {
				str += '        <td><button type="button" class="ls_btn2" onclick="available('+ apply.serialNum +')"><b style="font-size: 12px">사용가능</b></button></td>';	
			}
			str += '	</tr>';
			i++
		} // for

		$('.bookApplyList').html(str);

		showApplyBookBlock(bookSubCnt); //관리자페이지 신청목록 블록 출력하기  

	} // showApplyList() 


	// 도서신청 정보 가져오는 함수
	function getApplyBookData(pageNum) {

		$.ajax({
			url: '/libraryService/getApplyBookList/' + pageNum ,
			method: 'GET',
			success: function (result) {
				console.log(typeof result);
				console.log("신청현황: " + result.bookSubCnt);
				console.log("result:list: " + result.list)
				
				showApplyBookList(result.bookSubCnt, result.list);
				
			},
			error: function () {
				alert('관리자 신청 리스트 가져오기 오류 발생...');
			}
		});
	} // getMyInquireData()
	
	getApplyBookData(1);


	// 신청리스트 블록 페이지 이동 이벤트
	$('#applyBookBlock').on('click', 'li a', function (event) {

		// a태그의 기본기능 하이퍼링크 막기
		event.preventDefault();
		
		var targetPageNum = $(this).attr('href');
		console.log('targetPageNum : ' + targetPageNum);

		if (targetPageNum == '#') {
			return;
		}
		
		pageNum = targetPageNum;

		getApplyBookData(pageNum);
	});

	// 도서대출 버튼 클릭시 신청하기
	 function rent(result) {

	 	var id = "${ id }";	
		var today = new Date(); 	
		var hours = today.getHours();

		console.log(hours);

		if( hours >= 17 /* ||   hours < 10 */ ){

			alert("도서대출 가능시간이 아닙니다.\n ※ 도서대출 가능시간: 10:00 ~ 17:00");
		
		} else {
			
			console.log("눌름");
	
			var num = result;
	
			console.log("서브책 번호: " + num);
	
			var result = confirm('해당도서를 대출하시겠습니까?\n- 대출내역확인: 마이페이지> 도서관리> 대출내역\n- 대출기간: 대출일로부터 일주일\n※ 도서반납시 회원증 필수지참, 미반납시 불이익 및 도서관 이용제한');
	
				if(result){
				 	$.ajax({
						url: '/libraryService/rentBook/' + num,
						method: 'GET',
						success: function (result) {
							
							alert(result);
							getApplyBookData(pageNum)
							getRentBookData(pageNum)
							
							
						}, 
						error: function () {
							alert('선택하신 도서는 대출이 불가능합니다. 다시 선택해주세요.');
							getApplyBookData(pageNum)
						}
					});
				} 

			} 


		}  


	</script>
	
	<!--  도서대출 현황 리스트-->	
	<script>

	function  showRentBookBlock(rentBookCnt) {

		// 한 페이지에 보여지는 댓글 갯수
		var pageSize = 5;
		// 총 페이지 갯수
		var pageCount = Math.ceil(rentBookCnt / pageSize);
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


		$('#rentBookBlock').html(str);

	}// showApplyBlock() 
	
	
	 //대출도서 목록 가져오기
	function showRentBookList(bookSubCnt, list) {

		var str = '';
		var i = 1;

		if (list == null || list.length == 0) {

			str += '	<tr>';
			str += '		<td colspan="7"></td>';
			str += '	</tr>';
			

			$('.rentList').html(str); 
			return;
		}


		for (let rent of list) {
			str += '	<tr>';
			str += '		<td>'+ i +'</td>';
			str += '		<td>'+ rent.serialNum +'</td>';
			str += '		<td style="width:380px; text-align: left;">'+ rent.bookname +'</td>';
			str += '		<td>'+ rent.renter +'</td>';
			str += '		<td>'+ rent.rentStart +'</td>';
			str += '		<td>'+ rent.rentEnd +'</td>';
			str += '        <td><button type="button"  onclick="returnBook('+ rent.serialNum +')" class="ls_btn2"><b style="font-size: 12px">도서반납</b></button></td>';	
			str += '	</tr>';
			i++
		} // for

		$('.rentList').html(str);

		showRentBookBlock(bookSubCnt); //관리자페이지 대출목록 블록 출력하기   

	} // showApplyList() 



	// 도서대출 정보 가져오는 함수
	function getRentBookData(pageNum) {

		$.ajax({
			url: '/libraryService/getRentBookList/' + pageNum ,
			method: 'GET',
			success: function (result) {
				console.log(typeof result);
				console.log("대출도서 갯수: " + result.bookSubCnt);
				console.log("result:list: " + result.list)
				
				showRentBookList(result.bookSubCnt, result.list);
				
			},
			error: function () {
				alert('관리자 신청 리스트 가져오기 오류 발생...');
			}
		});
	} // getRentBookData()
	
	getRentBookData(1);


	// 신청리스트 블록 페이지 이동 이벤트
	$('#rentBookBlock').on('click', 'li a', function (event) {

		// a태그의 기본기능 하이퍼링크 막기
		event.preventDefault();
		
		var targetPageNum = $(this).attr('href');
		console.log('targetPageNum : ' + targetPageNum);

		if (targetPageNum == '#') {
			return;
		}
		
		pageNum = targetPageNum;

		getRentBookData(pageNum);
	});

	// 도서반납 버튼 클릭시 신청하기
	 function returnBook(serialNum) {

	 	var id = "${ id }";	
		var today = new Date(); 	
		var hours = today.getHours();

		console.log(hours);

		if( hours >= 17  /* ||   hours < 10 */  ){

			alert("도서반납 가능시간이 아닙니다.\n ※ 도서반납 가능시간: 10:00 ~ 17:00");
		
		} else {
			
			console.log("눌름");
	
			console.log("서브책 번호: " + serialNum);
	
			var result = confirm('해당도서를 반납하시겠습니까?');
	
				if(result){
				 	$.ajax({
						url: '/libraryService/returnBook/' + serialNum,
						method: 'GET',
						success: function (result) {
							
							alert(result);
							getRentBookData(pageNum)
								
						}, 
						error: function () {
							alert('선택하신 도서는 반납이 불가능합니다. 다시 선택해주세요.');
							getRentBookData(pageNum)
						}
					});
				} 

			} 


		}  

	</script>
	<script>

	//에약도서 블록페이지 함수
	function showReserveBookBlock(reserveCnt) {

		console.log("reserveCnt: " + reserveCnt)

		// 한 페이지에 보여지는 댓글 갯수
		var pageSize = 5;
		// 총 페이지 갯수
		var pageCount = Math.ceil(reserveCnt / pageSize);
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

		$('#reserveBookBlock').html(str);

	}// showRentBlock()

	//예약도서 목록 가져오기
	function showReserveBookList(reserveCnt, list) {

		var id = "${id}";
		var str = '';
		var i = 1;

		if (list == null || list.length == 0) {

			str += '	<tr>';
			str += '		<td colspan="8"></td>';
			str += '	</tr>';
			

			$('.reserveList').html(str); 
			return;
		}

		
		for (let reserve of list) {

			console.log("예약자2: " + reserve.reserver2);
			
			if(reserve.reserver2 != ''){
				
				
				str += '	<tr>';
				str += '		<td>'+ i +'</td>';
				str += '		<td>'+ reserve.serialNum +'</td>';
				str += '		<td style="width:380px; text-align: left;">'+ reserve.bookname +'</td>';
				str += '		<td>'+ reserve.reserver +'</td>';
				if(reserve.reserveStart != ''){
					str += '	<td>'+ reserve.reserveStart +'</td>';
				} else {
					str += '	<td></td>';
				}
				if(reserve.reserveEnd != ''){
					str += '	<td>'+ reserve.reserveEnd +'</td>';
				} else {
					str += '	<td></td>';
				}
				str += '		<td>1순위</td>';
				if(reserve.reserveStart != '' && reserve.reserveEnd != '' && reserve.status == 0){
					str += '        <td>신청대기중</td>';	
				} else if(reserve.status > 0){
					str += '        <td>사용중지</td>';	
				} else{
					str += '        <td>예약중</td>';
				}
				str += '	</tr>';

				str += '	<tr>';
				str += '		<td>'+ i +'</td>';
				str += '		<td>'+ reserve.serialNum +'</td>';
				str += '		<td style="width:380px; text-align: left;">'+ reserve.bookname +'</td>';
				str += '		<td>'+ reserve.reserver2 +'</td>';
				str += '		<td></td>';
				str += '		<td></td>';
				str += '		<td>2순위</td>';
				str += '    	<td>예약중</td>';
				str += '	</tr>';
			} else if(reserve.reserver2 == ''){

				str += '	<tr>';
				str += '		<td>'+ i +'</td>';
				str += '		<td>'+ reserve.serialNum +'</td>';
				str += '		<td style="width:380px; text-align: left;">'+ reserve.bookname +'</td>';
				str += '		<td>'+ reserve.reserver +'</td>';
				if(reserve.reserveStart != ''){
					str += '	<td>'+ reserve.reserveStart +'</td>';
				} else {
					str += '	<td></td>';
				}
				if(reserve.reserveEnd != ''){
					str += '	<td>'+ reserve.reserveEnd +'</td>';
				} else {
					str += '	<td></td>';
				}
				str += '		<td>1순위</td>';
				if(reserve.reserveStart != '' && reserve.reserveEnd != ''){
					str += '        <td>신청대기중</td>';	
				} else{
					str += '        <td>예약중</td>';
				}
				str += '	</tr>';

			}
		} // for

		$('.reserveList').html(str);

		showReserveBookBlock(reserveCnt); //관리자페이지 신청목록 블록 출력하기  

	} // showApplyList() 
	
	
	// 예약도서 정보 가져오는 함수
	function getReserveBookData(pageNum) {

		$.ajax({
			url: '/libraryService/getReserveBookList/' + pageNum ,
			method: 'GET',
			success: function (result) {
				console.log(typeof result);
				console.log("result.bookSubCnt: " + result.bookSubCnt);
				console.log("result:list: " + result.list)
				
				showReserveBookList(result.bookSubCnt, result.list);
				
			},
			error: function () {
				alert('관리자 신청 리스트 가져오기 오류 발생...');
			}
		});
	} // getReserveBookData()

	
	getReserveBookData(1)
	
			// 대출리스트 블록 페이지 이동 이벤트
	$('#reserveBookBlock').on('click', 'li a', function (event) {

		// a태그의 기본기능 하이퍼링크 막기
		event.preventDefault();
		
		var targetPageNum = $(this).attr('href');
		console.log('targetPageNum : ' + targetPageNum);

		if (targetPageNum == '#') {
			return;
		}
		
		pageNum = targetPageNum;

		getReserveBookData(pageNum);
	});
	


	
	</script>
</body>
</html>