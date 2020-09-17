package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.domain.ApplyVo;
import com.example.domain.Criteria;

public interface ApplyMapper {
	
	
	// 신청글 번호 생성
	@Select(value="select ifnull(max(num), 0) + 1 as max_num from book_apply")
	int getApplyNum(); //sql문 실행시 결과값에 맞게 반환형을 주어야한다. 다르게 주면 알아서 인식
	
	//신청글 생성
	int insertApply(ApplyVo vo);
	
	//신청상태 수정
	void updateStatus(int num);
	
	//취소사유 작성
	void updateReason(int num);
	
	//신청 총 갯수
	int getTotalCount(@Param("category") String category,
					  @Param("search") String search);
	
	// 내가 신청한 갯수
	@Select("SELECT count(*) FROM book_apply WHERE id = #{id} ")
	int getMyApplyCnt(String id);
	
	// 관리자 페이지 신청글 갯수
	@Select("SELECT count(*) FROM book_apply WHERE status != 2 AND status != 3 ")
	int getApplyListCnt();
	
	
	// 신청글 전체 가져오기
	List<ApplyVo> getApplys(@Param("startRow") int startRow, 
							@Param("pageSize") int pageSize,
				            @Param("category") String category,
				            @Param("search") String search);
	
	// 신청글 번호로 가져오기
	ApplyVo getApplyByNum(int num);
	
	// 신청글 수정
	void update(ApplyVo vo);
	
	// 도서신청 상태 수정
	void statusUpdate(ApplyVo vo);
	
	// 신청글 삭제
	@Delete("DELETE FROM book_apply WHERE num = #{num}")
	void deleteByNum(int num);
	
	// 신청글 전체 삭제
	@Delete("DELETE FROM book_apply")
	void deleteAll();
	
	@Select("SELECT * "
			+ "FROM book_apply "
			+ "WHERE status != 2 AND status != 3 "
			+ "ORDER BY num DESC "
			+ "LIMIT #{cri.startRow}, #{cri.pageSize} ")
	List<ApplyVo> getApplyList(@Param("cri") Criteria cri);
	
	
	@Select("SELECT * "
			+ "FROM book_apply "
			+ "WHERE id = #{id} "
			+ "ORDER BY num DESC "
			+ "LIMIT #{cri.startRow}, #{cri.pageSize} ")
	List<ApplyVo> getMyApplyWithPaging(@Param("id") String id, @Param("cri") Criteria cri);
	

}
