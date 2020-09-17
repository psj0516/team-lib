package com.example.controller;
import java.io.File;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.domain.CommentVo;
import com.example.domain.NoticeVo;
import com.example.domain.NoticefileVo;
import com.example.domain.PageDto;
import com.example.service.MemberService;
import com.example.service.NoticeFileService;
import com.example.service.NoticeService;

import lombok.extern.java.Log;

@Log
@RequestMapping("/notice/*")
@Controller
public class NoticeController {

	@Autowired
	private NoticeService noticeService;
	@Autowired
	private NoticeFileService noticeFileService;
	@Autowired
	private MemberService memberService;

	// 공지글 목록 가져오기
	@GetMapping("/list")
	public String noticeList(Model model,
						   @RequestParam(defaultValue = "1") int pageNum,
						   @RequestParam(defaultValue = "") String category, 
						   @RequestParam(defaultValue = "") String search) { 
		 
		
		// 오늘날짜 가져오기
		String date = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy.MM.dd"));

		// 전체 글갯수
		int totalCount = noticeService.getTotalCount(category, search);

		int pageSize = 15;
		// 시작행 인덱스번호 구하기(수식)
		int startRow = (pageNum - 1) * pageSize;

		// 원하는 페이지의 글을 가져오는 메소드
		List<NoticeVo> list = null;
		if (totalCount > 0) {
			list = noticeService.getNotices(startRow, pageSize, category, search);
		}

		
		// 총 페이지 수 구하기
		int pageCount = totalCount / pageSize;
		if (totalCount % pageSize > 0) {
			pageCount += 1;
		}

		// 화면에 보여줄 페이지번호의 갯수 설정
		int pageBlock = 10;

		
		// 1~10 11~20 21~30
		// 페이지 블록의 시작페이지
		int startPage = ((pageNum / pageBlock) - (pageNum % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;
		
		// 페이지 블록의 끝페이지
		int endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) {
			endPage = pageCount;
		}

		// 페이지블록 관련 정보를 pageDTO에 저장
		PageDto pageDto = new PageDto(); 
		pageDto.setTotalCount(totalCount);
		pageDto.setPageCount(pageCount);
		pageDto.setPageBlock(pageBlock);
		pageDto.setStartPage(startPage);
		pageDto.setEndPage(endPage);
		pageDto.setCategory(category);
		pageDto.setSearch(search);

		// 뷰(jsp)에서 사용할 데이터를 request 영역객체에 저장 
		model.addAttribute("noticeList", list);
		model.addAttribute("pageDto", pageDto);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("date", date);

		return "board/notice";

	}// noticeList()
	
	
	@GetMapping(value ="/subList", produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE} )
	public ResponseEntity<List<NoticeVo>> getList(){ //현재 url 주소에서 bno를 넘기는 상황(@GetMapping(value ="/pages/{bno}" ) 때문에 
														// url 에서 값을 가져오라고 알려줘야함. 그래서 @PathVariable("bno") 를 넣어줌.
		int pageSize = 7;

		// 원하는 페이지의 글을 가져오는 메소드
		List<NoticeVo> list = noticeService.getSubNoitces(pageSize);
		
		log.info("list : " + list);


		return new ResponseEntity<List<NoticeVo>>(list, HttpStatus.OK); //리턴할 때 지금 자바버전은 알아서 JSON형식으로 보내주지만 만약
		//	ResponseEntity로 요청하는 이유는 return값에 		   	   //구형버전이라면 안될 수 있다. 때문에 produces로 형식을 return 형식을 정해주는 것이 좋다.
		//	json형식일 때는 HttpStatus.OK를 넣어주는 것이 좋기 때문
		// 단순히 결과만 리턴해도 상관은 없다.
		
	} //getList()
	
	
	
	
	//공지글 작성 페이지로 이동
	@GetMapping("/write")
	public String noticeWrite(Model model, HttpSession session, @ModelAttribute("pageNum") String pageNum) {
		
		// 세션값 가져오기
		String id = (String) session.getAttribute("id");

		String name = memberService.getNameById(id);
		
		// 세션값 없거나 세션값이 "admin"이 아닐경우 login.jsp로 이동
		if (id == null) {
			return "redirect:/member/login";
		}
		
		model.addAttribute("name", name); 

		return "board/noticeWrite";
	}// noticeWrite()

	
	//공지글 작성
	@PostMapping("/write")
	public String noticeWrite(HttpServletRequest request, @RequestParam("filename") List<MultipartFile> files,
			NoticeVo noticeVo) throws Exception {

		
		// 작성 현재시간 가져오기 
		String date = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy.MM.dd"));

		// 작성일자 넣기
		noticeVo.setRegDate(date);
		
		// 새공지글 번호 구하기
		int num = noticeService.getNoticeNum();
		// 새공지글 번호를 vo에 설정
		noticeVo.setNum(num);
		noticeVo.setFile(0);


		ServletContext application = request.getServletContext();
		String path = application.getRealPath("/upload"); //-> 내부에 업로드
		System.out.println("path: " + path); //path: C:/devtools/workspace-sts/funweb-boot/src/main/webapp/upload 에 저장된다.

		
		String strDate = this.getFolder(); // 날짜 년월일 형식의 문자열 리턴
		

		// 파일 경로에 폴더가 없을시 생성
		File dir = new File(path, strDate);
		if (!dir.exists()) {
			dir.mkdirs(); // 폴더가 여러개 만들어져야 할 경우에는 mkdir에 's'를 붙여줘야함
		}


		// 첨부파일정보 담을 리스트 준비
		List<NoticefileVo> noticefileList = new ArrayList<>();

		// 데이터를 불러오기 (텍스트 파일과 다운로드 파일을 나눠야 한다.)
		for (MultipartFile MultipartFile : files) {
			if (MultipartFile.isEmpty()) {
				continue;
			}

			String filename = MultipartFile.getOriginalFilename();
			// 익스플로러는 파일이름에 파일경로가 다 포함되있으므로
			// 순수 파일이름만 부분문자열로 가져오기
			int index = filename.lastIndexOf("\\") + 1;
			filename = filename.substring(index);
			log.info(filename);
			
			// 파일명 중복 피하기 위해 파일이름 앞에 uuid 문자열 붙이기
			UUID uuid = UUID.randomUUID();
			String strUuid = uuid.toString();

			// 업로드(생성)할 파일이름
			String uploadFilename = strUuid + "_" + filename;
			
			log.info(uploadFilename);

			// 생성할 파일정보 File 객체로 준비
			File saveFile = new File(dir, uploadFilename);
			

			MultipartFile.transferTo(saveFile); // 임시업로드된 파일을 최종경로에 파일을 복사한다.

			// ======================================================= 파일업로드 수행완료

			// 파일정보 담기위한 AttachfileVo 객체 생성
			NoticefileVo noticefileVo = new NoticefileVo();
			// 게시판 글번호 설정
			noticefileVo.setBno(noticeVo.getNum());
			// 업로드 경로 설정, 경로에서 백슬래시문자는 슬래시로 모두 변환해서 설정
			noticefileVo.setUploadpath(dir.getPath().replace("\\", "/"));

			noticefileVo.setUuid(strUuid);
		
			noticefileVo.setFilename(filename);
			
			// NoticefileVo에 첨부파일정보 한개 추가
			noticefileList.add(noticefileVo);
			
			
		} //for
			
		noticeService.insertNoticeAndfiles(noticeVo, noticefileList);

		return "redirect:/notice/list";
	}

	
	
