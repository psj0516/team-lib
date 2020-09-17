<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/mypage/book-detail.css" rel="stylesheet" type="text/css" media="all" />
<script src="https://kit.fontawesome.com/f31fb562ea.js" crossorigin="anonymous"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/menu.jsp" />
	<div id="wrapper">
		<div class="col-md-9 col-sm-12">
			<h2>관심도서</h2>
			<table  id="like-list" class="books-box" >
				<!-- 책 한권 정보 시작 -->
		
				<!-- 책 한권 정보 끝 -->
			</table>
			<!-- 글 페이지 번호 -->
			<div id="likepage" class="text-center">
				<ul class="pagination">
				
				</ul>
			</div>
			<!-- 글 페이지 번호 -->
		</div>
	</div>
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<!-- footer -->
	<script src="/script/jquery-3.5.1.js"></script>
	<script src="/script/bootstrap.js"></script>
	<script src="/script/mypage/infoUpdateCheck.js"></script>
	<script src="/script/menuActive.js"></script>
	
	<script>
	function getBookLikeList(pageNum) {
		$.ajax({
			method : 'GET',
			url : '/mypage/books/like/'+pageNum,
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

	function showBookLikeList(likeCnt,list){
		var str ='';
		var urlString = '\'/libraryService/searchContent?bookCode=';
		console.log(likeCnt+'likCnt in showbooklist');
		
		if(list==null || list.length == 0){
			str += '<tr>';
			str += '	<td colspan="5">관심도서를 등록하지 않았습니다.</td>';
			str += '</tr>';
		} else{
			for(let book of list){
				str+= '<tr onclick="location.href='+urlString+book.bookCode+'\'">';
				str+= '	<td rowspan="2" class="thumb last-row">';
				str+= '		<img alt="책 썸네일"src="/images/main/book01.jpg">';
				str+= '	<td colspan="2"><span class="title">'+book.bookName+'</span></td>';
				str+= '</tr>';
				str+= '<tr class="last-row">';
				str+= '	<td>'+book.author+'<br>'+book.publisher+'<br>'+book.pubYear+'</td>';
				str+= '	<td class="book-ad">';
				str+= '		<input type="checkbox" id="'+book.bookCode+'_r" class="rsv">';
				str+= '		<label for="'+book.bookCode+'_r"><i class="fas fa-star"></i></label><span> 도서예약</span><br>';
				str+= '		<input type="checkbox" id="'+book.bookCode+'_f" class="fav" checked>';
				str+= '		<label for="'+book.bookCode+'_f"><i class="fas fa-heart"></i></label><span> 관심도서</span>';
				str+= '	</td>';
				str+= '</tr>';
				} //for
			
			}
		$('#like-list').html(str);
		showPagination(likeCnt);
		};


		function showPagination(likeCnt) { // replyCnt는 총 댓글갯수
			if (likeCnt == 0) {
				return;
			}

			var pageSize = 3;
			var pageCount = Math.ceil(likeCnt / pageSize);
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

			// 페이지블록 화면요소 만들기
			var str = '';
			str +='<ul class="pagination">';

			if (prev) {
				str += '	<li class="page-item"><a class="page-link" href="' + (startPage - pageBlock) + '">이전</a></li>';
			} else {
				str += '	<li class="disabled"><a href="#">이전</a></li>';
			}

			for (let i=startPage; i<=endPage; i++) {

				var active = (pageNum == i) ? 'active' : '';
				
				str += '	<li class="' + active + '"><a class="page-link" href="' + i + '">' + i + '</a></li>';
			}

			if (next) {
				str += '	<li class="page-item"><a href="' + (startPage + pageBlock) + '">다음</a></li>';
			} else {
				str += '	<li  class="page-item disabled"><a class="page-link" href="#">다음</a></li>';
			}
			
			str += '</ul>';

			$('div#likepage').html(str);
			
		} // showReplyPage()
		
		$('table#like-list').on('click', 'input.fav', function () { //cnt값을 줘서 0인거, 3인 경우 생각
			var $curTr = $(this).closest('tr.last-row');
			var $prevTr = $curTr.prev();

// 			$curTr.remove();
// 			$prevTr.remove();

			
			var bookCode = $(this).data('bookcode');
			
			console.log('selected bookCode'+bookCode);
			 // ajax delete -> success function 안에서
			$.ajax({
				method: 'DELETE',
				url : '/mypage/books/like/',
				data : {bookCode : bookCode},
				success : function(){
					console.log('deleteLike success');
// 					$curTr.remove();
// 					$prevTr.remove();
					getBookLikeList(pageNum);
	
					},
				error : function(e){
					console.log(e)
					console.log ('deleteLike fail');
					}
					
				});
		});

		// 동적 이벤트 연결(이벤트 위임 방식 사용)
		$('div#likepage').on('click', 'li a', function (event) {
			// a태그의 기본기능 하이퍼링크 막기
			event.preventDefault();

			var targetPageNum = $(this).attr('href'); // attr() VS prop()
			console.log('targetPageNum : ' + targetPageNum);

			if (targetPageNum == '#') {
				return;
			}
			
			pageNum = targetPageNum;

			getBookLikeList(pageNum);
		});
	
		var pageNum=1;
		getBookLikeList(pageNum);

		
	</script>
</body>
</html>