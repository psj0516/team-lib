<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/board/write-form.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/menu.jsp" />
	<div id="wrapper">
		<div class="col-md-12 col-sm-10 col-xs-12">
			<h2>공지 작성</h2>
			<div class="main-box" id="main-box_inq">
				<form action="/notice/write" method="post" enctype="multipart/form-data" name="frm">
					<table class="table">
						<tbody>
							<td>
								<input style="display:none" type="text" name="writer" value="${ name }">
							</td>
							<tr>
								<th>제목</th>
								<td>
									<input type="text" name="subject" placeholder="제목을 입력하세요. " class="form-control" />
								</td>
							</tr>
							<tr>
								<th>글 설정</th>
								<td>
									<input style="display:inline-block" type="checkbox" id="top" name="fix" value="1">
									상단 고정
								</td>
							</tr>
							<tr>
								<th scope="col">파일</th>
								<td style="text-align: left;">
									<button style="margin-bottom:10px" type="button" id="btnAddFile">첨부파일 추가</button>
									<div id="fileBox">
										<div>
											<input style="display:inline-block" type="file" name="filename">
											<span class="fileDelete"><img style="width: 20px; margin-bottom: 4px;" src="/images/close.png"></span>  <!-- 만약 파일이 없을 경우 null이 아니라 빈문자열로 들어가서 파일이 없어도 text 파일 처럼 인식한다. -->
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<th>공지 내용</th>
								<td>
									<textarea cols="10" name="content" placeholder="내용을 입력하세요. " class="form-control"></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<div class="button-box">
										<button type="submit" id="w_btn1">작성</button>
										<button type="reset" id="w_btn2">초기화</button>
										<button type="button" id="w_btn3" onClick="location.href='/notice/list?pageNum=${pageNum}'">글목록</button>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
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
	var fileCount = 1;

	// 정적 이벤트 바인딩(기존에 있던 것에만 적용을 시키는 것. 새로생기면 이어서 적용이 되지 않는다.)
	$('button#btnAddFile').click(function (event) {
		if (fileCount >= 5) {
			alert('첨부파일은 최대 5개까지만 가능합니다.');
			return;
		}
		
		var str = '<div><input style="display:inline-block" type="file" name="filename"><span class="fileDelete"><img style="width: 20px; margin-left: 4px; margin-bottom: 4px;" src="/images/close.png"></span>';
		
		//$(this).next().append(str); <!--  $('div#fileBox') 위와 동일하나 성능적으로 아래가 더 좋음 why 밑에는 파일을 한번 더 검색하지만 위는 바로 다음껄로 넘어감.-->
		$('div#fileBox').append(str);
		fileCount++;
	});

	// 동적 이벤트 바인딩 (정적 이벤트로 추가하면 기존에 있는곳에만 이벤트가 적용이 되고 새로 생긴곳에는 적용이 안된다. 동적 이벤트를 해야지만 새로 생긴것에도 이벤트가 적용.)
	// 새로생긴 것에도 이벤트를 적용하는게 동적 이벤트 바인딩
	$('div#fileBox').on('click','span.fileDelete', function (event) {
		$(this).parent().remove(); // empty()는 자신의 안쪽요소만 지움(자신은 남겨둠) 클릭한 곳(fileDelete)의 부모를 다 삭제한다.
		fileCount--;
	});
	
</script>
</body>
</html>