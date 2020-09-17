package com.example.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.domain.SeatVo;
import com.example.service.SeatService;

@Controller
@RequestMapping("/library/*")
public class SeatController {
	
	@Autowired
	private SeatService seatService;
	
	
	// 자리 예약/현황 첫 화면
	@GetMapping("/seatRes")
	public String seatRes(Model model, HttpSession session) { //HttpSession session
		
		
		String id = (String) session.getAttribute("id");
		
		
		if (id != null && id.equals("admin")) {
			
			return "redirect:/admin/seatManage";	
		
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
			String tendTime = yymmdd+"T"+hhmmss;
			LocalDateTime endTime = LocalDateTime.parse(tendTime, DateTimeFormatter.ISO_DATE_TIME);
			LocalDateTime twelve = LocalDateTime.of(LocalDate.now(), LocalTime.of(12, 0));
			if (endTime.isBefore(timeNow) && endTime.isEqual(twelve) == false ) {
				int seatNum = vo.getSeatNum();
				seatService.exitBySeatNum(seatNum);
			}	
		}
	}
	
	//로그인 했을시 memNum가져오기

	if (id != null && id !="") {
		int memNum = seatService.getMemNumById(id);
		// member테이블에서 가져온 예약시 필요한 memNum
		model.addAttribute("memNum", memNum);
			
		SeatVo mySeat = null;
		
		List<SeatVo> listVo = seatService.getSeatAndName();
		
		for (SeatVo seatAndNameVo : listVo) {
			if (memNum == seatAndNameVo.getMemNum()) {
				String sReserveTime = seatAndNameVo.getReserveTime();
				
				String reserveTime = sReserveTime.substring(11,16);
				String sEndTime = seatAndNameVo.getEndTime();
				String endTime = sEndTime.substring(11,16);
				

				seatAndNameVo.setReserveTime(reserveTime);
				seatAndNameVo.setEndTime(endTime);
								
				mySeat = seatAndNameVo;
			}
		}
			model.addAttribute("mySeat", mySeat);
	}
	
	// 퇴실 후 자리에 대한 모든정보 
	List<SeatVo> list = seatService.getAllSeat();
		
	model.addAttribute("allSeat", list);
	
	
	// 예약 시간과 퇴실시간 설정 
	LocalTime lReserveTime = LocalTime.now();
	LocalTime lEndTime = lReserveTime.plusHours(3);
	
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
	
	String sReserveTime = lReserveTime.format(formatter);
	String sEndTime = lEndTime.format(formatter);
	
	LocalTime reserveTime = LocalTime.parse(sReserveTime, DateTimeFormatter.ISO_TIME);
	LocalTime endTime = LocalTime.parse(sEndTime, DateTimeFormatter.ISO_TIME);
	
	LocalTime openTime = LocalTime.of(8, 0);
	
	LocalTime closeTime = null;
	
	// 이용시간 주말과 평일 구분
	Calendar calendar = Calendar.getInstance();
	int week = calendar.get(Calendar.DAY_OF_WEEK);
	
	if(week == 1 || week == 7) {
		closeTime = LocalTime.of(20, 0);
	} else {
		closeTime = LocalTime.of(23, 59);
	}
	
	if (reserveTime.isBefore(openTime) || reserveTime.isAfter(closeTime)) {
		reserveTime = openTime;
		endTime = reserveTime.plusHours(3);
	}
	
	if (endTime.isAfter(closeTime) || endTime.isBefore(openTime)) {
		endTime = closeTime;
	}

	model.addAttribute("reserveTime", reserveTime);
	model.addAttribute("endTime", endTime);
	
