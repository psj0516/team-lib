<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/chat/chat.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body onresize="parent.resizeTo(465,820)" onload="parent.resizeTo(465,820)">
	<div class="container">
		<c:set var="id" value="${ memberVo.id }" />
		<c:choose>
			<c:when test="${empty id}">
				<div class="chat-box">
					<div class="heading">
						<h5>채팅방은 로그인 후 이용 가능합니다.</h5>
						<div class="page">
							<button class="btn" onclick="goLogin()">로그인 하기</button>
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="chat-content"></div>
					<div class="chat-footer"></div>
				</div>
			</c:when>
			<c:otherwise>
				<input type="hidden" id="sessionId" value="">
				<div class="chat-box">
					<div class="heading">
						<div class="opened hidden">
							<h5>
								<span class="nametag">${ memberVo.name }</span>&nbsp;님,&nbsp;채팅방에&nbsp;접속중입니다.
							</h5>
						</div>
						<div class="closed">
							<h5>
								<span class="nametag">${ memberVo.name }</span>&nbsp;님,&nbsp;채팅방에&nbsp;어서오세요!
							</h5>
						</div>
						<div class="button-box">
							<button id="btnOpen" class="openbtn">참여하기</button>
							<button id="btnQuit" class="quitbtn hidden">종료하기</button>
						</div>
						<div class="clearfix"></div>
						<input type="hidden" id="userName" value="${ memberVo.name }">
					</div>
					<div class="chat-content"></div>
					<div class="chat-footer">
						<div id="yourMsg">
							<div class="message-box">
								<input type="text" id="chatMsg" placeholder="메시지를 입력하세요.">
								<button id="btnSend" class="btn">보내기</button>
							</div>
						</div>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
	<script src="/script/jquery-3.5.1.js"></script>
	<script src="/script/bootstrap.js"></script>
	<script>
		var ws; // 웹소켓 객체를 저장할 변수 선언

		function wsOpen() {
			console.log(location.host);
			// 웹브라우저가 웹소켓서버에 연결 요청하기
			ws = new WebSocket('wss://' + location.host + '/chatting');

			wsEvt(); // 웹소켓 객체에 이벤트 콜백메소드 등록하기

		} // wsOpen()

		function wsEvt() {

			// 소켓서버와 연결이 되면 호출됨
			ws.onopen = function() {
				$('#btnOpen').addClass("hidden");
				$('#btnQuit').removeClass("hidden");
				$('.closed').addClass("hidden");
				$('.opened').removeClass("hidden");

				$('#yourMsg').show();
				$('#chatMsg').focus();
			};

			// 소켓서버로부터 데이터를 받으면 호출됨
			ws.onmessage = function(event) {
				var jsonStr = event.data;

				if (jsonStr != null && jsonStr.trim() != '') {

					var obj = JSON.parse(jsonStr);

					if (obj.type == 'getId') {
						$('#sessionId').val(obj.sessionId);
					} else if (obj.type == 'message') {
						if (obj.sessionId == $('#sessionId').val()) {
							$('.chat-content').append(
									'<div class="me"><p>' + obj.userName
											+ '</p><span>' + obj.msg
											+ '</span></div>');
						} else {
							$('.chat-content').append(
									'<div class="others"><p>' + obj.userName
											+ '</p><span>' + obj.msg
											+ '</span></div>');
						}
					} else {
						console.warn('unknown type...');
					}
				}

				var top = $('.chat-content').prop('scrollHeight');
				$('.chat-content').prop('scrollTop', top);
			};

			// 소켓서버와 연결이 끊기면 호출됨
			ws.onclose = function() {
				$('#btnOpen').removeClass("hidden");
				$('#btnQuit').addClass("hidden");
				$('.closed').removeClass("hidden");
				$('.opened').addClass("hidden");

				$('#yourMsg').hide();
				$('#userName').focus();
			};

			// 소켓서버와 통신오류가 있을때 호출됨
			ws.onerror = function() {
				alert('웹소켓 통신 오류 발생...');
			};

		} // wsEvt()

		function send() {
			var obj = {
				type : 'message',
				sessionId : $('#sessionId').val(),
				userName : $('#userName').val(),
				msg : $('#chatMsg').val()
			};

			var jsonStr = JSON.stringify(obj); //json객체를 json문자열로 변환해서 리턴함
			if ($('#chatMsg').val() != null && $('#chatMsg').val() != '') {
				ws.send(jsonStr); // 웹소켓 서버에 json문자열 전송
			}

			$('#chatMsg').val('');
		} // send()

		$('#btnOpen').on('click', function() {
			wsOpen(); // 웹소켓서버에 연결하기
		});

		$('#btnQuit').on('click', function() {
			ws.close(); // 웹소켓 서버 연결을 끊기
		});

		$('#btnSend').on('click', function() {
			send();
		});

		$('#chatMsg').on('keydown', function(event) {
			if (event.keyCode == 13) { // 엔터키를 눌렸을때
				send();
			}
		});

		// 채팅이름 입력상자에 포커스 주기
		$('#userName').focus();

		function goLogin() {
			window.opener.location.href = '/member/login';
			window.close();

		}
	</script>
</body>
</html>
