// form 빈칸 확인
$(document).ready(function() {
	$("#btn").click(function() {
		if (fieldCheck() == true) {
			true;
		} else {
			alert('가입되셨습니다.');
			$("#joinForm").submit();
		}
	});
});

function fieldCheck() {
	var element = $("#joinForm input");
	for (var i = 0; i < element.length; i++) {
		if ("" == $(element[i]).val() || null == $(element[i]).val()) {
			var ele_id = $(element[i]).attr("id");
			var label_txt = $("label[for='" + ele_id + "']").text();
			showAlert(ele_id, label_txt);
			return true;
		}
	}
}

function showAlert(ele_id, label_txt) {
	textVal = document.getElementById('alt').innerHTML;
	if (textVal == null || textVal == "") {
		$("#alt").append(" " + label_txt + "을(를) 입력해주세요.");
	} else {
		$("#alt").empty();
		$("#alt").append(" " + label_txt + "을(를) 입력해주세요.");
	}
	$("#myAlert").removeClass('hide');
	// 해당 칸에 focus.
	$("#" + ele_id).focus();
}

// 경고창 닫기
$(function() {
	$(".close").click(function() {
		if (!$("myAlert").hasClass("hide")) {
			$("#myAlert").addClass('hide');
		}
		$("#alt").empty();
	});
});


// 패스워드 일치
var passwd = document.getElementById('passwd');
var passwd2 = document.getElementById('passwd2');
var spanMessage = document.getElementById('passwdMessage');

passwd2.onkeyup = function() {
	if (passwd.value != passwd2.value) {
		spanMessage.innerHTML = '&nbsp;* 비밀번호 불일치';
	} else {
		spanMessage.innerHTML = '';
	}
};

// ID 중복체크
function winopen() {
	var memId = document.joinForm.id.value;
	
	if (memId == '') {
		alert('아이디를 입력하세요');
		document.joinForm.id.focus();
		return;
	}
	
	// 새창 열어서 jsp요청   window.open()
	open('/member/joinIdDupCheck?id=' + memId, 'dupCheck', 'width=400,height=200');
}