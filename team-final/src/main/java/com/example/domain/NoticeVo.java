package com.example.domain;

import java.util.List;

import lombok.Data;

@Data
public class NoticeVo {
	
	private List<NoticefileVo> noticefileList;
	
	private int num; /* 공지글 번호 */
	private int readcount; //조회수
	private int fix; //상단고정 여부
	private int file; //첨부파일 여부
	private String writer; /* 공지글 작성자 */
	private String subject; /* 공지글 내용 */
	private String content; /* 공지글글 내용 */
	private String regDate; /* 공지글 작성일자 */
}
