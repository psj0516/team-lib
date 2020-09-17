package com.example.mapper;

import com.example.domain.RentVo;

public interface RentMapper {
	
	RentVo getRentState(int bookcode, int memNum);
	
}
