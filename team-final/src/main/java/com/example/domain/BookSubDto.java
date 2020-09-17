package com.example.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor //필드 값을 모두 사용하는 생성자를 만듬
public class BookSubDto {
	private List<BookSubVo> list;
	private int bookSubCnt;
}
