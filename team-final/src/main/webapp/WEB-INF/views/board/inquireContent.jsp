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
		<div class="main-box" id="main-box_inq_con_li">
			<h2>${ boardVo.type eq 1 ? "오류신고" : "문의/건의사항" }</h2>
			<hr class="inq_con_line1" />
			<div class="inq_con_info_area">
				<ul class="inq_con_info_list">
					<li class="inq_con_info_item"><span class="inq_info_title">작성자: </span> <span class="info_date">${ boardVo.name }</span></li>
					<c:if test="${ boardVo.type gt 0  }">
						<li class="inq_con_info_item">
							<span class="inq_info_title">|&nbsp;&nbsp;답변상태: </span><span class="inq_info_hits">
							${ boardVo.status eq 1 ? '답변 대기중' : '답변완료' }</span>
						</li>
					</c:if>
					<li class="inq_con_info_item"><span class="inq_info_title">|&nbsp;&nbsp;등록일: </span> <span class="info_date">${ boardVo.regDate }</span></li>
					<li class="inq_con_info_item"><span class="inq_info_title">|&nbsp;&nbsp;조회수: </span><span class="inq_info_hits">${ boardVo.readcount }</span></li>
				</ul>
			</div>
			<hr class="inq_con_line2" />
			<div class="inq_board_contents">
				<div class="inq_contens_c">
				
					<h3 align="left">${ boardVo.subject }</h3>
					<br>
					<p>
						${ boardVo.content }
					</p>
				</div>
			</div>
			<div id="inq_con_btn" align="right">
				<c:if test="${ not empty id and (id eq 'admin' or id eq boardVo.id) }">
					<button onclick="location.href = '/board/modify?num=${ boardVo.num }&pageNum=${ pageNum }'">수정</button>
					<button onclick="remove()">삭제</button>
				</c:if>	
				<c:if test="${ not empty id and id eq 'admin' and boardVo.status gt 0}">
					<button type="button" onclick="location.href='/board/reply?reRef=${ boardVo.reRef }&reLev=${ boardVo.reLev }&reSeq=${ boardVo.reSeq }&pageNum=${ pageNum }&subject=${ boardVo.subject }&secret=${ boardVo.secret }'">답글</button>
				</c:if>
				<button onclick="location.href='/board/inquire?pageNum=${ pageNum }'">목록</button>
			</div>
			<hr class="inq_con_line4" />
			
			
			<!--댓글 시작 -->
			<h4>
				<i class="fas fa-comment-dots"></i>댓글
			</h4>
			<!-- 댓글적기 -->
			<div class="cmtSection">
				<div class="comment-box">
					<div class="comment-body">
						<p class="name">작성자 이름</p>
						<p>작성자 코멘트 작성자 코멘트 작성자 코멘트 작성자 코멘트</p>
						<p class="date">2020.01.01</p>
						<div class="comment-btn">
							<button>답글</button>
							<button>수정</button>
							<button>삭제</button>
						</div>
					</div>
				</div>
			</div>
			<div id="update-box" class="collapse"></div>
			<div class="comment-write">
				<p class="bold">댓글 쓰기</p>
				<textarea class="comment" ${boardVo.id eq id or id eq 'admin' ? '' : 'disabled'}></textarea>
				<div class="comment-button">
					<button id="commentRegister" ${boardVo.id eq id or id eq 'admin' ? '' : 'disabled'}>작성</button>
				</div>
			</div>

			

			
			
			<!-- 답변부분 -->
			<hr class="inq_con_line4" />
			<c:if test="${ replyCount eq 1 }">
				<div class="inq_con_answer_area">
					<a class="inq_con_answer"><i class="fab fa-replyd"></i>&nbsp;답변: ${ reply.subject }</a>
					<hr class="inq_con_line5" />
					<ul class="inq_con_an_list">
						<li class="inq_con_an_item"><span class="inq_info_title">작성자: </span><span class="inq_an_hits">${ reply.name }</span></li>
						<li class="inq_con_an_item"><span class="inq_an_title">|&nbsp;&nbsp;등록일:</span> <span class="an_date"> ${ reply.regDate }</span></li>
					</ul>
					<hr class="inq_con_line3" />
					<p>
						${ reply.content }
					</p>
				</div>
			</c:if>
		</div>
	</div>
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<!-- footer 끝 -->
	<script src="/script/jquery-3.5.1.js"></script>
	<script src="/script/bootstrap.js"></script>
	<script src="/script/menuActive.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.27.0/moment-with-locales.min.js"></script>
	<script>

var loginId = '${ id }'; //세션 아이디값
var bno = ${ boardVo.num }; // 현재 게시판 글번호

//함수 정의용

