package com.project.controller;

import java.io.File;
import java.io.IOException;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.tika.Tika;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import com.project.dao.*;
import com.project.dto.*;
import com.project.service.FileService;

@Controller
public class BoardController {
	
	@Autowired
	private BoardDAOImpl board;	// 전체 게시판 DAO
	
	@Autowired 
	private ReplyDAOImpl reply;
	
	@Autowired
	private FileService fileService;

	@Autowired
	private RecommendDAOImpl recommend;
	
	@Resource(name="uploadPath")
	String uploadPath;
	
	
	Pagination pagination;
	Map<String, Object> map = new HashMap<String, Object>();


	// 전체 게시판 가져오기
	@RequestMapping("/board.do")	 
	public String board(@RequestParam int pageParam, @RequestParam String board_type, @RequestParam String boardSearch, Model model) {
		if(boardSearch.equals("yes")) {  //boardSearch.do에서 넘어온게 있을때만 model 객체 그대로 가지고 넘어간다
		} else {
			pagination = new Pagination(board.getRecords(board_type), pageParam);	// (전체레코드 수, 페이지 번호)
			
			map.put("rowStart", pagination.getRowStart());
			map.put("rowEnd", pagination.getRowEnd());
			map.put("board_type", board_type);
			
			model.addAttribute("list", board.selectList(map));
			model.addAttribute("upBoardList", board.selectUpBoardList(map));
			model.addAttribute("page", pagination);
			model.addAttribute("board_type", board_type);
			
		}
		return "board";
	} //entire.do
	
	
	// 글 작성으로 이동
	@RequestMapping("/boardWrite.do")
	public String boardWrite(@RequestParam String board_type, @RequestParam int user_type,  Model model) {
		model.addAttribute("board_type", board_type); 
		model.addAttribute("user_type", user_type);
		return "boardWrite";
	}
	
	// 글 작성 완료
	/* @RequestMapping( value="/boardWriteOk.do", method=RequestMethod.POST) */
	@RequestMapping("boardWriteOk.do")
	public String boardWriteOk(HttpServletRequest request, MultipartRequest files,  Model model) throws IOException {
		String board_type = request.getParameter("board_type");
		String upBoard = request.getParameter("upBoard");
		if(upBoard != null) {
			map.put("board_upBoard", request.getParameter("upBoard"));
		}
		// 글 작성 
		map.put("board_title", request.getParameter("board_title").trim());
		map.put("board_content", request.getParameter("board_content"));
		map.put("board_nickname", request.getParameter("board_nickname").trim());
		map.put("board_type", request.getParameter("board_type"));
		
		board.insertRecord(map);
		
		map.clear();

		
		// name="file" 로 되어있는 파일 list에 담기
		List<MultipartFile> fileList = files.getFiles("file"); 
		
		if(fileList.get(0).getOriginalFilename() != "") {	// 첨부파일이 있을때만 실행함.
			board.hasFileUp(board.getLatest());		//getLatest() : 지금 업로드한 글의 board_no
			fileService.fileUpload(fileList, board_type, board.getLatest());	
		}  
		
		if(board_type.equals("hotel") || board_type.equals("restaurant")) {
			return "redirect:"+board_type+".do?board_type="+board_type+"&"+board_type+"_search=";
			
		} else {
			return "redirect:board.do?pageParam="+1+"&board_type="+board_type+"&boardSearch=no";
		}
		
		
	}
	
