package com.example.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.CommentVo;
import com.example.mapper.CommentMapper;

import lombok.extern.java.Log;

@Service
@Transactional
@Log
public class CommentService {

	@Autowired
	private CommentMapper commentMapper;
	
	
	// 댓글 번호 생성 메소드
	public int getCno() {

		return commentMapper.getCno();
	} // getNoticeNum()
	
	
	//댓글 등록(int로 생성갯수 결과값)
	public int register(CommentVo commentVo) {
		log.info("register: " + commentVo);
				
		return commentMapper.insert(commentVo);
	}
	
	//댓글 등록(int로 생성갯수 결과값)
	public int replyRegister(CommentVo commentVo) {
		log.info("replyRegister: " + commentVo);
				
		return commentMapper.replyinsert(commentVo);
	}
	
	//댓글번호로 내용 가져오기
	public CommentVo getComment(int cno) {
		CommentVo commentVo = commentMapper.getComment(cno);
		return commentVo;
	}
	
	
	//댓글 삭제
	public int remove(int cno) {
		int commentVo = commentMapper.delete(cno);
				
		return commentVo;
		
	}
	
	// 댓글 수정하기
	public void modify(CommentVo commentVo) {
		commentMapper.update(commentVo);
	}
	

	//글 번호로 댓글리스트 가져오기
	public List<CommentVo> getList(int bno) {
		List<CommentVo> list = commentMapper.getList(bno);
		return list;
	}
	
	
	
}
