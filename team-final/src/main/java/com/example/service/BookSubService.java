package com.example.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.ApplyDto;
import com.example.domain.ApplyVo;
import com.example.domain.BookDto;
import com.example.domain.BookRentDto;
import com.example.domain.BookSubVo;
import com.example.domain.BookVo;
import com.example.domain.Criteria;
import com.example.domain.RentVo;
import com.example.domain.BookSubDto;
import com.example.mapper.BookMapper;
import com.example.mapper.BookSubMapper;

import lombok.extern.java.Log;

@Log
@Service
@Transactional // 모든 메소드 각각이 한개의 트랜잭션 단위로 수행됨
public class BookSubService {
	@Autowired
	private BookSubMapper bookSubMapper;
	
	@Autowired
	private BookMapper bookMapper;
	

	public int getReserveState(int bookCode) {
		int reserveState = bookSubMapper.getReserveState(bookCode);
		
		return reserveState;
	}//getRentState()
	
	
	public Integer getSerialNumsearch(int bookCode) {
		Integer serialNumsearch = bookSubMapper.getSerialNumsearch(bookCode);
		
		System.out.println(serialNumsearch);
		
		return serialNumsearch;
	}
	
	public BookSubVo getSubBookByNum(int serialNum) {
		
		BookSubVo book = bookSubMapper.getSubBookByNum(serialNum);
		
		return book;
	}
	
	// 서브 북 추가하기
	public int insertSubBook(int bookcode, String bookname) {
		
		int update = bookSubMapper.insertSubBook(bookcode,bookname);
		bookMapper.updateBookAmount(bookcode);
		
		return update;
	} // getMyBoardById()
	
	
	// 북코드로 서브도서 삭제 메소드(책 전체 삭제할 때 사용)
	public void removeSubBookByBookCode(int bookcode) {
		
		bookSubMapper.removeByBookCode(bookcode);
		
	}
	
	// 시리얼번호로 서브도서 삭제 메소드
	public void removeSubBookBySerialNum(int bookcode, int serialNum) {
		
		bookSubMapper.removeBySerialNum(serialNum);
		bookMapper.updateBookAmount2(bookcode);
		
	}
	
	// 서브도서 사용중지
	public void useStop(int serialNum) {
		
		bookSubMapper.useStop(serialNum);
		
	}
	
	// 서브도서 사용가능
	public void available(int serialNum) {
		
		bookSubMapper.available(serialNum);
		
	}
	
	public int applyTest(String id) {
		
		int cnt = bookSubMapper.applyTest(id);
		
		return cnt;
	}
	
	
	public BookSubDto getMyReserveList(String id, Criteria cri) {
		List<BookSubVo> list = bookSubMapper.getMyReserveList(id, cri);
		int bookSubCnt = bookSubMapper.getMyReserveCnt(id);
		log.info("reserveCnt: " + bookSubCnt);
		BookSubDto myReserveDto = new BookSubDto(list, bookSubCnt);

		return myReserveDto;
	} // getMyBoardById()
	
	public BookSubDto getMyRentList(String id, Criteria cri) {
		List<BookSubVo> list = bookSubMapper.getMyRentList(id, cri);
		int bookSubCnt = bookSubMapper.getMyRentCnt(id);
		log.info("rentCnt: " + bookSubCnt);
		BookSubDto myRentDto = new BookSubDto(list, bookSubCnt);

		return myRentDto;
	} // getMyBoardById()
	
	//관리자 페이지 신청도서 리스트
	public BookSubDto getApplyBookList(Criteria cri) {
		List<BookSubVo> list = bookSubMapper.getApplyBookList(cri);
		int bookSubCnt = bookSubMapper.getApplyBookCnt();
		log.info("applyBookCnt: " + bookSubCnt);
		BookSubDto applyBookListDto = new BookSubDto(list, bookSubCnt);

		return applyBookListDto;
	} // getMyBoardById()
	
	public BookSubDto getRentBookList(Criteria cri) {
		List<BookSubVo> list = bookSubMapper.getRentBookList(cri);
		int bookSubCnt = bookSubMapper.getRentBookCnt();
		log.info("applyBookCnt: " + bookSubCnt);
		BookSubDto rentBookListDto = new BookSubDto(list, bookSubCnt);

		return rentBookListDto;
	} // getMyBoardById()
	
	//관리자 사용중지 도서 리스트 가져오기
	public BookSubDto getnotAvailableList(Criteria cri) {
		List<BookSubVo> list = bookSubMapper.getnotAvailableList(cri);
		int bookSubCnt = bookSubMapper.getnotAvailableCnt();
		log.info("사용중지 도서 갯수: " + bookSubCnt);
		BookSubDto notAvailableListDto = new BookSubDto(list, bookSubCnt);

		return notAvailableListDto;
	} // getMyBoardById()
	
	
	//도서 월별 도서대출기록 가져오기
	public BookRentDto getRentRecord(Criteria cri) {
		List<RentVo> list = bookSubMapper.getRentRecord(cri);
		int rentRecordCnt = bookSubMapper.getRentRecordCnt();
		log.info("rentRecordCnt: " + rentRecordCnt);
		BookRentDto RentRecordDto = new BookRentDto(list, rentRecordCnt);

		return RentRecordDto;
	} // getRentRecord()
	
