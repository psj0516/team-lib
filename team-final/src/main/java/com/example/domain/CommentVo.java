package com.example.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class CommentVo {
	
	private int cno;
	private int bno;
	private Integer reRef; /* 댓글 그룹 번호 */
	private Integer reLev; /* 댓글 들여쓰기 레벨 */
	private String comment;
	private String writer;
	private LocalDateTime regDate;
	private LocalDateTime updateDate;

}