	// 글 찾기
	@RequestMapping("/boardSearch.do")
	public String entireSearch(HttpServletRequest request, Model model) {
		int pageParam = Integer.parseInt(request.getParameter("pageParam"));
		String board_type = request.getParameter("board_type");

		//검색종류, 검색어 map에 담아서 sql query로 전달
		map.put("searchType", request.getParameter("searchType"));
		map.put("searchData", request.getParameter("searchData"));
		map.put("board_type", request.getParameter("board_type"));
		
		pagination = new Pagination(board.getRecordsBySerachType(map), pageParam);
		
		// 모델 객체에 값들 넣어주기 --- *다음 페이지를 위해서 검색타입, 검색내용도 넘겨주기 (boardSearch.jsp 에서 똑같이 다시 넘겨줄 예정)
		map.put("rowStart", pagination.getRowStart());
		map.put("rowEnd", pagination.getRowEnd());
		
		model.addAttribute("list", board.selectSearchData(map));
		model.addAttribute("upBoardList", board.selectUpBoardList(map));
		model.addAttribute("page", pagination);
		model.addAttribute("board_type", request.getParameter("board_type"));
		model.addAttribute("searchType", request.getParameter("searchType"));
		model.addAttribute("searchData", request.getParameter("searchData"));
		
		return "forward:board.do?pageParam="+pageParam+"&board_type="+board_type+"&boardSearch=yes";
		//return "boardSearch";	// 다른 페이지에서 보이게 (boardSearch=yes 필요없음)
	} //boardSearch.do
	

	@RequestMapping("/content.do")
	public String content(@RequestParam int board_no, @RequestParam String board_type,@RequestParam int pageParam, Model model, HttpSession session) throws IOException {
		board.updateView(board_no); 	//조회수 증가
		
		model.addAttribute("dto", board.selectOne(board_no));	// 해당 게시물 가져오기
		model.addAttribute("replyNum", reply.getRecords(board_no));	// 해당 게시물의 답글 수 가져오기
		model.addAttribute("board_type", board_type);	// bottomBoard(댓글 아래 다음 게시물들) 을 위해 board_type을 넘겨준다
		model.addAttribute("pageParam", pageParam);	// bottomBoard(댓글 아래 다음 게시물들) 을 위해 현재페이지(pageParam)을 넘겨준다
		
		// 해당 게시물에 첨부되어 있을 첨부파일 가져오기
		List<String> getFiles = board.selectFile(board_no);
		
		//이미지/일반파일 분류  저장
		List<String> files = new ArrayList<String>();
		List<String> images = new ArrayList<String>();
		
		// 만약 첨부파일이 있다면 실행
		if(!getFiles.isEmpty()) {
			for(int i = 0; i < getFiles.size(); i++) {
				File file = new File(uploadPath+getFiles.get(i));		//uploadPath는 servlet-context.xml에서 수정할 수 있음
				
				if(new Tika().detect(file).startsWith("image")) { 		// 가져온 첨부파일이 어떤 형태인지 (image 인지, txt 인지 등등)
					images.add(getFiles.get(i)); 						// 이미지에 해당하는 파일을 따로 담아 images라는 이름으로 넘긴다
					model.addAttribute("images", images);
				} else {
					files.add(getFiles.get(i));	// 위와 동일
					model.addAttribute("files", files );
				}
			}
		}
		
		return "boardContent";
	} ///content.do
	
	
	@RequestMapping("/boardBottom.do")
	@ResponseBody
	public ModelAndView boardBottom(@RequestParam int pageParam, @RequestParam String board_type, ModelAndView mav) {
		pagination = new Pagination(board.getRecords(board_type), pageParam);	// (전체레코드 수, 페이지 번호)
		
		map.put("rowStart", pagination.getRowStart());
		map.put("rowEnd", pagination.getRowEnd());
		map.put("board_type", board_type);
		
		mav.addObject("list", board.selectList(map));
		mav.addObject("upBoardList", board.selectUpBoardList(map));
		mav.addObject("page", pagination);
		mav.addObject("board_type", board_type);
		mav.setViewName("ajax/boardBottom");	
		
		return mav;
	} //entire.do
	
	// 원글의 좋아요 or 싫어요 누르면 바로 실행되는 함수
	@RequestMapping("/getBoardLikey.do")
	@ResponseBody
	public ModelAndView  getBoardLikey(@RequestParam int board_no, HttpSession session, ModelAndView mav) {
		// 현재 로그인 닉네임의 좋아요/싫어요 가져오기
		String nickname = (String) session.getAttribute("nickname");
		if (nickname != null) {
			List<RecommendDTO> dto = recommend.selectByNickname(nickname);
			
			for(int i = 0; i < dto.size(); i++) {
				if(board_no == dto.get(i).getBoard_no()) {
					RecommendDTO boardRec = dto.get(i);
					mav.addObject("boardRec", boardRec);
				}
			}
		}
		
		mav.addObject("likes", board.getLikes(board_no));
		mav.addObject("dislikes", board.getDislikes(board_no));
		mav.addObject("board_no", board_no);
		mav.setViewName("ajax/boardLikey");
		
		return mav;
	}
	
