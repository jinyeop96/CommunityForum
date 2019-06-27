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
	public  int checkId(String id) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		int result = join.findId(map);
		return result;
	}
//닉네임 중복 체크 	
	@ResponseBody
	@RequestMapping("/nickcheck.do")
	public  int checknick(String nickname) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("nickname", nickname);
		int result = join.findnick(map);
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
	public String searchId(@RequestParam String name, @RequestParam String email) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("name", name);
		result.put("email", email);
		  String id = join.searchId(result);
		return id;
	}
	
	@RequestMapping("pwd_search.do")
	public String pwdsearch() {
		return "pwdsearch";
	}
	
	@ResponseBody
	@RequestMapping("/searchpwdOK")
	public String searchpwd(@RequestParam String id, @RequestParam String email) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("id", id);
		result.put("email", email);
		String pwd = join.searchpwd(result);
		return pwd;
	}
	
}
