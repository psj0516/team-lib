package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.BookLikeVo;
import com.example.domain.BookVo;
import com.example.mapper.BookLikeMapper;
import com.example.mapper.MemberMapper;

import lombok.extern.java.Log;

@Log
@Service
@Transactional // 모든 메소드 각각이 한개의 트랜잭션 단위로 수행됨
public class BookLikeService {
	
	@Autowired
	private BookLikeMapper bookLikeMapper;
	
	@Autowired
	private MemberMapper memberMapper;

	
	public boolean getBookLike(String memNum, int bookCode) {
		boolean booklikecnt = false;
		booklikecnt = bookLikeMapper.getBookLike(memNum,bookCode);
		return booklikecnt;
	}//getBookLike()
	
	public void delBookLike(int memNum, int bookCode) {
		bookLikeMapper.delBookLike(memNum, bookCode);
	}
	
	public void delBookLike(String memNum, int bookCode) {
		bookLikeMapper.delBookLike(memNum, bookCode);
	}
	
	public void insertBookLike(int memNum, int bookCode) {
		bookLikeMapper.insertBookLike(memNum, bookCode);
	}
	
	public List<BookVo> getMyBookLikeListWithPaging(String id, int startRow, int pageSize){
		String memNum = memberMapper.getMemNumById(id);
		List list = bookLikeMapper.getLikeListByMemNumWithPaging(memNum, startRow, pageSize);
		
		return list;
	}
	
	public List<BookVo>getMyBookLikeList(String id){
		String memNum = memberMapper.getMemNumById(id);
		List list = bookLikeMapper.getLikeListByMemNum(memNum);
		
		return list;
	}
	
	public int getMyLikeListCount(String id) {
		int cnt=0;
		
		String memNum = memberMapper.getMemNumById(id);
		cnt = bookLikeMapper.getLikeCountByMemNum(memNum);
		
		return cnt;
	}
	

}