	// 게시물 삭제
	@RequestMapping("/boardDelete.do")
	public String boardDelete(@RequestParam int board_no, @RequestParam String board_type) {
		// 게시글 삭제
		board.boardDelete(board_no);
		
		// 첨부파일 있다면 삭제 진행
		List<String> files = board.selectFile(board_no);
		
		if(!files.isEmpty()) {
			for(String name : files) {
				File file = new File(uploadPath + name);
				file.delete();
			}
		}
		
		board.deleteAllFile(board_no);
				
		return "redirect:board.do?pageParam=1&board_type="+board_type+"&boardSearch=no";
	}
	
	// 게시물 수정
	@RequestMapping("/boardEdit.do")
	public String boardEdit(@RequestParam int board_no, @RequestParam String board_type,@RequestParam int pageParam, Model model) {
		model.addAttribute("dto", board.selectOne(board_no));	// 해당 게시물 가져오기
		model.addAttribute("board_type", board_type);	// bottomBoard(댓글 아래 다음 게시물들) 을 위해 board_type을 넘겨준다
		model.addAttribute("files", board.selectFile(board_no));
		model.addAttribute("pageParam", pageParam);
		
		return "boardEdit";
	}

	@RequestMapping("/boardEditOk.do")	//@RequestParam List<String> fileDel,  
	public String boardEditOk(HttpServletRequest request, MultipartRequest multipart, Model model) {
		int board_no = Integer.parseInt(request.getParameter("board_no"));
		String board_type = request.getParameter("board_type");
		int pageParam = Integer.parseInt(request.getParameter("pageParam"));
		
		map.put("board_title", request.getParameter("board_title").trim());
		map.put("board_content", request.getParameter("board_content"));
		map.put("board_nickname", request.getParameter("board_nickname"));
		map.put("board_type", board_type);
		map.put("board_no", board_no);
		
		// 수정한 게시글로 변경
		board.updateContent(map);	
		
		// 삭제 하는 첨부파일
		String[] fileDel = request.getParameterValues("fileDel");	// checkbox의 value 배열로 가져온다
		
		if( fileDel != null) {	// 삭제를 체크한게 있다면 
			for(String name: fileDel) {	// 이름(checkbox의 value가 이름임)을 각각 가져와서 삭제해줌
				map.put("boardfile_name", name);
				fileService.deleteFile(map);	// 우선 boardfile table에 있는 레코드 삭제  (board_no, boardfile_name 으로 삭제함)
				
				File file = new File(uploadPath + name);	// 파일 위치
				file.delete();		// 로컬 파일 삭제
			}
		}
		
		
		// 파일 추가한게 있다면 List로 받아줌
		List<MultipartFile> fileList = multipart.getFiles("file");
		if(fileList.get(0).getOriginalFilename() != "") {	// 첨부파일이 있을때만 실행함.
			board.hasFileUp(board_no);
			fileService.fileUpload(fileList, board_type, board_no);	 // 해당 글번호(board_no)에 파일이름 다 넣어줌
		} 
		
		// 수정 완료 후 해당 글에 대한 파일이 있는지 다시 확인 후, 없다면 board테이블의 board_hasFile -1 을 해줌
		List<String> fileNames = board.selectFile(board_no);
		if(fileNames.isEmpty()) {
			board.hasFileDown(board_no);
		}
		
		if(board_type.equals("hotel") || board_type.equals("restaurant")) {
			return "redirect:"+board_type+".do?board_type="+board_type+"&"+board_type+"_search=";
		}
		// 다시 content.jsp 로 가면서 변경사항 바로 보이게끔 함
		return "redirect:content.do?board_no="+board_no+"&board_type="+board_type+"&pageParam="+pageParam;
	}

