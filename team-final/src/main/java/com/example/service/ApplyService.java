package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.ApplyDto;
import com.example.domain.ApplyVo;
import com.example.domain.Criteria;
import com.example.mapper.ApplyMapper;

import lombok.extern.java.Log;

@Log
@Service
@Transactional
public class ApplyService {

	@Autowired
	private ApplyMapper applyMapper;
		
	// 신청 글 번호 생성 메소드
	public int getApplyNum() {

		return applyMapper.getApplyNum();
	} // getApplyNum()
	
	
	
	// 신청글 insert 메소드
	public void insert(ApplyVo vo) {

		// 새글번호 구하기
		int num = applyMapper.getApplyNum();
		// 새글번호를 vo에 설정
		vo.setNum(num);
		
		//신청상태 0 = 신청중
		vo.setStatus(0);

		applyMapper.insertApply(vo);
	}// insert()
	
	
	// 행의 갯수(전체글갯수)를 구하는 메소드
	public int getTotalCount(String category, String search) {
		int count = applyMapper.getTotalCount(category, search);

		return count;
	} // getTotalCount()
	
	
	// list에 신청글 목록 내역 가져오는 메소드
	public List<ApplyVo> getApplys(int startRow, int pageSize, String category, String search) {
		List<ApplyVo> list = applyMapper.getApplys(startRow, pageSize, category, search);

		return list;
	} // getApplys()
	
	
	// id로 내 신청목록 가져오는 메소드
	public ApplyDto getMyApplyWithPaging(String id, Criteria cri) {
		List<ApplyVo> list = applyMapper.getMyApplyWithPaging(id, cri);
		int applyCnt = applyMapper.getMyApplyCnt(id);
		log.info("applyCnt: " + applyCnt);
		ApplyDto myApplyDto = new ApplyDto(list, applyCnt);

		return myApplyDto;
	} // getMyBoardById()
	
	// 관지자 페이지 신청글 가져오는 메소드
	public ApplyDto getApplyList(Criteria cri) {
		List<ApplyVo> list = applyMapper.getApplyList(cri);
		log.info("list: " + list);
		int applyCnt = applyMapper.getApplyListCnt();
		log.info("applyListCnt: " + applyCnt);
		ApplyDto applyListDto = new ApplyDto(list, applyCnt);
		log.info("applyListDto: " + applyListDto);

		return applyListDto;
	} // getMyBoardById()
	
	
	// 번호로 신청글 가져오는 메소드
	public ApplyVo getApplyByNum(int num) {
		ApplyVo vo = applyMapper.getApplyByNum(num);

		return vo;
	} // getApplyByNum()
	
	// 신청글 수정 메소드
	public void update(ApplyVo vo) {

		applyMapper.update(vo);

	} // update()
	
	public void statusUpdate(ApplyVo vo) {

		applyMapper.statusUpdate(vo);

	} // update()

	
	// 해당 번호에 있는 글 삭제 메소드
	public void deleteByNum(int num) {

		applyMapper.deleteByNum(num);

	} // deleteByNum()

	
	// 모든 게시글 삭제
	public void deleteAll() {

		applyMapper.deleteAll();

	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
} //ApplyService class
