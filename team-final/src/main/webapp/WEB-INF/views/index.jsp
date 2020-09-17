<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/main/index.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
	<!-- 메뉴 -->
	<jsp:include page="/WEB-INF/views/include/menu.jsp" />
	<div id="featured-wrapper">
		<div class="main-title">
			<input name="search" type="text" placeholder="도서 이름, 출판사, 저자를 입력하세요."></input>
			<button type="button" onclick= "searchAll()" >검색</button>
		</div>
	</div>
	<div id="wrapper">
		<div class="col-md-7">
			<div class="main-box">
				<h1>공지사항</h1>
				<span class="notice-link"><a href="/notice/list"><i class="far fa-plus-square"></i></a></span>
				<div class="subNotice">
					<table>
						<tr>
							<td class="col-md-10">공지제목</td>
							<td class="col-md-2 cell-right">2020.01.01</td>
						</tr>
						<tr>
							<td class="col-md-10">공지제목</td>
							<td class="col-md-2 cell-right">2020.01.01</td>
						</tr>
						<tr>
							<td class="col-md-10">공지제목</td>
							<td class="col-md-2 cell-right">2020.01.01</td>
						</tr>
						<tr>
							<td class="col-md-10">공지제목</td>
							<td class="col-md-2 cell-right">2020.01.01</td>
						</tr>
						<tr>
							<td class="col-md-10">공지제목</td>
							<td class="col-md-2 cell-right">2020.01.01</td>
						</tr>
						<tr>
							<td class="col-md-10">공지제목</td>
							<td class="col-md-2 cell-right">2020.01.01</td>
						</tr>
						<tr>
							<td class="col-md-10">공지제목</td>
							<td class="col-md-2 cell-right">2020.01.01</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="col-md-5">
			<div class="main-box">
				<h1 class="cal-h1">일정</h1>
				<div class="cal_top">
					<a href="#" id="movePrevMonth"><span id="prevMonth" class="cal_tit">&lt;</span></a> <span id="cal_top_year"></span> <span id="cal_top_month"></span> <a href="#" id="moveNextMonth"> <span id="nextMonth" class="cal_tit">&gt;</span></a>
				</div>
				<div id="cal_tab" class="cal"></div>
			</div>
		</div>
		<div class="col-md-6 carousel-box">
			<div class="main-box">
				<h1>이달의 책</h1>
				<div id="carousel-example-generic" class="carousel slide">
					<div class="carousel-inner">
						<div class="item active">
							<div class="row main">
								<div class="img-box">
									<img src="css/images/main/book01.jpg" alt="First slide">
								</div>
								<div class="img-box">
									<img src="css/images/main/book02.jpg" alt="First slide">
								</div>
								<div class="img-box">
									<img src="css/images/main/book03.jpg" alt="First slide">
								</div>
							</div> 
						</div>
						<div class="item">
							<div class="row sub">
								<div class="img-box">
									<img src="/images/main/book04.jpg" alt="Second slide">
								</div>
								<div class="img-box">
									<img src="/images/main/book05.jpg" alt="Second slide">
								</div>
								<div class="img-box">
									<img src="/images/main/book06.jpg" alt="Second slide">
								</div>
							</div>
						</div>
					</div>
					<a class="left carousel-control" href="#carousel-example-generic" data-slide="prev"> <span class="icon-prev"></span>
					</a> <a class="right carousel-control" href="#carousel-example-generic" data-slide="next"> <span class="icon-next"></span>
					</a>
				</div>
			</div>
		</div>
		<div class="col-md-6 map-box">
			<div class="main-box">
				<h1>찾아오시는 길</h1>
				<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d815.5063177622442!2d129.05903058814084!3d35.15599049876392!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3568eb6feb39fa0d%3A0x99fa06d0443b23c6!2z67aA7IKw6rSR7Jet7IucIOu2gOyCsOynhOq1rCDrtoDsoIQy64-ZIOykkeyVmeuMgOuhnCA3MDg!5e0!3m2!1sko!2skr!4v1597907980577!5m2!1sko!2skr"></iframe>
			</div>
		</div>
	</div>
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<!-- footer -->
	<script src="/script/jquery-3.5.1.js"></script>
	<script src="/script/bootstrap.js"></script>
	<script src="/script/main/calendar.js"></script>
	<script>

	// 검색어로 도서 찾기 
	function searchAll() {

		var search =  $('input[name=search]').val();
		var allSearch = "allContent";
		console.log("검색값 버튼: " + search);
		
		
		location.href='/libraryService/bookList?search='+ search;

	}
	
	//메인화면 공지글 선택시 공지글 내용으로 이동
	$('div.subNotice').on('click', 'tr', function () {

		var num = $(this).data('num');

		location.href='/notice/content?num='+ num;
	});

	function showNoticeList(list) {

		var str = '';

		if (list == null || list.length == 0) {	
			str += '<table>';
			str += '	<tr>';
			str += '		<td colspan="5"></td>';
			str += '	</tr>';
			str += '</table>';
			$('div.subNotice').html(str);
			return;
		}
		
		for (let notice of list) {

			str += '<table>';
			str += ' 	<tr style="cursor:pointer" data-num="' + notice.num + '">';
			str += '		<td class="col-md-10">' + notice.subject + '</td>';
			str += '		<td class="col-md-2 cell-right">' + notice.regDate +'</td>';
			str += ' 	</tr>';
			str += '</table>';

		}
		$('div.subNotice').html(str);
	}	
	
	// 공지사항 정보 가져오는 함수
	function getNoticeData() {

		$.ajax({
			url: '/notice/subList' ,
			method: 'GET',
			success: function (result) {
				console.log("typeof result: " + typeof result);
				console.log("result.list: " + result.list);
				console.log("result.myNoticeCnt: " + result.myNoticeCnt);				
				showNoticeList(result);				
			},
			error: function () {
				alert('공지사항 가져오기 오류 발생...');
			}
		});
	} // getReplyData()

	getNoticeData();

	function bestBook(bookcode){

		console.log("북코드: " + bookcode);
		location.href='/libraryService/searchContent?&bookCode='+bookcode;
	}



	
 	function showBestBookList(list) {

		var str = '';
		var i = 1;
		for (let best of list) {

			if(i < 4){
				str += '		<div class="img-box">';
				str += '			<img onclick="bestBook('+ best.bookCode +')" src="css/images/main/book0'+i+'.jpg" alt="First slide">';
				str += ' 		</div>';
				$('div.main').html(str);

				i++		

			} 

/* 			if(i > 3) {

				if(list[4]){
				str += '		<div class="img-box">';
				str += '			<img onclick="bestBook('+ best.bookCode +')" src="css/images/main/book0'+i+'.jpg" alt="Second slide">';
				str += ' 		</div>';
				$('div.sub').html(str);	

				}
				i++	
				
			} */
		}
	} 

	
	// 베스트 도서 정보 가져오는 함수
	function getBestBookData() {

		$.ajax({
			url: '/libraryService/getBestBook' ,
			method: 'GET',
			success: function (result) {
				console.log("bestBook: " + result);

				 showBestBookList(result); 
				
			},
			error: function () {
				alert('댓글 리스트 가져오기 오류 발생...');
			}
			
		});
	} // getBestBookData()

	getBestBookData();

	</script>
</body>
</html>