	private String getFolder() {

		LocalDateTime dateTime = LocalDateTime.now(); // 오늘날짜 객체준비
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
		String strDate = dateTime.format(formatter); // 오늘날짜가 나옴
		return strDate;
	} // getFolder()

	
	@GetMapping("/content")
	public Object noticeContent(@ModelAttribute("pageNum") String pageNum, int num, Model model, HttpSession session) {

		// 조회수 1증가
		noticeService.updateReadcount(num);
		// 글 한개 가져오기
		NoticeVo noticeVo = noticeService.getNoticeAndNoitcefilesByNum(num);
		// 첨부파일 리스트 가져오기
		List<NoticefileVo> noticefileList = noticeVo.getNoticefileList();
		
		// 내용에서 엔터키 줄바꿈 \r\n -> <br> 바꾸기
		String content = "";
		if (noticeVo.getContent() != null) {
			content = noticeVo.getContent().replace("\r\n", "<br>");
			noticeVo.setContent(content);
		}
		
		//jsp화면(뷰) 만들때 필요한 데이터를 Mode 타입 객체에 저장
		model.addAttribute("noticeVo", noticeVo);
		model.addAttribute("noticefileList", noticefileList);
		
		
		
		return "board/noticeContent";
	}//noticeContent()
	
	
		//공지글 삭제
		@GetMapping("/delete")
		public ResponseEntity<String> delete(int num, String pageNum) {
			
			
			
			List<NoticefileVo> fileVoList = noticeFileService.getNoticefilesByBno(num);
			  
				
			if(fileVoList != null) {
				// 파일 삭제하기
				for (NoticefileVo fileVo : fileVoList) {
					String filename = fileVo.getUuid() + "_" + fileVo.getFilename();
					// 삭제할 파일을 File 객체로 준비
					File file = new File(fileVo.getUploadpath(), filename);
					
					if (file.exists()) { // 해당경로에 파일 존재하면
						file.delete(); // 파일삭제
					}
				}
			}
			
			noticeFileService.deleteNoticefilesByBno(num);
			noticeService.deleteByNum(num);
			
			
	
			HttpHeaders headers = new HttpHeaders(); //header를 통해서 html에 출력정보를 넣어준다. mvc에서 response.setContentType("text/html; charset=UTF-8");와 동일
			headers.add("Content-type", "text/html; charset=UTF-8");
			
			// mvc에서는 PrintWriter out = response.getWriter();로 우리가 html 입력 정보를 직접 출력했다
			StringBuilder sb = new StringBuilder(); //하지만 spring에서는 우리가 직접 정보를 출력하는 것은 허용되지 않는다. 무조건 spring이 하도록 해야한다.
													// 따라서 출력정보만 StringBuilder로 spring에게 넘겨주는것
			sb.append("<script>");                   //넘겨주면 알아서 스프링이 출력해준다.
			sb.append("alert('공지글이 삭제되었습니다.');");
			sb.append("location.href='/notice/list?pageNum'");
			sb.append("</script>");
			
			return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
			
		}//delete()
		
	
		
