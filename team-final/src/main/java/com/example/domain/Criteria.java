package com.example.domain;

public class Criteria {
	
	private int pageNum; //나의게시글 페이지번호
	private int pageSize; // 나의게시글 한 페이지당 보여줄 갯수
	private int startRow; // 나의 게시글 가져올 시작 행번호
	
	public Criteria() {
		this(1, 10); //기본값 1페이지에 10개씩 댓글 가져오도록 기본값 설정
	}
	
	public Criteria(int pageNum, int pageSize) {
		
		this.pageNum = pageNum;
		this.pageSize = pageSize;
		
		//MySQL 기준: 시작행번호가 0부터 시작함
		this.startRow = (this.pageNum -1) * this.pageSize;
		
	}

}
