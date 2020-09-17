package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.RentVo;
import com.example.mapper.RentMapper;

import lombok.extern.java.Log;

@Log
@Service
@Transactional // 모든 메소드 각각이 한개의 트랜잭션 단위로 수행됨
public class RentService {
	@Autowired
	private RentMapper rentMapper;

	public RentVo getRentState(int bookcode, int rentNum) {
		RentVo vo = rentMapper.getRentState(bookcode, rentNum);

		return vo;
	}//getRentState()
}
