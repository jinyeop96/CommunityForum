package com.military.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.military.dao.EntireDAOImpl;
import com.military.dao.EntireReplyDAOImpl;
import com.military.dao.LoginDAOImpl;

@Controller
public class FrontController {
	
	// DAOs
	@Autowired
	public LoginDAOImpl login;	// 로그인 DAO
	
	@Autowired
	public EntireDAOImpl entire;	// 전체 게시판 DAO
	
	@Autowired
	public EntireReplyDAOImpl entireReply;

	// get requests
	@RequestMapping("/main.do")	// index.jsp -> main.jsp
	public String main() {
		return "main";
	}
	
	@RequestMapping("/login.do")	// login.jsp로 이동
	public String login() {
		return "login";
	}
	
	@RequestMapping("/register.do")
	public String join() {
		return "join";
	}

	@RequestMapping("/content.do")
	public String content(@RequestParam("no") int no, Model model) {
		entire.updateView(no); 	//조회수 증가
		
		model.addAttribute("dto", entire.selectOne(no));	// 특정 레코드 가져오기
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("no", no);
		model.addAttribute("list", entireReply.selectList(map));	//특정 레코드 답변글 가져오기
		return "content";
	}
	
	@RequestMapping("entire.do")	// 전체 게시판 가져오기 
	public ModelAndView entire(@RequestParam int pageParam, ModelAndView mav) {
		// 전체 리스트 가져올 값들 준비
		int totalRecords = entire.getRecords();							//전체 페이지 수  = 전체 페이지 수 가져오기
		int page = pageParam;											//현제 페이지 (pageParam으로 받아옴)
		int rows = 20;													//한 페이지당 보여질 게시글
		int rowStart = (page * rows) - (rows -1);						//row시작
		int rowEnd = (page * rows);										//row끝
		int totalPages = (int)(Math.ceil(totalRecords / (double)rows));	//만들어져야할 페이지 수 
		int blocks = 5;													//보여질 페이지 번호
		int blockStart = (((page - 1) / blocks) * blocks) + 1;
		int blockEnd = (((page - 1) / blocks) * blocks) + blocks;
		
		if(blockEnd > totalPages) {										//block 마지막이 전체페이지 보다 크면 동기화
			blockEnd = totalPages;
		}
		
		// 전체 리스트 가져옴 + 모든 값들 entire.jsp로 넘겨주자
		// map에 담아서 넘겨줄 준비하기
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("rowStart", rowStart);
		map.put("rowEnd", rowEnd);
		
		mav.addObject("list", entire.selectList(map));
		mav.addObject("totalRecords", totalRecords);
		mav.addObject("totalPages", totalPages);
		mav.addObject("page", page);
		mav.addObject("rows", rows);
		mav.addObject("rowStart", rowStart);
		mav.addObject("rowEnd", rowEnd);
		mav.addObject("blocks", blocks);
		mav.addObject("blockStart", blockStart);
		mav.addObject("blockEnd", blockEnd);
		
		mav.setViewName("entire");
		return mav;
	}
	
	@RequestMapping("/entireSearch.do")
	public String entireSearch(@RequestParam String entireSearchType, @RequestParam String entireSearchData, @RequestParam int pageParam, Model model) {
		//검색종류, 검색어 map에 담아서 sql query로 전달
		Map<String, Object> map	 = new HashMap<String, Object>();
		map.put("entireSearchType", entireSearchType);
		map.put("entireSearchData", entireSearchData);
		
		int totalRecords = entire.getSearchByTypeRecords(map);
		
		// 페이징 처리 기본값 설정
		int page = pageParam;											//현제 페이지 (pageParam으로 받아옴)
		int rows = 20;													//한 페이지당 보여질 게시글
		int rowStart = (page * rows) - (rows -1);						//row시작
		int rowEnd = (page * rows);										//row끝
		int totalPages = (int)(Math.ceil(totalRecords / (double)rows));	//만들어져야할 전체 페이지 수 
		int blocks = 5;													//보여질 페이지 개수
		int blockStart = (((page - 1) / blocks) * blocks) + 1;			
		int blockEnd = (((page - 1) / blocks) * blocks) + blocks;
		
		if(blockEnd > totalPages) {										//block 마지막이 전체페이지 보다 크면 동기화
			blockEnd = totalPages;
		}
		
		// 모델 객체에 값들 넣어주기 --- *다음 페이지를 위해서 검색타입, 검색내용도 넘겨주기 (entireSearch.jsp 에서 똑같이 다시 넘겨줄 예정)
		// 검색해서 실제 게시물 가져올건때 범위지정
		map.put("rowStart", rowStart);
		map.put("rowEnd", rowEnd);
		
		model.addAttribute("list", entire.selectSearchData(map));
		model.addAttribute("totalRecords", totalRecords);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("page", page);
		model.addAttribute("rows", rows);
		model.addAttribute("rowStart", rowStart);
		model.addAttribute("rowEnd", rowEnd);
		model.addAttribute("blocks", blocks);
		model.addAttribute("blockStart", blockStart);
		model.addAttribute("blockEnd", blockEnd);
		model.addAttribute("entireSearchType", entireSearchType);
		model.addAttribute("entireSearchData", entireSearchData);
		
		return "entireSearch";
	}
	
	@RequestMapping("/replyUpdate.do")
	@ResponseBody
	public void replySave(HttpServletRequest request, Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("no", Integer.parseInt(request.getParameter("no")));
		map.put("e_reply_nickname", request.getParameter("e_reply_nickname").trim());
		map.put("e_reply_content", request.getParameter("e_reply_content"));
		entireReply.updateReply(map);
		//알아서 결과값 리턴해줌
	}
	
	@RequestMapping("/replyList.do")
	public ModelAndView replyList(@RequestParam int no, ModelAndView mav  ) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("no", no);
		
		mav.addObject("list", entireReply.selectList(map));
		mav.setViewName("reply/replyList");
		return mav;
	}
	
	@RequestMapping("/free.do")
	public String free() {
		return "free";
	}
}

















