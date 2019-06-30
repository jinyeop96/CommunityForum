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
//媛��엯 	
	@RequestMapping("/join_ok.do")
	public String joinok(JoinDTO dto, Model model) throws Exception {
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
		System.out.println(name);
		result.put("name", name);
		result.put("email", email);
		System.out.println(result.get("name"));
		  String id = join.searchId(result);
		  System.out.println(id);
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
	
	@RequestMapping("/memberinfo.do")
	public String memberinfo(HttpServletRequest request, HttpSession session, Model model) throws Exception{
		String nickname = (String) session.getAttribute("nickname");
		System.out.println(nickname);
		model.addAttribute("dto", join.memeberinfo(nickname)) ;

		return "memberinfo";
	}
	
	@RequestMapping("/memberupdate.do")
	public String memberupdate (HttpServletRequest request, HttpSession session, Model model) throws Exception{
		String nickname = (String) session.getAttribute("nickname");
		System.out.println(nickname);
		model.addAttribute("dto", join.memeberinfo(nickname)) ;
		return "memberupdate";
	}
	
	@RequestMapping("/memberupdateOK.do")
	public String updateOK(@RequestParam String id, @RequestParam String nickname, @RequestParam String email, Model model, HttpSession session) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println(id);
        map.put("id", id);
        map.put("nickname", nickname);
        map.put("email", email);
        System.out.println(map.get("id"));
        join.infoupdate(map);
        session.setAttribute("nickname", nickname);
        
		return "redirect:memberinfo.do";
	}
	
}
