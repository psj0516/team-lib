package com.example.controller;


import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.domain.BoardVo;
import com.example.domain.Criteria;
import com.example.domain.InquireDto;
import com.example.domain.PageDto;
import com.example.service.BoardService;
import com.example.service.MemberService;

import lombok.extern.java.Log;

@Log
@Controller 
@RequestMapping("/board/*")
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private MemberService memberService;

	@GetMapping("/intro")
	public String intro() {
		return "/board/intro";
	}
	
	
	
	// 글 전체 가져오기
	@GetMapping("/inquire")
	public String list(Model model,
					   @RequestParam(defaultValue = "1") int pageNum,
					   @RequestParam(defaultValue = "")String category,
					   @RequestParam(defaultValue = "") String search){
		
			
		// 오늘날짜 가져오기
		String date = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy.MM.dd"));

	
		// 전체 글갯수
		int totalCount = boardService.getTotalCount(category, search);
		
		
		// 한 페이지에 15개씩 가져오기
		int pageSize = 10;
		// 페이지의 첫번째 글 번호 구하기(수식)
		int startRow = (pageNum-1) * pageSize;
			
		// 원하는 페이지의 글을 가져오는 메소드
		List<BoardVo> list = null;
		if (totalCount > 0) {
			list = boardService.getBoards(startRow, pageSize, category, search);
		}
		
		//페이지 블록의 총 갯수 구하기
		int pageCount = totalCount / pageSize;
		if (totalCount % pageSize > 0) {
			pageCount += 1;
		}
		
		// 화면에 한번에 보여줄 페이지 블록갯수 설정
		int pageBlock = 10;

		// 페이지 블록의 시작번호(1~10   11~20   21~30)
		int startPage = ((pageNum / pageBlock) - (pageNum % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;
		
		// 페이지 블록의 끝페이지
		int endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) {
			endPage = pageCount;
		}
		
	
		// 페이지블록 관련 정보를 pageDTO에 저장
		PageDto pageDto = new PageDto(); 
		pageDto.setTotalCount(totalCount);
		pageDto.setPageCount(pageCount);
		pageDto.setPageBlock(pageBlock);
		pageDto.setStartPage(startPage);
		pageDto.setEndPage(endPage);
		pageDto.setCategory(category);
		pageDto.setSearch(search);
		
		
		
		// 뷰(jsp)에서 사용할 데이터를 request 영역객체에 저장 
		model.addAttribute("boardList", list); 
		model.addAttribute("pageDto", pageDto);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("date", date);
		
		return "board/inquire";
		
	} // list()
	
	
	@GetMapping(value ="/myList/{pageNum}", produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE} )
	public ResponseEntity<InquireDto> getMyList(HttpSession session, @PathVariable("pageNum") int pageNum){
		
		log.info("페이지 이동");
		// 세션값 가져오기 인터셉션은 디스패처 서블릿에서 모든 파라미터 값을 가지고온다.
		String id = (String)session.getAttribute("id");
		
		// 가져올 나의 게시글 목록 옵션
		Criteria cri = new Criteria(pageNum, 5);
		
		
		// 원하는 페이지의 글을 가져오는 메소드
		InquireDto myInquireDto = boardService.getMyBoardWithPaging(id,cri);
		
		
		return new ResponseEntity<InquireDto>(myInquireDto, HttpStatus.OK);

	} //getMyList()
	
	@GetMapping(value ="/inquireList/{pageNum}", produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE} )
	public ResponseEntity<InquireDto> getInquireList(HttpSession session, @PathVariable("pageNum") int pageNum){
		
		
		// 가져올 나의 게시글 목록 옵션
		Criteria cri = new Criteria(pageNum, 5);
		
		
		// 원하는 페이지의 글을 가져오는 메소드
		InquireDto inquireDto = boardService.getInquireList(cri);
		
		
		return new ResponseEntity<InquireDto>(inquireDto, HttpStatus.OK);

	} //getMyList()
	
	@GetMapping(value ="/errorList/{pageNum}", produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE} )
	public ResponseEntity<InquireDto> getErrorList(HttpSession session, @PathVariable("pageNum") int pageNum){
		
		
		// 가져올 나의 게시글 목록 옵션
		Criteria cri = new Criteria(pageNum, 5);
		
		
		// 원하는 페이지의 글을 가져오는 메소드
		InquireDto errorDto = boardService.getErrorList(cri);
		
		
		return new ResponseEntity<InquireDto>(errorDto, HttpStatus.OK);

	} //getMyList()
	
	
	
	
	
	// 게시글 작성페이지로 이동
	@GetMapping("/inquireWrite")
	public String write(HttpSession session, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		
		
		
		// 세션값 가져오기 인터셉션은 디스패처 서블릿에서 모든 파라미터 값을 가지고온다.
		String id = (String)session.getAttribute("id");
		
		String name = memberService.getNameById(id);
		String memNum = memberService.getMemNumById(id);
		
		
		// 로그인 안했으면(세션값 없으면) /member/login 리다이렉트 이동
		if (id == null) {
			response.sendRedirect("/member/login");
		}
		
		model.addAttribute("memNum", memNum); 
		model.addAttribute("name", name); 
		
		return "board/inquireWrite";
	}
	
	
	// 게시글 생성
	@PostMapping("/inquireWrite")
	public String write(BoardVo boardVo, HttpServletRequest request) {
		
		// 작성 현재시간 가져오기 
		String date = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy.MM.dd"));
		
		// 작성일자 값 저장
		boardVo.setRegDate(date);
		
		boardService.insert(boardVo);

		return "redirect:/board/inquire";
	}
	
	//글번호로 게시글 가져오기
	@GetMapping("/inquireContent")
	public String content(int num, @ModelAttribute("pageNum") String pageNum, Model model) { 
		
		
		// 조회수 1증가
		boardService.updateReadcount(num);
		
		int count = boardService.getReplyCount(num);
		
		BoardVo vo = boardService.getBoardByNum(num);
		BoardVo reply = boardService.getReplyByNum(num);
		
		
		String content = "";
		if (vo.getContent() != null) {
			content = vo.getContent().replace("\r\n", "<br>");
			vo.setContent(content);
		}
		
		// jsp에서 사용할 게시글 데이터를 영역객체에 저장
		model.addAttribute("boardVo", vo);
		model.addAttribute("reply", reply);
		model.addAttribute("replyCount", count);
		
		return "board/inquireContent";
	}
	
	//답글 작성 페이지로 이동
	@GetMapping("/reply")
	public String reply(BoardVo boardVo, HttpSession session, HttpServletResponse response, @ModelAttribute("pageNum") String pageNum, Model model) throws Exception{
		
		// 세션값 가져오기 인터셉션은 디스패처 서블릿에서 모든 파라미터 값을 가지고온다.
				String id = (String)session.getAttribute("id");
				
				String name = memberService.getNameById(id);
				String memNum = memberService.getMemNumById(id);
				
			
				model.addAttribute("memNum", memNum); 
				model.addAttribute("name", name); 
		
		
		return "board/replyWrite";
	}
	
	//답글쓰기
	@PostMapping("/reply")
	public String reply(BoardVo boardVo, String pageNum, HttpServletRequest request,RedirectAttributes rttr) {
		
		String date = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy.MM.dd"));
		
		//작성일자 값 저장
		boardVo.setRegDate(date);
		
		// 답글 inser하기
		boardService.replyInsert(boardVo);	

		rttr.addAttribute("pageNum", pageNum);
		
		return "redirect:/board/inquire";
	}
	
	@GetMapping("/deleteContent")
	public ResponseEntity<String> deleteContent(int reRef, String pageNum) {
		
		boardService.deleteByReref(reRef);

		HttpHeaders headers = new HttpHeaders(); //header를 통해서 html에 출력정보를 넣어준다. mvc에서 response.setContentType("text/html; charset=UTF-8");와 동일
		headers.add("Content-type", "text/html; charset=UTF-8");
		
		// mvc에서는 PrintWriter out = response.getWriter();로 우리가 html 입력 정보를 직접 출력했다
		StringBuilder sb = new StringBuilder(); //하지만 spring에서는 우리가 직접 정보를 출력하는 것은 허용되지 않는다. 무조건 spring이 하도록 해야한다.
												// 따라서 출력정보만 StringBuilder로 spring에게 넘겨주는것
		sb.append("<script>");                   //넘겨주면 알아서 스프링이 출력해준다.
		sb.append("alert('글이 삭제되었습니다.');");
		sb.append("location.href='/board/inquire?pageNum'");
		sb.append("</script>");
		
		return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
		
	}
	
	@GetMapping("/deleteReply")
	public ResponseEntity<String> deleteReply(int reRef, int num, String pageNum) {
		
		boardService.deleteByNum(num);
		boardService.updateStatus2(reRef);

		HttpHeaders headers = new HttpHeaders(); //header를 통해서 html에 출력정보를 넣어준다. mvc에서 response.setContentType("text/html; charset=UTF-8");와 동일
		headers.add("Content-type", "text/html; charset=UTF-8");
		
		// mvc에서는 PrintWriter out = response.getWriter();로 우리가 html 입력 정보를 직접 출력했다
		StringBuilder sb = new StringBuilder(); //하지만 spring에서는 우리가 직접 정보를 출력하는 것은 허용되지 않는다. 무조건 spring이 하도록 해야한다.
												// 따라서 출력정보만 StringBuilder로 spring에게 넘겨주는것
		sb.append("<script>");                   //넘겨주면 알아서 스프링이 출력해준다.
		sb.append("alert('글이 삭제되었습니다.');");
		sb.append("location.href='/board/inquire?pageNum'");
		sb.append("</script>");
		
		return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
		
	}
	
	//문의글 수정 페이지로 이동
		@GetMapping("/modify")
		public String modify(HttpSession session, HttpServletResponse response, @ModelAttribute("pageNum") String pageNum, int num, Model model) throws Exception{
			
			BoardVo vo = boardService.getBoardByNum(num);
			
			model.addAttribute("boardVo", vo);
				
			return "board/inquireModify";
		}
		
		//문의글 수정
		@PostMapping("/modify")
		public String modify(BoardVo boardVo, String pageNum, HttpServletRequest request,RedirectAttributes rttr) {
			
			log.info("페이지 번호: " + pageNum);
			// 답글 inser하기
			boardService.update(boardVo);

			rttr.addAttribute("pageNum", pageNum);
			
			return "redirect:/board/inquire";
		}
	
	
	
}
