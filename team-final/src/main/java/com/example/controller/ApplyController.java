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

import com.example.domain.Criteria;
import com.example.domain.ApplyDto;
import com.example.domain.ApplyVo;
import com.example.domain.PageDto;
import com.example.service.ApplyService;
import com.example.service.MemberService;

import lombok.extern.java.Log;

@Log
@Controller 
@RequestMapping("/library/*")
public class ApplyController {

	@Autowired
	private ApplyService applyService;
	
	@Autowired
	private MemberService memberService;
	

	// 글 전체 가져오기
		@GetMapping("/apply")
		public String list(Model model,
						   @RequestParam(defaultValue = "1") int pageNum,
						   @RequestParam(defaultValue = "")String category,
						   @RequestParam(defaultValue = "") String search){
			
				
			// 오늘날짜 가져오기
			String date = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy.MM.dd"));

		
			// 전체 글갯수
			int totalCount = applyService.getTotalCount(category, search);
			
			
			// 한 페이지에 15개씩 가져오기
			int pageSize = 10;
			// 페이지의 첫번째 글 번호 구하기(수식)
			int startRow = (pageNum-1) * pageSize;
				
			// 원하는 페이지의 글을 가져오는 메소드
			List<ApplyVo> list = null;
			if (totalCount > 0) {
				list = applyService.getApplys(startRow, pageSize, category, search);
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
			model.addAttribute("applyList", list); 
			model.addAttribute("pageDto", pageDto);
			model.addAttribute("pageNum", pageNum);
			model.addAttribute("date", date);
			
			return "library/apply";
			
		} // list()
		
		@GetMapping(value ="/myApplyList/{pageNum}", produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE} )
		public ResponseEntity<ApplyDto> getMyList(HttpSession session, @PathVariable("pageNum") int pageNum){
			
			// 세션값 가져오기 인터셉션은 디스패처 서블릿에서 모든 파라미터 값을 가지고온다.
			String id = (String)session.getAttribute("id");
			
			// 가져올 나의 게시글 목록 옵션
			Criteria cri = new Criteria(pageNum, 5);
			
			
			// 원하는 페이지의 글을 가져오는 메소드
			ApplyDto myApplyDto = applyService.getMyApplyWithPaging(id, cri);
			
			
			return new ResponseEntity<ApplyDto>(myApplyDto, HttpStatus.OK);

		} //getMyList()
		
		@GetMapping(value ="/applyList/{pageNum}", produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE} )
		public ResponseEntity<ApplyDto> getAppyList(HttpSession session, @PathVariable("pageNum") int pageNum){
			
			log.info("pageNum: " + pageNum);
			
			// 가져올 나의 게시글 목록 옵션
			Criteria cri = new Criteria(pageNum, 5);
			
			log.info("cri: " + cri);
			
			// 원하는 페이지의 글을 가져오는 메소드
			ApplyDto applyListDto = applyService.getApplyList(cri);
			
			log.info("데이터: " + applyListDto);
			
			
			return new ResponseEntity<ApplyDto>(applyListDto, HttpStatus.OK);

		} //getMyList()
		
		
	
		
		// 게시글 작성페이지로 이동
		@GetMapping("/applyWrite")
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
			
			return "library/applyWrite";
		}
		
		
		// 게시글 생성
		@PostMapping("/applyWrite")
		public String write(ApplyVo applyVo, HttpServletRequest request) {
			
			// 작성 현재시간 가져오기 
			String date = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy.MM.dd"));
			
			// 작성일자 값 저장
			applyVo.setRegDate(date);
			
			applyService.insert(applyVo);

			return "redirect:/library/apply";
		}
		
		//글번호로 신청글 가져오기
		@GetMapping("/applyContent")
		public String content(int num, @ModelAttribute("pageNum") String pageNum, Model model) { 
			
			
			
			ApplyVo vo = applyService.getApplyByNum(num);
			
			
			String content = "";
			if (vo.getContent() != null) {
				content = vo.getContent().replace("\r\n", "<br>");
				vo.setContent(content);
			}
			
			String reason = "";
			if (vo.getReason() != null) {
				reason = vo.getReason().replace("\r\n", "<br>");
				vo.setReason(reason);
			}
			
			// jsp에서 사용할 게시글 데이터를 영역객체에 저장
			model.addAttribute("applyVo", vo);

			
			return "library/applyContent";
		}
		
		//신청글 수정 페이지로 이동
		@GetMapping("/applyModify")
		public String modify(HttpSession session, HttpServletResponse response, @ModelAttribute("pageNum") String pageNum, int num, Model model) throws Exception{
			
			ApplyVo vo = applyService.getApplyByNum(num);
			
			model.addAttribute("applyVo", vo);
				
			return "library/applyModify";
		}
		
		//신청글 수정
		@PostMapping("/applyModify")
		public String modify(ApplyVo applyVo, String pageNum, HttpServletRequest request,RedirectAttributes rttr) {
			
			// 답글 inser하기
			applyService.update(applyVo);

			rttr.addAttribute("pageNum", pageNum);
			
			return "redirect:/library/apply";
		}
		
		//신청글 상태수정 페이지로 이동
		@GetMapping("/statusModify")
		public String statusModify(HttpSession session, HttpServletResponse response, @ModelAttribute("pageNum") String pageNum, int num, Model model) throws Exception{
			
			ApplyVo vo = applyService.getApplyByNum(num);
			
			model.addAttribute("applyVo", vo);
				
			return "library/statusModify";
		}
		
		@PostMapping("/statusModify")
		public String statusModify(ApplyVo applyVo, HttpServletRequest request) {
			
			// 답글 inser하기
			applyService.statusUpdate(applyVo);
			
			return "redirect:/admin/bookManage";
		}
		
		
		@GetMapping("/cancelApply")
		public ResponseEntity<String> cancelApply(int num, String pageNum) {
			
			applyService.deleteByNum(num);

			HttpHeaders headers = new HttpHeaders(); //header를 통해서 html에 출력정보를 넣어준다. mvc에서 response.setContentType("text/html; charset=UTF-8");와 동일
			headers.add("Content-type", "text/html; charset=UTF-8");
			
			// mvc에서는 PrintWriter out = response.getWriter();로 우리가 html 입력 정보를 직접 출력했다
			StringBuilder sb = new StringBuilder(); //하지만 spring에서는 우리가 직접 정보를 출력하는 것은 허용되지 않는다. 무조건 spring이 하도록 해야한다.
													// 따라서 출력정보만 StringBuilder로 spring에게 넘겨주는것
			sb.append("<script>");                   //넘겨주면 알아서 스프링이 출력해준다.
			sb.append("alert('신청이 취소되었습니다.');");
			sb.append("location.href='/library/apply?pageNum'");
			sb.append("</script>");
			
			return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
			
		}
	
		
		
	
	
} //applyController
