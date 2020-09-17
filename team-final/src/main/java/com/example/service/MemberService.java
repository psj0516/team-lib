package com.example.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.MemberVo;
import com.example.mapper.MemberMapper;

@Service
@Transactional
public class MemberService {
	@Autowired
	private MemberMapper memberMapper;

	// 회원가입
	public void insert(MemberVo memberVo) {
		memberMapper.insert(memberVo);
	}

	// 회원가입 - 아이디 중복 체크
	public boolean isIdDup(String id) {
		boolean isIdDup = false;

		int count = memberMapper.countMemberById(id);
		if (count == 1) {
			isIdDup = true;
		} else {
			isIdDup = false;
		}

		return isIdDup;
	}

	// 로그인
	public int userCheck(String id, String passwd) {
		// 0: 실패, 1: 성공
		int check = 0;
		String dbpasswd = memberMapper.getPasswdById(id);
		if (dbpasswd != null) {
			if (dbpasswd.equals(passwd)) {
				check = 1;
			} else {
				check = 0;
			}
		} else {
			check = 0;
		}

		return check;
	}

	// 마이페이지 - 내 정보 가져오기
	public MemberVo getInfoById(String id) {
		MemberVo memberVo = memberMapper.getInfoById(id);
		return memberVo;
	}

	// 마이페이지 - 내 정보 수정하기
	public int updateInfo(MemberVo memberVo) {
		int update = memberMapper.updateInfo(memberVo);
		return update;
	}

	// 관리자 페이지 - 전체 멤버 수 구하기
	public int getTotalCount() {
		int count = memberMapper.getTotalCount();
		return count;
	} // getTotalCount()

	// 관리자 페이지 - 멤버 목록 가져오기
	public List<MemberVo> getMembers(int startRow, int pageSize) {
		List<MemberVo> list = memberMapper.getMembers(startRow, pageSize);
		return list;
	}

	// 관리자 페이지 - 특정 멤버 정보 가져오기
	public MemberVo getMemberByNum(int memNum) {
		MemberVo memberVo = memberMapper.getMemberByNum(memNum);
		return memberVo;
	}
	
	//id로 회원이름 가져오기
	public String getNameById(String id) {
		
		String name = memberMapper.getNameById(id);
		
		return name;
	}
	
	//id로 회원번호 가져오기
	public String getMemNumById(String id) {
		
		String name = memberMapper.getMemNumById(id);
		
		return name;
	}

	// 더미정보 넣기
	public MemberVo insertDummyRows(int count) {
		MemberVo vo = null;
		for (int i = 1; i <= count; i++) {
			Random ran = new Random();
			String gender = "남자";

			if (i % 2 == 1) {
				gender = "여자";
			}

			if (i < 10) {
				String num = "0" + Integer.toString(i);

				vo.setId("member" + num);
				vo.setName("회원" + num);
				vo.setPasswd("1234");
				vo.setAddress("01014, 서울 강북구 4.19로11길 6, 111-111");
				vo.setBirth("1990-01-01");
				vo.setGender(gender);
				vo.setEmail("member" + num + "@mm.com");
				vo.setTel("051-" + "000-" + num + num);
				vo.setPhone("010-" + "0000-" + num + num);
				vo.setRegDate(LocalDateTime.now());
			} else {
				vo.setId("member" + i);
				vo.setName("회원" + i);
				vo.setPasswd("1234");
				vo.setAddress("01014, 서울 강북구 4.19로11길 6, 111-111");
				vo.setBirth("1990-01-01");
				vo.setGender(gender);
				vo.setEmail("member" + i + "@mm.com");
				vo.setTel("051-" + "000-" + i + i);
				vo.setPhone("010-" + "0000-" + i + i);
				vo.setRegDate(LocalDateTime.now());
			}
		}
		return vo;
	}
}
