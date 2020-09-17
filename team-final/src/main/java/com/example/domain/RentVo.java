package com.example.domain;

import lombok.Data;

@Data
public class RentVo {
	
	private Integer num;
	private Integer bookcode;
 	private Integer serialNum;
	private Integer memNum;
	private String renter;
	private String bookname;
	private String rentStart;
	private String returnDate;
	
}