	@RequestMapping("/boardBottomCon.do")
	@ResponseBody
	public ModelAndView boardBottomCon(@RequestParam int pageParam, @RequestParam String board_type, ModelAndView mav) throws IOException {
			pagination = new Pagination(board.getRecords(board_type), pageParam);	// (전체레코드 수, 페이지 번호)
			
			map.put("rowStart", pagination.getRowStart());
			map.put("rowEnd", pagination.getRowEnd());
			map.put("board_type", board_type);
			
			mav.addObject("list", board.selectList(map));	//게시글
			mav.addObject("upBoardList", board.selectUpBoardList(map)); // 공지글
			mav.addObject("page", pagination);
			mav.addObject("pageParam", pageParam);
			mav.addObject("board_type", board_type);
			
			mav.setViewName("ajax/boardBottomCon");	
		return mav;
	} //entire.do
	
	@RequestMapping("/contentsCon.do")	// 게시글 상세 가져오기
	@ResponseBody
	public ModelAndView contents(@RequestParam int board_no, @RequestParam int pageParam, ModelAndView mav, HttpSession session) throws IOException {
		//게시글 가져오기
		mav.addObject("dto", board.selectOne(board_no));

		
		
		//게시글의 댓글 가져오기 + 페이징
		pagination = new Pagination(reply.getRecords(board_no), pageParam, 10, 5);	// 10rows, 5 blocks
		
		map.put("rowStart", pagination.getRowStart());
		map.put("rowEnd", pagination.getRowEnd());
		map.put("board_no", board_no);
		
		mav.addObject("page", pagination);
		
		mav.addObject("replyList", reply.selectList(map));	// board_no에 해당하는 댓글 rowStart부터 rowEnd만 가져옴
		
		
		
		
		// 현재 로그인 닉네임의 좋아요/싫어요 가져오기
		String nickname = (String) session.getAttribute("nickname");
			if (nickname != null) {	// 현재 로그인 했을 때만 실행
				List<RecommendDTO> dto = recommend.selectByNickname(nickname);	//현재 로그인한 닉네임이 좋아요/싫어요 했던 게시글/댓글 번호 다 가져오기
				List<RecommendDTO> replyRec = new ArrayList<RecommendDTO>();	//좋아요/싫어요 한 댓글 담을 List
				
				for(int i = 0; i < dto.size(); i++) {			
					if(board_no == dto.get(i).getBoard_no()) {	// 현재 글번호 == 가져온 레코드 중 현재 글번호랑 일치하면
						RecommendDTO boardRec = dto.get(i);	
						mav.addObject("boardRec", boardRec);	// mav에 담아준다	
					}
					
					if(dto.get(i).getReply_no() != 0) {			// 일단 가져온 레코드 중 null값이 아닌 경우 
						replyRec.add(dto.get(i));
						mav.addObject("replyRec", replyRec);	// 전부 mav에 담아준다
						
					}
						
				}
			}
		
		
		

		// 해당 게시물에 첨부되어 있을 첨부파일 가져오기
		List<String> fileNames = board.selectFile(board_no);	//게시글에 포함되어있는 첨부파일
		
		List<BoardFileDTO> files = new ArrayList<BoardFileDTO>();		// 파일 저장
		List<BoardFileDTO> images = new ArrayList<BoardFileDTO>();		// 이미지 저장
		
		// 만약 첨부파일이 있다면 실행
		if(!fileNames.isEmpty()) {
			BoardFileDTO fileDto = new BoardFileDTO();
			for(int i = 0; i < fileNames.size(); i++) {
				File file = new File(uploadPath + fileNames.get(i));	//uploadPath는 servlet-context.xml에서 수정할 수 있음
				
				if(new Tika().detect(file).startsWith("image")) { // 가져온 첨부파일이 어떤 형태인지 (image 인지, txt 인지 등등)
					fileDto.setBoardfile_name(fileNames.get(i));
					images.add(fileDto);	// 이미지에 해당하는 파일을 따로 담아 images라는 이름으로 넘긴다
					mav.addObject("images", images);
				} else {
					fileDto.setBoardfile_name(fileNames.get(i));
					files.add(fileDto);	// 파일
					mav.addObject("files", files );
				}
			}
		}
		
		mav.setViewName("ajax/contentsCon");
		return mav;
	}
	
}
