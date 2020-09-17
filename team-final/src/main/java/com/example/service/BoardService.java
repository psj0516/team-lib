package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.BoardVo;
import com.example.domain.Criteria;
import com.example.domain.InquireDto;
import com.example.mapper.BoardMapper;

@Service
@Transactional
public class BoardService {

	@Autowired
	private BoardMapper boardMapper;

	// 글 번호 생성 메소드
	public int getBoardNum() {

		return boardMapper.getBoardNum();
	} // getBoardNum()

	// 게시글 insert 메소드
	public void insert(BoardVo vo) {

		// 새글번호 구하기
		int num = boardMapper.getBoardNum();
		// 새글번호를 vo에 설정
		vo.setNum(num);
		// 주글관련 re 필드값 설정
		vo.setReRef(num);
		vo.setReLev(0);
		vo.setReSeq(0);
		
		//조회수 0
		vo.setReadcount(0);
		
		//답변상태 0 = 답변대기중
		vo.setStatus(1);

		boardMapper.insertBoard(vo);
	}// insert()

	// 보드에 입력된 행의 갯수(전체글갯수)를 구하는 메소드
	public int getTotalCount(String category, String search) {
		int count = boardMapper.getTotalCount(category, search);

		return count;
	} // getTotalCount()
	
	// 보드에 입력된 행의 갯수(전체글갯수)를 구하는 메소드
	public int getMyBoardCnt(String id) {
		int count = boardMapper.getMyBoardCnt(id);

		return count;
	} // getTotalCount()
	
	
	public int getReplyCount(int num) {
		int count = boardMapper.getReplyCount(num);

		return count;
	} // getReplyCount()
	
	
	// 특정글 조회수 1증가시키는 메소드
	public void updateReadcount(int num) {
		
			boardMapper.updateReadcount(num);
	
	} // updateReadcount()
	
	// 답변상태 수정하는 메소드
	public void updateStatus(int reRef) {
		
			boardMapper.updateStatus(reRef);
	
	} // updateReadcount()
	
	// 답변상태 수정하는 메소드
	public void updateStatus2(int reRef) {
		
			boardMapper.updateStatus2(reRef);
	
	} // updateReadcount()
	

	// list에 게시글 목록 내역 가져오는 메소드
	public List<BoardVo> getBoards(int startRow, int pageSize, String category, String search) {
		List<BoardVo> list = boardMapper.getBoards(startRow, pageSize, category, search);

		return list;
	} // getBoards()

	
	// id로 내가 작성한 게시글 가져오는 메소드
	public InquireDto getMyBoardWithPaging(String id, Criteria cri) {
		List<BoardVo> list = boardMapper.getMyBoardWithPaging(id,cri);
		int inquireCnt = boardMapper.getMyBoardCnt(id);
		InquireDto myInquireDto = new InquireDto(list, inquireCnt);

		return myInquireDto;
	} // getMyBoardById()
	
	// 모든 문의 및 건의사항 목록 가져오기.
	public InquireDto getInquireList(Criteria cri) {
		List<BoardVo> list = boardMapper.getInquireList(cri);
		int inquireCnt = boardMapper.getInquireCnt();
		InquireDto inquireDto = new InquireDto(list, inquireCnt);

		return inquireDto;
	} // getMyBoardById()
	
	// 모든 오류신고 리스트 가져오기.
	public InquireDto getErrorList(Criteria cri) {
		List<BoardVo> list = boardMapper.getErrorList(cri);
		int inquireCnt = boardMapper.getErrorCnt();
		InquireDto ErrorDto = new InquireDto(list, inquireCnt);

		return ErrorDto;
	} // getMyBoardById()
	
	
	
	// 글번호로 글 한개를 가져오는 메소드
	public BoardVo getBoardByNum(int num) {
		BoardVo vo = boardMapper.getBoardByNum(num);

		return vo;
	} // getBoardByNum()
	
	
	// 글번호로 답글을 가져오는 메소드
	public BoardVo getReplyByNum(int num) {
		BoardVo vo = boardMapper.getReplyByNum(num);

		return vo;
	} // getReplyByNum()
	
	

	// 게시글 수정 메소드
	public void update(BoardVo vo) {

		boardMapper.update(vo);

	} // update()

	
	// 해당 번호에 있는 글 삭제 메소드
	public void deleteByNum(int num) {

		boardMapper.deleteByNum(num);

	} // deleteByNum()
	
	
	// 해당 reRef로 글 삭제 메소드
	public void deleteByReref(int reRef) {

		boardMapper.deleteByReref(reRef);

	} // deleteByNum()

	
	// 모든 게시글 삭제
	public void deleteAll() {

		boardMapper.deleteAll();

	}

	
	// 답글 작성
	public void replyInsert(BoardVo vo) {
		

		boardMapper.updateReSeqByReRef(vo.getReRef(), vo.getReSeq());
		boardMapper.updateStatus(vo.getReRef());
		
		// 새글번호 구하기
		int num = boardMapper.getBoardNum();
		
		// 답글 insert할 정보로 vo를 설정
		vo.setNum(num);
		vo.setReLev(vo.getReLev()+1);
		vo.setReSeq(vo.getReSeq()+1);
		//조회수 0
		vo.setReadcount(0);
		
		
		boardMapper.insertBoard(vo);

	}


}
