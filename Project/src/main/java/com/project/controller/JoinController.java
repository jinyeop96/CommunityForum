package com.project.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

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
//가입 	
	@RequestMapping("/join_ok.do")
	public String joinok(JoinDTO dto, Model model) throws Exception {
		this.join.insert(dto);
		return "redirect:login.do";
	}
//아이디 중복체크	
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
//닉네임 중복 체크 	
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
	//아이디 찾기 페이지로 이동
	@RequestMapping("/id_search.do")
	public String idsearch() {
		return "idsearch";
	}
	//아이디 찾기 결과
	@ResponseBody
	@RequestMapping("/searchIdOK.do")
	public String searchId(@RequestParam String j_name, @RequestParam String j_mobile) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("j_name", j_name);
		result.put("j_mobile", j_mobile);
		
		System.out.println("매핑후 결과값 ="+result.get("j_name"));
		System.out.println("매핑후 결과값 ="+result.get("j_mobile"));
		  String id = join.searchId(result);
		 
		
		System.out.println("sql후 결과값 ="+id);
		return id;
	}
	
	@RequestMapping("pwd_search.do")
	public String pwdsearch() {
		return "pwdsearch";
	}
	
	@ResponseBody
	@RequestMapping("/searchpwdOK")
	public String searchpwd(@RequestParam String j_id, @RequestParam String j_mobile) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("j_id", j_id);
		result.put("j_mobile", j_mobile);
		
		System.out.println("매핑후 결과값 ="+result.get("j_id"));
		System.out.println("매핑후 결과값 ="+result.get("j_mobile"));
		  String pwd = join.searchpwd(result);
		 
		
		System.out.println("sql후 결과값 ="+pwd);
		return pwd;
	}
	
}
