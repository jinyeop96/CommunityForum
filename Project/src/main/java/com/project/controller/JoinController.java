package com.project.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
	BCryptPasswordEncoder bcryptEncoder;
	
	@Autowired
	public JoinDAOImpl join;
	
	
	@RequestMapping("/join.do")
	public String join() {
		return "join";
	}
//媛��엯 	
	@RequestMapping("/join_ok.do")
	public String joinok(JoinDTO dto, Model model) throws Exception {
		String inputpwd = dto.getPwd();
		String bcryptpwd = bcryptEncoder.encode(inputpwd);
		dto.setPwd(bcryptpwd);
		this.join.insert(dto);
		return "redirect:login.do";
	}
//�븘�씠�뵒 以묐났泥댄겕	
	@ResponseBody
	@RequestMapping("/idcheck.do")
	public  int checkId(String id) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		int result = join.findId(map);
		return result;
	}
//�땳�꽕�엫 以묐났 泥댄겕 	
	@ResponseBody
	@RequestMapping("/nickcheck.do")
	public  int checknick(String nickname) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("nickname", nickname);
		int result = join.findnick(map);
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/emailcheck.do")
	public  int checkemail(String email) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", email);
		int result = join.findemail(map);
		return result;
	}
	//�븘�씠�뵒 李얘린 �럹�씠吏�濡� �씠�룞
	@RequestMapping("/id_search.do")
	public String idsearch() {
		return "idsearch";
	}
	//�븘�씠�뵒 李얘린 寃곌낵
	@ResponseBody
	@RequestMapping("/searchIdOK.do")
	public String searchId(@RequestParam String name, @RequestParam String email) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("name", name);
		result.put("email", email);
		  String id = join.searchId(result);
		  System.out.println(id);
		return id;
	}
	
	//비밀번호 찾기 폼으로 이동
	@RequestMapping("pwd_search.do")
	public String pwdsearch() {
		return "pwdsearch";
	}
	
	//비밀번호 찾기폼에서 입력받은 id와 email을 기반으로 비밀번호값을 찾고 리턴
	@ResponseBody
	@RequestMapping("/searchpwdOK")
	public String searchpwd(@RequestParam String id, @RequestParam String email) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		String pwd = "";
		for(int i=0; i<12; i++) {
			pwd += (char)((Math.random()*26)+97);
		}
		String bcryptpwd = bcryptEncoder.encode(pwd);
		System.out.println(pwd);
		result.put("id", id);
		result.put("email", email);
		result.put("pwd", bcryptpwd);
		int num = join.searchpwd(result);
		System.out.println(result.get("pwd"));
		if(num == 0) {
			pwd ="";
			return pwd;
		}else {
			return pwd;
		}
	}
	
}
