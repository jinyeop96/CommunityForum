package com.project.controller;

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

import com.project.dao.EntireDAOImpl;
import com.project.dao.EntireReplyDAOImpl;
import com.project.dto.Pagination;

@Controller
public class EntireBoardController {
	
	@Autowired
	public EntireDAOImpl entire;	// 전체 게시판 DAO
	
	@Autowired
	public EntireReplyDAOImpl entireReply;
	
	Pagination pagination;
	Map<String, Object> map;
	
	@RequestMapping("/content.do")
	public String content(@RequestParam("no") int no, Model model) {
		entire.updateView(no); 	//조회수 증가
		
		model.addAttribute("dto", entire.selectOne(no));	// 특정 레코드 가져오기
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("no", no);
		model.addAttribute("list", entireReply.selectList(map));	//특정 레코드 답변글 가져오기
		return "content";
	} ///content.do
	
	@RequestMapping("/entire.do")	// 전체 게시판 가져오기 
	public String entire(@RequestParam int pageParam, Model model) {
		pagination = new Pagination(entire.getRecords(), pageParam);	// (전체레코드 수, 페이지 번호)
		
		map = new HashMap<String, Object>();
		map.put("rowStart", pagination.getRowStart());
		map.put("rowEnd", pagination.getRowEnd());
		
		model.addAttribute("list", entire.selectList(map));
		model.addAttribute("page", pagination);
		
		return "entire";
	} //entire.do
	
	@RequestMapping("/entireSearch.do")
	public String entireSearch(@RequestParam String entireSearchType, @RequestParam String entireSearchData, @RequestParam int pageParam, Model model) {
		//검색종류, 검색어 map에 담아서 sql query로 전달
		map	= new HashMap<String, Object>();
		map.put("entireSearchType", entireSearchType);
		map.put("entireSearchData", entireSearchData);
		
		pagination = new Pagination(entire.getSearchByTypeRecords(map), pageParam);	//
		
		// 모델 객체에 값들 넣어주기 --- *다음 페이지를 위해서 검색타입, 검색내용도 넘겨주기 (entireSearch.jsp 에서 똑같이 다시 넘겨줄 예정)
		map.put("rowStart", pagination.getRowStart());
		map.put("rowEnd", pagination.getRowEnd());
		
		model.addAttribute("list", entire.selectSearchData(map));
		model.addAttribute("page", pagination);
		model.addAttribute("entireSearchType", entireSearchType);
		model.addAttribute("entireSearchData", entireSearchData);
		
		return "entireSearch";
	} //entireSearch.do
	
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
}
