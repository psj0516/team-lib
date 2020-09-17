package com.example.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.domain.MemberVo;
import com.example.domain.SeatVo;
import com.example.domain.AdminMemPageDto;
import com.example.service.MemberService;
import com.example.service.SeatService;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping("/admin/*")
public class AdminController {
	@Autowired
	private MemberService memberService;

	@Autowired
	private SeatService seatService;

	@GetMapping("/bookManage")
	public void bookManage() {

	}
	
	@GetMapping("/inquireManage")
	public void inquireManage() {

	}
	
	// 회원정보
	@GetMapping("/memberManage")
	public String memberManage(@RequestParam(defaultValue = "1") int pageNum, Model model) {
		// 멤버 목록 가져오기
		int count = memberService.getTotalCount();

		int pageSize = 20;
		int startRow = (pageNum - 1) * pageSize;

		List<MemberVo> list = null;
		if (count > 0) {
			list = memberService.getMembers(startRow, pageSize);
		}

		int pageCount = count / pageSize;
		if (count % pageSize > 0) {
			pageCount += 1;
		}

		int pageBlock = 5;
		int startPage = ((pageNum / pageBlock) - (pageNum % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;
		int endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) {
			endPage = pageCount;
		}

		AdminMemPageDto pageDto = new AdminMemPageDto();
		pageDto.setCount(count);
		pageDto.setPageCount(pageCount);
		pageDto.setPageBlock(pageBlock);
		pageDto.setStartPage(startPage);
		pageDto.setEndPage(endPage);

		model.addAttribute("memberList", list);
		model.addAttribute("pageDto", pageDto);
		model.addAttribute("pageNum", pageNum);

		return "/admin/memberManage";
	}
	
	@GetMapping("/memberinfo")
	public String memberinfo(int memNum, Model model) {
		MemberVo memberVo = memberService.getMemberByNum(memNum);
		
		model.addAttribute("memberVo", memberVo);
		return "admin/memberinfo";
	}
	
	// 각 회원별 도서정보
	@GetMapping("/bookRent")
	public void bookRent() {
	}
	
	@GetMapping("/bookLike")
	public void bookLike() {
	}
	
	@GetMapping("/bookRes")
	public void bookRes() {
	}

	@GetMapping("/seatManage")
	public String seatManage(Model model, HttpSession session) {
		
		String id = (String) session.getAttribute("id");
		
		
		if (id == null || !id.equals("admin")) {
			
			return "redirect:/library/seatRes";		
		
		}

		
		// 퇴실전의 모든 자리정보
		List<SeatVo> exitList = seatService.getAllSeat();

		// 현재 시간과 이용중인 모든 자리의 종료 시간를 비교하여 현재시간보다 종료시간이 과거라면 퇴실처리
		LocalDateTime timeNow = LocalDateTime.now();

		for (SeatVo vo : exitList) {
			if (vo.getEndTime() != "" && vo.getEndTime() != null) {
				String sEndTime = vo.getEndTime();
				String yymmdd = sEndTime.substring(0, 10);
				String hhmmss = sEndTime.substring(11);
				String tendTime = yymmdd + "T" + hhmmss;
				LocalDateTime endTime = LocalDateTime.parse(tendTime, DateTimeFormatter.ISO_DATE_TIME);
				LocalDateTime twelve = LocalDateTime.of(LocalDate.now(), LocalTime.of(12, 0));
				if (endTime.isBefore(timeNow) && endTime.isEqual(twelve) == false) {
					int seatNum = vo.getSeatNum();
					seatService.exitBySeatNum(seatNum);
				}
			}
		}

		//로그인 했을시 memNum가져오기

		if (id != null && id != "") {
			int memNum = seatService.getMemNumById(id);
			// member테이블에서 가져온 예약시 필요한 memNum
			model.addAttribute("memNum", memNum);

		}

		// 퇴실 후 자리에 대한 모든정보
		List<SeatVo> list = seatService.getAllSeat();
		
		int count = 0;
		
		for (SeatVo vo : list) {
			
			count += 1;
			
			if (vo.getEndTime() != "" && vo.getEndTime() != null) {
				String sReserveTime = vo.getReserveTime();
				String reserveTime = sReserveTime.substring(11);
				String sEndTime = vo.getEndTime();
				String endTime = sEndTime.substring(11);

				vo.setReserveTime(reserveTime);
				vo.setEndTime(endTime);
				
			}

		}
		
		model.addAttribute("allSeat", list);
		
		// 자리갯수
		model.addAttribute("count", count);	
		
		// join을 활용한 현재 좌석이 배치된 사용자의 이름과 자리정보
		List<SeatVo> seatAndNameVo = seatService.getSeatAndName();
		
		int countUseSeat = 0;
		
		for (SeatVo vo : seatAndNameVo) {
			countUseSeat+=1;
			if (vo.getEndTime() != "" && vo.getEndTime() != null) {
				String sReserveTime = vo.getReserveTime();
				String reserveTime = sReserveTime.substring(11);
				String sEndTime = vo.getEndTime();
				String endTime = sEndTime.substring(11);

				vo.setReserveTime(reserveTime);
				vo.setEndTime(endTime);
			} else {
				vo.setEndTime("관리자 퇴실 처리 요망");
			}
		}
	
		model.addAttribute("allSeatAndName", seatAndNameVo);
		// 현재 이용중인 모든 자리 개수
		model.addAttribute("countUseSeat", countUseSeat);
		
		return null;

	}
}
