package com.example.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.datetime.joda.DateTimeParser;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.ApplyDto;
import com.example.domain.BookDto;
import com.example.domain.BookRentDto;
import com.example.domain.BookSubVo;
import com.example.domain.BookVo;
import com.example.domain.Criteria;
import com.example.domain.PageDto;
import com.example.mapper.BookMapper;
import com.example.domain.BookSubDto;
import com.example.service.BookLikeService;
import com.example.service.BookService;
import com.example.service.BookSubService;
import com.example.service.MemberService;

import lombok.extern.java.Log;

//books, booklike 컨트롤러
@Log
@Controller
@RequestMapping("/libraryService/*")
public class LibraryServiceController {

	@Autowired
	private BookService bookService;

	@Autowired
	private BookLikeService bookLikeService;
	
	@Autowired
	private BookSubService bookSubService;
	
	@Autowired
	private MemberService memberService;

	@GetMapping("/bookList")
	public String bookSearch(@RequestParam(defaultValue = "1") int pageNum,
							 @RequestParam(defaultValue = "allSearch") String category, 
							 @RequestParam(defaultValue = "") String search, Model model) {
		log.info("/bookList has been called");
		log.info("category : " + category + "search : " + search);
		int totalCount = bookService.getBookCnt(category, search);

		// 한페이지에 해당하는 책 목록 구하기
		int pageSize = 5;
		int startRow = (pageNum - 1) * pageSize;

		List<BookVo> list = null;
		if (totalCount > 0) {
			list = bookService.getBooksInfo(startRow, pageSize, category, search);
		}

		int pageCount = totalCount / pageSize;
		if (totalCount % pageSize > 0) {
			pageCount += 1;
		}

		int pageBlock = 5;

		// 페이지 블록의 시작페이지
		int startPage = ((pageNum / pageBlock) - (pageNum % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;
		// 페이지 블록의 끝페이지
		int endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) {
			endPage = pageCount;
		}

		PageDto pageDto = new PageDto();
		pageDto.setTotalCount(totalCount);
		pageDto.setPageCount(pageCount);
		pageDto.setPageBlock(pageBlock);
		pageDto.setStartPage(startPage);
		pageDto.setEndPage(endPage);
		pageDto.setCategory(category);
		pageDto.setSearch(search);

		model.addAttribute("bookList", list);
		model.addAttribute("pageDto", pageDto);
		model.addAttribute("pageNum", pageNum);

		return "/libraryService/bookSearch";
	}
	
	
	//	//관리자 페이지 도서목록 보여주기
	@GetMapping(value ="/getBestBook", produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE} )
	public ResponseEntity <List<BookVo>> getSearchBookList(){
		
		
		List<BookVo> bestBook = bookService.getBestBook();
		
		log.info("베스트 북 목록: " + bestBook);
		
	
		return new ResponseEntity<List<BookVo>>(bestBook, HttpStatus.OK);

	} // getSearchBookList()
	
	
	//관리자 페이지 도서목록 보여주기
	@GetMapping(value ="/getBooksData/{pageNum}", consumes ="application/json", produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE} )
	public ResponseEntity<BookDto> getSearchBookList(HttpSession session, @PathVariable("pageNum") int pageNum , @RequestParam(defaultValue = "") String search){
		
		
		log.info("검색값: " + search);
		// 가져올 나의 게시글 목록 옵션
		Criteria cri = new Criteria(pageNum, 3);
		
		BookDto bookDto = bookService.getSearchBookList(search, cri);
		
	
		return new ResponseEntity<BookDto>(bookDto, HttpStatus.OK);

	} // getSearchBookList()
	
	//관리자 페이지 월별대출 현황 리스트 가져오기
	@GetMapping(value ="/getRentRecord/{pageNum}", produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE} )
	public ResponseEntity<BookRentDto> getRentRecord(HttpSession session, @PathVariable("pageNum") int pageNum ){
		

		// 가져올 나의 게시글 목록 옵션
		Criteria cri = new Criteria(pageNum, 5);
		
		BookRentDto rentRecordDto = bookSubService.getRentRecord(cri);
		log.info("대출기록 정보: " + rentRecordDto);
		
	
		return new ResponseEntity<BookRentDto>(rentRecordDto, HttpStatus.OK);

	} // getRentRecor()
	
	//관리자 페이지 사용중지 도서목록 가져오
	@GetMapping(value ="/getnotAvailableList/{pageNum}", produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE} )
	public ResponseEntity<BookSubDto> getnotAvailableList(HttpSession session, @PathVariable("pageNum") int pageNum ){
		
		// 가져올 나의 게시글 목록 옵션
		Criteria cri = new Criteria(pageNum, 5);
		
		BookSubDto notAvailableListDto = bookSubService.getnotAvailableList(cri);
		log.info("대출기록 정보: " + notAvailableListDto);
		
		return new ResponseEntity<BookSubDto>(notAvailableListDto, HttpStatus.OK);

	} // getSearchBookList()
	
	
	
	// 도서 추가
	@PostMapping("/addBook")
	public ResponseEntity<String> write(BookVo bookVo) {
		
		
		  // 오늘날짜 가져오기
		  String date = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		  int bookCode = bookService.getNewBookCode();
		  
		  // 작성일자 값 저장
		  bookVo.setHoldDate(date);
		  bookVo.setBookCode(bookCode);
		  
		  bookService.insertBook(bookVo);
		  
		  HttpHeaders headers = new HttpHeaders(); //header를 통해서 html에 출력정보를 넣어준다. mvc에서 response.setContentType("text/html; charset=UTF-8");와 동일
		  headers.add("Content-type", "text/html; charset=UTF-8");
		  
		  StringBuilder sb = new StringBuilder(); 
		  sb.append("<script>");                   
		  sb.append("alert('도서가 추가되었습니다.');");
		  sb.append("location.href='/admin/bookManage'");
		  sb.append("</script>");
					
		return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
	}
	
	@DeleteMapping("/ajaxLikeDel")
	@ResponseBody
	// 호출시 기본적으로 jsp 호출을 하게 되므로 jsp호출을 막으려면 ResponseBody 를 해줘야함
	public void ajaxLikeDel(int memNum, int bookCode) {
		bookLikeService.delBookLike(memNum, bookCode);
	}

	@PostMapping("/ajaxLikeAdd")
	@ResponseBody
	public void ajaxLikeAdd(int memNum, int bookCode) {
		bookLikeService.insertBookLike(memNum, bookCode);
	}
	
		
	
	  // 서브도서 추가하기
	  @GetMapping(value ="/addSubBook/{bookcode}", produces = MediaType.TEXT_PLAIN_VALUE )
	  public ResponseEntity<String> addSubBook(HttpSession session, @PathVariable("bookcode") int bookcode){
	  
		  log.info("북코드: " + bookcode);
			  
		  BookVo bookVo = bookService.getBookInfo(bookcode);
		  
		  String bookname = bookVo.getBookName();
		  
		  log.info("북이름: " + bookname);
		  
		  int update = bookSubService.insertSubBook(bookcode,bookname);
		  
		  ResponseEntity<String> entity = null;
		  
		  if(update == 0) {
			  
			  entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
			  
		  } else {
			  
			  entity = new ResponseEntity<String>("사용가능한 도서가 한권 추가되었습니다.", HttpStatus.OK);
		  }
		  
		  return entity;
	
	  } // addSubBook()
	  
	  // 도서전체 삭제하기
	  @GetMapping(value ="/removeBook/{bookcode}", produces = MediaType.TEXT_PLAIN_VALUE )
	  public ResponseEntity<String> removeBook(HttpSession session, @PathVariable("bookcode") int bookcode){
	  
		  log.info("북코드: " + bookcode);
			  
		  bookService.removeBook(bookcode);
		  bookSubService.removeSubBookByBookCode(bookcode);

		  return new ResponseEntity<String>("해당도서가 전체 삭제되었습니다.", HttpStatus.OK);
		
	  } // addSubBook()
	  
	  
	  // 서브도서 삭제하기
	  @GetMapping(value ="/RemoveSubBook/{serialNum}", produces = MediaType.TEXT_PLAIN_VALUE )
	  public ResponseEntity<String> RemoveSubBook(HttpSession session, @PathVariable("serialNum") int serialNum){
	  
		  log.info("서브북코드: " + serialNum);
		  BookSubVo bookSubVo = bookSubService.getSubBookByNum(serialNum);
		  int bookcode = bookSubVo.getBookcode();
		  bookSubService.removeSubBookBySerialNum(bookcode,serialNum);
		  	
		  return new ResponseEntity<String>("해당도서가 삭제되었습니다.", HttpStatus.OK);
		
	  } // addSubBook()
	  
	  // 서브도서 사용중지하기
	  @GetMapping(value ="/useStop/{serialNum}", produces = MediaType.TEXT_PLAIN_VALUE )
	  public ResponseEntity<String> useStop(HttpSession session, @PathVariable("serialNum") int serialNum){
	  
		  log.info("서브북코드: " + serialNum);
		  bookSubService.useStop(serialNum);
		  	
		  return new ResponseEntity<String>("해당도서의 사용이 중지되었습니다.", HttpStatus.OK);
		
	  } // addSubBook()
	  
	  // 서브도서 사용가능하기
	  @GetMapping(value ="/available/{serialNum}", produces = MediaType.TEXT_PLAIN_VALUE )
	  public ResponseEntity<String> available(HttpSession session, @PathVariable("serialNum") int serialNum){
	  
		  log.info("서브북코드: " + serialNum);
		  bookSubService.available(serialNum);
		  	
		  return new ResponseEntity<String>("해당도서의 사용이 다시 가능하게되었습니다.", HttpStatus.OK);
		
	  } // addSubBook()
	 	 	
	
		//회원 도서신청
	  @GetMapping(value ="/bookApply/{num}", produces = MediaType.TEXT_PLAIN_VALUE ) 
	  public ResponseEntity<String> applyBook(HttpSession session, @PathVariable("num") int num){
	  
	  
		  log.info("서브책 번호: " + num);
		  
		  String id = (String) session.getAttribute("id");
		  ResponseEntity<String> entity = null;
		  
		  // 오늘날짜 가져오기
		  String date = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		  
		  BookSubVo bookSubVo = bookSubService.getSubBookByNum(num);
		  
		  int cnt = bookSubService.applyTest(id);
		  
		  //도서가 이미 신청중이거나 신청자의 신청횟수가 5를 넘으면 실패
		  if(bookSubVo.getIsApply() == 1 || cnt >= 5) {
			  
			  entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
			  
			  
		  } else {
		  
			  bookSubVo.setApplyer(id);
			  bookSubVo.setApplyStart(date);
			  bookSubVo.setApplyEnd(date);
			  
			  bookSubService.bookApplyUpdate(bookSubVo);
			  
			  entity = new ResponseEntity<String>("도서가 신청되었습니다.\n- 12:00 ~ 17:00 사이에 수령 부탁드립니다.\n※ 도서수령시 회원증 필수지참, 미수령시 신청 다음날 자동취소", HttpStatus.OK);
			  
		  
		  }
		  
		  return entity;
	  
	  } //applyBook()
	  
		//회원 도서신청 취소
	  @GetMapping(value ="/applyCancel/{serialNum}", produces = MediaType.TEXT_PLAIN_VALUE ) 
	  public ResponseEntity<String> applyCancel(HttpSession session, @PathVariable("serialNum") int serialNum){
	  
		  log.info("서브책 번호: " + serialNum);
		  		  		  		  
		  BookSubVo bookSubVo = bookSubService.getSubBookByNum(serialNum);
		  
		  //아이디 동일안되서 패스했었음
		  
		  bookSubService.applyCancel(serialNum);
			 
		  
		  return new ResponseEntity<String>("도서신청이 취소되었습니다.", HttpStatus.OK);
	  
	  } //applyCancel()
	  
	  
	  //도서예약하기
	  @GetMapping(value ="/bookReserve/{num}", produces = MediaType.TEXT_PLAIN_VALUE ) 
	  public ResponseEntity<String> reserveBook(HttpSession session, @PathVariable("num") int num){
	  
	  
		  log.info("서브책 번호: " + num);
		  
		  String id = (String) session.getAttribute("id");
		  ResponseEntity<String> entity = null;
	
		  
		  BookSubVo bookSubVo = bookSubService.getSubBookByNum(num);
		  log.info("책 1번 예약자: " + bookSubVo.getReserver());
		  log.info("책 2번 예약자: " + bookSubVo.getReserver2());
		  log.info("id: " + id);
		  
		  
		  
		  if(bookSubVo.getReserver().length() == 0) {
			  
			  bookSubVo.setReserver(id);
			  
			  bookSubService.bookReserveUpdate1(bookSubVo);
			  
			  log.info("넣기완료");
			  
			  entity = new ResponseEntity<String>("도서가 예약되었습니다.", HttpStatus.OK);
			  
		  } else if(bookSubVo.getReserver().length() != 0 && !bookSubVo.getReserver().equals(id) && bookSubVo.getReserver2().length() == 0 ){
		  
			  bookSubVo.setReserver2(id);
			  
			  bookSubService.bookReserveUpdate2(bookSubVo);
			  entity = new ResponseEntity<String>("도서가 예약되었습니다.", HttpStatus.OK);
			  
		  } else {
			  
			  entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		  }
		  
		  return  entity;
	  
	  } //reserveBook()
	  
		
		//나의 대출도서 리스트 가져오기
		@GetMapping(value ="/myRentList/{pageNum}", produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE} )
		public ResponseEntity<BookSubDto> getMyRentData(HttpSession session, @PathVariable("pageNum") int pageNum){
			
			// 세션값 가져오기 인터셉션은 디스패처 서블릿에서 모든 파라미터 값을 가지고온다.
			String id = (String)session.getAttribute("id");
			
			// 가져올 나의 게시글 목록 옵션
			Criteria cri = new Criteria(pageNum, 5);
			
			
			// 원하는 페이지의 글을 가져오는 메소드
			BookSubDto myRentDto = bookSubService.getMyRentList(id, cri);
			
			
			return new ResponseEntity<BookSubDto>(myRentDto, HttpStatus.OK);

		} //getMyReserveData()
		
		//나의 대출이력 리스트 가져오기
		@GetMapping(value ="/getMyRentRecord/{pageNum}", produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE} )
		public ResponseEntity<BookRentDto> getMyRentRecord(HttpSession session, @PathVariable("pageNum") int pageNum){
			
			// 세션값 가져오기 인터셉션은 디스패처 서블릿에서 모든 파라미터 값을 가지고온다.
			String id = (String)session.getAttribute("id");
			
			// 가져올 나의 게시글 목록 옵션
			Criteria cri = new Criteria(pageNum, 5);
			
			
			// 원하는 페이지의 글을 가져오는 메소드
			BookRentDto myRentRecordDto = bookSubService.getMyRentRecord(id, cri);
			
			
			return new ResponseEntity<BookRentDto>(myRentRecordDto, HttpStatus.OK);

		} //getMyReserveData()
		
		
		
		
		//나의 예약도서 리스트 가져오기
		@GetMapping(value ="/myReserveList/{pageNum}", produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE} )
		public ResponseEntity<BookSubDto> getMyReserveData(HttpSession session, @PathVariable("pageNum") int pageNum){
			
			// 세션값 가져오기 인터셉션은 디스패처 서블릿에서 모든 파라미터 값을 가지고온다.
			String id = (String)session.getAttribute("id");
			
			// 가져올 나의 게시글 목록 옵션
			Criteria cri = new Criteria(pageNum, 5);
			
			
			// 원하는 페이지의 글을 가져오는 메소드
			BookSubDto myReserveDto = bookSubService.getMyReserveList(id, cri);
			
			
			return new ResponseEntity<BookSubDto>(myReserveDto, HttpStatus.OK);

		} //getMyReserveData()
		
		
		  //예약도서 마이페이지에서 신청하기
		 @GetMapping(value ="/myPageApply/{num}", produces = MediaType.TEXT_PLAIN_VALUE ) 
		  public ResponseEntity<String> myPageApply(HttpSession session, @PathVariable("num") int num){
		  
		  
			  log.info("서브책 번호: " + num);
			  
			  String id = (String) session.getAttribute("id");
			  ResponseEntity<String> entity = null;
			  
			 // 오늘날짜 가져오기
			  String date = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
			  
			  BookSubVo bookSubVo = bookSubService.getSubBookByNum(num);
			  
			  if(bookSubVo.getIsApply() == 1) {
				  
				  entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
				  
				  
			  } else {
			  
				  bookSubVo.setApplyer(id);
				  bookSubVo.setApplyStart(date);
				  bookSubVo.setApplyEnd(date);
				  
				  bookSubService.bookApplyUpdate2(bookSubVo);
				  
				  entity = new ResponseEntity<String>("도서가 신청되었습니다.\n※ 12:00 ~ 17:00 사이에 수령 부탁드립니다.\n※ 도서수령시 회원증 필수지참, 신청 다음날 미수령시 자동취소 ", HttpStatus.OK);
				  
			  
			  }
			  
			  return entity;
		  
		  } //myPageApply()
		 
		 
	  
	  //신청대기중 예약도서 취소
	  @GetMapping(value ="/reserveCancel1/{num}", produces = MediaType.TEXT_PLAIN_VALUE ) 
	  public ResponseEntity<String> reserveCancel1(@PathVariable("num") int num){
	  
	  
		  log.info("서브책 번호: " + num);
		  
		  ResponseEntity<String> entity = null;
		  		  
		  BookSubVo bookSubVo = bookSubService.getSubBookByNum(num);
		  
		  if(bookSubVo.getApplyStart() == "") {
			  
			  entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
			  
			  
		  } else {
 
			  bookSubService.reserveCancel1(num);
			  
			  entity = new ResponseEntity<String>("도서예약이 취소되었습니다.", HttpStatus.OK);
			  
		  
		  }
		  
		  return entity;
	  
	  } //reserveCancel1()
	  
	  // 예약중 도서 1번 순위 취소
	  @GetMapping(value ="/reserveCancel2/{num}", produces = MediaType.TEXT_PLAIN_VALUE ) 
	  public ResponseEntity<String> reserveCancel2(@PathVariable("num") int num){
	  
	  
		  log.info("서브책 번호: " + num);
		  
		  ResponseEntity<String> entity = null;
		  		  
		  BookSubVo bookSubVo = bookSubService.getSubBookByNum(num);
		  
		  if(bookSubVo.getReserver() == "") {
			  
			  entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
			  
			  
		  } else {
 
			  bookSubService.reserveCancel2(num);
			  
			  entity = new ResponseEntity<String>("도서예약이 취소되었습니다.", HttpStatus.OK);
			  
		  
		  }
		  
		  return entity;
	  
	  } //reserveCancel2()
	  
	  // 예약중 도서 2번 순위 취소
	  @GetMapping(value ="/reserveCancel3/{num}", produces = MediaType.TEXT_PLAIN_VALUE ) 
	  public ResponseEntity<String> reserveCancel3(HttpSession session, @PathVariable("num") int num){
	  
	  
		  log.info("서브책 번호: " + num);
		  
		  String id = (String) session.getAttribute("id");
		  ResponseEntity<String> entity = null;
		  		  
		  BookSubVo bookSubVo = bookSubService.getSubBookByNum(num);
		  
		  if(bookSubVo.getReserver2() == "") {
			  
			  entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
			  
			  
		  } else {
			  		
			  bookSubService.reserveCancel3(num);
			  
			  entity = new ResponseEntity<String>("도서예약이 취소되었습니다.", HttpStatus.OK);
			  
		  
		  }
		  
		  return entity;
	  
	  } //reserveCancel2()
	  
	  
	  //관리자 페이지 신청도서 가져오기
	  
	  @GetMapping(value ="/getApplyBookList/{pageNum}", produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE} )
		public ResponseEntity<BookSubDto> getApplyBookList(HttpSession session, @PathVariable("pageNum") int pageNum){
			
		
			
			Criteria cri = new Criteria(pageNum, 5);
			
			
			// 관리자 페이지 신청도서 목록
			BookSubDto applyBookListDto = bookSubService.getApplyBookList(cri);
			
			return new ResponseEntity<BookSubDto>(applyBookListDto, HttpStatus.OK);

		} //getMyList()
	  
	  @GetMapping(value ="/getReserveBookList/{pageNum}", produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE} )
		public ResponseEntity<BookSubDto> getReserveBookList(HttpSession session, @PathVariable("pageNum") int pageNum){
			
			Criteria cri = new Criteria(pageNum, 5);
			
			// 관리자 페이지 신청도서 목록
			BookSubDto reserveBookListDto = bookSubService.getReserveBookList(cri);
			
			return new ResponseEntity<BookSubDto>(reserveBookListDto, HttpStatus.OK);

		} //getMyList()
	  
	  
	  //도서 대출하기
	  @GetMapping(value ="/rentBook/{num}", produces = MediaType.TEXT_PLAIN_VALUE ) 
	  public ResponseEntity<String> rentBook(HttpSession session, @PathVariable("num") int num){
	  
	  
		  log.info("서브책 번호: " + num);
		 
		  
		 String rentStart = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		 LocalDateTime today = LocalDateTime.now();     //Today
	     LocalDateTime tomorrow = today.plusDays(7);
	     
	     String rentEnd = tomorrow.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
	     
	     ResponseEntity<String> entity = null;
		 
		  
		  BookSubVo bookSubVo = bookSubService.getSubBookByNum(num);
		  int bookCode = bookSubVo.getBookcode();
		  log.info("도서코드: " + bookCode);
		 
		  
		  if(bookSubVo.getApplyer().length() == 0) {
			  
			  entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
			  
		  } else {
			 
			  bookSubVo.setRentStart(rentStart);
			  bookSubVo.setRentEnd(rentEnd);
			  bookService.updateRentCnt(bookCode);
			  bookSubService.rentBook(bookSubVo);

			  
			  entity = new ResponseEntity<String>("도서가 대출되었습니다.", HttpStatus.OK);
		  }
		  
		  return  entity;
	  
	  } //reserveBook()
	  
	  @GetMapping(value ="/getRentBookList/{pageNum}", produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE} )
		public ResponseEntity<BookSubDto> getRentBookList(HttpSession session, @PathVariable("pageNum") int pageNum){
						
			Criteria cri = new Criteria(pageNum, 5);
			
			// 관리자 페이지 신청도서 목록
			BookSubDto rentBookListDto = bookSubService.getRentBookList(cri);
			
			return new ResponseEntity<BookSubDto>(rentBookListDto, HttpStatus.OK);

		} //getMyList()
	  
	  
	  // 도서반납
	  @GetMapping(value ="/returnBook/{serialNum}", produces = MediaType.TEXT_PLAIN_VALUE ) 
	  public ResponseEntity<String> returnBook(@PathVariable("serialNum") int serialNum){
	  
		  	
		  log.info("서브책 번호: " + serialNum);
		  
		  ResponseEntity<String> entity = null;
		  		  
		  BookSubVo bookSubVo = bookSubService.getSubBookByNum(serialNum);
		  
		  log.info("서브책 목록: " + bookSubVo);
		  
		  if(bookSubVo.getRenter() == "") {
			  
			  entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
			  
			  
		  } else {
 
			  bookSubService.returnBook(bookSubVo, serialNum);
			  
			  entity = new ResponseEntity<String>("도서가 반납되었습니다.", HttpStatus.OK);
			  
		  }
		  
		  return entity;
	  
	  } //reserveCancel2()
	  
	  
	 	
	@GetMapping(value ="/bookData/{bookCode}", produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE} )
	public ResponseEntity<List<BookSubVo>> getBookData(HttpSession session, @PathVariable("bookCode") int bookCode){
		
		
		// 원하는 페이지의 글을 가져오는 메소드
		List<BookSubVo> list = bookSubService.getBookSubList(bookCode);
		
		
		return new ResponseEntity<List<BookSubVo>>(list, HttpStatus.OK);

	} //getMyList()
	
	
	@GetMapping(value ="/extensionBook/{num}", produces = MediaType.TEXT_PLAIN_VALUE )
	public ResponseEntity<String> extensionBook(HttpSession session, @PathVariable("num") int num){
		
		
		// 원하는 페이지의 글을 가져오는 메소드
		BookSubVo bookSubVo = bookSubService.getSubBookByNum(num);
		
		 String day = bookSubVo.getRentEnd();
		 
		 DateTimeFormatter DATEFORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		 LocalDate ld = LocalDate.parse(day, DATEFORMATTER);
		 
		 LocalDateTime now = LocalDateTime.of(ld, LocalDateTime.now().toLocalTime());

	     LocalDateTime three = now.plusDays(3);
	     
	     log.info("시간: " + three);
	     
	     String rentEnd = three.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
	     
	     log.info("시간변경: " + rentEnd);
		
		bookSubVo.setExtension(1);
		bookSubVo.setRentEnd(rentEnd);
		
		bookSubService.extensionBook(bookSubVo);
		

		return new ResponseEntity<String>("대출기간이 3일 연장되었습니다.", HttpStatus.OK);

	} //getMyList()
	
	
		
	
	@GetMapping("/searchContent")
	public String searchcontent(int bookCode, Model model, HttpSession session) {
		
		
		  String id = (String) session.getAttribute("id");
		  String memNumBL = memberService.getMemNumById(id);
		
		  
		  boolean bookLike = false;
		  if (id != null) {
				bookLike = bookLikeService.getBookLike(memNumBL, bookCode);
				System.out.println(bookLike);
		  } else {
				model.addAttribute("message","로그인이 필요한 서비스 입니다.");
				model.addAttribute("url","/");
				return "/libraryService/logInCheck";
			}

		BookVo bookVo = bookService.getBookInfo(bookCode);
		
		Integer memNum = Integer.parseInt(memberService.getMemNumById(id));
		

		System.out.println(bookVo);
		/* System.out.println(bookLike); */
		
		model.addAttribute("bookVo", bookVo);
		model.addAttribute("id", id);
		model.addAttribute("bookLike", bookLike);
		model.addAttribute("memNum", memNum);
		

		// 실행할 특정 jsp 경로정보 리턴
		return "libraryService/searchContent";
	}
	
	
	

}

