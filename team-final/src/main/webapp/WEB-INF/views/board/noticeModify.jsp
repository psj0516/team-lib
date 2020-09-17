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
<link href="/css/board/write-form.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/menu.jsp" />
	<div id="wrapper">
		<div class="col-md-12 col-sm-10 col-xs-12">
			<h2>공지 작성</h2>
			<div class="main-box" id="main-box_inq">
				<form action="/notice/modify" method="post" enctype="multipart/form-data" name="frm">
					<div id="hidden">
						<input type="hidden" name="num" value="${ noticeVo.num }">
						<input type="hidden" name="pageNum" value="${ pageNum }">
					</div>
					<table class="table">
						<tbody>
							<tr>
								<th>제목</th>
								<td>
									<input type="text" name="subject" value="${ noticeVo.subject }" class="form-control" />
								</td>
							</tr>
							<tr>
								<th>글 설정</th>
								<td>
									<input type="checkbox" id="top" name="fix" value="1" ${ noticeVo.fix eq 1 ? 'checked' : ' ' }>
									<label for="top"></label>상단 고정
								</td>
							</tr>
							<tr>
								<th scope="col">파일</th>
								<td style="text-align: left;">
									<button style="margin-bottom:10px" type="button" id="btnAddFile">첨부파일 추가</button>
									<div id="fileBox">
										<div id="oldFileBox">
											<c:forEach var="file" items="${ fileVo }">
												<input style="display:inline-block" type="hidden" name="olduuid" value="${ file.uuid }">
												<div>
												${file.filename }
												<span class="delete-oldfile"><img style="width: 20px;" src="/images/close.png"></span>
												</div>
											</c:forEach>
										</div>
										<div id="newFileBox"></div>
									</div>
								</td>
							</tr>
							<tr>
								<th>공지 내용</th>
								<td>
									<textarea cols="10" name="content" class="form-control">${ noticeVo.content }</textarea>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<div class="button-box">
										<button type="submit" onclick="modify()" id="w_btn1">수정</button>
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
	var fileCount = ${ fn:length(fileVo) };

	// 정적 이벤트 바인딩(기존에 있던 것에만 적용을 시키는 것. 새로생기면 이어서 적용이 되지 않는다.)
	$('button#btnAddFile').click(function (event) {
		if (fileCount >= 5) {
			alert('첨부파일은 최대 5개까지만 가능합니다.');
			return;
		}
		
		var str = '<div><input style="display:inline-block" type="file" name="filename"><span class="fileDelete"><img style="width: 20px;" src="/images/close.png"></span>';
		
		//$(this).next().append(str); <!--  $('div#fileBox') 위와 동일하나 성능적으로 아래가 더 좋음 why 밑에는 파일을 한번 더 검색하지만 위는 바로 다음껄로 넘어감.-->
		$('div#newFileBox').append(str);
		fileCount++;
	});

	// 동적 이벤트 바인딩 (정적 이벤트로 추가하면 기존에 있는곳에만 이벤트가 적용이 되고 새로 생긴곳에는 적용이 안된다. 동적 이벤트를 해야지만 새로 생긴것에도 이벤트가 적용.)
	// 새로생긴 것에도 이벤트를 적용하는게 동적 이벤트 바인딩
	$('div#newFileBox').on('click','span.fileDelete', function (event) {
		$(this).parent().remove(); // empty()는 자신의 안쪽요소만 지움(자신은 남겨둠) 클릭한 곳(fileDelete)의 부모를 다 삭제한다.
		fileCount--;
	});

	// 정적 이벤트 바인딩
	$('span.delete-oldfile').click(function () {
		console.log($(this).parent().prev());
		$(this).parent().prev().prop('name', 'deluuid');
		$(this).parent().remove();
		fileCount--;
	});

	function modify(){
	
		var oldcnt = $("input[name=olduuid]").length;
		var newcnt = $("input[name=filename]").length;
		var newcnt2 = $("input[name=filename]").length;
		

		var newlist = new Array(newcnt);
		
		for(var i=0; i<newcnt; i++){                          
			newlist[i] = $("input[name=filename]").eq(i).val();

			
 			if(newcnt > 0){
				if(newlist[i] == null || newlist[i] == ''){

					newcnt2 = (newcnt2 - 1);
					
				} 

			} 
		}

		var filecnt = newcnt2 + oldcnt;
		console.log("파일 갯수: " + filecnt);

		var str ='<input type="text" name="file" value="'+ filecnt +'">'
		$("div#hidden").append(str);
		
	}
	
</script>
</body>
</html>