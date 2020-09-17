package com.example.domain;

import java.util.Date;

import lombok.Data;

@Data
public class SeatVo {
	private Integer seatNum;
	private Integer memNum;
	private String reserveTime;
	private String endTime;
	private Boolean seatStatus;
	
	// members에서 조인으로 받아온 아이디와 이름
	private String id;
	private String name; 
	
}
