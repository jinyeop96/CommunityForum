package com.project.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.dao.LoginDAOImpl;
import com.project.dto.JoinDTO;


@Controller
public class LoginController {
	
	// DAOs
		@Autowired
		public LoginDAOImpl login;	// 로그인 DAO
		@Autowired
		BCryptPasswordEncoder passEncoder; //비밀번호 암호화를 위해 필요
		
		
		
		@RequestMapping("/loginok.do")
		public String userlogin(JoinDTO dto, HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception{
			 	
			JoinDTO logindto = login.selectUser(dto);	// id, pwd 로 멤버 가져옴
			
			boolean passmatch = passEncoder.matches(dto.getPwd(), logindto.getPwd()); //기존 dto에 들어가있는 pwd와 결과값으로 받아온 pwd의 암호화 입력값이 같은지 확인
			if(logindto != null && passmatch) {	// 가져온게 있을 때
				session.setAttribute("nickname", logindto.getNickname());
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
		//회원정보 보기
		//필요한 정보를 가져오기 위한 session에 저장된 닉네임을 가져와서 쿼리문에 대입하여 정보를 가져온다
		@RequestMapping("/memberinfo.do")
		public String memberinfo(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model) throws Exception{
			String nickname = (String) session.getAttribute("nickname");
			model.addAttribute("dto", login.memeberinfo(nickname)) ;
			return "memberinfo";
		}
		
		//회원정보 수정 페이지로 이동
		@RequestMapping("/memberupdate.do")
		public String memberupdate (HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model) throws Exception{
			String nickname = (String) session.getAttribute("nickname");
			model.addAttribute("dto", login.memeberinfo(nickname)) ;
			return "memberupdate";
		}
		
		//회원정보 수정 최종 메서드
		//수정폼에서 입력받은 이메일과 닉네임을 히든값으로 넘어온 id를 기반으로 업데이트 / DB에 닉네임이 변경되있음으로 세션의 닉네임도 새로 설정해주고 
		//회원정보 보기 폼으로 이동
		@RequestMapping("/memberupdateOK.do")
		public String updateOK(@RequestParam String id, @RequestParam String nickname, @RequestParam String email, Model model, HttpSession session) throws Exception {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", id);
	        map.put("nickname", nickname);
	        map.put("email", email);
	        login.infoupdate(map);
	        session.setAttribute("nickname", nickname);
	        return "redirect:memberinfo.do";
		}
		
		@RequestMapping("/member_pwdchange.do")
		public String pwdchange(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model) throws Exception{
			String nickname = (String) session.getAttribute("nickname");
			model.addAttribute("dto", login.memeberinfo(nickname)) ;
			return "pwdchange";
		}
		
		@RequestMapping("/pwdchangeOK.do")
		public void pwdchangeok(JoinDTO dto, Model model, HttpServletResponse response) throws Exception{
			PrintWriter out = response.getWriter();
			String inputpwd = dto.getPwd();
			String bcryptpwd = passEncoder.encode(inputpwd);
			dto.setPwd(bcryptpwd);
			login.changepwd(dto);
			out.println("<script>alert('Pass word change Success'); location.href='memberinfo.do';</script>");
		}
		
		
		
		@RequestMapping("/member_withraw.do")
		public String memberwithraw(HttpSession session, Model model) throws Exception{
			String nickname = (String)session.getAttribute("nickname");
			model.addAttribute("dto", login.memeberinfo(nickname)) ;
			return "memberwithraw";
		}
		
		@RequestMapping("/memberwithrawOK.do")
		public void withrawOK (JoinDTO dto, Model model, HttpServletResponse response, HttpSession session) throws Exception{
			
			JoinDTO memdto = login.selectUser(dto);
			PrintWriter out = response.getWriter();
			boolean passmatch = passEncoder.matches(dto.getPwd(), memdto.getPwd());
			if(memdto != null&&passmatch) {
				login.withraw(dto);
				out.println("<script>alert('Member withdraw Success'); location.href='main.do';</script>");
				session.invalidate();
			}else {
				out.println("<script>alert('Wrong Password'); location.href='member_withraw.do';</script>");
			}
		}
}
