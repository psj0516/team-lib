package com.example.controller;

import java.time.LocalDateTime;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.domain.MemberVo;
import com.example.service.MemberService;

import lombok.extern.java.Log;

//@controller가 생성되면 프론트컨트롤러 역할을 하는 디스패쳐서블릿에서 컨트롤러를 인식하고 @getMepper와 @postMepper 사용이 가능해진다.

@Log
@Controller
@RequestMapping("/member/*")
public class MemberController {

	@Autowired
	private MemberService memberService;

	@GetMapping("/join")
	public void join() {
	}

	@PostMapping("/join")
	public String join(MemberVo memberVo) {
		memberVo.setRegDate(LocalDateTime.now());
		memberService.insert(memberVo);
		return "redirect:/member/login";
	}

	@GetMapping("/confirm")
	public void confirm() {

	}

	// id 중복체크
	@RequestMapping("/joinIdDupCheck")
	public String joinIdDupCheck(String id, Model model) {

		// 아이디 중복여부 값 구하기
		boolean isIdDup = memberService.isIdDup(id);

		// model 타입 객체에 뷰(JSP)에서 사용할 데이터를 저장하기(싣기)
		model.addAttribute("isIdDup", isIdDup);
		model.addAttribute("id", id);

		return "member/join_IDCheck";
	}

	@GetMapping("/login")
	public void login() {
		log.info("login() 호출됨");
	}

	@PostMapping("/login")
	public ResponseEntity<String> login(String id, String passwd,
			@RequestParam(defaultValue = "false") boolean keepLogin, HttpSession session,
			HttpServletResponse response) { // HttpSession를 넣으면 알아서 session을 가져온다
		// keeplogin의 경우 체크박스를 체크하지 않으면 기본값 null이 온다. 때문에 @RequestParam(defaultValue =
		// "false")를 넣어서 기본값을 false로 바꿔준다.
		// String 값이 넘어오지만 형태가 boolean이면 spring이 알아서 형식을 boolean으로 변환한다.

		// -1: 아이디 없음, 0: 비밀번호 틀림, 1: 아이디 비밀번호 일치
		int check = memberService.userCheck(id, passwd);

		// 로그인 실패시
		if (check != 1) {
			String message = "";
			if (check == 0) {
				message = "비밀번호 틀림";
			} else if (check == -1) {
				message = "아이디 없음";

			}
			HttpHeaders headers = new HttpHeaders(); // header를 통해서 html에 출력정보를 넣어준다. mvc에서
														// response.setContentType("text/html; charset=UTF-8");와 동일
			headers.add("Content-type", "text/html; charset=UTF-8");

			// mvc에서는 PrintWriter out = response.getWriter();로 우리가 html 입력 정보를 직접 출력했다
			StringBuilder sb = new StringBuilder(); // 하지만 spring에서는 우리가 직접 정보를 출력하는 것은 허용되지 않는다. 무조건 spring이 하도록 해야한다.
													// 따라서 출력정보만 StringBuilder로 spring에게 넘겨주는것
			sb.append("<script>"); // 넘겨주면 알아서 스프링이 출력해준다.
			sb.append("alert('" + message + "');");
			sb.append("history.back();");
			sb.append("</script>");

			return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK); // 위에 정보를 하나로 묶어주는 ResponseEntity를
																						// 사용해서 frontcontroller에
		} // 전달하는게 형식이다.
			// HttpStatus.OK는 http 형식이 정상적으로 가는게 맞는지에 대한 여부정보.

		// 로그인 성공시
		// 세션에 아이디 저장
		session.setAttribute("id", id);

		// 로그인 상태유지 원하면 쿠키 생성 후 응답주기
		if (keepLogin) { // keepLogin == true
			Cookie idCookie = new Cookie("id", id);
			idCookie.setMaxAge(60 * 10); // (초단위 설정) 10분
			idCookie.setPath("/"); // 쿠키경로 설정
			response.addCookie(idCookie); // 응답객체에 추가
		}

		// return "redirect:/"; 직접 리다이렉트를 해주지 않는 이유는 위에 반환값이 로그인 실패시 때문에
		// ResponseEntity<String>로 정해져 있어서
		// 로그인 성공도 그 형식에 맞게 해줘야한다.

		HttpHeaders header = new HttpHeaders(); // 위에 header랑 형태는 같지만 종류가 여러가지가 이써서 header location이면 이동 경로를 header 뒤에
												// html 타입종류가
		// 오면 html 관련 정보구나 하고 spring이 인식해서 그에 맞게 처리한다.
		header.add("Location", "/"); // redirect 경로 위치 지정 header가 있어야 경로 지정이 가능(초기화면으로 경로 지정)
		// 리다이렉트일 경우 HttpStatus.FOUND WLWJDGODIGKA. 그래야 headers 위치로 리다이렉트함.
		return new ResponseEntity<String>(header, HttpStatus.FOUND); // HttpStatus.FOUND 는 리다이렉트할 경로를 찾았다는 의미로 즉 리다이렉트
																		// 하라는 의미.

	}// login()

	@GetMapping("/logout")
	public ResponseEntity<String> logout(HttpSession session, HttpServletRequest request,
			HttpServletResponse response) { // 직접 전달하는 경우는 그냥 정보를 전달할 때
		// 세션값 초기화
		session.invalidate();

		// 로그인 상태유지용 쿠키가 존재하면 삭제
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("id")) {
					cookie.setMaxAge(0); // 유효기간 0 설정
					cookie.setPath("/"); // 경로 설정
					response.addCookie(cookie);
				}
			}

		}

		HttpHeaders headers = new HttpHeaders(); // header를 통해서 html에 출력정보를 넣어준다. mvc에서
													// response.setContentType("text/html; charset=UTF-8");와 동일
		headers.add("Content-type", "text/html; charset=UTF-8");

		StringBuilder sb = new StringBuilder(); // 하지만 spring에서는 우리가 직접 정보를 출력하는 것은 허용되지 않는다. 무조건 spring이 하도록 해야한다.
		// 따라서 출력정보만 StringBuilder로 spring에게 넘겨주는것
		sb.append("<script>"); // 넘겨주면 알아서 스프링이 출력해준다.
		sb.append("alert('로그아웃됨');");
		sb.append("location.href = '/';");
		sb.append("</script>");

		return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK); // 만약 스크립트 부분이 없으면 바로 redirect를 하면되지만
																					// 있기때문에 정보를 넘기기 위해서
		// ResponseEntity를 사용한다.
	}

}
