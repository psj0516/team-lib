package com.example.domain;


import lombok.Data;

@Data
public class ApplyVo {
	
	
	private int num; /* 신청 번호 */
	private int memNum; /* 회원 번호 */
	private int status; //신청상태
	private String pubYear; //출판일자
	private String name; /* 작성자 */
	private String id; /* 회원 아이디 */
	private String bookname; /* 책 제목 */
	private String author; /* 저자 */
	private String publisher; /* 출판사 */
	private String secret; // 비밀글여부
	private String regDate; /* 신청일자 */
	private String content; /* 비고 */
	private String reason; //신청 취소사유



	
	

}
