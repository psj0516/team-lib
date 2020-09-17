// form 빈칸 확인
$(document).ready(function() {
	$("#btn").click(function() {
		if (fieldCheck() == true) {
			true;
		} else {
			$("#loginForm").submit();
		}
	});
});

function fieldCheck() {
	var element = $("#loginForm input");
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