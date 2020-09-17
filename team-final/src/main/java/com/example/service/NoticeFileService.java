package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.NoticefileVo;
import com.example.mapper.NoticefileMapper;

import lombok.extern.java.Log;

@Log
@Service
@Transactional
public class NoticeFileService {

	@Autowired
	private NoticefileMapper noticefileMapper;
	

		//uuid로 공지자료 가져오기
		public NoticefileVo getNoticefileByUuid(String uuid) {
			
			NoticefileVo vo = noticefileMapper.getNoticefileByUuid(uuid);
			
		
			return vo;
		} //getNoticefileByUuid()
	
		
		// 글번호로 공지자료 가져오기
		public List<NoticefileVo> getNoticefilesByBno(int bno) {
			List<NoticefileVo> list = noticefileMapper. getNoticefilesByBno(bno);
	
			
			return list;
		} // getNoticefilesByBno()
	
		
		// 공지자료 한개 첨부
		public void insert(NoticefileVo vo) {
		
			noticefileMapper.insert(vo);
			
		}// insert()
		
	
		
		// 공지자료 여러개 첨부
		public void insert(List<NoticefileVo> list) {
			
			for(NoticefileVo vo : list) {
				this.insert(vo);
			}
		}// insert()
		
		
		// 공지글 첨부자료 삭제
		public void deleteNoticefilesByBno(int bno) {
			noticefileMapper.deleteNoticefilesByBno(bno);
			
		}// deleteNoticefilesByBno()
		
		
		// 공지글 첨부자료 수정
		public void deleteNoticefileByUuid(String uuid) {
			noticefileMapper.deleteNoticefileByUuid(uuid);
			
		}// deleteNoticefileByUuid()	
		
		
		// 선택한 첨부자료 삭제
		public void deleteNoticefilesByUuids(List<String> uuids) {
			noticefileMapper.deleteNoticefilesByUuids(uuids);
			
		}// deleteNoticefilesByUuids()
	
	
}
	
	
