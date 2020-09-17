package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.domain.MemberVo;

public interface MemberMapper {

	// 회원가입
	int insert(MemberVo memberVo);

	// 회원가입 - 아이디 중복 체크
	@Select("SELECT COUNT(*) FROM member WHERE id = #{id}")
	int countMemberById(String id);

	// 로그인 - 비밀번호 아이디 일치여부
	@Select("SELECT passwd FROM member WHERE id = #{id}")
	String getPasswdById(String id);

	// 마이페이지 - 내 정보 가져오기
	@Select("SELECT * FROM member WHERE id = #{id}")
	MemberVo getInfoById(String id);

	// 마이페이지 - 내 정보 수정하기
	int updateInfo(MemberVo memberVo);

	// 관리자 페이지 - 전체 멤버 수 구하기
	@Select("SELECT count(*) FROM member")
	int getTotalCount();

	// 관리자 페이지 - 멤버 목록 가져오기
	@Select("SELECT * FROM member LIMIT #{startRow}, #{pageSize}")
	List<MemberVo> getMembers(@Param("startRow") int startRow, @Param("pageSize") int pageSize);
	
	// 관리자 페이지 - 특정 멤버 정보 가져오기
	@Select("SELECT * FROM member WHERE mem_num = #{memNum}")
	MemberVo getMemberByNum(int memNum);
	
	//id로 회원이름 가져오기
	@Select("SELECT name FROM member WHERE id= #{id};")
	 String getNameById(String id);
	
	//id로 회원번호 가져오기
	@Select("SELECT mem_Num FROM member WHERE id= #{id};")
	 String getMemNumById(String id);
}
