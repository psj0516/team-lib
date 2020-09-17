<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/library/seat.css" rel="stylesheet" type="text/css" media="all" />
<style>
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/menu.jsp" />
	<div id="wrapper">
		<jsp:include page="/WEB-INF/views/include/lib-menu.jsp" />
		<div class="col-md-10 col-sm-10 col-xs-12">
			<h2>좌석 예약</h2>
			<form id="seatRes" action="/library/seatRes" method="post">
				<input type="hidden" name="memNum" value="${ memNum }">
				<div class="seat-res-box">
					<div class="seat-box">
						<div class="radio-box">
							<c:forEach var="seat" items="${ allSeat }" begin="0" end="1000" step="10">
								<div class="seat-row">
									<input type="radio" id="${ seat.getSeatNum() }" class="useSeat" name="seatNum" value="${ seat.getSeatNum() }">
									<label for="${ seat.getSeatNum() }" class="${ seat.getSeatStatus() }">${ seat.getSeatNum() }</label> <br>
									<c:forEach var="seat" items="${ allSeat }" begin="${ seat.getSeatNum() }" end="${ seat.getSeatNum() + 8 }">
										<input type="radio" id="${ seat.getSeatNum() }" class="useSeat" name="seatNum" value="${ seat.getSeatNum() }">
										<label for="${ seat.getSeatNum() }" class="${ seat.getSeatStatus() }">${ seat.getSeatNum() }</label>
										<br>
									</c:forEach>
								</div>
							</c:forEach>
						</div>	
						<div class="clearfix"></div>
					</div>
					<div class="seat-info">
						<h3>열람실 이용시간</h3>
						<p>평일 : 8:00 ~ 24:00</p>
						<p>주말 : 8:00 ~ 20:00</p>
						<h3>열람실 이용수칙</h3>
						<p>1. 좌석은 1인 1좌석제로 운영됩니다.</p>
						<p>2. 좌석은 한 번에 최대 3시간까지 이용할 수 있습니다.</p>
						<p>3. 장시간 이석 및 열람실의 분위기를 해치는 경우에는 강제퇴실 될 수 있습니다.</p>
						<p>4. 휴대폰은 다른 이용자들을 위하여 진동으로, 자료실 밖에서 이용해 주세요.</p>
						<p>5. 열람실 내부에서 음식물(과자, 커피, 음료수 등)을 드실 수 없습니다.</p>
						<p>6. 분실물 습득시 도서관 1층 대출· 반납실로 신고하여 주시기 바랍니다.</p>
						<p>7. 도서관의 자료 및 물품을 훼손하거나 무단으로 반출할 수 없습니다.</p>
					</div>
					<div class="clearfix"></div>
				</div>
				<div class="button-box">
					<span id="message">자리 예약 시스템을 이용하기 위해서는 로그인이 필요합니다.</span> <span id="useSeat"></span> <br>
					<div class="time-set-box">
						<span id="time-box">
							<span>입실시간</span>
							<input type="time" name="reserveTime" value="${ reserveTime }" readonly="readonly">
							<span>~ 퇴실시간</span>
							<input type="time" name="endTime" value="${ endTime }" readonly="readonly">
						</span>
						<input type="submit" id="enter" disabled="disabled" value="예약하기">
						<input type="submit" id="exit" formaction="/library/exit" value="퇴실하기" disabled="disabled">
					</div>
				</div>
			</form>
		</div>
	</div>
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<!-- footer 끝 -->
	<script src="/script/jquery-3.5.1.js"></script>
	<script src="/script/bootstrap.js"></script>
	<script src="/script/menuActive.js"></script>
	<script>

		// 예약 및 퇴실 버튼 상태 전환
		if(${ not empty memNum }) {
			if(${ memNum eq mySeat.getMemNum() }) {
				$('span#message').html('현재 회원님께서는 ${ mySeat.getSeatNum() } 번 자리를 ${ mySeat.getReserveTime() } 부터 ${ mySeat.getEndTime() } 까지 예약/이용 중이십니다.').css('color', '#e89415');
				$('input[type="submit"]#enter').prop('disabled', true);
				$('input[type="submit"]#exit').prop('disabled', false);
			} else {
				$('span#message').html('현재 회원님께서는 이용중이신 자리가 없습니다.').css('color', '#e89415');
				$('input[type="submit"]#enter').prop('disabled', false);
				$('input[type="submit"]#exit').prop('disabled', true);
			}
		}


		// 자리 선택해야 예약가능
	    $("#enter").click(function() {
	    	if ($('input:radio[name=seatNum]').is(':checked') == false) {
				alert('자리를 선택 해주세요');
				return false;
			}
	    });
			
		
		// 사용중인 자리 비활성화
		$(document).ready(function(){
			if($('label.true')) {
			   $('label.true').prev().prop('disabled', true);
			}
		});

		// 반복적으로 호출할 나의 현재 자리이용 상태
		function state(myState) {
			if (${ not empty memNum }) {
				if (myState == null || myState.length == 0) {
					console.log("함수실행2")
					$('span#message').html('현재 회원님께서는 이용중이신 자리가 없습니다.').css('color', '#e89415');
					$('input[type="submit"]#enter').prop('disabled', false);
					$('input[type="submit"]#exit').prop('disabled', true);
				   return;
				} else {
					console.log("함수실행1")
					$('span#message').html('현재 회원님께서는 ${ mySeat.getSeatNum() } 번 자리를 ${ mySeat.getReserveTime() } 부터 ${ mySeat.getEndTime() } 까지 예약/이용 중이십니다.').css('color', '#e89415');
					$('input[type="submit"]#enter').prop('disabled', true);
					$('input[type="submit"]#exit').prop('disabled', false);		 	
				}
			} 	
		}

		function time(endTime,reserveTime) {
			console.log("endTime"+endTime);

			  
			var uT = '';

			$('span#time-box').empty();
			
			uT += '<span>입실시간 </span>';
			uT += '<input type="time" name="reserveTime" value="'+reserveTime+'" readonly="readonly">';
			uT += '<span> ~ 퇴실시간 </span>';
			uT += '<input type="time" name="endTime" value="'+endTime+'" readonly="readonly"> ';
			
			$('span#time-box').html(uT);
			
		} 	 
			
		// 반복적으로 호출할 최신화된 자리(radio) 
		 function seatList(resetSeat) {

			var seatTable = '';
			
			
	 		if (resetSeat == null || resetSeat.length == 0) {
				$('div.radio-box').empty();
				return;

			} else {
				$('div.radio-box').empty();

				var i = 0;
				var j = 0;
				
				for (i = 0 ; i < resetSeat.length ; i+=10 ) {

					var vo = resetSeat[i];
					
					seatTable +='<div class="seat-row">';
					
					if (vo.seatNum == seatNum) {
						seatTable +='	<input type="radio" checked  id="' + vo.seatNum + '" class="useSeat" name="seatNum" value="' + vo.seatNum +'">';
					} else {
						seatTable +='	<input type="radio" id="' + vo.seatNum + '" class="useSeat" name="seatNum" value="' + vo.seatNum +'">';
					}

					seatTable +='	<label for="' + vo.seatNum + '" class="' + vo.seatStatus + '">' + vo.seatNum + '</label> <br>';

					var num = vo.seatNum+9
						
					for (j = vo.seatNum ; j < num ; j+=1 ) {
						var row = resetSeat[j];
						
						if (row != null) {
							if (row.seatNum == seatNum) {
								seatTable +='	<input type="radio" checked id="' + row.seatNum + '" class="useSeat" name="seatNum" value="' + row.seatNum +'">';
							} else {
								seatTable +='	<input type="radio" id="' + row.seatNum + '" class="useSeat" name="seatNum" value="' + row.seatNum +'">';
							}

							seatTable +='	<label for="' + row.seatNum + '" class="' + row.seatStatus + '">' + row.seatNum + '</label>';
							seatTable += '	<br>';

						}		
					}
					
					seatTable +='</div>';
					
				} 

			}

	 		$('div.radio-box').html(seatTable);
	 		
	 		if ($('label.true')) {
				$('label.true').prev().prop('disabled', true);
			}

	 		
		} // seatList


		// 좌석 선택시
	 	var seatNum;
		$(document).on('click', 'input.useSeat', function(){
			console.log('클릭됨');
			seatNum = parseInt($(this).val());
			console.log('seatNum = ' + seatNum);
			 //console.log('typeof seatNum = ' + typeof seatNum);
		});


		// 10초마다 자리목록 새롭게 가져오기
	   	setInterval(function() {
	 	  	
			console.log("5초마다 실행됨");

			$.ajax({
				
 	 			method : 'POST',
				url: '/library/resetSeat',
				success: function(resetSeat) {
					seatList(resetSeat);
				}
			}); 

			$.ajax({
  	 			method: 'POST',	
				url: '/library/myState',
				success: function(myState) {			
					
					// 나의 상태정보
					state(myState);
				}
			});
		
		}, 5000);

		// 입실시간과 퇴실시간 1초마다 갱신
	   	setInterval(function() {
	   		$.ajax({
  	 			method: 'POST',	
				url: '/library/updateTime',
				success: function(updateTime) {			
	
					var endTime = updateTime.endTime;
					var reserveTime = updateTime.reserveTime;
					time(endTime,reserveTime); 
					
				}
			});
		}, 1000);
		
	</script>
</body>
</html>
