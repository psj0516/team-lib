package com.example.mapper;


import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.domain.BoardVo;
import com.example.domain.BookSubVo;
import com.example.domain.BookVo;
import com.example.domain.CommentVo;
import com.example.domain.Criteria;
import com.example.domain.RentVo;

public interface BookSubMapper {
	
	int getReserveState(int bookCode);
	
	Integer getSerialNumsearch(int bookCode);
	
	
	//시리얼 번호로 서브 북 정보가져오기
	@Select("SELECT * FROM sub WHERE serial_num = #{num} ")
	BookSubVo getSubBookByNum(int num);
	
	//내가 예약중인 도서 갯수
	@Select("SELECT count(*) FROM sub WHERE reserver = #{id} OR reserver2 = #{id}")
	int getMyReserveCnt(String id);
	
	//월별 도서대출기록
	@Select("SELECT count(*) FROM book_rent where DATE(return_date) >= DATE_SUB(NOW(), INTERVAL 30 DAY) ")
	int getRentRecordCnt();
	
	//내가 대출중인 도서 갯수
	@Select("SELECT count(*) FROM sub WHERE renter = #{id} ")
	int getMyRentCnt(String id);
	
	//내 대출이력  갯수
	@Select("SELECT count(*) FROM book_rent WHERE renter = #{id} AND DATE(return_date) >= DATE_SUB(NOW(), INTERVAL 91 DAY) ")
	int getMyRentRecordCnt(String id);
	
	// 신청도서 갯수
	@Select("SELECT count(*) FROM sub WHERE is_apply = 1 AND applyer != '' ")
	int getApplyBookCnt();
	
	// 대출도서 갯수
	@Select("SELECT count(*) FROM sub WHERE is_rent = 1 AND renter != '' ")
	int getRentBookCnt();
	
	// 예약도서 갯수
	@Select("SELECT count(*) FROM sub WHERE is_reserve >= 1 AND (reserver != '' OR reserver2 != '') ")
	int getReserveBookCnt();
	
	// 예약도서 갯수
	@Select("SELECT count(*) FROM sub WHERE status > 0 ")
	int getnotAvailableCnt();
	
	// 도서신청 가능한지 확인(최대 5개 가능)
	@Select("SELECT count(*) FROM sub WHERE applyer = #{id} OR renter = #{id} OR reserver = #{id} ")
	int applyTest(String id);
	
	//서브도서 한권 추가하기
	int insertSubBook(int bookcode, String bookname);
	
	// 서브도서 전체 삭제
	@Delete("DELETE FROM sub WHERE bookcode = #{bookcode}")
	void removeByBookCode(int bookcode);
	
	// 서브도서 전체 삭제
	@Delete("DELETE FROM sub WHERE serial_num = #{serialNum}")
	void removeBySerialNum(int serialNum);
	
	// 서브도서 사용중지
	@Update("UPDATE sub "
			+ "SET status = 1 "
			+ "WHERE serial_num = #{serialNum} ")
	void useStop(int serialNum);
	
	// 서브도서 사용가능
	@Update("UPDATE sub "
			+ "SET status = 0 "
			+ "WHERE serial_num = #{serialNum} ")
	void available(int serialNum);
	
	
	//내 예약도서 리스트 가져오기
	@Select("SELECT * "
			+ "FROM sub "
			+ "WHERE reserver = #{id} OR reserver2 = #{id} "
			+ "ORDER BY reserve_start DESC "
			+ "LIMIT #{cri.startRow}, #{cri.pageSize} ")
	List<BookSubVo> getMyReserveList(@Param("id") String id, @Param("cri") Criteria cri);
	
	//내 대출도서 리스트 가져오기
	@Select("SELECT * "
			+ "FROM sub "
			+ "WHERE renter = #{id} "
			+ "ORDER BY rent_start DESC "
			+ "LIMIT #{cri.startRow}, #{cri.pageSize} ")
	List<BookSubVo> getMyRentList(@Param("id") String id, @Param("cri") Criteria cri);
	
