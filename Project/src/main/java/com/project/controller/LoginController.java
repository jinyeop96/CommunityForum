package com.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.project.dao.LoginDAOImpl;

@Controller
public class LoginController {
	
	// DAOs
		@Autowired
		public LoginDAOImpl login;	// 로그인 DAO
}
