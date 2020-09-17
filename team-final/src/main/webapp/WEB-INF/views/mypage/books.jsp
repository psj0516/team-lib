<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/mypage/books.css" rel="stylesheet" type="text/css" media="all" />
<script src="https://kit.fontawesome.com/f31fb562ea.js" crossorigin="anonymous"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/menu.jsp" />
	<div id="wrapper">
		<jsp:include page="/WEB-INF/views/include/mypage-menu.jsp" />
		<div class="col-md-10 col-sm-10 col-xs-12">
			<h2>관심도서</h2>
			<div class="books-box">
				<table id="like-list">
				</table>
			</div>
			<div class="more-like">
				<span id="more-like" class="more-info"><a href="/mypage/moreBookLike">더보기>></a></span>
			</div>
			<h2>예약중 도서</h2>
			<div class="book-loan-status">
				<table class="table3">
					<thead style="text-align: center;">
						<tr>
							<td id="br-li">번호</td>
							<td>도서명</td>
							<td>예약상태</td>
							<td>신청종료일</td>
							<td>예약순위</td>
							<td>기능</td>
						</tr>
					</thead>
					<tbody class="myReserveList" style="cursor: pointer; text-align: center;">
						<tr>
							<td>1</td>
							<td class="subject">도서명</td>
							<td>예약중</td>
							<td>2020.09.04</td>
							<td>1</td>
							<td>
								<button type="button" onclick="apply()">도서신청</button>
								<button type="button" onclick="cancel()">예약취소</button>
							</td>
						</tr>
						<tr>
							<td>2</td>
							<td class="subject">도서명</td>
							<td>예약중</td>
							<td>2020.09.04</td>
							<td>1</td>
							<td>
								<button type="button" onclick="apply()">도서신청</button>
								<button type="button" onclick="cancel()">예약취소</button>
							</td>
						</tr>
						<tr>
							<td>3</td>
							<td class="subject">도서명</td>
							<td>예약중</td>
							<td>2020.09.04</td>
							<td>1</td>
							<td>
								<button type="button" onclick="apply()">도서신청</button>
								<button type="button" onclick="cancel()">예약취소</button>
							</td>
						</tr>
						<tr>
							<td>4</td>
							<td class="subject">도서명</td>
							<td>예약중</td>
							<td>2020.09.04</td>
							<td>1</td>
							<td>
								<button type="button" onclick="apply()">도서신청</button>
								<button type="button" onclick="cancel()">예약취소</button>
							</td>
						</tr>
						<tr>
							<td>5</td>
							<td class="subject">도서명</td>
							<td>예약중</td>
							<td>2020.09.04</td>
							<td>1</td>
							<td>
								<button type="button" onclick="apply()">도서신청</button>
								<button type="button" onclick="cancel()">예약취소</button>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div style="margin-top: -30px; margin-bottom: 30px;" id="reserveBlock" class="text-center"></div>
			<h2>대출중 도서</h2>
			<div class="book-loan-status">
				<table class="table3">
					<thead style="text-align: center;">
						<tr>
							<td id="br-li">번호</td>
							<td>도서번호</td>
							<td>도서명</td>
							<td>대출일</td>
							<td>반납예정일</td>
							<td>기능</td>
						</tr>
					</thead>
					<tbody class="myRentList" style="text-align: center;">
						<tr>
							<td>1</td>
							<td>1</td>
							<td class="subject">도서명</td>
							<td>2020.09.04</td>
							<td>2020.09.04</td>
							<td>
								<button type="button" onclick="extension()">대출연장</button>
							</td>
						</tr>
						<tr>
							<td>2</td>
							<td>2</td>
							<td class="subject">도서명</td>
							<td>2020.09.04</td>
							<td>2020.09.04</td>
							<td>
								<button type="button" onclick="extension()">대출연장</button>
							</td>
						</tr>
						<tr>
							<td>3</td>
							<td>3</td>
							<td class="subject">도서명</td>
							<td>2020.09.04</td>
							<td>2020.09.04</td>
							<td>
								<button type="button" onclick="extension()">대출연장</button>
							</td>
						</tr>
						<tr>
							<td>4</td>
							<td>4</td>
							<td class="subject">도서명</td>
							<td>2020.09.04</td>
							<td>2020.09.04</td>
							<td>
								<button type="button" onclick="extension()">대출연장</button>
							</td>
						</tr>
						<tr>
							<td>5</td>
							<td>5</td>
							<td class="subject">도서명</td>
							<td>2020.09.04</td>
							<td>2020.09.04</td>
							<td>
								<button type="button" onclick="extension()">대출연장</button>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div style="margin-top: -30px; margin-bottom: 30px;" id="rentBlock" class="text-center"></div>
			<h2 class="rent-h2">대출이력</h2>
			<span class="rent-info">(대출 이력은 최근 3달까지만 보여집니다.)</span>
			<div class="book-loan-status">
				<table class="table3">
					<thead style="text-align: center;">
						<tr>
							<td id="br-li">번호</td>
							<td>도서번호</td>
							<td>도서명</td>
							<td>대출일</td>
							<td>반납일</td>
						</tr>
					</thead>
					<tbody class="myRentRecord" style="text-align: center;">
						<tr>
							<td>1</td>
							<td>1</td>
							<td class="subject">도서명</td>
							<td>2020.09.04</td>
							<td>2020.09.04</td>
						</tr>
						<tr>
							<td>2</td>
							<td>2</td>
							<td class="subject">도서명</td>
							<td>2020.09.04</td>
							<td>2020.09.04</td>
						</tr>
						<tr>
							<td>3</td>
							<td>3</td>
							<td class="subject">도서명</td>
							<td>2020.09.04</td>
							<td>2020.09.04</td>
						</tr>
					</tbody>
				</table>
				<div id="myRentRecordBlock" class="text-center"></div>
			</div>
		</div>

	</div>
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<!-- footer -->
	<script src="/script/jquery-3.5.1.js"></script>
	<script src="/script/bootstrap.js"></script>
	<script src="/script/mypage/infoUpdateCheck.js"></script>
	<script src="/script/menuActive.js"></script>
	<!-- 관심도서 script -->
	<script>
		//관심도서 리스트 가져오기
		function getBookLikeList(pageNum) {
			$.ajax({
				method : 'GET',
				url : '/mypage/books/like/'+ pageNum,
				success : function(result) {
					console.log(result.bookCnt);
					console.log(result.bookList);
					showBookLikeList(result.bookCnt,result.bookList);
				},
				error : function() {
					console.log('관심도서 리스트 가져오기 실패');
				}
			});
		};

		// 관심도서 리스트 보여주기
		function showBookLikeList(likeCnt,list){
			var str ='';
			var urlString = '\'/libraryService/searchContent?bookCode=';
			console.log(likeCnt+'likCnt in showbooklist');
			if(likeCnt<=5){
				$('span#more-like').empty();
				}
			
			if(list==null || list.length == 0){
				str += '<tr>';
				str += '	<td colspan="5">등록된 관심도서가 없습니다.</td>';
				str += '</tr>';
			} else{
				for(let book of list){
					str+= '<tr onclick="location.href='+urlString+book.bookCode+'\'">';
					str+= '	<td rowspan="2" class="thumb last-row">';
					str+= '		<img alt="책 썸네일"src="/images/main/bookimg.png">';
					str+= '	<td colspan="2"><span class="title">'+book.bookName+'</span></td>';
					str+= '</tr>';
					str+= '<tr class="last-row">';
					str+= '	<td>'+book.author+'<br>'+book.publisher+'<br>'+book.pubYear+'</td>';
					str+= '	<td class="book-ad">';
					str+= '		<input type="checkbox" id="'+book.bookCode+'_r" class="rsv">';
					str+= '		<label for="'+book.bookCode+'_r"><i class="fas fa-star"></i></label><span> 도서예약</span><br>';
					str+= '		<input type="checkbox" id="'+book.bookCode+'_f" class="fav" checked  data-bookcode="'+book.bookCode+'">';
					str+= '		<label for="'+book.bookCode+'_f"><i class="fas fa-heart"></i></label><span> 관심도서</span>';
					str+= '	</td>';
					str+= '</tr>';
					//if(i==3){break;}
					} //for
				
				}
			$('#like-list').html(str);
			
			};

		// 관심도서 삭제 {동적 이벤트 연결(이벤트 연결 위임 방식)}
		$('table#like-list').on('click', 'input.fav', function () { //cnt값을 줘서 0인거, 3인 경우 생각
			var $curTr = $(this).closest('tr.last-row');
			var $prevTr = $curTr.prev();			
			var bookCode = $(this).data('bookcode');
			
			console.log('selected bookCode'+bookCode);
			$.ajax({
				method: 'DELETE',
				url : '/mypage/books/like/',
				data : {bookCode : bookCode},
				success : function(){
					console.log('deleteLike success');
					getBookLikeList(pageNum);
	
					},
				error : function(e){
					console.log(e)
					console.log ('deleteLike fail');
					}
					
				});
		});

		getBookLikeList(1);
	</script>
	<script>
	// 도서신청 버튼 클릭시 신청하기
	 function apply(serialNum) {

	 	var id = "${ id }";	
		var today = new Date(); 	
		var hours = today.getHours();

		console.log(hours);


		if(id == null || id == ''){

			alert("도서신청은 회원만 가능합니다. 로그인 해주세요.");
			
		}else if( hours >= 17 ||  hours < 1){

			alert("도서신청 가능시간이 아닙니다.\n※ 도서신청은 01:00 ~ 17:00 사이에 가능합니다.");
		
		} else {
			
			console.log("눌름");
	
			var num = serialNum;
	
			console.log("서브책 번호: " + num);
	
			var result = confirm('해당도서를 신청하시겠습니까?\n- 예약내역확인:마이페이지> 도서관리> 신청도서\n- 수령시간: 12:00 ~ 17:00\n※ 도서수령시 회원증 필수지참, 신청 다음날 미수령시 자동취소');
	
				if(result){
				 	$.ajax({
						url: '/libraryService/myPageApply/' + num,
						method: 'GET',
						success: function (result) {
							
							alert(result);
							getMyReserveData(1);
							
						}, 
						error: function () {
							alert('선택하신 도서가 이미 신청 중입니다. 다시 선택해주세요.');
							getMyReserveData(1);
						}
					});
				} 

			} 


		}  

	// 도서예약 취소 버튼 클릭시 예약 취소1
	 function cancel1(serialNum) {

	 	var id = "${ id }";	


		if(id == null || id == ''){

			alert("도서신청은 회원만 가능합니다. 로그인 해주세요.");
			
		} else {
			
			console.log("눌름");
	
			var num = serialNum;
	
			console.log("서브책 번호: " + num);
	
			var result = confirm('해당도서 예약을 취소하시겠습니까?');
	
				if(result){
				 	$.ajax({
						url: '/libraryService/reserveCancel1/' + num,
						method: 'GET',
						success: function (result) {
							
							alert(result);
							getMyReserveData(1);
							
						}, 
						error: function () {
							alert('선택하신 도서의 예약취소가 실패했습니다');
							getMyReserveData(1);
						}
					});
				} 

			} 
		}

		// 도서예약 취소 버튼 클릭시 예약 취소1
	 function cancel2(serialNum) {

	 	var id = "${ id }";	


		if(id == null || id == ''){

			alert("도서신청은 회원만 가능합니다. 로그인 해주세요.");
			
		} else {
			
			console.log("눌름");
	
			var num = serialNum;
	
			console.log("서브책 번호: " + num);
	
			var result = confirm('해당도서 예약을 취소하시겠습니까?');
	
				if(result){
				 	$.ajax({
						url: '/libraryService/reserveCancel2/' + num,
						method: 'GET',
						success: function (result) {
							
							alert(result);
							getMyReserveData(1);
							
						}, 
						error: function () {
							alert('선택하신 도서의 예약취소가 실패했습니다');
							getMyReserveData(1);
						}
					});
				} 

			} 
		}

		// 도서예약 취소 버튼 클릭시 예약 취소1
	 function cancel3(serialNum) {

	 	var id = "${ id }";		


		if(id == null || id == ''){

			alert("도서신청은 회원만 가능합니다. 로그인 해주세요.");
			
		} else {
			
			console.log("눌름");
	
			var num = serialNum;
	
			console.log("서브책 번호: " + num);
	
			var result = confirm('해당도서 예약을 취소하시겠습니까?');
	
				if(result){
				 	$.ajax({
						url: '/libraryService/reserveCancel3/' + num,
						method: 'GET',
						success: function (result) {
							
							alert(result);
							getMyReserveData(1);
							
						}, 
						error: function () {
							alert('선택하신 도서의 예약취소가 실패했습니다');
							getMyReserveData(1);
						}
					});
				} 

			} 
		}
 
	</script>
	<script>


	//나의 대출도서 블록페이지 함수
	function showmyRentRecordBlock(rentRecordCnt)  {

		console.log("rentCnt: " + rentRecordCnt)

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
				
		str += '<li class="' + active + ' page-item"><a class="page-link" href="'+ i +'">'+ i +'</a></li>'
		
		}

		if (next) {
			str += '<li class="page-item"><a class="page-link" href="'+ (startPage + pageBlock) +'">다음</a></li>';
		} else {
			str += '<li class="page-item disabled"><a class="page-link" href="#">다음</a></li>';
		}
		str += '	<li class="page-item"><a class="page-link" href="'+ pageCount +'">>></a></li>';
		str += '</ul>'

		$('#myRentRecordBlock').html(str);

	}// showRentBlock()

	 //나의 대출도서 목록 가져오는 함수
	function showMyRentRecord(rentRecordCnt, list) {

		var i = 1;
		var str = '';
		var id = "${ id }"
		console.log("갯수: " + rentRecordCnt);
		console.log("리스트: " + list);

		if (list == null || list.length == 0) {

			str += '	<tr>';
			str += '		<td colspan="5"></td>';
			str += '	</tr>';
			

			$('.myRentRecord').html(str); 
			return;
		}

		
		for (let record of list) {

			
			str += '	<tr>';
			str += '		<td>'+ i +'</td>';
			str += '		<td>'+ record.serialNum +'</td>';
			str += '		<td style="text-align: left;" class="subject">'+ record.bookname +'</td>';
			str += '		<td>'+ record.rentStart +'</td>';
			str += '		<td>'+ record.returnDate +'</td>';
			str += '	</tr>';
			i++;
		} // for		

		$('.myRentRecord').html(str);

		 showmyRentRecordBlock(rentRecordCnt) 

	} //  myRentList() 
	

	// 나의 대출이력 가져오는 함수
	function getMyRentRecord(pageNum) {

		$.ajax({
			url: '/libraryService/getMyRentRecord/' + pageNum ,
			method: 'GET',
			success: function (result) {
				console.log(typeof result);
				console.log("reserveCnt: " + result.rentRecordCnt);
				console.log("reserveList: " + result.list)
				
				 showMyRentRecord(result.rentRecordCnt, result.list); 
				
			},
			error: function () {
				alert('댓글 리스트 가져오기 오류 발생...');
			}
		});
	} //getMyReserveData() 

	getMyRentRecord(1);

	// 대출리스트 블록 페이지 이동 이벤트
	$('#myRentRecordBlock').on('click', 'li a', function (event) {

		// a태그의 기본기능 하이퍼링크 막기
		event.preventDefault();
		
		var targetPageNum = $(this).attr('href');
		console.log('targetPageNum : ' + targetPageNum);

		if (targetPageNum == '#') {
			return;
		}
		
		pageNum = targetPageNum;

		getMyRentRecord(pageNum);
	});

	</script>
	<script>

	//나의 에약도서 블록페이지 함수
	function showReserveBlock(bookSubCnt) {

		console.log("예약 블록갯수: " + bookSubCnt)

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

		var i = 1;
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
			
			str += '<li class="' + active + ' page-item"><a class="page-link" href="'+ i +'">'+ i +'</a></li>'
			
			}

		if (next) {
			str += '<li class="page-item"><a class="page-link" href="'+ (startPage + pageBlock) +'">다음</a></li>';
		} else {
			str += '<li class="page-item disabled"><a class="page-link" href="#">다음</a></li>';
		}
		str += '	<li class="page-item"><a class="page-link" href="'+ pageCount +'">>></a></li>';
		str += '</ul>'
		i ++;
		$('#reserveBlock').html(str);

	}// showReserveBlock()
	

	 //나의 예약도서 목록 가져오는 함수
	function showReserveList(bookSubCnt, list) {

		var i = 1;
		var str = '';
		var id = "${ id }"
		console.log("갯수: " + bookSubCnt);
		console.log("리스트: " + list);
		console.log("아이디: " + id);

		if (list == null || list.length == 0) {

			str += '	<tr>';
			str += '		<td colspan="6"></td>';
			str += '	</tr>';
			

			$('.myReserveList').html(str); 
			return;
		}

		for (let reserve of list) {
			str += '	<tr>';
			str += '		<td>'+ i +'</td>';
			str += '		<td style="text-align: left;" class="subject">'+ reserve.bookname +'</td>';
			if (reserve.reserver2 == id) {
				str += '	<td>예약중</td>';	
			} else if(reserve.reserver == id && reserve.reserveStart != "" && reserve.reserveEnd != ""){
				str += '	<td>신청 대기중</td>';
			} else if(reserve.reserver == id && reserve.reserveStart == "" && reserve.reserveEnd == ""){
				str += '	<td>예약중</td>';	
			}
			
			if(reserve.reserver == id && reserve.reserveStart != "" && reserve.reserveEnd != "") {
				str += '	<td>'+ reserve.reserveEnd +'</td>';
			} else {
				str += '	<td></td>'
			}
			
			if (reserve.reserver == id) {
				str += '	<td>1</td>';	
			} else if(reserve.reserver2 == id) {
				str += '	<td>2</td>';
			} 
				str += '	<td>';
	
			if(reserve.status == 0){
				
				if (reserve.reserveStart !="" && reserve.reserveEnd != "" && reserve.reserver == id) {
					str += '		<button type="button" class="btn-custom" onclick="apply('+ reserve.serialNum +')">도서신청</button>';	
				} 
				
				if (reserve.reserveStart !="" && reserve.reserver !="" && reserve.reserver == id) {
					str += '		<button type="button" class="btn-custom" onclick="cancel1('+ reserve.serialNum +')">예약취소</button>';
				} else if(reserve.reserveStart =="" && reserve.reserver !="" && reserve.reserver == id) {
					str += '		<button type="button" class="btn-custom" onclick="cancel2('+ reserve.serialNum +')">예약취소</button>';
				} else {
					str += '		<button type="button" class="btn-custom" onclick="cancel3('+ reserve.serialNum +')">예약취소</button>';
				}
				
			} else if(reserve.status > 0){
		
				str += '			<button type="button">사용불가</button>';
			}
			str += '	   </td>';
			str += '	</tr>';

			i++;
		} // for		

		$('.myReserveList').html(str);

		showReserveBlock(bookSubCnt)

	} // showReserveList() 
	

	// 나의 예약도서 정보 가져오는 함수
	function getMyReserveData(pageNum) {

		$.ajax({
			url: '/libraryService/myReserveList/' + pageNum ,
			method: 'GET',
			success: function (result) {
				console.log(typeof result);
				console.log("reserveCnt: " + result.bookSubCnt);
				console.log("reserveList: " + result.list)
				
				 showReserveList(result.bookSubCnt, result.list); 
				
			},
			error: function () {
				alert('댓글 리스트 가져오기 오류 발생...');
			}
		});
	} //getMyReserveData() 

	var pageNum = 1;
	getMyReserveData(1);

	// 신청리스트 블록 페이지 이동 이벤트
	$('#reserveBlock').on('click', 'li a', function (event) {

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


	</script>
	<script>

	//나의 대출도서 블록페이지 함수
	function showRentBlock(rentCnt) {

		console.log("rentCnt: " + rentCnt)

		// 한 페이지에 보여지는 댓글 갯수
		var pageSize = 5;
		// 총 페이지 갯수
		var pageCount = Math.ceil(rentCnt / pageSize);
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
		
		str += '<li class="' + active + ' page-item"><a class="page-link" href="'+ i +'">'+ i +'</a></li>'
		
		}

		if (next) {
			str += '<li class="page-item"><a class="page-link" href="'+ (startPage + pageBlock) +'">다음</a></li>';
		} else {
			str += '<li class="page-item disabled"><a class="page-link" href="#">다음</a></li>';
		}
		str += '	<li class="page-item"><a class="page-link" href="'+ pageCount +'">>></a></li>';
		str += '</ul>'

		$('#rentBlock').html(str);

	}// showRentBlock()

	 //나의 대출도서 목록 가져오는 함수
	function showRentList(rentCnt, list) {

		var i = 1;
		var str = '';
		var id = "${ id }"
		console.log("갯수: " + rentCnt);
		console.log("리스트: " + list);

		if (list == null || list.length == 0) {

			str += '	<tr>';
			str += '		<td colspan="6"></td>';
			str += '	</tr>';
			

			$('.myRentList').html(str); 
			return;
		}

		for (let rent of list) {
			var date = new Date(rent.rentStart);
			var today = new Date();
			var extension = rent.extension
			var diffDay = (today.getTime() - date.getTime()) > (1000*60*60*24*3);
			console.log("연장횟수: " + extension)

			
			str += '	<tr>';
			str += '		<td>'+ i +'</td>';
			str += '		<td>'+ rent.serialNum +'</td>';
			str += '		<td style="text-align: left;" class="subject">'+ rent.bookname +'</td>';
			str += '		<td>'+ rent.rentStart +'</td>';
			str += '		<td>'+ rent.rentEnd +'</td>';
			if(rent.reserver == '' && diffDay && rent.extension == 0){
				str += '		<td><button class="btn-custom" type="button" onclick="extension('+ rent.serialNum +')">대출연장</button></td>';
			} else {
				str += '		<td></td>';
			}	
			str += '	</tr>';
			i++;
		} // for		

		$('.myRentList').html(str);

		showRentBlock(rentCnt)

	} //  myRentList() 

	
	// 나의 대출도서 정보 가져오는 함수
	function getMyRentData(pageNum) {

		$.ajax({
			url: '/libraryService/myRentList/' + pageNum ,
			method: 'GET',
			success: function (result) {
				console.log(typeof result);
				console.log("reserveCnt: " + result.bookSubCnt);
				console.log("reserveList: " + result.list)
				
				 showRentList(result.bookSubCnt, result.list); 
				
			},
			error: function () {
				alert('댓글 리스트 가져오기 오류 발생...');
			}
		});
	} // getMyApplyData() 

	getMyRentData(1)
	
		// 대출리스트 블록 페이지 이동 이벤트
	$('#rentBlock').on('click', 'li a', function (event) {

		// a태그의 기본기능 하이퍼링크 막기
		event.preventDefault();
		
		var targetPageNum = $(this).attr('href');
		console.log('targetPageNum : ' + targetPageNum);

		if (targetPageNum == '#') {
			return;
		}
		
		pageNum = targetPageNum;

		getMyRentData(pageNum);
	});

	</script>
	<script>

	// 대출연장 버튼 클릭시 신청하기
	 function extension(result) {

	 	var id = "${ id }";	
		var today = new Date(); 	
		var hours = today.getHours();

		console.log(hours);

		if( hours >= 16  || hours < 1  ){

			alert("대출연장 가능시간이 아닙니다.\n ※ 대출연장 가능시간: 01:00 ~ 16:00");
		
		} else {
			
			console.log("눌름");
	
			var num = result;
	
			console.log("서브책 번호: " + num);
	
			var result = confirm('해당도서를 대출연장하시겠습니까?\n※ 도서연장은 1회(3일)에 한해 연장 신청이 가능합니다.');
	
				if(result){
				 	$.ajax({
						url: '/libraryService/extensionBook/' + num,
						method: 'GET',
						success: function (result) {
							
							alert(result);
							 getMyRentData(pageNum)
							
							
						}, 
						error: function () {
							alert('선택하신 도서는 대출이 불가능합니다. 다시 선택해주세요.');
							 getMyRentData(pageNum)
						}
					});
				} 

			} 


		}  


	</script>
</body>
</html>