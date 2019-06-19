package com.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class FrontController {
	
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

	@RequestMapping("/free.do")
	public String free() {
		return "free";
	}
}

















