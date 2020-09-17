package com.example.domain;


import lombok.Data;

@Data
public class BoardVo {
	
	
	private int num; /* 글 번호 */
	private int type; /* 글 종류 */
	private int memNum; /* 회원 번호 */
	private int status; //답변상태
	private Integer readcount; //조회수
	private String name; /* 작성자 */
	private String id; /* 회원 아이디 */
	private String subject; /* 글 제목 */
	private String content; /* 글 내용 */
	private String secret; // 비밀글여부
	private String regDate; /* 글 작성일자 */
	private Integer reRef; /* 글 그룹 번호 */
	private Integer reLev; /* 글 들여쓰기 레벨 */
	private Integer reSeq; /* 글 그룹 내에서의 순서 */

	
	

}
