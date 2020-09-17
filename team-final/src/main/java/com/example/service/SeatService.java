package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.MemberVo;
import com.example.domain.SeatVo;
import com.example.mapper.SeatMapper;

@Service
@Transactional
public class SeatService {
	
	@Autowired
	private SeatMapper seatMapper;
	
	// 자리생성
	public void insert() {
		seatMapper.insert();
	}
	
	// 자리제거
	public void delete(int count) {
		seatMapper.delete(count);
	}
	
	//MySQL seat_num의 auto_increment 초기화 및 셋팅
	public void resetAI(int count) {
		seatMapper.resetAI(count);
	}
	
	// 모든 seat의 정보 가져오기
	public List<SeatVo> getAllSeat() {
		List<SeatVo> seatVo = seatMapper.getAllSeat();
		return seatVo;
	}
	
	// 예약하기전 내가 사용한 자리의 이용여부
	public boolean useSelectSeat(int seatNum) {
		Boolean useSelectSeat = seatMapper.useSelectSeat(seatNum);
		return useSelectSeat;
	}
	
	// 예약하기
	public void reservation(SeatVo seatVo) {
		seatMapper.reservation(seatVo);
	}
	
	// 퇴실하기
	public void exitBySeatNum(int seatNum) {
		seatMapper.exitBySeatNum(seatNum);
	}
	
	// member에서 id에 해당하는 memNum찾아오기
	public int getMemNumById(String id) {
		int memNum = seatMapper.getMemNumById(id);
		return memNum;
	} // getMemberById()
	
	// seat에서 memNum에 해당하는 모든값 찾아오기
//	public SeatVo getSeatByMemNum(int memNum) {
//		 SeatVo vo = seatMapper.getSeatByMemNum(memNum);
//		return vo;
//		
//	}
	
	// join을 활용한 현재 활성화된 자리의 사용자 이름과 정보
	public List<SeatVo> getSeatAndName() {
		List<SeatVo> vo =  seatMapper.getSeatAndName();
		return vo;
	}
	
}