		//공지수정 페이지로 이동
		@GetMapping("/modify")
		public String modify(HttpSession session, HttpServletResponse response, @ModelAttribute("pageNum") String pageNum, int num, Model model) throws Exception{
			
			NoticeVo noticeVo = noticeService.getNoticeByNum(num);
			List<NoticefileVo> fileVo = noticeFileService.getNoticefilesByBno(num);
			
			model.addAttribute("noticeVo", noticeVo);
			model.addAttribute("fileVo", fileVo);
				
			return "board/noticeModify";
		} //modify
		
		
		
		//공지수정 등록
		@PostMapping("/modify")
		public String modify(NoticeVo noticeVo, @RequestParam("filename") List<MultipartFile> files, String deluuid, String pageNum, HttpServletRequest request,RedirectAttributes rttr) throws Exception {
			
			
			
			  log.info("file: " + noticeVo.getFile());
			  ServletContext application = request.getServletContext(); 
			  String path = application.getRealPath("/upload"); 
			  
			  
			  String strDate = this.getFolder(); // 날짜 년월일 형식의 문자열 리턴
			  
			  
				// 파일 경로에 폴더가 없을시 생성
				File dir = new File(path, strDate);
				if (!dir.exists()) {
					dir.mkdirs(); 
				}


				// 첨부파일정보 담을 리스트 준비
				List<NoticefileVo> noticefileList = new ArrayList<>();
				
				// 삭제할 첨부파일 uuid 담을 리스트 준비
				List<String> delUuidList = new ArrayList<>();
			  
			  
				log.info("uuid: " + deluuid);
				NoticefileVo fileVo = noticeFileService.getNoticefileByUuid(deluuid);
			  
				
				
				// 파일삭제
				if(fileVo != null) {
					File delFile = new File(fileVo.getUploadpath(), fileVo.getUuid() + "_" + fileVo.getFilename());
					if (delFile.exists()) {
						delFile.delete();
					}
				}
				
				// attachfile 테이블 레코드 삭제
				//attachDao.deleteAttachfileByUuid(uuid);
				delUuidList.add(deluuid); // 삭제할 첨부파일 정보를 리스트에 추가
				
				// uuid에 해당하는 첨부파일 레코드들 삭제
				if (delUuidList.size() > 0) {
					noticeFileService.deleteNoticefilesByUuids(delUuidList);
				}
			 
					
				// 데이터를 불러오기 (텍스트 파일과 다운로드 파일을 나눠야 한다.)
				for (MultipartFile MultipartFile : files) {
					if (MultipartFile.isEmpty()) {
						continue;
					}

					String filename = MultipartFile.getOriginalFilename();
					// 익스플로러는 파일이름에 파일경로가 다 포함되있으므로
					// 순수 파일이름만 부분문자열로 가져오기
					int index = filename.lastIndexOf("\\") + 1;
					filename = filename.substring(index);
					log.info("파일이름: " + filename);
					
					// 파일명 중복 피하기 위해 파일이름 앞에 uuid 문자열 붙이기
					UUID uuid = UUID.randomUUID();
					String strUuid = uuid.toString();

					// 업로드(생성)할 파일이름
					String uploadFilename = strUuid + "_" + filename;
					
					log.info("최종파일: " + uploadFilename);

					// 생성할 파일정보 File 객체로 준비
					File saveFile = new File(dir, uploadFilename);
					
					
					

					MultipartFile.transferTo(saveFile); // 임시업로드된 파일을 최종경로에 파일을 복사한다.

					// ======================================================= 파일업로드 수행완료

					// 파일정보 담기위한 AttachfileVo 객체 생성
					NoticefileVo noticefileVo = new NoticefileVo();
					// 게시판 글번호 설정
					noticefileVo.setBno(noticeVo.getNum());
					// 업로드 경로 설정, 경로에서 백슬래시문자는 슬래시로 모두 변환해서 설정
					noticefileVo.setUploadpath(dir.getPath().replace("\\", "/"));

					noticefileVo.setUuid(strUuid);
				
					noticefileVo.setFilename(filename);
					
					// NoticefileVo에 첨부파일정보 한개 추가
					noticefileList.add(noticefileVo);
					
					
				} //for
					
			noticeService.update(noticeVo);
			noticeFileService.insert(noticefileList);
			

			rttr.addAttribute("pageNum", pageNum);
			
			return "redirect:/notice/list";
		}
	
	
	