//글 삭제 함수
function remove() {
	var result = confirm('글을 정말 삭제하시겠습니까?');
	if(${boardVo.status} > 0){
		
		if (result) {
			location.href = '/board/deleteContent?reRef=${ boardVo.reRef }&pageNum=${ pageNum }';
		}
		
	} else {
		location.href = '/board/deleteReply?reRef=${ boardVo.reRef }&num=${ boardVo.num }&pageNum=${ pageNum }&';
	}
} // remove()

// 댓글 시간 설정 함수
function displayTime(timeValue) {
	console.log("timeValue의 타입: " + typeof timeValue);
	console.log("timeValue의 값: " + timeValue);

	moment.locale('ko');

	var time = moment().format();     
	var format = moment(timeValue).startOf('hour').fromNow(); 

	console.log("time의 값: " + time); 
	console.log("timeValue의 값: " + timeValue); 
	console.log("format의 값: " + format); 
	
	var today = new Date();
	var date = new Date(timeValue); // new Date('2020-07-20T14:56:45');

	console.log("date의 값: " + date);
	console.log("date의 값: " + date);
	
	var gap = today.getTime() - date.getTime(); // 밀리초 차이값
	var oneDay = 1000 * 60 * 60 * 24;
	//var index = timeValue.indexOf('T');
	var strArr = timeValue.split('T');
	var str = '';

	console.log("gap의 값: " + gap);
	
	if (gap < oneDay) { // '14:56:45'
		//str = timeValue.substring(index + 1, timeValue.length-1);
		str = format
	} else { // '2020-07-20'
		//str = timeValue.substring(0, index);
		str = strArr[0];
	}

	console.log(str);
	return str;
} // displayTime()


//댓글목록(전체) 데이터 가공하여 화면에 보여주는 함수
function showReplyList(list) {

	var str = '';

	if (list == null || list.length == 0) {
		//$('ul.media-list').html('');
		$('div.comment-box').hide(); // remove()와 구분 주의!
		return;
	}

	
	for (let comment of list) {
		if(comment.reLev == 0){
			str += '<div>';
			str += '	<div class="comment-box" data-cno="' + comment.cno + '" >';
			str += '		<div class="comment-body">';
			str += '			<p class="name" style="display:inline-block">' + comment.writer + '</p>';
		if(comment.updateDate == null){
			str += '			<p class="date" style="display:inline-block; margin-left:10px">' + displayTime(comment.regDate) + '</p>';
		} else {
			str += '			<p class="date" style="display:inline-block; margin-left:10px">' + displayTime(comment.updateDate) + '</p>';
		}
			str += '			<p style="margin-top:10px">' + comment.comment + '</p>';
			str += '			<div style="MARGIN-TOP: 10PX;" class="comment-btn">';
			str += '				<c:if test="${ not empty id and (id eq 'admin')}">';
			str += '					<button class="commentReply" type="button">답글</button>';
			str += '				</c:if>';			
			str += '				<c:if test="${ not empty id and (id eq 'admin' or id eq boardVo.id)}">';		
			str += '					<button class="commentDelete" type="button">삭제</button>';
			str += '					<button class="commentModify" type="button">수정</button>';
			str += '				</c:if>';
			str += '			</div>';
			str += '		</div>';
			str += '	</div>';
			str += '	<div class="reply-box"></div>';
			str += '	<div class="update-box"></div>';
			str += '</div>';
		} else {

			str += '<div>';
			str += '	<div class="comment-box"  style="margin-left: 30px;" data-cno="' + comment.cno + '" >';
			str += '		<div class="comment-body">';
			str += '			<p class="name" style="display:inline-block;"><i class="fas fa-reply-all"></i>' + comment.writer + '</p>';
		if(comment.updateDate == null){
			str += '			<p class="date" style="display:inline-block; margin-left:10px">' + displayTime(comment.regDate) + '</p>';
		} else {
			str += '			<p class="date" style="display:inline-block; margin-left:10px">' + displayTime(comment.updateDate) + '</p>';
		}
			str += '			<p style="margin-top:10px">' + comment.comment + '</p>';
			str += '			<div class="comment-btn">';			
			str += '				<c:if test="${ not empty id and (id eq 'admin' or id eq boardVo.id)}">';		
			str += '					<button class="commentDelete" type="button">삭제</button>';
			str += '					<button class="commentModify" type="button">수정</button>';
			str += '				</c:if>';
			str += '			</div>';
			str += '		</div>';
			str += '	</div>';
			str += '	<div class="reply-box"></div>';
			str += '	<div class="update-box"></div>';
			str += '</div>';

			}
		
	} // for

	$('div.cmtSection').html(str); // 댓글리스트(댓글게시판) 화면출력 (기존에 있던 기본 내용들은 밀어버리고 데이터가 들어간다.)
} // processList()


