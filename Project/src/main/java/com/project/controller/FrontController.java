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

	@RequestMapping("/free.do")
	public String free() {
		return "free";
	}
	
	@RequestMapping("/OwyMember.do") 
	public String OwyMember() {
		return "OwyMember";
	}
	
	@RequestMapping("/plan.do")
	public String plan() {
		return "plan";
	}
	
	@RequestMapping("/future.do")
	public String future() {
		return "future";
	}
	
	@RequestMapping("/contents.do")
	public String contents() {
		return "contents";
	}
	
	@RequestMapping("/hotel.do")
	public String hotel() {
		return "hotel";
	}
	
	@RequestMapping("/restaurant.do")
	public String restaurant(){
		return "restaurant";
	}
	
	@RequestMapping("/transport.do")
	public String transport() {
		return "transport";
	}
}

















