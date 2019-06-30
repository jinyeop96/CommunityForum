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
		// 글 장성 
		map.put("board_title", request.getParameter("board_title").trim());
		map.put("board_content", request.getParameter("board_content"));
		map.put("board_nickname", request.getParameter("board_nickname").trim());
		map.put("board_type", request.getParameter("board_type"));
		
		board.insertRecord(map);

		
		// name="file" 로 되어있는 파일 list에 담기
		List<MultipartFile> fileList = files.getFiles("file"); 
		
		if(fileList.get(0).getOriginalFilename() != "") {	// 첨부파일이 있을때만 실행함.
			fileService.fileUpload(fileList, board.getLatest());	//getLatest() :  insertRecord()의  board_no 얻기 위한 메서드 (같은 board_no으로 boardfile 테이블에 저장할예정)
		}  
		
		return "redirect:board.do?pageParam="+1+"&board_type="+request.getParameter("board_type")+"&boardSearch=no";
		
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
		System.out.println("nickname = "+nickname);
		if(nickname != null) {
			// 해당 글에 nickname이 추천or비추천 했는지 레코드 가져옴
			System.out.println("nickname = "+nickname);
			model.addAttribute("rec", recommendService.selectRecInfo(pageParam, session));	
		}
		*/
		
		// 해당 게시물에 첨부되어 있을 첨부파일 가져오기
		List<String> files = board.selectFile(board_no);
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

		/*
		String nickname = (String) session.getAttribute("nickname");
		if(nickname != null) {
			map.put("rec", recommendService.selectRecInfo(board_no, session));
		}
		 */
		return map;
	}
	
	
	
}
