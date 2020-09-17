package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;

import com.example.domain.SeatVo;

public interface SeatMapper {
	// 자리생성
	void insert();
	
	// 자리제거
	@Delete("DELETE FROM seat where seat_num = #{seatNum}")
	void delete(int count);
	
	//MySQL seat_num의 auto_increment 초기화 및 셋팅
	void resetAI(int count);
	
	// 예약하기전 내가 사용한 자리의 이용여부
	@Select("SELECT seat_status FROM seat where seat_num = #{seatNum}")
	Boolean useSelectSeat(int seatNum);
	
	// 예약하기
	void reservation(SeatVo seatVo);
	
	// 퇴실하기
	void exitBySeatNum(int seatNum);
	
	// member에서 memId가져오기
	@Select("SELECT mem_num FROM member WHERE id = #{id}")
	int getMemNumById(String id);
	
	// seat에서 memNum과 일치하는 행 가져오기 ***********************
//	@Select("SELECT * FROM seat WHERE mem_num = #{memNum}")
//	SeatVo getSeatByMemNum(int memNum);
	
	// seat테이블의 모든 데이터
	@Select("SELECT * FROM seat")
	List<SeatVo> getAllSeat();
	
	// join을 활용한 현재 활성화된 자리의 사용자 이름과 정보
	List<SeatVo> getSeatAndName();
	
}