	//내 대출이력 리스트 가져오기
	@Select("SELECT * "
			+ "FROM book_rent "
			+ "WHERE renter = #{id} AND DATE(return_date) >= DATE_SUB(NOW(), INTERVAL 91 DAY) "
			+ "ORDER BY rent_start DESC "
			+ "LIMIT #{cri.startRow}, #{cri.pageSize} ")
	List<RentVo> getMyRentRecord(@Param("id") String id, @Param("cri") Criteria cri);
	
	//관리자 신청도서 리스트 가져오기
	@Select("SELECT * "
			+ "FROM sub "
			+ "WHERE is_apply = 1 AND applyer != '' "
			+ "ORDER BY serial_num DESC "
			+ "LIMIT #{cri.startRow}, #{cri.pageSize} ")
	List<BookSubVo> getApplyBookList(@Param("cri") Criteria cri);
	
	//관리자 사용중지 도서 리스트 가져오기
	@Select("SELECT * "
			+ "FROM sub "
			+ "WHERE status > 0 "
			+ "ORDER BY serial_num DESC "
			+ "LIMIT #{cri.startRow}, #{cri.pageSize} ")
	List<BookSubVo> getnotAvailableList(@Param("cri") Criteria cri);
	
	//관리자  대출기록 가져오기
	@Select("SELECT * "
			+ "FROM book_rent "
			+ "WHERE DATE(return_date) >= DATE_SUB(NOW(), INTERVAL 30 DAY) "
			+ "ORDER BY num DESC "
			+ "LIMIT #{cri.startRow}, #{cri.pageSize} ")
	List<RentVo> getRentRecord(@Param("cri") Criteria cri);
	
	//관리자 예약도서 리스트 가져오기
	@Select("SELECT * "
			+ "FROM sub "
			+ "WHERE is_reserve >= 1 AND (reserver != '' OR reserver2 != '') "
			+ "ORDER BY serial_num DESC "
			+ "LIMIT #{cri.startRow}, #{cri.pageSize} ")
	List<BookSubVo> getReserveBookList(@Param("cri") Criteria cri);
	
	//관리자 대출도서 리스트 가져오기
	@Select("SELECT * "
			+ "FROM sub "
			+ "WHERE is_rent = 1 AND renter != '' "
			+ "ORDER BY serial_num DESC "
			+ "LIMIT #{cri.startRow}, #{cri.pageSize} ")
	List<BookSubVo> getRentBookList(@Param("cri") Criteria cri);
	
		
	// 도서신청
	@Update("UPDATE sub "
			+ "SET is_apply = 1, apply_start = #{applyStart}, apply_end = #{applyEnd}, applyer = #{applyer} "
			+ "WHERE serial_num = #{serialNum} ")
	void bookApplyUpdate(BookSubVo bookSubVo);
	
	
	// 도서신청(마이페이지)
	@Update("UPDATE sub "
			+ "SET is_apply = 1, apply_start = #{applyStart}, apply_end = #{applyEnd}, applyer = #{applyer}, reserve_start = '', reserve_end = '', reserver = '', is_reserve = is_reserve - 1 "
			+ "WHERE serial_num = #{serialNum} ")
	void bookApplyUpdate2(BookSubVo bookSubVo);
	
	// 예약자 1번이 신청하면 예약자 2번이 예약자 1번으로 옮겨지기
	@Update("UPDATE sub "
			+ "SET reserver = reserver2, reserver2 = '' "
			+ "WHERE reserve_end ='' AND reserve_start ='' AND reserver ='' ")
	void reserve2Update();
	
	
	// 도서신청 취소 스케줄링 
	@Update("UPDATE sub "
			+ "SET is_apply = 0, applyer = '', apply_start = '', apply_end = '' "
			+ "WHERE apply_end != date_format(now(), '%Y-%m-%d') ")
	void taskApplyUpdate();
	
	// 도서신청 취소
	@Update("UPDATE sub "
			+ "SET is_apply = 0, applyer = '', apply_start = '', apply_end = '' "
			+ "WHERE serial_num = #{serialNum} ")
	void applyCancel(int serialNum);
	
	
	// 도서대출
	@Update("UPDATE sub "
			+ "SET is_apply = 0, renter = applyer, apply_start = '', apply_end = '', is_rent = 1, applyer = '', rent_start = #{rentStart}, rent_end = #{rentEnd} "
			+ "WHERE serial_num = #{serialNum} ")
	void rentBook(BookSubVo bookSubVo);
	
