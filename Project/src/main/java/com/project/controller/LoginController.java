package com.project.controller;




import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.dao.LoginDAOImpl;
import com.project.dto.JoinDTO;

@Controller
public class LoginController {
	
	// DAOs
		@Autowired
		public LoginDAOImpl login;	// 로그인 DAO
		
		
		@RequestMapping("/loginok.do")
		public String userlogin(@RequestParam String j_id,@RequestParam String j_pwd, HttpSession session) throws Exception{
			System.out.println("넘어온값 ="+j_id);
			System.out.println("넘어온값 ="+j_pwd);
			Map<String, Object> result = new HashMap<String, Object>();
			result.put("j_id", j_id);
			result.put("j_pwd", j_pwd);
			System.out.println("매핑후 결과값 ="+result.get("j_id"));
			System.out.println("매핑후 결과값 ="+result.get("j_pwd"));
			JoinDTO sucess = login.selectUser(result);
			if(sucess != null) {
				String id = sucess.getJ_id();
				String pwd = sucess.getJ_pwd();
				String phone = sucess.getJ_mobile();
				
				System.out.println("쿼리후 결과값 ="+id);
				System.out.println("쿼리후 결과값 ="+pwd);
				System.out.println("쿼리후 결과값 ="+phone);
				
				session.setAttribute("memberinfo", sucess);
				
				return "Logintrue";
				
				
				
			}else {
				JOptionPane.showMessageDialog(null, "아이디와 비밀번호를 확인해주세요", "경고",JOptionPane.INFORMATION_MESSAGE);

				return "login";
			}
			
				
		}
}
