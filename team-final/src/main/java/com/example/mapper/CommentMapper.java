package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.domain.CommentVo;

public interface CommentMapper {

	
	@Select(value="select ifnull(max(cno), 0) + 1 as max_cno from comment")
	int getCno(); //sql문 실행시 결과값에 맞게 반환형을 주어야한다. 다르게 주면 알아서 인식
	
	
	//댓글 생성
	@Insert("INSERT INTO comment (cno, bno, re_ref, comment, writer) "
			+ "VALUES (#{cno}, #{bno}, #{reRef}, #{comment}, #{writer}) ")
	int insert(CommentVo commentVo);
	
	
	
	//댓글번호로 댓글내용 가져오기
	@Select("SELECT * FROM comment WHERE cno = #{cno}")
	CommentVo getComment(int cno);
	
	
	// 댓글 삭제
	@Delete("DELETE FROM comment WHERE cno = #{cno}")
	int delete(int cno);
	
	// 댓글 수정
	@Update("UPDATE comment "
			+ "SET comment = #{comment}, update_date = CURRENT_TIMESTAMP "
			+ "WHERE cno = #{cno}")
	void update(CommentVo commentVo);
	
	
	// 댓글리스트 가져오기
	@Select("SELECT * "
			+ "FROM comment "
			+ "WHERE bno = #{bno} "
			+ "ORDER BY re_ref ASC, re_lev ASC")
	List<CommentVo> getList(int bno);
	
	//댓글의 답글 생성
	@Insert("INSERT INTO comment (bno, cno, comment, writer, re_ref, re_lev) "
			+ "VALUES (#{bno}, #{cno}, #{comment}, #{writer}, #{reRef}, #{reLev}) ")
	int replyinsert(CommentVo commentVo);
	
	
	
}








