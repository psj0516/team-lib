package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.domain.BoardVo;
import com.example.domain.Criteria;


public interface BoardMapper {
	
	// 새글번호 생성
	@Select(value="select ifnull(max(num), 0) + 1 as max_num from board")
	int getBoardNum(); //sql문 실행시 결과값에 맞게 반환형을 주어야한다. 다르게 주면 알아서 인식


	//글 생성
	int insertBoard(BoardVo vo);
	
	//게시판 총 갯수
	int getTotalCount(@Param("category") String category,
					  @Param("search") String search);
	
	
	// 내가 작성한 게시물 갯수
	@Select("SELECT count(*) FROM board WHERE id = #{id} ")
	int getMyBoardCnt(String id);
	
	//문의 및 건의사항 게시물 갯수
	@Select("SELECT count(*) FROM board WHERE type = 2 AND status != 0 ")
	int getInquireCnt();
	
	//오류신고 게시물 갯수
	@Select("SELECT count(*) FROM board WHERE type = 1 AND status != 0 ")
	int getErrorCnt();
	
	
	//답변 여부확인
	@Select("SELECT count(*) FROM board WHERE re_ref = #{num} AND type = 0 ")
	int getReplyCount(int num);
	
	//답변 가져오기
	@Select("SELECT * FROM board WHERE re_ref = #{num} AND type = 0 ")
	BoardVo getReplyByNum(int num);
	
	// 게시글 전부 가져오기
	// 매퍼 메소드의 매개변수가 2개 이상일떄는
	// @Param 애노테이션 값으로 sql 문에 배치함
	// select문을 xml에서 실행할 때는
	// resultType 속성을 반드시 해당 Vo로 지정해야 함.
	List<BoardVo> getBoards(@Param("startRow") int startRow, 
							@Param("pageSize") int pageSize,
			                @Param("category") String category,
			                @Param("search") String search);
	
	
	//답변상태 '완료'로 수정
	void updateStatus(int reRef);
	
	
	//답변상태 '대기 중' 으로 수정
	void updateStatus2(int reRef);
	
	
	// 조회수 수정
	void updateReadcount(int num);
	
	// 특정 게시글 가져오기
	BoardVo getBoardByNum(int num);
	
	// 내가 작성한 게시글 가져오기
	List<BoardVo> getMyBoardById(String id);
		
	// 게시글 수정
	void update(BoardVo vo);
	
	// 글 번호로 게시글 삭제
	@Delete("DELETE FROM board WHERE num = #{num}")
	void deleteByNum(int num);
	
	//reRef로 게시글 삭제
	@Delete("DELETE FROM board WHERE re_ref = #{reRef}")
	void deleteByReref(int reRef);
	
	// 게시글 전체 삭제
	@Delete("DELETE FROM board")
	void deleteAll();
	
	int updateReSeqByReRef(@Param("reRef")int reRef, @Param("reSeq")int reSeq);
	
	
	@Select("SELECT * "
			+ "FROM board "
			+ "WHERE id = #{id} "
			+ "ORDER BY num DESC "
			+ "LIMIT #{cri.startRow}, #{cri.pageSize} ")
	List<BoardVo> getMyBoardWithPaging(@Param("id") String id, @Param("cri") Criteria cri);
	
	//문의 및 건의글 리스트 가져오기
	@Select("SELECT * "
			+ "FROM board "
			+ "WHERE type = 2 AND status != 0 "
			+ "ORDER BY num DESC "
			+ "LIMIT #{cri.startRow}, #{cri.pageSize} ")
	List<BoardVo> getInquireList(@Param("cri") Criteria cri);
	
	//오류사항 게시글 리스트 가져오기
	@Select("SELECT * "
			+ "FROM board "
			+ "WHERE type = 1 AND status != 0 "
			+ "ORDER BY num DESC "
			+ "LIMIT #{cri.startRow}, #{cri.pageSize} ")
	List<BoardVo> getErrorList(@Param("cri") Criteria cri);
	
	
	
}