	// 도서대출연장
	@Update("UPDATE sub "
			+ "SET extension = 1,  rent_end = #{rentEnd} "
			+ "WHERE serial_num = #{serialNum} ")
	void extensionBook(BookSubVo bookSubVo);
	
	
	//도서반납
	@Update("UPDATE sub "
			+ "SET is_rent = 0, renter = '', rent_start = '', rent_end = '', extension = 0 "
			+ "WHERE serial_num = #{serialNum} ")
	void returnBook(int serialNum);
	
	//도서 반납시 대출내역 기록
	void recordReturn(@Param("book") BookSubVo bookSubVo, @Param("reserveStart") String reserveStart);
	
	
	// 도서 예약 1번 순위
	@Update("UPDATE sub "
			+ "SET is_reserve = is_reserve + 1, reserver = #{reserver} "
			+ "WHERE serial_num = #{serialNum} ")
	void reserveUpdate1(BookSubVo bookSubVo);
	
	// 도서 예약 2번 순위
	@Update("UPDATE sub "
			+ "SET is_reserve = is_reserve + 1, reserver2 = #{reserver2} "
			+ "WHERE serial_num = #{serialNum} ")
	void reserveUpdate2(BookSubVo bookSubVo);
	
	
	// 신청대기 예약자의 예약취소
	@Update("UPDATE sub "
			+ "SET is_reserve = is_reserve - 1, reserver = '', reserve_start = '', reserve_end = '' "
			+ "WHERE serial_num = #{serialNum} ")
	void reserveCancel1(int serialNum);
	
	// 대기중 예약자1의 예약취소
	@Update("UPDATE sub "
			+ "SET is_reserve = is_reserve - 1, reserver = '' "
			+ "WHERE serial_num = #{serialNum} ")
	void reserveCancel2(int serialNum);
	
	// 대기중 예약자2의 예약취소
	@Update("UPDATE sub "
			+ "SET is_reserve = is_reserve - 1, reserver2 = '' "
			+ "WHERE serial_num = #{serialNum} ")
	void reserveCancel3(int serialNum);
	
	
	// 도서 예약 스케줄링1(도서 신청자와 대출자가 없을시  도서를 신청할 수 있는 기간 설정)
	@Update("UPDATE sub "
			+ "SET reserve_start = #{reserveStart}, reserve_end = #{reserveEnd} "
			+ "WHERE applyer = '' AND is_apply = 0 AND renter = '' AND is_rent = 0 AND reserver != '' ")
	void taskReserveUpdate1(@Param("reserveStart") String reserveStart, @Param("reserveEnd") String reserveEnd);
	
	// 도서 예약 스케줄링2(예약기간이 지났을경우 예약취소  )
	@Update("UPDATE sub "
			+ "SET is_reserve = is_reserve -1, reserve_start = '', reserve_end = '', reserver = '' "
			+ "WHERE reserve_end < date_format(now(), '%Y-%m-%d') && reserve_end != '' ")
	void taskReserveUpdate2();
	
	// 도서 예약 스케줄링3(예약자 1번이 신청안하고 없어지면 예약자 2번이 1번으로 옮겨지고 도서 신청 가능기간 설정)
	@Update("UPDATE sub "
			+ "SET reserve_start = #{reserveStart}, reserve_end = #{reserveEnd}, reserver = reserver2, reserver2 = '' "
			+ "WHERE reserve_end ='' AND reserve_start ='' AND reserver ='' ")
	void taskReserveUpdate3(@Param("reserveStart") String reserveStart, @Param("reserveEnd") String reserveEnd);
	
	// 도서 대출 스케줄링(대출기간이 지났는데 반납이 안됬을 경우 상태 미반납으로 변경)
	@Update("UPDATE sub "
			+ "SET status = 2 "
			+ "WHERE rent_end < date_format(now(), '%Y-%m-%d') && rent_end != '' ")
	void taskNonReturn();
	
	

	List<BookSubVo> getBookSubList(int bookCode);
	
}
