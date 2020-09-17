package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.BoardVo;
import com.example.domain.NoticeVo;
import com.example.domain.NoticefileVo;
import com.example.mapper.NoticeMapper;
import com.example.mapper.NoticefileMapper;

@Service
@Transactional
public class NoticeService {

	@Autowired
	private NoticeMapper noticeMapper;
	@Autowired
	private NoticefileMapper noticefileMapper;
	

	// 공지글 번호 생성 메소드
	public int getNoticeNum() {

		return noticeMapper.getNoticeNum();
	} // getNoticeNum()

	// 공지글 insert 메소드
	public void insert(NoticeVo vo) {
	
		//조회수 0
		vo.setReadcount(0);

		noticeMapper.insertNotice(vo);
	}// insert()

	
	
	// 보드에 입력된 행의 갯수(전체 공지글 갯수)를 구하는 메소드
	public int getTotalCount(String category, String search) {
		int count = noticeMapper.getTotalCount(category, search);

		return count;
	} // getTotalCount()
		
	
	
	// 특정 공지글 조회수 1증가시키는 메소드
	public void updateReadcount(int num) {
		
		noticeMapper.updateReadcount(num);
	
	} // updateReadcount()
	


	// list에 공지글 목록 내역 가져오는 메소드
	public List<NoticeVo> getNotices(int startRow, int pageSize, String category, String search) {
		List<NoticeVo> list = noticeMapper.getNotices(startRow, pageSize, category, search);

		return list;
	} // getBoards()
	
	public List<NoticeVo> getSubNoitces(int pageSize) {
		List<NoticeVo> list = noticeMapper.getSubNoitces(pageSize);

		return list;
	} // getBoards()

	
	// 글번호로 공지글 한개를 가져오는 메소드
	public NoticeVo getNoticeByNum(int num) {
		NoticeVo vo =noticeMapper.getNoticeByNum(num);

		return vo;
	} // getBoardByNum()
	
	
	// 공지글 수정 메소드
	public void update(NoticeVo vo) {

		noticeMapper.update(vo);

	} // update()

	
	// 해당 번호에 있는 공지글 삭제 메소드
	public void deleteByNum(int num) {

		noticeMapper.deleteByNum(num);

	} // deleteByNum()

	
	// 모든 게시글 삭제
	public void deleteAll() {

		noticeMapper.deleteAll();

	} // deleteAll()
	
	
	// notice테이블과 noticefile 테이블 조인해서 결과 리턴
	public NoticeVo getNoticeAndNoitcefilesByNum(int num) {
		NoticeVo noticeVo = noticeMapper.getNoticeAndNoitcefilesByNum(num);
		
		return noticeVo;
	} // getNoticeAndNoitcefilesByNum()

	
	
	// 공지글과 첨부파일 함께 등록
	public void insertNoticeAndfiles(NoticeVo noticeVo, List<NoticefileVo> noticefileList) {
		
		// 첨부파일들 있으면 등록
		if (noticefileList.size() > 0) {
			
			//첨부파일 있으면 1(있음)
			noticeVo.setFile(noticefileList.size());
			
			for(NoticefileVo noticefileVo : noticefileList) {
				noticefileMapper.insert(noticefileVo);
			}
			
		} else {
			
			
		}
		
		// 게시글 등록
		noticeMapper.insertNotice(noticeVo);
		
	} //insertNoticeAndfiles();


}
