package com.project.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.project.dao.*;
import com.project.dto.Pagination;

@Controller
public class BoardController {
	
	@Autowired
	public BoardDAOImpl board;	// 전체 게시판 DAO
	
	@Autowired 
	public ReplyDAOImpl reply;
	 
	
	Pagination pagination;
	Map<String, Object> map = new HashMap<String, Object>();

	// 전체 게시판 가져오기
	@RequestMapping("/board.do")	 
	public String entire(@RequestParam int pageParam, @RequestParam String board_type, Model model) {
		pagination = new Pagination(board.getRecords(board_type), pageParam);	// (전체레코드 수, 페이지 번호)
		
		map.put("rowStart", pagination.getRowStart());
		map.put("rowEnd", pagination.getRowEnd());
		map.put("board_type", board_type);
		
		model.addAttribute("list", board.selectList(map));
		model.addAttribute("page", pagination);
		model.addAttribute("board_type", board_type);
		
		return "board";
	} //entire.do
	
	
	// 글 작성으로 이동
	@RequestMapping("/boardWrite.do")
	public String boardWrite(@RequestParam String board_type, Model model) {
		model.addAttribute("board_type", board_type);
		return "boardWrite";
	}
	
	// 글 작성 완료
	@RequestMapping("/boardWriteOk.do")
	public String writeEntireOk(HttpServletRequest request, Model model) {
		map.put("board_title", request.getParameter("board_title").trim());
		map.put("board_content", request.getParameter("board_content"));
		map.put("board_nickname", request.getParameter("board_nickname").trim());
		map.put("board_pwd", request.getParameter("board_pwd").trim());
		map.put("board_type", request.getParameter("board_type"));
		
		
		board.insertRecord(map);
		
		return "redirect:board.do?pageParam="+1+"&board_type="+request.getParameter("board_type");
	}
	
	// 글 찾기
	@RequestMapping("/boardSearch.do")
	public String entireSearch(HttpServletRequest request, Model model) {
		//검색종류, 검색어 map에 담아서 sql query로 전달
		map.put("searchType", request.getParameter("searchType"));
		map.put("searchData", request.getParameter("searchData"));
		map.put("board_type", request.getParameter("board_type"));
		
		pagination = new Pagination(board.getRecordsBySerachType(map), Integer.parseInt(request.getParameter("pageParam")));
		
		// 모델 객체에 값들 넣어주기 --- *다음 페이지를 위해서 검색타입, 검색내용도 넘겨주기 (entireSearch.jsp 에서 똑같이 다시 넘겨줄 예정)
		map.put("rowStart", pagination.getRowStart());
		map.put("rowEnd", pagination.getRowEnd());
		
		model.addAttribute("board_type", request.getParameter("board_type"));
		model.addAttribute("list", board.selectSearchData(map));
		model.addAttribute("page", pagination);
		model.addAttribute("searchType", request.getParameter("searchType"));
		model.addAttribute("searchData", request.getParameter("searchData"));
		
		return "boardSearch";
	} //entireSearch.do
	

	@RequestMapping("/content.do")
	public String content(@RequestParam int board_no, Model model) {
		board.updateView(board_no); 	//조회수 증가
		
		model.addAttribute("dto", board.selectOne(board_no));	// 해당 게시물 가져오기
		model.addAttribute("replyNum", reply.getRecords(board_no));	// 해당 게시물의 답글 수 가져오기
		
		return "boardContent";
	} ///content.do
	
	
	///////////////////////답변 관련///////////////////////////////

	//해당 글 답변 가져오기
	@RequestMapping("/replyList.do")
	public ModelAndView replyList(@RequestParam int board_no, @RequestParam int pageParam, ModelAndView mav  ) {
		pagination = new Pagination(reply.getRecords(board_no), pageParam, 10, 5);	// 10rows, 5 blocks
		
		map.put("rowStart", pagination.getRowStart());
		map.put("rowEnd", pagination.getRowEnd());
		map.put("board_no", board_no);
		
		
		mav.addObject("list", reply.selectList(map));
		mav.addObject("page", pagination);
		mav.addObject("replyNum", reply.getRecords(board_no));
		mav.setViewName("reply/replyList");
		return mav;
	}
	
	// 답변 쓰기
	@RequestMapping("/replyUpdate.do")
	@ResponseBody
	public void replyUpdate(HttpServletRequest request) {
		map.put("board_no", Integer.parseInt(request.getParameter("board_no")));
		map.put("reply_nickname", request.getParameter("reply_nickname").trim());
		map.put("reply_content", request.getParameter("reply_content"));
		
		reply.updateReply(map);
		//알아서 결과값 리턴해줌
	}
	
	
	// 좋아요
	@RequestMapping("/updateLike.do")
	@ResponseBody
	public void updateLike(@RequestParam int reply_no) {
		reply.updateLike(reply_no);
	}
	
	//싫어요
	@RequestMapping("/updateDislike.do")
	@ResponseBody
	public void updateDislike(@RequestParam int reply_no) {
		reply.updateDislike(reply_no);
	}

	
}
