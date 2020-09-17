package com.example.task;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.example.service.BoardService;
import com.example.service.BookSubService;

import lombok.extern.java.Log;

@Component //스프링이 알아서 작동시키고 관리 하기 떄문에 스프링 빈으로 만들어줘야한다. 직접 쿼츠(알람)을 사용할 수 있지만 그건 어렵고 실무에서 잘 안쓰인다 그러니 스프링에 맡기자.
@Log
public class LibraryTask {
	
	@Autowired
	private BookSubService bookSubService;

	@Scheduled(cron = "0 10 00 * * *") 
	//도서관 도서신청현황 갱신
	public void applyUpdate() {
		
		bookSubService.taskApplyUpdate();
		
		log.info("도서신청 업데이트 성공");
	}
	
	@Scheduled(cron = "0 11 00 * * *") 
	//도서관 예액현황 갱신1
	public void reserveUpdate1() {
		
		 // 예약날짜 가져오기
		 String reserveStart = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		 
		 log.info("예약날자:" + reserveStart);
		 
		 // 예약종료 날짜 가져오기
		 LocalDateTime today = LocalDateTime.now();     //Today
	     LocalDateTime tomorrow = today.plusDays(2);
	     
	     String reserveEnd = tomorrow.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
	     
	     log.info("예약종료:" + reserveEnd);
		 
		bookSubService.taskReserveUpdate1(reserveStart, reserveEnd);
		
		log.info("도서예약 업데이트1 성공");
	}
	
	@Scheduled(cron = "00 13 00 * * *") 
	//도서관 예액현황 갱신2
	public void reserveUpdate2() {
		
		bookSubService.taskReserveUpdate2();
		
		log.info("도서예약 업데이트2 성공");
	}
	
	@Scheduled(cron = "00 15 00 * * *") 
	//도서관 예액현황 갱신3
	public void reserveUpdate3() {
		
		 // 예약날짜 가져오기
		 String reserveStart = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		 
		 // 예약종료 날짜 가져오기
		 LocalDateTime today = LocalDateTime.now();     //Today
	     LocalDateTime tomorrow = today.plusDays(2);
	     
	     String reserveEnd = tomorrow.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		 
		bookSubService.taskReserveUpdate3(reserveStart, reserveEnd);
		
		log.info("도서예약 업데이트3 성공");
	}
	
	@Scheduled(cron = "00 17 00 * * *") 
	//도서관 대출도서 미반납자 갱신하기
	public void rentUpdate() {
		
		bookSubService.taskNonReturn();
		
		log.info("도서예약 업데이트4 성공");
	}
	
	
	
}
