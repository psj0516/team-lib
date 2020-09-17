package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.java.Log;

@Controller
@Log
public class HomeController {
	
	//디스패처 서브릿 클래스가 미리 getMapping이나 posMapping 부분이 있는 곳을 스캔해서 읽어 온다.
	//접속방식을 선택해준다 getMapping 이나 postMapping, "/"는 뒤에 붙는 url이 아무것도 없을 때 기본값. 페이지를 의미한다.
	//즉 ()안에 url값을 정해주면 다른 페이지를 불러 올 수도있다. 그래서 메소드 이름(ex.index()) 은 전혀 중요하지 않다.
	//String말고 void로 resturn 값이 아무것도 없을 수도 있다. 그럴 경우는 메소드의 이름에 해당하는 jsp를 찾는다.(index면 index.jsp를 찾는것) 아래 참조
	@GetMapping("/") 
	public String index(){  
		return "index";
		//application.properties에서 주소 설정을 해둠. 그래서 index만 넣어도 됨.
		//spring.mvc.view.prefix=/WEB-INF/views/
		//spring.mvc.view.suffix=.jsp
	}
	
	/*	@GetMapping("/")
	 * public void index(){ }
	 */
	
	
	// 리턴타입이 void면 url요청 주소경로를
	// jsp 경로로 사용함 -> 리턴타입의 경로와 url요청 주소경로가 같을 경우에 사용 아래 확인.
//	@GetMapping("/company/welcome")
//	public String welcome( ) {
//		return "company/welcome";
//		
//	}

}
