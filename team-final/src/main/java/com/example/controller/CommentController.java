package com.example.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.domain.CommentVo;
import com.example.service.CommentService;
import com.example.service.MemberService;

import lombok.extern.java.Log;

/*
 
  REST 컨트롤러의 HTTP method 매핑 방식
  Create - POST방식
  Read - GET 방식
  Update - PUT 또는 PATCH 방식
  Delete - DELETE 방식
  
  Get 방식 - SELECT
  
 */

@RestController
@RequestMapping("/comment/*")
@Log
public class CommentController {

	@Autowired
	private CommentService commentService;
	
	@Autowired
	private MemberService memberService;
	
	//댓글 생성 메서드
	@PostMapping(value ="/new", consumes ="application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> create(HttpSession session, @RequestBody CommentVo commentVo) { 
		// 세션값 가져오기 인터셉션은 디스패처 서블릿에서 모든 파라미터 값을 가지고온다.
		String id = (String)session.getAttribute("id");
		
		String name = memberService.getNameById(id);
		
		int num = commentService.getCno();
		
		commentVo.setCno(num);
		commentVo.setWriter(name);
		commentVo.setReRef(num);
		/* commentVo.setRegDate(LocalDateTime.now()); */
		
		
		log.info("commentVo : " + commentVo);
		
		int count = commentService.register(commentVo);
		log.info("comment INSERT count : " + count);
		
		ResponseEntity<String> entity = null;
		if (count > 0) {
			entity = new ResponseEntity<String>("댓글작성 완료", HttpStatus.OK);
		} else {
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	//댓글의 답글 생성 메서드
	@PostMapping(value ="/replyNew", consumes ="application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> replycreate(HttpSession session, @RequestBody CommentVo commentVo) { 
		// 세션값 가져오기 인터셉션은 디스패처 서블릿에서 모든 파라미터 값을 가지고온다.
		String id = (String)session.getAttribute("id");
		
		String name = memberService.getNameById(id);
		
		int num = commentService.getCno();
		
		commentVo.setCno(num);
		commentVo.setWriter(name);
		commentVo.setReLev(1);
		
		log.info("commentVo : " + commentVo);
		
		int count = commentService.replyRegister(commentVo);
		log.info("comment INSERT count : " + count);
		
		ResponseEntity<String> entity = null;
		if (count > 0) {
			entity = new ResponseEntity<String>("답글작성 완료", HttpStatus.OK);
		} else {
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	
	
	// 요청주소 뒤에 .json을 붙이면 JSON 응답, .xml을 붙이면 XML 응답을 줌(최근 업데이트 후 적용안됨)
	// Accept를 통해서 application/xml로 설정해줘야 xml 형태로 응답할 수 있다.(만약 Accept 정보가 빠지면 무조건 JSON형태로 응답)  
	@GetMapping(value ="/pages/{bno}", produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE} )
	public ResponseEntity<List<CommentVo>> getList(@PathVariable("bno") int bno) { //현재 url 주소에서 bno를 넘기는 상황(@GetMapping(value ="/pages/{bno}" ) 때문에 
														// url 에서 값을 가져오라고 알려줘야함. 그래서 @PathVariable("bno") 를 넣어줌.
		List<CommentVo> list = commentService.getList(bno);
		
		log.info("bno : " + bno);
		log.info("list : " + list);
		
		return new ResponseEntity<List<CommentVo>>(list, HttpStatus.OK); //리턴할 때 지금 자바버전은 알아서 JSON형식으로 보내주지만 만약
		//	ResponseEntity로 요청하는 이유는 return값에 		   	   //구형버전이라면 안될 수 있다. 때문에 produces로 형식을 return 형식을 정해주는 것이 좋다.
		//	json형식일 때는 HttpStatus.OK를 넣어주는 것이 좋기 때문
		// 단순히 결과만 리턴해도 상관은 없다.
		
	} //getList()
	
	
	@DeleteMapping(value = "/{cno}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove(@PathVariable("cno") int cno) { //@PathVariable로 값을 가져오려면 반드시 value에서 {}로 감싸야한다.
		int count = commentService.remove(cno);
		
		return (count > 0)
				? new ResponseEntity<String>("댓글이 삭제되었습니다.", HttpStatus.OK) //True
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR); //false
		
	} //remove()
	
	
	
	@PutMapping(
							 value = "/{cno}",
							 consumes = "application/json",
							 produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> modify(@RequestBody CommentVo commentVo, @PathVariable("cno") int cno) {
		
			commentVo.setCno(cno); //만약 댓글번호가 포함이 안되면 넣어주기
			
			commentService.modify(commentVo);
			
			return new ResponseEntity<String>("댓글이 수정되었습니다.", HttpStatus.OK); //success를 만약 produces로 정확하게 설정 안해주면 string으로 받는다.
	} //moidfy()
	
	
	
	
}
