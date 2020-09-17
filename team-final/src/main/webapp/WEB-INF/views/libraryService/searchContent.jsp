<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/library/bookinfo.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/menu.jsp" />
	<div id="wrapper">
		<div class="all-box">
			<h2>도서 상세정보</h2>
			<div class="sc-box">
				<div class="img-box col-sm-12 col-md-3">
					<img src="/images/main/bookimg.png">
				</div>
				<div class="info-box col-sm-12 col-md-9">
					<table class="table">
						<tbody>
							<tr style="color: green">
								<td colspan="2">
									<h4>
										<b>${ bookVo.bookName }</b>
									</h4>
								</td>
							</tr>
							<tr>
								<th scope="col">출판사</th>
								<td style="text-align: left;">${ bookVo.publisher }</td>
							</tr>
							<tr>
								<th scope="col">저자</th>
								<td style="text-align: left;">${ bookVo.author }</td>
							</tr>
							<tr>
								<th scope="col">출판년도</th>
								<td style="text-align: left;">${ bookVo.pubYear }</td>
							</tr>
							<tr>
								<th scope="col">도서 등록일</th>
								<td style="text-align: left;">${ bookVo.holdDate }</td>
							</tr>
							<tr>
								<th scope="col">대출 횟수</th>
								<td style="text-align: left;">${ bookVo.rentCnt }</td>
							</tr>
							<tr>
								<th scope="col">책 설명</th>
								<td style="text-align: left;">${ bookVo.description }</td>
							</tr>
						</tbody>
					</table>
				</div>
			<c:choose>				
				<c:when test="${bookLike}"> 	
					<button type="button" id="likeBook" onclick="changeLikeButton(event); likeTrans();" class="btn btn-primary active" style="background: #771a1a; width: 80px; height: 30px; FLOAT: RIGHT; margin-top: -30px;">
						<span style="font-size: 12px; position: relative; bottom: 6px;">찜하기</span>
					</button>
				</c:when>
				<c:otherwise>
					<button type="button" id="likeBook" onclick="changeLikeButton(event); likeTrans();" class="btn btn-primary" style="background: #154063; width: 80px; height: 30px; FLOAT: RIGHT; margin-top: -30px;">
						<span style="font-size: 12px; position: relative; bottom: 6px">찜하기</span>
					</button>
				</c:otherwise>
			</c:choose>
			</div>
			<div class="clearfix"></div>
		</div>
		<div class="stock-box">
			<h2 style="font-size: 20px;">소장정보</h2>
			<div class="book-loan-status">
				<table class="table3">
					<thead style="text-align: center;">
						<tr>
							<td id="br-li">도서관명</td>
							<td class="small-n">등록번호</td>
							<td class="small-n">도서번호</td>
							<td>대출여부</td>
							<td>반납예정</td>
							<td>예약자수</td>
							<td>예약</td>
							<c:if test="${ id eq 'admin'}">
								<td>기능</td>
							</c:if>
						</tr>
					</thead>
					<tbody class="bookSubData" style="text-align: center;">
						<tr>
							<td>중앙도서관</td>
							<td class="small-n">1</td>
							<td class="small-n">1</td>
							<td>가능(대출가능)</td>
							<td>
								<button type="button" id="like" class="btn btn-primary" style="background: #95959c; width: 80px; height: 30px;">
									<span style="font-size: 12px; position: relative; bottom: 6px">도서신청</span>
								</button>
							</td>
							<td>0</td>
							<td></td>
						</tr>
						<tr>
							<td>중앙도서관</td>
							<td class="small-n">1</td>
							<td class="small-n">1</td>
							<td>불가능(대출중)</td>
							<td>20201011</td>
							<td>0</td>
							<td>
								<button type="button" id="like" class="btn btn-primary" style="background: #95959c; width: 80px; height: 30px;">
									<span style="font-size: 12px; position: relative; bottom: 6px">도서예약</span>
								</button>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<!-- footer 끝 -->
	<script src="/script/jquery-3.5.1.js"></script>
	<script>

	var booklike = ${bookLike};
	var bookCodetest = ${bookVo.bookCode};
	var memNum = ${memNum};

	//찜하기 클릭시 처리
	function likeTrans(){

		if(booklike){
			$.ajax({
				//ajax는 기본적으로 get 방식이므로 method 지정이 필요
				method: 'DELETE',
				url: '/libraryService/ajaxLikeDel',
				data: { bookCode: bookCodetest, memNum: memNum },
				success: function () {
					console.log("DELELTE");
					booklike = false;
				}
			});		
		}
		else{
			$.ajax({
				method: 'POST',
				url: '/libraryService/ajaxLikeAdd',
				data: { bookCode: bookCodetest, memNum: memNum },
				success: function () {
					console.log("SUCCESS");
					booklike = true;
				}
			});		
		}	
	}


	function changeLikeButton(event){
		if ($('#likeBook').hasClass('active')) {
			$('#likeBook').removeClass('active');

			$('#likeBook').css('backgroundColor', '#154063');
		} else {
			$('#likeBook').addClass('active');

			$('#likeBook').css('backgroundColor', '#771a1a');
		}

	}
	
	</script>
	
	<script>

	var id = "${ id }";	
	var bookCode = "${bookVo.bookCode}";
	console.log("bookCode: " +bookCode);
	
	function removeBookSub(serialNum){

		var result = confirm('해당도서를 삭제하시겠습니까?');
		
			if(result){
			$.ajax({
				url: '/libraryService/RemoveSubBook/' + serialNum ,
				method: 'GET',
				success: function (result) {
	
					alert(result);
					getBookData(bookCode)
					
				}
			});
		}
	}

	function useStop(serialNum){

		var result = confirm('해당도서의 사용을 중지하시겠습니까?');
		
			if(result){
			$.ajax({
				url: '/libraryService/useStop/' + serialNum ,
				method: 'GET',
				success: function (result) {
	
					alert(result);
					getBookData(bookCode)
					
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
					getBookData(bookCode)
					
				}
			});
		}
	}

	// 도서예약 취소 버튼 클릭시 예약 취소1
	 function cancel1(serialNum) {

	 	var id = "${ id }";	


		if(id == null || id == ''){

			alert("도서예약 취소는 회원만 가능합니다. 로그인 해주세요.");
			
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
							getBookData(bookCode);
							
						}, 
						error: function () {
							alert('선택하신 도서의 예약취소가 실패했습니다');
							getBookData(bookCode);
						}
					});
				} 

			} 
		}

		// 도서예약 취소 버튼 클릭시 예약 취소2
	 function cancel2(serialNum) {

	 	var id = "${ id }";	


		if(id == null || id == ''){

			alert("도서예약 취소는 회원만 가능합니다. 로그인 해주세요.");
			
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
							getBookData(bookCode);
							
						}, 
						error: function () {
							alert('선택하신 도서의 예약취소가 실패했습니다');
							getBookData(bookCode);
						}
					});
				} 

			} 
		}

		// 도서예약 취소 버튼 클릭시 예약 취소3
	 function cancel3(serialNum) {

	 	var id = "${ id }";		


		if(id == null || id == ''){

			alert("도서예약 취소는 회원만 가능합니다. 로그인 해주세요.");
			
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
							getBookData(bookCode);
							
						}, 
						error: function () {
							alert('선택하신 도서의 예약취소가 실패했습니다');
							getBookData(bookCode);
						}
					});
				} 

			} 
		}


	</script>
	<script>

	//도서 상세정보 가져오는 함수
	function showBookList(list) {

		console.log("list: " + list)
		
		var str = '';

		console.log("아이디 값: " + id)
		
		if ((list == null || list.length == 0) && id != "admin" ) {

			str += '	<tr>';
			str += '		<td colspan="7"></td>';
			str += '	</tr>';
			

			$('.bookSubData').html(str);
			return;
		} 


		for (let book of list) {
			str += '<tr class="tr" data-num="' + book.serialNum + '"> ';
			str += '		<td>중앙도서관</td>';
			str += '		<td class="small-n">'+ book.serialNum +'</td>';
			str += '		<td class="small-n">'+ book.bookcode +'</td>';
			if (book.isRent == 1 && book.status == 0) {
				str += '	<td><b>불가능(대출중)</b></td>';	
			}  else if(book.isReserve > 0 && book.isRent == 0 && book.isApply == 0 && book.status == 0) {
				str += '	<td><b>불가능(예약중)</b></td>';
			}  else if(book.isApply == 1 && book.status == 0) {
				str += '	<td><b>불가능(신청중)</b></td>';
			}  else if(book.status > 0) {
				str += '	<td><b>불가능(사용중지)</b></td>';
			}  else {
				str += '	<td><b>가능(대출가능)</b></td>';
			} 
			if(book.status == 0){
				if (book.isRent > 0) {
					str += '	<td>'+ book.rentEnd+'</td>';
				}  else if(book.applyer != id && (book.isApply > 0 || book.isReserve > 0)) {
					str += '	<td></td>';
				}  else if(book.applyer == id ){
					str += '<td><button type="button" onclick="applyCancel('+ book.serialNum+')" id="like" class="btn btn-primary" style="background:#95959c; width: 80px; height: 30px;"><span style="font-size: 12px; position: relative; bottom: 6px">신청취소</span></button></td>';
				}  else {
					str += '<td><button type="button" onclick="apply('+ book.serialNum+')" id="like" class="btn btn-primary" style="background:#95959c; width: 80px; height: 30px;"><span style="font-size: 12px; position: relative; bottom: 6px">도서신청</span></button></td>';
				}
			} else {
					str += '	<td></td>';
				}
				str += '    <td>'+ book.isReserve +'</td>';

			if(book.status == 0){
				if (book.reserver2 == id && book.isReserve == 2) {
					str += '<td><button type="button" onclick="cancel3('+ book.serialNum +')" id="like" class="btn btn-primary" style="background:#95959c; width: 80px; height: 30px;"><span style="font-size: 12px; position: relative; bottom: 6px">예약취소</span></button></td>';
				} else if(book.applyer != id && book.reserver != id && book.status == 0 && (book.isRent > 0 || book.isApply > 0)){
					str += '<td><button type="button" onclick="reserve('+ book.serialNum+')" id="like" class="btn btn-primary" style="background:#95959c; width: 80px; height: 30px;"><span style="font-size: 12px; position: relative; bottom: 6px">도서예약</span></button></td>';
				} else if(book.reserver == id && book.reserverStart != ""){
					str += '<td><button type="button" onclick="cancel1('+ book.serialNum +')" id="like" class="btn btn-primary" style="background:#95959c; width: 80px; height: 30px;"><span style="font-size: 12px; position: relative; bottom: 6px">예약취소</span></button></td>';
				} else if(book.reserver == id && (book.isRent != "" || book.isApply != "")){
					str += '<td><button type="button" onclick="cancel2('+ book.serialNum +')" id="like" class="btn btn-primary" style="background:#95959c; width: 80px; height: 30px;"><span style="font-size: 12px; position: relative; bottom: 6px">예약취소</span></button></td>';
				} else {
					str += '<td></td>';
				}
			} else {
				str += '<td><button type="button" id="like" class="btn btn-primary" style="background:#95959c; width: 80px; height: 30px;"><span style="font-size: 12px; position: relative; bottom: 6px">사용중지</span></button></td>';
			}



			if(id == "admin") {
				if(book.status == 0){
					str += '<td><button type="button" onclick="useStop('+ book.serialNum+')" id="like" class="btn btn-primary" style="background:#95959c; width: 80px; height: 30px;"><span style="font-size: 12px; position: relative; bottom: 6px">사용중지</span></button>';
				} else if(book.status > 0){
					str += '<td><button type="button" onclick="available('+ book.serialNum+')" id="like" class="btn btn-primary" style="background:#95959c; width: 80px; height: 30px;"><span style="font-size: 12px; position: relative; bottom: 6px">사용가능</span></button>';
				}
				str += '&nbsp;<button type="button" onclick="removeBookSub('+ book.serialNum+')" id="like" class="btn btn-primary" style="background:#95959c; width: 80px; height: 30px;"><span style="font-size: 12px; position: relative; bottom: 6px">도서삭제</span></button></td>';
			}
			str += '</tr>';

			console.log(book.serialNum);
			
		} // for

		$('.bookSubData').html(str);


	} // showInquireList()


	// 신청글 정보 가져오는 함수
	function getBookData(bookCode) {
		
		$.ajax({
			url: '/libraryService/bookData/' + bookCode ,
			method: 'GET',
			success: function (result) {
				console.log(typeof result);
				console.log("list: " + result);
				
				showBookList(result);	
			},
			error: function () {
				alert('책 리스트 정보 가져오기 오류 발생...');
			}
		});
	} // getMyInquireData()
	

	getBookData(bookCode);


	// 도서신청 버튼 클릭시 신청하기
	 function apply(result) {

		var today = new Date(); 	
		var hours = today.getHours();

		console.log(hours);


		if(id == null || id == ''){

			alert("도서신청은 회원만 가능합니다. 로그인 해주세요.");
			
		} else if( hours >= 17 || hours < 1 ){

			alert("도서신청 가능시간이 아닙니다.\n ※ 도서신청 가능시간: 01:00 ~ 17:00");
		
		} else {
			
			console.log("눌름");
	
			var num = result;
	
			console.log("서브책 번호: " + num);
	
			var result = confirm('해당도서를 신청하시겠습니까?\n- 예약내역확인: 마이페이지> 도서관리> 신청도서\n- 수령시간: 10:00 ~ 17:00\n- 신청/예약권수: 1인 최대 5권\n※ 도서수령시 회원증 필수지참, 미수령시 신청 다음날 자동취소');
	
				if(result){
				 	$.ajax({
						url: '/libraryService/bookApply/' + num,
						method: 'GET',
						success: function (result) {
							
							alert(result);
							getBookData(bookCode);
							
						}, 
						error: function () {
							alert('선택하신 도서가 이미 신청 중이거나 도서 신청가능 횟수를 초과하셨습니다. 다시 선택해주세요.\n※ 신청권수: 1인 최대 5권');
							getBookData(bookCode);
						}
					});
				} 

			} 


		}  

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
							getBookData(bookCode);
							
						}, 
						error: function () {
							alert('선택하신 도서 신청 취소가 불가능합니다. 다시 선택해주세요.');
							getBookData(bookCode);
						}
					});
				} 

		} 

	// 도서예약 번튼 클릭시 예약하기
	 function reserve(result) {

		var today = new Date(); 	
		var hours = today.getHours();

		console.log(hours);


		if(id == null || id == ''){

			alert("도서예약은 회원만 가능합니다. 로그인 해주세요.");
			
		} else if(hours >= 17 || hours < 1){

			alert("도서예약 가능시간이 아닙니다.\n ※ 01:00 ~ 17:00 까지 가능");
		
		} else {
			
			console.log("눌름");
	
			var num = result;
	
			console.log("서브책 번호: " + num);
	
			var result = confirm('해당도서를 예약하시겠습니까?\n- 예약내역확인: 마이페이지> 도서관리> 예약도서\n- 도서신청이 가능해지면 메일로 알림발송\n※ 예약 후 도서신청은 예약도서 페이지에서 신청버튼 클릭 \n※ 알림 후 다음날까지 미 신청시 자동취소\n※ 예약취소는 예약도서 페이지에서 가능');
	
				if(result){
 				 	$.ajax({
						url: '/libraryService/bookReserve/' + num,
						method: 'GET',
						success: function (result) {
							
							alert(result);
							getBookData(bookCode);
							
						}, 
						error: function () {
							alert('선택하신 도서의 예약이 불가능합니다. 다시 선택해주세요.');
							getBookData(bookCode);
						}
					}); 
				} 

			} 


		}  
		
	</script>
	<script src="/script/jquery-3.5.1.js"></script>
	<script src="/script/bootstrap.js"></script>
	<script src="/script/menuActive.js"></script>
</body>
</html>