	// 공지 첨부파일 다운로드
	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	public ResponseEntity<Resource> download(String uuid) throws Exception {
		
		// uuid에 해당하는 레코드 한개 가져오기
		NoticefileVo fileVo = noticeFileService.getNoticefileByUuid(uuid);
		
		// 다운로드할 파일 객체 준비
		String filename = fileVo.getUuid() + "_" + fileVo.getFilename();
		File file = new File( fileVo.getUploadpath(), filename);
		
		Resource resource = new FileSystemResource(file);
		
		if (!resource.exists()) {
			System.out.println("다운로드할 파일이 존재하지 않습니다.");
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND); //404 에러로 값이 없다고 오류뜨기.
		}
		
		String resFilename = resource.getFilename();
		
		// 다운로드할 파일이름에서 UUID 제거하기
		int beginIndex = resFilename.indexOf("_") + 1;
		String originalFilename = resFilename.substring(beginIndex);
		
		// 다운로드 파일명의 문자셋을 utf-8에서 iso-8859-1로 변환
		String downloadFilename = new String(originalFilename.getBytes("utf-8"), "iso-8859-1");
		System.out.println("iso-8859-1 filename = " + downloadFilename);
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Disposition", "attachment; filename=" + downloadFilename);
		
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	} // download()

}
