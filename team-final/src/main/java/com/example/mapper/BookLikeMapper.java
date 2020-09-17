package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.example.domain.BookLikeVo;
import com.example.domain.BookVo;

public interface BookLikeMapper {
	
	boolean getBookLike(String memNum, int bookCode);
	
	void delBookLike(int memNum, int bookCode);
	
	void delBookLike(String memNum, int bookCode);
	
	void insertBookLike(int memNum, int bookCode);
	
	List<BookVo> getLikeListByMemNumWithPaging(String memNum, int startRow, int pageSize);
	
	List<BookVo> getLikeListByMemNum(String memNum);
	@Select("SELECT COUNT(*) FROM book_like WHERE mem_num = #{memNum}")
	int getLikeCountByMemNum(String memNum);

	
}
