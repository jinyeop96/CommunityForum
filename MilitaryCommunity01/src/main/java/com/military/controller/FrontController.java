package com.military.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.military.dao.EntireDAO;
import com.military.dao.EntireDAOImpl;
import com.military.dao.LoginDAOImpl;

@Controller
public class FrontController {
	
	// DAOs
	@Autowired
	public LoginDAOImpl login;	// 로그인 DAO
	
	@Autowired
	public EntireDAOImpl entire;	// 전체 게시판 DAO
	
	// get requests
	@RequestMapping("/main.do")	// index.jsp -> main.jsp
	public String main() {
		return "main";
	}
	
	@RequestMapping("/login.do")	// 로그인화면으로 이동
	public String login() {
		return "login";
	}
	
	@RequestMapping("entire.do")	// 전체 게시판 가져오기 
	public String entire(@RequestParam int pageParam, Model model) {
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
		
		model.addAttribute("list", entire.selectList(rowStart));
		model.addAttribute("totalRecords", totalRecords);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("page", page);
		model.addAttribute("rows", rows);
		model.addAttribute("rowStart", rowStart);
		model.addAttribute("rowEnd", rowEnd);
		model.addAttribute("blocks", blocks);
		model.addAttribute("blockStart", blockStart);
		model.addAttribute("blockEnd", blockEnd);
		
		return "entire";
	}

	@RequestMapping("/content.do")
	public String content(@RequestParam int no, Model model) {
		model.addAttribute("dto", entire.selectOne(no));
		return "content";
	}

}

















