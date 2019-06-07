package com.military.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.military.loginDao.LoginDAOImpl;

@Controller
public class FrontController {
	
	@Autowired
	public LoginDAOImpl dao;
	
	@RequestMapping("/main.do")
		public String main() {
			return "main";
		}
	
	@RequestMapping("/login.do")
	public String login() {
		return "login";
	}
}
