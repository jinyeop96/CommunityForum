package com.project.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.dao.LoginDAOImpl;

@Controller
public class LoginController {
	
	// DAOs
		@Autowired
		public LoginDAOImpl login;	// 로그인 DAO
		
		
		@RequestMapping("/loginok.do")
		public String userlogin(@RequestParam String id,@RequestParam String pwd, HttpSession session, Model model) throws Exception{
			Map<String, Object> result = new HashMap<String, Object>();
			result.put("id", id);
			result.put("pwd", pwd);
			
			String nickname = login.selectUser(result);	// id, pwd 로 멤버 가져옴
			
			
			if(nickname != null) {	// 가져온게 있을 때
				session.setAttribute("nickname", nickname);
				return "redirect:main.do";
			}else {
				
				model.addAttribute("msg", "다시 한번 확인해주세요.");
				
				return "login";
			}
		}
		
		@RequestMapping("logout.do")
		public String logout(HttpSession session, HttpServletRequest request) {
			session.invalidate();
			return "redirect:"+request.getHeader("Referer");	// 로그아웃 한 페이지로 다시 돌아감.
		}
}
