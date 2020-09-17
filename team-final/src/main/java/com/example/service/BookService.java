package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.ApplyDto;
import com.example.domain.ApplyVo;
import com.example.domain.BookDto;
import com.example.domain.BookSubVo;
import com.example.domain.BookVo;
import com.example.domain.Criteria;
import com.example.mapper.BookMapper;

import lombok.extern.java.Log;

@Log
@Service
@Transactional // 모든 메소드 각각이 한개의 트랜잭션 단위로 수행됨
public class BookService {
	
	@Autowired
	private BookMapper bookMapper;
	
	//  도서번호 생성 메소드
	public int getNewBookCode() {
		
		int bookCode = bookMapper.getNewBookCode();
		
		return bookCode;
	} // getNewBookCode()
	
	public void insertBook(BookVo bookVo) {
		
		bookMapper.insertBook(bookVo);
		
	}
	
	// 도서 삭제 메소드
	public void removeBook(int bookCode) {
		
		bookMapper.deleteByBookCode(bookCode);
		
	}
	
	// 베스트 도서 가져오기
	public List<BookVo> getBestBook() {
		
		List<BookVo> bestBook = bookMapper.getBestBook();
		
		return bestBook;
	}
	
	// 도서 대출 횟수증가
	public void updateRentCnt(int bookCode) {
		
		bookMapper.updateRentCnt(bookCode);
		
	}
	
	
	public List<BookVo> getBooksInfo(int startRow, int pageSize, String category, String search) {
		List<BookVo> list = bookMapper.getBooksInfo(startRow, pageSize, category, search);
		return list;
	}
	
	public BookVo getBookInfo(int bookCode) {
		BookVo vo = bookMapper.getBookInfo(bookCode);
		return vo;
	}
	
	
	public int getBookCnt(String category, String search) {

		int cnt = bookMapper.getBookCnt(category, search);

		return cnt;
	}
	
	// 관지자 페이지 검색으로 북리스트 가져오는 메소드
	public BookDto getSearchBookList(String search, Criteria cri) {
		List<BookVo> list = bookMapper.getSearchBookList(search, cri);
		log.info("list: " + list);
		int bookCnt = bookMapper.getSeachBookCnt(search);

		BookDto bookDto = new BookDto(list, bookCnt);
		log.info("bookDto: " + bookDto);

		return bookDto;
	} // getMyBoardById()
	
	// 관지자 페이지 북리스트 가져오는 메소드
	public BookDto getAdminBookList(Criteria cri) {
		List<BookVo> list = bookMapper.getAdminBookList(cri);
		log.info("list: " + list);
		int bookCnt = bookMapper.getAdminBookCnt();

		BookDto bookDto = new BookDto(list, bookCnt);
		log.info("bookDto: " + bookDto);

		return bookDto;
	} // getMyBoardById()
}
