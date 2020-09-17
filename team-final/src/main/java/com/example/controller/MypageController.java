package com.example.controller;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.BookPageDto;
import com.example.domain.MemberVo;
import com.example.service.BookLikeService;
import com.example.service.MemberService;
import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping("/mypage/*")
public class MypageController {
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BookLikeService bookLikeService;
	

	// 마이페이지 - 비밀번호 재확인 화면
	@GetMapping("/mypageCheck")
	public String mypageCheck(HttpSession session, Model model) {
		String id = (String) session.getAttribute("id");
		if (id == null) {
			return "redirect:/";
		}
		MemberVo info = memberService.getInfoById(id);
		model.addAttribute("memberVo", info);
		return "/mypage/mypageCheck";
	}

	// 마이페이지 - 비밀번호 재확인 절차
	@PostMapping("/mypage/infoCheck")
	ResponseEntity<String> login(String id, String passwd, @RequestParam(defaultValue = "false") boolean keepLogin,
			HttpSession session, HttpServletResponse response) {
		// 0: 실패, 1: 성공
		int check = memberService.userCheck(id, passwd);

		// 실패시
		if (check != 1) {
			String message = "비밀번호가 일치하지 않습니다.";

			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", "text/html; charset=UTF-8");

			StringBuilder sb = new StringBuilder();
			sb.append("<script>");
			sb.append("alert('" + message + "');");
			sb.append("history.back();");
			sb.append("</script>");

			return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
		}

		// 성공시
		HttpHeaders headers = new HttpHeaders();
		headers.add("Location", "/mypage/mypage"); // redirect 경로 위치 지정
		return new ResponseEntity<String>(headers, HttpStatus.FOUND);
	}
	
	@GetMapping("/moreBookLike")
	public String moreBookLike() {
		return "/mypage/bookLike";
	}
	
	@GetMapping("/books/like/{pageNum}")
	@ResponseBody
	public ResponseEntity<BookPageDto> likeBooks(HttpSession session, @PathVariable("pageNum") int pageNum) {
		
		String id = (String) session.getAttribute("id");
		List likeList = null;
		
		int pageSize=3;
		int startRow = (pageNum-1) * pageSize;
		

		int likeCnt = bookLikeService.getMyLikeListCount(id);
		System.out.println("likeCnt: "+  likeCnt);

		if(likeCnt > 0) {
			likeList = bookLikeService.getMyBookLikeListWithPaging(id, startRow, pageSize);
		}
		
		BookPageDto bpDto;
		bpDto = new BookPageDto(likeList,likeCnt);
		System.out.println(bpDto);
		return new ResponseEntity<BookPageDto>(bpDto,HttpStatus.OK);
	}
	
	
	//관심도서 삭제
	@DeleteMapping(value="/books/like")
	@ResponseBody
	public void delLike(HttpSession session,int bookCode) {
		System.out.println("bookCode in controller : "+bookCode);
		String id = (String) session.getAttribute("id");
		String memNum = memberService.getMemNumById(id);
		
		bookLikeService.delBookLike(memNum, bookCode);
	}
	
	
	// 마이페이지
	@GetMapping("/mypage")
	public String mypage(
			
			HttpSession session, Model model) {
		// 회원정보 가져오기
		String id = (String) session.getAttribute("id");
		if (id == null) {
			return "redirect:/";
		}
		MemberVo info = memberService.getInfoById(id);
		model.addAttribute("memberVo", info);

		// 작성글 가져오기

		return "/mypage/mypage";
	}

	// 회원정보 수정
	@PostMapping("/infoUpdate")
	public String infoUpdate(MemberVo memberVo) {
		memberService.updateInfo(memberVo);
		return "redirect:/mypage/mypage";
	}

	@GetMapping("/books")
	public void books() {
	}
}