// 댓글 정보 가져오는 함수
function getReplyData() {

	$.ajax({
		url: '/comment/pages/' + bno,
		method: 'GET',
		success: function (result) {
			console.log(typeof result);
			console.log(result);
			
			showReplyList(result);
			
		},
		error: function () {
			alert('댓글 리스트 가져오기 오류 발생...');
		}
	});
} // getReplyData()

getReplyData();

//댓글등록 버튼을 클릭했을때
$('#commentRegister').on('click', function () {

 	var comment = {
		bno: bno,
		comment: $(".comment").val()
	}; 
	console.log('comment : ' + comment);

	 var str = JSON.stringify(comment);
	console.log('str : ' + str);

	$.ajax({
		method: 'POST',
		url: '/comment/new',
		data: str,
		contentType: 'application/json; charset=utf-8',
		success: function (result) {
			alert(result);

			$(".comment").val("")

			getReplyData();
		},
		error: function () {
			alert('댓글등록 에러발생...');
		}
	}); 

});


$(document).on('click', '.commentDelete', function () {
    // your function here
    
    var cno = $(this).closest("div.comment-box").data('cno');
	console.log(cno);

	var isRemove = confirm('댓글을 정말로 삭제하시겠습니까?');
	if (!isRemove) {
		return;
	}

	$.ajax({
		method: 'DELETE',
		url: '/comment/' + cno,
		success: function (result) {
			alert(result);
			getReplyData();
		},
		error: function () {
			alert('댓글 삭제 오류 발생...');
		}

	});
});


//댓글에서 수정버튼 누를시 수정입력 부분 추가
$(document).on('click', '.commentModify', function () {
    // your function here   
	var str = '';
	var main = $(this).closest("div.comment-box");
	var comment = $(this).closest("div.comment-btn").prev().html();
	
	console.log("이전: " + comment);	
	
	console.log("이전: " + main.next().next().html());

	if(main.next().next().html() == ''){
		str += '<div class="invisible-box">';
		str += 		'<p>';
		str += 			'<i class="fas fa-edit">&nbsp;수정하기</i>';
		str += 		'</p>';
		str += 		'<form>';
		str += 		'	<textarea class="modifyCmt">'+ comment +'</textarea>';
		str += 			'<div class="comment-button">';
		str += 			'	<button class="modify" type="button">수정</button>';
		str += 			'</div>';
		str += 		'</form>';
		str += '</div>';

		main.next().next().html(str);
	} else {

		main.next().next().html('');

	}
	
});

//댓글에서 답글버튼 누를시 답글입력 부분 추가
$(document).on('click', '.commentReply', function (list) {
    // your function here   
	var str = '';
	var main = $(this).closest("div.comment-box");

	if(main.next().html() == ''){
		str += '<div class="invisible-box">';
		str += 		'<p>';
		str += 			'<i class="fas fa-reply-all">&nbsp;답글</i>';
		str += 		'</p>';
		str += 		'<form>';
		str += 		'	<textarea class="replyCmt"></textarea>';
		str += 			'<div class="comment-button">';
		str += 			'	<button class="reply" type="button">작성</button>';
		str += 			'</div>';
		str += 		'</form>';
		str += '</div>';

		main.next().html(str);
	} else {

		main.next().html('');

	}
	
});

</script>

<script>
//수정작성 부분에서 수정버튼 누를시 데이터 넘기기.
$(document).on('click', '.modify', function () {	

	var cno = $(this).closest("div.update-box").prev().prev().data('cno');
	/* var main = $(this).closest("div.update-box").prev().prev(); */
	console.log(cno);

	var comment = {
			comment: $(this).closest("div.comment-button").prev().val()
		};

	var str = JSON.stringify(comment);

	$.ajax({
		method: 'PUT',
		url: '/comment/' + cno,
		data: str,
		contentType: 'application/json; charset=utf-8',
		success: function (result) {
			alert(result);
			getReplyData();
		},
		error: function () {
			alert('댓글 수정 오류 발생...')
		}
	});
})

//답글작성 부분에서  작성버튼 누를시 데이터 넘기기
$(document).on('click', '.reply', function () {	

	var cno = $(this).closest("div.reply-box").prev().data('cno');
	console.log("cno: " + cno);

	var comment = $(this).closest("div.comment-button").prev().val();
	console.log("comment: " + comment);

	var replyComment = {

			bno: bno,
			reRef: cno,
			comment : comment
			
	};

	  var str = JSON.stringify(replyComment);
		console.log('str : ' + str);

		$.ajax({
			method: 'POST',
			url: '/comment/replyNew',
			data: str,
			contentType: 'application/json; charset=utf-8',
			success: function (result) {
				alert(result);

				getReplyData();
			},
			error: function () {
				alert('댓글등록 에러발생...');
			}
		});  

	
})	
	
</script>
</body>



</html>
