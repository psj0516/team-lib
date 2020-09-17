package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.domain.BoardVo;
import com.example.domain.NoticeVo;


public interface NoticeMapper {
	
	// 새글번호 생성
	@Select(value="SELECT ifnull(max(num), 0) + 1 as max_num FROM notice")
	int getNoticeNum(); //sql문 실행시 결과값에 맞게 반환형을 주어야한다. 다르게 주면 알아서 인식

	
	//공지글 생성
	int insertNotice(NoticeVo vo);
	
	//공지글 총 갯수
	int getTotalCount(@Param("category") String category,
					  @Param("search") String search);
	
	
	// 공지글 전부 가져오기
	List<NoticeVo> getNotices(@Param("startRow") int startRow, 
							  @Param("pageSize") int pageSize,
			                  @Param("category") String category,
			                  @Param("search") String search);
	
	// 메인페이지 공지글 가져오기
	List<NoticeVo> getSubNoitces(int pageSize);
		
	// 조회수 수정
	void updateReadcount(int num);
	
	// 번호로 공지글 가져오기
	NoticeVo getNoticeByNum(int num);
		
	// 공지글 수정
	void update(NoticeVo vo);
	
	// 특정 공지글 삭제
	@Delete("DELETE FROM notice WHERE num = #{num}")
	void deleteByNum(int num);
	
	// 게시글 전체 삭제
	@Delete("DELETE FROM notice")
	void deleteAll();
	
	
	//notice와 noticefile 테이블 조인해서 select
	NoticeVo getNoticeAndNoitcefilesByNum(int num);

	
}
