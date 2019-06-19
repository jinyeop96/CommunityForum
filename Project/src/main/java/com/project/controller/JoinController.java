package com.project.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.dao.JoinDAOImpl;
import com.project.dto.JoinDTO;

@Controller
public class JoinController {
	
	@Autowired
	public JoinDAOImpl join;
	
	
	@RequestMapping("/join.do")
	public String join() {
		return "join";
	}
	
	@RequestMapping("/join_ok.do")
	public String joinok(JoinDTO dto, Model model) throws Exception {
		this.join.insert(dto);
		
		return "redirect:login.do";
	}
	
	@ResponseBody
	@RequestMapping("/idcheck.do")
	public  int checkId(String j_id) throws Exception{
		System.out.println("펑션에서 넘어온값 ="+j_id);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("j_id", j_id);
		System.out.println("MAP구조형으로 변환된값 ="+j_id);
		int result = join.findId(map);
		System.out.println("매핑후 결과값 ="+result);
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/nickcheck.do")
	public  int checknick(String j_nickname) throws Exception{
		System.out.println("펑션에서 넘어온값 ="+j_nickname);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("j_nickname", j_nickname);
		System.out.println("MAP구조형으로 변환된값 ="+j_nickname);
		int result = join.findnick(map);
		System.out.println("매핑후 결과값 ="+result);
		return result;
	}
}