	//나의 도서대출이력 가져오기
	public BookRentDto getMyRentRecord(String id, Criteria cri) {
		List<RentVo> list = bookSubMapper.getMyRentRecord(id, cri);
		int rentRecordCnt = bookSubMapper.getMyRentRecordCnt(id);
		log.info("rentRecordCnt: " + rentRecordCnt);
		BookRentDto myRentRecordDto = new BookRentDto(list, rentRecordCnt);

		return myRentRecordDto;
	} // getRentRecord()
	
	public BookSubDto getReserveBookList(Criteria cri) {
		List<BookSubVo> list = bookSubMapper.getReserveBookList(cri);
		int bookSubCnt = bookSubMapper.getReserveBookCnt();
		log.info("reserveBookCnt: " + bookSubCnt);
		BookSubDto reserveBookListDto = new BookSubDto(list, bookSubCnt);

		return reserveBookListDto;
	} // getMyBoardById()
	
	
	public void applyCancel(int serialNum) {
		
		 // 예약날짜 가져오기
		 String reserveStart = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		 
		 log.info("예약날자:" + reserveStart);
		 
		 // 예약종료 날짜 가져오기
		 LocalDateTime today = LocalDateTime.now();     //Today
	     LocalDateTime tomorrow = today.plusDays(2);
	     	     
	     String reserveEnd = tomorrow.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		
		bookSubMapper.applyCancel(serialNum);
		bookSubMapper.taskReserveUpdate1(reserveStart, reserveEnd);
		
	}
	
	
	
	
	public void bookApplyUpdate(BookSubVo bookSubVo) {
		
		bookSubMapper.bookApplyUpdate(bookSubVo);
	}
	
	public void bookApplyUpdate2(BookSubVo bookSubVo) {
		
		bookSubMapper.bookApplyUpdate2(bookSubVo);
		bookSubMapper.reserve2Update();
	}
	
	
	public void reserveCancel1(int serialNum) {
		
		bookSubMapper.reserveCancel1(serialNum);
		bookSubMapper.reserve2Update();
	}
	
	public void reserveCancel2(int serialNum) {
		
		bookSubMapper.reserveCancel2(serialNum);
		bookSubMapper.reserve2Update();
		
	}
	
	public void reserveCancel3(int serialNum) {
		
		bookSubMapper.reserveCancel3(serialNum);
		
	}
	

	public void bookReserveUpdate1(BookSubVo bookSubVo) {
		
		bookSubMapper.reserveUpdate1(bookSubVo);
	}
	
	
	public void bookReserveUpdate2(BookSubVo bookSubVo) {
		
		bookSubMapper.reserveUpdate2(bookSubVo);
	}
	
	
	public void rentBook(BookSubVo bookSubVo) {
		
		bookSubMapper.rentBook(bookSubVo);
	}
	
	//도서반납 메소드
	public void returnBook(BookSubVo bookSubVo, int serialNum) {
		
		 // 예약날짜 가져오기
		 String reserveStart = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		 
		 log.info("예약날자:" + reserveStart);
		 log.info("시리얼넘버:" + serialNum);
		 log.info("서브책 목록2:" + bookSubVo);
		 
		 // 예약종료 날짜 가져오기
		 LocalDateTime today = LocalDateTime.now();     //Today
	     LocalDateTime tomorrow = today.plusDays(2);
	     	     
	     String reserveEnd = tomorrow.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		
	     
	    //대출기록하기
	    bookSubMapper.recordReturn(bookSubVo,reserveStart);
	    
	    //시리얼번호로 도서반납
	    bookSubMapper.returnBook(serialNum);

		bookSubMapper.taskReserveUpdate1(reserveStart, reserveEnd);
	}
	
	
	//대출기간 연장
	public void extensionBook(BookSubVo bookSubVo) {
		
		bookSubMapper.extensionBook(bookSubVo);
	}
	
	
	
	public void taskApplyUpdate() {
		
		bookSubMapper.taskApplyUpdate();
	}
	
	public void taskReserveUpdate1(String reserveStart, String reserveEnd) {
		
		bookSubMapper.taskReserveUpdate1(reserveStart, reserveEnd);
	}
	
	public void taskReserveUpdate2() {
		
		bookSubMapper.taskReserveUpdate2();
	}
	
	public void taskReserveUpdate3(String reserveStart, String reserveEnd) {
		
		bookSubMapper.taskReserveUpdate3(reserveStart, reserveEnd);
	}
	
	//도서관 대출도서 미반납자 갱신하기
	public void taskNonReturn() {
		
		bookSubMapper.taskNonReturn();
	}
	
	
	
	public List<BookSubVo> getBookSubList(int bookCode) {
		
		List<BookSubVo> list = bookSubMapper.getBookSubList(bookCode);
		
		return list;
		
	}
}
