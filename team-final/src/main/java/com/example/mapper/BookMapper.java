package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.domain.ApplyVo;
import com.example.domain.BookLikeVo;
import com.example.domain.BookSubVo;
import com.example.domain.BookVo;
import com.example.domain.Criteria;

public interface BookMapper {
	
	// 도서번호 생성
	@Select(value="select ifnull(max(bookcode), 0) + 1 as max_num from books")
	int getNewBookCode(); //sql문 실행시 결과값에 맞게 반환형을 주어야한다. 다르게 주면 알아서 인식
	
	//관리자 페이지 검색으로 도서목록 갯수
	@Select("SELECT count(*) FROM books WHERE bookname LIKE CONCAT('%',#{search},'%') OR author LIKE CONCAT('%',#{search},'%') OR publisher LIKE CONCAT('%',#{search},'%') ")
	int getSeachBookCnt(String search);
	
	//관리자 페이지 검색으로 도서목록 갯수
	@Select("SELECT count(*) FROM books ")
	int getAdminBookCnt();
	
	//도서 추가하기
	int insertBook(BookVo bookVo);

	// 해당도서 전체  삭제
	@Delete("DELETE FROM books WHERE bookcode = #{bookCode}")
	void deleteByBookCode(int bookCode);
	
	int getBookCnt(@Param("category") String category,
			@Param("search") String search);
	
	//베스트 도서 가져오기
	@Select("SELECT * "
			+ "FROM books "
			+ "ORDER BY rentcnt DESC "
			+ "LIMIT 6")
	List<BookVo> getBestBook();
	
	
	public BookVo getBookInfo(int bookCode);
	
	List<BookVo> getBooksInfo(@Param("startRow") int startRow, 
			@Param("pageSize") int pageSize,
			@Param("category") String category,
			@Param("search") String search);
	
	//도서 대출 횟수증가
	@Update("UPDATE books SET rentcnt = rentcnt + 1 where bookcode=#{bookCode} ")
	void updateRentCnt(int bookCode);
	
	//도서 갯수 추가
	@Update("UPDATE books SET bookamount = bookamount + 1 where bookcode=#{bookCode} ")
	void updateBookAmount(int bookCode);
	
	//도서 갯수 감소
	@Update("UPDATE books SET bookamount = bookamount - 1 where bookcode=#{bookcode} ")
	void updateBookAmount2(int bookcode);
	
	
	@Select("SELECT bookcode FROM books WHERE serial_num=#{serialNum} ")
	int getBookcodeBySerialNum(int serialNum);
	
	@Select("SELECT COUNT(*) FROM book_like WHERE bookcode=#{bookCode} and mem_num=#{memNum} ")
	int checkBookLike(int bookCode, int memNum);
	
	//관리자 페이지 검색으로 도서목록 가져오기
	@Select("SELECT * "
			+ "FROM books "
			+ "WHERE bookname LIKE CONCAT('%',#{search},'%') OR author LIKE CONCAT('%',#{search},'%') OR publisher LIKE CONCAT('%',#{search},'%') "
			+ "LIMIT #{cri.startRow}, #{cri.pageSize} ")
	List<BookVo> getSearchBookList(@Param("search") String search, @Param("cri") Criteria cri);
	
	//관리자 페이지 검색으로 도서목록 가져오기
	@Select("SELECT * "
			+ "FROM books "
			+ "LIMIT #{cri.startRow}, #{cri.pageSize} ")
	List<BookVo> getAdminBookList(@Param("cri") Criteria cri);
	
}

