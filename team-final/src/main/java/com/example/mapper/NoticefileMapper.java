package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.domain.NoticefileVo;

public interface NoticefileMapper {
	
	
	//uuid로 공지 첨부파일 가져오기
	@Select("SELECT * FROM noticefile WHERE uuid = #{uuid}")
	NoticefileVo getNoticefileByUuid(String uuid);
	
	
	// 글번호로 공지 첨부파일 가져오기
	@Select("SELECT * FROM noticefile WHERE bno = #{bno}")
	List<NoticefileVo> getNoticefilesByBno(int bno);
	
	
	// 공지에 파일 첨부하기
	@Insert("INSERT INTO noticefile (uuid,filename,uploadpath,bno)"
			+ "VALUES (#{uuid}, #{filename}, #{uploadpath}, #{bno})")	
	void insert(NoticefileVo vo);
	
	// 공지글 첨부파일 번호로 삭제
	@Delete("Delete FROM noticefile WHERE bno = #{bno}")
	void deleteNoticefilesByBno(int bno);
	
	// 공지글 첨부파일 uuid로 삭제
	@Delete("Delete FROM noticefile WHERE uuid = #{uuid}")
	void deleteNoticefileByUuid(String Uuid);
	

	void deleteNoticefilesByUuids(@Param("uuids")List<String> uuids);
}
