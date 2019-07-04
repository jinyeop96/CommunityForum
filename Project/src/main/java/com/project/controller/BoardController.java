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

@Controller
public class BoardController {
	
	@Autowired
	private BoardDAOImpl board;	// 전체 게시판 DAO
	
	@Autowired 
	private ReplyDAOImpl reply;
	
	@Autowired
	private FileService fileService;
	
	@Autowired
	private RecommendService recommendService;
	
	@Resource(name="uploadPath")
	String uploadPath;
	
	
	Pagination pagination;
	Map<String, Object> map = new HashMap<String, Object>();
	RecommendDTO rec = new RecommendDTO();

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
			model.addAttribute("page", pagination);
			model.addAttribute("board_type", board_type);
			
		}
		return "board";
	} //entire.do
	
	
	// 글 작성으로 이동
	@RequestMapping("/boardWrite.do")
	public String boardWrite(@RequestParam String board_type, Model model) {
		model.addAttribute("board_type", board_type);
		return "boardWrite";
	}
	
	// 글 작성 완료
	/* @RequestMapping( value="/boardWriteOk.do", method=RequestMethod.POST) */
	@RequestMapping("boardWriteOk.do")
	public String boardWriteOk(HttpServletRequest request, MultipartRequest files,  Model model) throws IOException {
		String board_type = request.getParameter("board_type");
		
		// 글 장성 
		map.put("board_title", request.getParameter("board_title").trim());
		map.put("board_content", request.getParameter("board_content"));
		map.put("board_nickname", request.getParameter("board_nickname").trim());
		map.put("board_type", request.getParameter("board_type"));
		
		board.insertRecord(map);

		
		// name="file" 로 되어있는 파일 list에 담기
		List<MultipartFile> fileList = files.getFiles("file"); 
		
		if(fileList.get(0).getOriginalFilename() != "") {	// 첨부파일이 있을때만 실행함.
			board.hasFileUp(board.getLatest());		//getLatest() : 지금 업로드한 글의 board_no
			fileService.fileUpload(fileList, board.getLatest());	
		}  
		
		if(board_type.equals("hotel") || board_type.equals("restaurant") || board_type.equals("transport")) {
			return "redirect:hotel.do?hotel_search=";
			
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
		
		/*
		// 로그인 되어있다면 nickname 받아와서
		String nickname = (String) session.getAttribute("nickname");
		if(nickname != null) {
			// 해당 글에 nickname이 추천or비추천 했는지 레코드 가져옴
			model.addAttribute("rec", recommendService.selectFromBoard(board_no, session));	
		}
		*/
		
		// 해당 게시물에 첨부되어 있을 첨부파일 가져오기
		List<String> files = board.selectFile(board_no);
		//담아서 보내줄 List
		List<String> other = new ArrayList<String>();
		List<String> img = new ArrayList<String>();
		
		// 만약 첨부파일이 있다면 실행
		if(!files.isEmpty()) {
			for(int i = 0; i < files.size(); i++) {
				File file = new File(uploadPath+files.get(i));	//uploadPath는 servlet-context.xml에서 수정할 수 있음
				
				if(new Tika().detect(file).startsWith("image")) { // 가져온 첨부파일이 어떤 형태인지 (image 인지, txt 인지 등등)
					img.add(files.get(i)); // 이미지에 해당하는 파일을 따로 담아 images라는 이름으로 넘긴다
					model.addAttribute("images", img);
				} else {
					other.add(files.get(i));	// 위와 동일
					model.addAttribute("files", other );
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
		mav.addObject("page", pagination);
		mav.addObject("board_type", board_type);
		mav.setViewName("ajax/boardBottom");	
		
		return mav;
	} //entire.do

	@RequestMapping("/boardBottomCon.do")
	@ResponseBody
	public ModelAndView boardBottomCon(@RequestParam int pageParam, @RequestParam String board_type, ModelAndView mav) {
		pagination = new Pagination(board.getRecords(board_type), pageParam);	// (전체레코드 수, 페이지 번호)
		Pagination replyPagination = new Pagination(board.getRecords(board_type), pageParam, 10, 5);
		
		map.put("rowStart", pagination.getRowStart());
		map.put("rowEnd", pagination.getRowEnd());
		map.put("board_type", board_type);
		mav.addObject("list", board.selectList(map));
		mav.addObject("replyList", reply.selectAllList());
		
		mav.addObject("page", pagination);
		mav.addObject("pageParam", pageParam);
		mav.addObject("replyPage", replyPagination);
		mav.addObject("board_type", board_type);
		mav.setViewName("ajax/boardBottomCon");	
		
		return mav;
	} //entire.do
	
	
	/////////원글 좋아요&싫어요////////////////
	@RequestMapping("/boardUpdateLike.do")
	@ResponseBody
	public Map<String, Object> boardUpdateLike(@RequestParam int board_no, HttpSession session) {
		return recommendService.boardUpdateLike(board_no, session);
	} 
	
	
	@RequestMapping("/boardUpdateDislike.do")
	@ResponseBody
	public Map<String, Object> boardUpdateDislike(@RequestParam int board_no, HttpSession session) {
		return recommendService.boardUpdateDislike(board_no, session);
	}

	
	// 원글의 좋아요 or 싫어요 누르면 바로 실행되는 함수
	@RequestMapping("/getLikeDislike.do")
	@ResponseBody
	public Map<String, Object> getLikeDislike(@RequestParam int board_no, HttpSession session) {
		map.put("likes", board.getLikes(board_no));
		map.put("dislikes", board.getDislikes(board_no));

		/*	//로그인 했다면 관련 recommend테이블 가져오기
		String nickname = (String) session.getAttribute("nickname");
		if(nickname != null) {
			map.put("rec", recommendService.selectFromBoard(board_no, session));
		}
		*/
		return map;
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
			fileService.fileUpload(fileList, board_no);	 // 해당 글번호(board_no)에 파일이름 다 넣어줌
		} 
		
		// 수정 완료 후 해당 글에 대한 파일이 있는지 다시 확인 후, 없다면 board테이블의 board_hasFile -1 을 해줌
		List<String> fileNames = board.selectFile(board_no);
		if(fileNames.isEmpty()) {
			board.hasFileDown(board_no);
		}
		
		// 다시 content.jsp 로 가면서 변경사항 바로 보이게끔 함
		return "redirect:content.do?board_no="+board_no+"&board_type="+board_type+"&pageParam="+pageParam;
	}
	
}
