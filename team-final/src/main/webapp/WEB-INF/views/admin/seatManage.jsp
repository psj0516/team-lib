<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/admin/seat.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/menu.jsp" />
	<div id="wrapper">
		<jsp:include page="/WEB-INF/views/include/admin-menu.jsp" />
		<div class="col-md-10 col-sm-10 col-xs-12">
			<h3>좌석 현황</h3>
			<form action="/library/seatDisable" method="post">
				<input type="hidden" name="memNum" value="${ memNum }">
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
					<button type="button" onclick="location.href='/library/createSeat'">자리생성</button>
					<button type="button" onclick="location.href='/library/deleteSeat?count=${ count }'">자리제거</button>
					<input type="submit" value="자리 비활성화">
				</div>
			</form>
			
			<h3>좌석 관리</h3>
			<div class="seat-status">
				<h2 id="countUseSeat"></h2>
				<table class="table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="allCheckBox" >
								<label for="allCheckBox"></label>
							</th>
							<th>자리번호</th>
							<th>이름</th>
							<th>회원번호</th>
							<th>입실시간</th>
							<th>퇴실시간</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="seatAndName" items="${ allSeatAndName }">
							<tr class="tdList">
							<c:choose>
								<c:when test="${ seatAndName.getId() eq 'admin' }">
									<td>
										<input type="checkbox" id="${ seatAndName.getReserveTime() }" class="checkboxes" name="checkbox" value="${ seatAndName.getSeatNum() }">
										<label for="${ seatAndName.getReserveTime() }"></label>
									</td>
								</c:when>
								<c:otherwise>
									<td>
										<input type="checkbox" id="${ seatAndName.getId() }" class="checkboxes" name="checkbox" value="${ seatAndName.getSeatNum() }">
										<label for="${ seatAndName.getId() }"></label>
									</td>
								</c:otherwise>
							</c:choose>
								<td>${ seatAndName.getSeatNum() }</td>
								<td>${ seatAndName.getName() }</td>
								<td>${ seatAndName.getMemNum() }</td>
								<td>${ seatAndName.getReserveTime() }</td>
								<td>${ seatAndName.getEndTime() }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<button type="button" id="selectBtn">퇴실처리</button>
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
		// 사용중인 자리 비활성화
		$(document).ready(function() {
			if ($('label.true')) {
				$('label.true').prev().prop('disabled', true);
			}

			$('h2#countUseSeat').html('자리이용 현황 '+${countUseSeat}+'명');
			
		});

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

		// 화면이 갱실될때마다 좌석선택 현상유지
	 	var seatNum;
		$(document).on('click', 'input.useSeat', function(){
			console.log('클릭됨');
			seatNum = parseInt($(this).val());
			console.log('seatNum = ' + seatNum);
		});


		 // 화면이 갱실될때마다 테이블 체크박스 현상유지
		 var checkBoxes = new Array();
		
	 	 $(document).on('click', 'input.checkboxes', function() {
		 	 
		  	 if($(this).prop('checked') == true) {
	 		 console.log('체크됨');
			 checkBoxes.push(parseInt($(this).val()));
			 console.log('checkBox = ' + checkBoxes);
			 
		  	 } else {
		  		console.log('체크해제됨');
				 var del = checkBoxes.indexOf(parseInt($(this).val()));
				 checkBoxes.splice(del,1);
				 
				 console.log(checkBoxes);
			 }
		  	 
		 });

	 	// th체크박스 선택시 하위 체크박스 모두 선택 또는 해제
			$('#allCheckBox').click(function() {
				if($(this).prop('checked') == true ) {

					checkBoxes.length = 0;
					console.log(checkBoxes);

					
					console.log("모든체크 선택됨");
					$('input[type="checkbox"]').prop('checked', true);

					if ($('input[type="checkbox"]').prop('checked') == true) {

						var checkBox = $('input.checkboxes:checked');
						
						checkBox.each(function(i) {

							var checkBox = $('input.checkboxes:checked').eq(i);
							var checkBoxNum = checkBox.val();
										
							checkBoxes.push(parseInt(checkBoxNum));
						});

						console.log(checkBoxes);
					}

					
				} else {
					$('input[type="checkbox"]').prop('checked', false);
					console.log("모든체크 해제됨");
					if ($('input[type="checkbox"]').prop('checked') != true) {

						var checkBox = $('input.checkboxes');

						
						checkBox.each(function(i) {

							var checkBox = $('input.checkboxes').eq(i);
							var checkBoxNum = checkBox.val();
							console.log(checkBoxes);

							var del = checkBoxes.indexOf(parseInt(checkBoxNum));
							checkBoxes.splice(del,1);
							
						});

					}
					
				}	
			});


		// td체크박스 하나라도 false면 th체크박스 false
	 	$('input.checkboxes').click(function() {
			if($(this).prop('checked') != true) {
				$('input#allCheckBox').prop('checked', false)
			}
		}); 

		// 3초마다 자리목록 새롭게 가져오기
 	   	setInterval(function() {
 	 	  	
			console.log("3초마다 실행됨");

			$.ajax({
				
  	 			method : 'POST',
				url: '/library/resetSeat',
				success: function(resetSeat) {
					seatList(resetSeat);
					
				}
			}); 

			$.ajax({
  	 			method: 'POST',	
				url: '/library/seatList',
				success: function(nameAndSeatVo) { 

					// 테이블에 반영될 위에 정의해둔 함수
					tableList(nameAndSeatVo);
				}
			});
		}, 3000);    

		
		// 관리자가 자리 이용자를 퇴실처리 한 정보가 반영된 테이블
	 	function tableList(nameAndSeatVo) {
			
			var strTable = '';
			var i = 0;
			
	 		if (nameAndSeatVo == null || nameAndSeatVo.length == 0) {
				$('tr.tdList').empty();
				$('h2#countUseSeat').html('자리이용 현황 0명');
				return;

			} else {
				$('tbody').empty();
				
				for (let vo of nameAndSeatVo) {
					
 					strTable += '<tr class="tdList">';
 	 				
					if(vo.id == "admin") {
						if(checkBoxes.includes(vo.seatNum)) {
							strTable += '		<td>';
							strTable += '			<input type="checkbox" checked id="'+vo.reserveTime+'" class="checkboxes" name="checkbox" value="'+vo.seatNum+'">';	
							strTable += '			<label for="'+vo.reserveTime+'"></label>';	
							strTable += '		</td>';	
						} else {
							strTable += '		<td>';
							strTable += '			<input type="checkbox" id="'+vo.reserveTime+'" class="checkboxes" name="checkbox" value="'+vo.seatNum+'"">';	
							strTable += '			<label for="'+vo.reserveTime+'"></label>';	
							strTable += '		</td>';	
						}	

					} else {
						if(checkBoxes.includes(vo.seatNum)) {
							strTable += '		<td>';
							strTable += '			<input type="checkbox" checked id="'+vo.id+'" class="checkboxes" name="checkbox" value="'+vo.seatNum+'">';	
							strTable += '			<label for="'+vo.id+'"></label>';	
							strTable += '		</td>';	
						} else {
							strTable += '		<td>';
							strTable += '			<input type="checkbox" id="'+vo.id+'" class="checkboxes" name="checkbox" value="'+vo.seatNum+'">';	
							strTable += '			<label for="'+vo.id+'"></label>';	
							strTable += '		</td>';	
						}
						
					}
					
 					strTable += '	<td>'+vo.seatNum+'</td>';
 					strTable += '	<td>'+vo.name+'</td>';
 					strTable += '	<td>'+vo.memNum+'</td>';
 					strTable += '	<td>'+vo.reserveTime+'</td>';	
 					strTable += '	<td>'+vo.endTime+'</td>';
 					strTable += '</tr>';

					i=i+1;
					
				} 

 				$('tbody').html(strTable);
 				$('h2#countUseSeat').html('자리이용 현황 '+i+'명');
			}

		} // tableList()


		// 퇴실 처리 버튼 클릭시 체크된(th의 값을 제외한) Row의 값을 가져온다.
		

		$("#selectBtn").click(function() { 

			// td를 담을 배열선언
			var tdArr = new Array();

			// 체크된 체크박스 값을 가져온다
			var checkbox = $('input.checkboxes:checked');
			
			checkbox.each(function(i) {

				// checkbox.parent().parent() : <td>의 부모이므로 <tr>이다.
				// checkbox.parent() : checkbox의 부모는 <td>이다.
				var tr = checkbox.parent().parent().eq(i);
				var td = tr.children();
				
				// td.eq(0)은 체크박스 이므로  td.eq(1)의 값부터 가져온다.
				var seatNum = td.eq(1).text();
				var name = td.eq(2).text();
				var memNum = td.eq(3).text();
				var reserveTime = td.eq(4).text();
				var endTime = td.eq(5).text();
				
				// 가져온 값을 배열에 담는다.
				
				var rowData = {seatNum,name,memNum,reserveTime,endTime}
				tdArr.push(rowData);

				// 활성화된 자리(radio)를 비활성화 한다.
				$('div.seat-box').find('input#' + seatNum).prop('disabled', false);
				
			});

			// ajax을 이용해서 선택한 체크박스에 해당하는 회원 퇴실처리
 			var strTdArr = JSON.stringify(tdArr);
	
  	 		$.ajax({
  	 			method: 'POST',
				url: '/library/selectExit',
				data: strTdArr,
				contentType: 'application/json; charset=utf-8',
				success: function(nameAndSeatVo) { 

					// 테이블에 반영될 위에 정의해둔 함수
					tableList(nameAndSeatVo);
				}
			});   
		}); 
		
	</script>
</body>
</html>