	return null;
		
	}

	// 자리예약 설정
	@PostMapping("/seatRes")
	public ResponseEntity<String> reservation(SeatVo vo, HttpServletRequest request, Model model) {
		int seatNum =  vo.getSeatNum();
		int memNum = vo.getMemNum();
		// 선택한 자리의 boolean 이용여부 또는 다른 자리의 이용여부
		Boolean useSelectSeat = seatService.useSelectSeat(seatNum);
		//SeatVo getSeatByMemNumVo  = seatService.getSeatByMemNum(memNum);
		SeatVo mySeat = null;
		
		List<SeatVo> listVo = seatService.getSeatAndName();
		
		for (SeatVo seatAndNameVo : listVo) {
			if (memNum == seatAndNameVo.getMemNum()) {
				
				mySeat = seatAndNameVo;
			}
		}
		
		
		if(useSelectSeat == true  || mySeat != null) {
			
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", "text/html; charset=UTF-8");
			
			StringBuilder sb = new StringBuilder();
			sb.append("<script>");
			sb.append("alert('다른 회원님께서 이용중인 자리이거나 회원님께서 이미 이용중인 자리가 있습니다.');");
			sb.append("history.back();");
			sb.append("</script>");
			
			return new ResponseEntity<String> (sb.toString(), headers, HttpStatus.OK);
			
		} 
			
			// 자리예약시 자리이용여부 true로 설정
			vo.setSeatStatus(true);
			
			// 예약시 현재 년월일 붙여주기
			LocalDate localDate = LocalDate.now();
			String reserveTime = localDate + " " + request.getParameter("reserveTime");
			String endTime = localDate + " " + request.getParameter("endTime");

			vo.setReserveTime(reserveTime);
			vo.setEndTime(endTime);
			
			seatService.reservation(vo);
			
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Location", "/library/seatRes");
		return new ResponseEntity<String> (headers, HttpStatus.FOUND);
	} 

	// 퇴실/예약 취소
	@PostMapping("/exit")
	public ResponseEntity<String> exit(SeatVo vo) {
		
		SeatVo mySeat = null;
		
		int memNum = vo.getMemNum();
		
		List<SeatVo> listVo = seatService.getSeatAndName();
		
		for (SeatVo seatAndNameVo : listVo) {
			if (memNum == seatAndNameVo.getMemNum()) {
				
				mySeat = seatAndNameVo;
			}
		}

		if(mySeat == null) {
			
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", "text/html; charset=UTF-8");
			
			StringBuilder sb = new StringBuilder();
			sb.append("<script>");
			sb.append("alert('사용 중인 자리가 없으면 퇴실할 수 없습니다.');");
			sb.append("history.back();");
			sb.append("</script>");
			
			return new ResponseEntity<String> (sb.toString(), headers, HttpStatus.OK);
			
		} 
			
		
		int seatNum = mySeat.getSeatNum();
		seatService.exitBySeatNum(seatNum);
		
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Location", "/library/seatRes");
		return new ResponseEntity<String> (headers, HttpStatus.FOUND);
	}
	
	@RequestMapping(method = RequestMethod.POST,
			value = "/resetSeat")
	public ResponseEntity<List<SeatVo>> resetSeat() {
	
	List<SeatVo> list = seatService.getAllSeat();
	
	for (SeatVo vo : list) {
		if (vo.getEndTime() != "" && vo.getEndTime() != null) {
			String sReserveTime = vo.getReserveTime();
			String reserveTime = sReserveTime.substring(11);
			String sEndTime = vo.getEndTime();
			String endTime = sEndTime.substring(11);
	
			vo.setReserveTime(reserveTime);
			vo.setEndTime(endTime);
		}
		
	}
	
	return new ResponseEntity<List<SeatVo>>(list, HttpStatus.OK);
	
	}
	
	@RequestMapping(method = RequestMethod.POST,
				value = "/myState")
	public ResponseEntity<SeatVo> myState(HttpSession session) {
	
	String id = (String) session.getAttribute("id");
	
	SeatVo myState = null;
	
	if (id != null && id !="") {
		int memNum = seatService.getMemNumById(id);
			
		List<SeatVo> listVo = seatService.getSeatAndName();
		
		for (SeatVo seatAndNameVo : listVo) {
			if (memNum == seatAndNameVo.getMemNum()) {
				
				myState = seatAndNameVo;
			}
			
		}
		
	}
	
	return new ResponseEntity<SeatVo>(myState, HttpStatus.OK);
	
	}
	
	// 입실 시간과 퇴실시간 실시간으로 갱신
	@RequestMapping(method = RequestMethod.POST,
			value = "/updateTime")
	public ResponseEntity<Map<String, LocalTime>> updateTime() {
	
		// 예약 시간과 퇴실시간 설정 
		LocalTime lReserveTime = LocalTime.now();
		LocalTime lEndTime = lReserveTime.plusHours(3);
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
		
		String sReserveTime = lReserveTime.format(formatter);
		String sEndTime = lEndTime.format(formatter);
		
		LocalTime reserveTime = LocalTime.parse(sReserveTime, DateTimeFormatter.ISO_TIME);
		LocalTime endTime = LocalTime.parse(sEndTime, DateTimeFormatter.ISO_TIME);
		
		LocalTime openTime = LocalTime.of(8, 0);
		
		LocalTime closeTime = null;
		
		// 이용시간 주말과 평일 구분
		Calendar calendar = Calendar.getInstance();
		int week = calendar.get(Calendar.DAY_OF_WEEK);
		
		if(week == 1 || week == 7) {
			closeTime = LocalTime.of(20, 0);
		} else {
			closeTime = LocalTime.of(23, 59);
		}
		
		if (reserveTime.isBefore(openTime) || reserveTime.isAfter(closeTime)) {
			reserveTime = openTime;
			endTime = reserveTime.plusHours(3);
		}
		
		if (endTime.isAfter(closeTime) || endTime.isBefore(openTime)) {
			endTime = closeTime;
		}
		
		
		Map<String, LocalTime> updateTime = new HashMap<>();
		updateTime.put("reserveTime", reserveTime);
		updateTime.put("endTime", endTime);
	
	return new ResponseEntity<Map<String, LocalTime>>(updateTime, HttpStatus.OK);
	
	}
	
	
	/////////////////////////////관리자////////////////////////////////////////
	
	
	// 자리생성
	@GetMapping("/createSeat")
	public String createSeat() {
	
		seatService.insert();
		
		return "redirect:/admin/seatManage";
	}
		
	// 자리제거
	@GetMapping("/deleteSeat")
	public String deleteSeat(int count) {
	
		seatService.delete(count);
		seatService.resetAI(count);
		
		return "redirect:/admin/seatManage";
	}
		
	// 관리자가 임의의 자리 비활성화
	@PostMapping("/seatDisable")
	public ResponseEntity<String> seatDisable(SeatVo vo, HttpServletRequest request) {
	
		if(vo.getSeatNum() == null) {
				
		   HttpHeaders headers = new HttpHeaders();
		   headers.add("Content-Type", "text/html; charset=UTF-8");
			
		   StringBuilder sb = new StringBuilder();
		   sb.append("<script>");
		   sb.append("alert('비활성화 처리할 자리를 선택해 주세요');");
		   sb.append("history.back();");
		   sb.append("</script>");
		   
		   return new ResponseEntity<String> (sb.toString(), headers, HttpStatus.OK);
				
		} 
		
		
		// 자리예약시 자리이용여부 true로 설정
		vo.setSeatStatus(true);
		String formatDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		vo.setReserveTime(formatDate);
		
		seatService.reservation(vo);
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Location", "/library/seatRes");
		return new ResponseEntity<String> (headers, HttpStatus.FOUND);
		
	} 
		
	// 관리자가 선택한 사용자를 퇴실처리
	@RequestMapping(method = RequestMethod.POST,
					value = "/selectExit")
	public ResponseEntity<List<SeatVo>> selectExit(@RequestBody List<SeatVo> selectExit) {
		
		List<SeatVo> nameAndSeatVo = null;
		
		if(selectExit != null) {
			for (SeatVo exitVo : selectExit) {
				seatService.exitBySeatNum(exitVo.getSeatNum());
			}
		}
		
	
		// join을 활용한 현재 좌석이 배치된 사용자의 이름과 자리정보
		nameAndSeatVo = seatService.getSeatAndName();
		
		for (SeatVo vo :nameAndSeatVo) {
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
		
		return new ResponseEntity<List<SeatVo>>(nameAndSeatVo, HttpStatus.OK);
	
	}	
	
	// ajax에서 사용할 현재 사용중인 자리정보 !!!관리자 와 이용자 모두 사용!!!
	@RequestMapping(method = RequestMethod.POST,
			value = "/seatList")
	public ResponseEntity<List<SeatVo>> seatList() {
		
		// 퇴실전의 모든 자리정보
		List<SeatVo> exitList = seatService.getAllSeat();

		// 현재 시간과 이용중인 모든 자리의 종료 시간를 비교하여 현재시간보다 종료시간이 과거라면 퇴실처리
		LocalDateTime timeNow = LocalDateTime.now();

		for (SeatVo vo : exitList) {
			if (vo.getEndTime() != "" && vo.getEndTime() != null) {
				String sEndTime = vo.getEndTime();
				String yymmdd = sEndTime.substring(0, 10);
				String hhmmss = sEndTime.substring(11);
				String tendTime = yymmdd+"T"+hhmmss;
				LocalDateTime endTime = LocalDateTime.parse(tendTime, DateTimeFormatter.ISO_DATE_TIME);
				LocalDateTime twelve = LocalDateTime.of(LocalDate.now(), LocalTime.of(12, 0));
				if (endTime.isBefore(timeNow) && endTime.isEqual(twelve) == false ) {
					int seatNum = vo.getSeatNum();
					seatService.exitBySeatNum(seatNum);
				}	
			}
		}
		
		List<SeatVo> nameAndSeatVo = null;
			
		// join을 활용한 현재 좌석이 배치된 사용자의 이름과 자리정보
		nameAndSeatVo = seatService.getSeatAndName();
		
		for (SeatVo vo :nameAndSeatVo) {
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
	
	return new ResponseEntity<List<SeatVo>>(nameAndSeatVo, HttpStatus.OK);
	
	}	
		
	////////////////////////////////////////////////////////////////////////////////
		
}
