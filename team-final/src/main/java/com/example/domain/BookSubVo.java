package com.example.domain;


import java.time.LocalDateTime;

import lombok.Data;

@Data
public class BookSubVo {
	
	private Integer serialNum;
	private Integer bookcode;
	private Integer isApply;
	private Integer isRent;
	private Integer isReserve;
	private Integer extension;
	private Integer status;
	private String bookname;
	private String applyer;
	private String renter;
	private String reserver;
	private String reserver2;
	private String applyStart;
	private String applyEnd;
	private String rentStart;
	private String rentEnd;
	private String reserveStart;
	private String reserveEnd;
	
	
	
}
