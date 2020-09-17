package com.example.domain;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberVo implements Cloneable {
	
	private int memNum;
	private String id;
	private String passwd;
	private String name;
	private String gender;
	private String birth;
	private String phone;
	private String address;
	private String tel;
	private String email;
	private LocalDateTime regDate;
	
	@Override
	protected Object clone() throws CloneNotSupportedException {
		return super.clone();
	}
}
