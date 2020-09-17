package com.example.domain;

import lombok.Data;

@Data
public class BookVo {
	
	private Integer bookCode;
	private String bookName;
	private String publisher;
	private String author;
	private String pubYear;
	private String holdDate;
	private Integer rentCnt;
	private Integer bookAmount;
	private String description;
	
}
