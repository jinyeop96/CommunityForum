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
		public void userlogin(JoinDTO dto, HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception{
			//로그인위해 dto에 id,pwd를 자동 매칭
			PrintWriter out = response.getWriter();
            //경고창 띄우기 위해 선언
			JoinDTO logindto = login.selectUser(dto);
			// 매칭된 dto를 selectUser로 넘겨주어 결과값을 logindto에 저장
			boolean passmatch = false;
			if(logindto == null) {
				out.println("<script>alert('NOT FOUND ID');location.href='login.do';</script>");
				//selectUser에서 값을 못가져온경우(아이디를 못찾은 경우)
				//경고창 및 로그인 페이지로 이동

			}else {
				//selectUser에서 값을 가져온경우(아이디를 찾은 경우)
				passmatch = passEncoder.matches(dto.getPwd(), logindto.getPwd());
				//DB에 저장된 pwd와 로그인시 입력한 pwd가 match하는지 확인
				if(logindto != null&&passmatch) {
					// logindto가 값을 갖고있으며 비밀번호 암호화값이 같다면
					session.setAttribute("nickname", logindto.getNickname());
					//session에 nickname키에 결과값으로 받아온 logindto의 nickname을 넣어준다
					out.println("<script>location.href='main.do';</script>");
					// 메인페이지로 이동	
				}else {
					out.println("<script>alert('WRONG PASSWORD');location.href='login.do';</script>");
					// pwd가 틀려서 logindto에 결과값이 없을때

					
			}
		}
	}
	
		
		@RequestMapping("logout.do")
		public String logout(HttpSession session, HttpServletRequest request) {
			session.invalidate();
			//sesiion에 저장된 값들을 초기화
			return "redirect:"+request.getHeader("Referer");	
			// 로그아웃 한 페이지로 다시 돌아감.
		}
		//회원정보 보기

		@RequestMapping("/memberinfo.do")
		public String memberinfo(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model) throws Exception{
			//필요한 정보를 가져오기 위한 session에 저장된 닉네임을 가져와서 쿼리문에 대입하여 정보를 가져온다
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
		//수정폼에서 입력받은 이메일과 닉네임을 히든값으로 넘어온 id를 기반으로 업데이트 / DB에 닉네임이 변경되있음으로 세션의 닉네임도 새로 설정해준다
		//회원정보 보기 폼으로 이동
		@RequestMapping("/memberupdateOK.do")
		public void updateOK(@RequestParam String id, @RequestParam String nickname, @RequestParam String email, Model model, HttpServletResponse response, HttpSession session) throws Exception {
			PrintWriter out = response.getWriter();
			//경고창 및 페이지 이동을 위한 PrintWriter선언
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", id);
	        map.put("nickname", nickname);
	        map.put("email", email);
	        //memberupdate.jsp에서 넘어온 id,nickname,email값을 map에 넣어준다
	        login.infoupdate(map);
	        //loginimpl의 infoupdate에 값이 들어있는 map을 넘겨준다.
	        session.setAttribute("nickname", nickname);
	        //DB 닉넴이 변경되었으므로 세션 닉넴이도 값 변경
	        out.println("<script>alert('UPDATE SUCCESS'); location.href='memberinfo.do';</script>");
	        //수정완료 경고창과 페이지 이동
		}
		
		//비밀번호 변경페이지로 이동
		@RequestMapping("/member_pwdchange.do")
		public String pwdchange(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model) throws Exception{
			String nickname = (String) session.getAttribute("nickname");
			model.addAttribute("dto", login.memeberinfo(nickname)) ;
			return "pwdchange";
		}
		//비밀번호 변경 페이지
		@RequestMapping("/pwdchangeOK.do")
		public void pwdchangeok(JoinDTO dto, Model model, HttpServletResponse response) throws Exception{
			PrintWriter out = response.getWriter();
			//경고창 및 페이지 이동을 위한 PrintWriter선언
			String inputpwd = dto.getPwd();
			//입력받은 pwd를 변수에 저장
			String bcryptpwd = passEncoder.encode(inputpwd);
			//변수에 저장되있는 pwd를 암호화한다
			dto.setPwd(bcryptpwd);
			//암호화된 pwd를 dto의 pwd에 넣어준다
			login.changepwd(dto);
			//비밀번호 변경 메서드로 dto값을 넘겨준다
			out.println("<script>alert('Pass word change Success'); location.href='memberinfo.do';</script>");
	        //변경완료 경고창과 페이지 이동
		}
		
		//회원 탈퇴 페이지로 이동
		@RequestMapping("/member_withraw.do")
		public String memberwithraw(HttpSession session, Model model) throws Exception{
			String nickname = (String)session.getAttribute("nickname");
			model.addAttribute("dto", login.memeberinfo(nickname)) ;
			return "memberwithraw";
		}
		//회원 탈퇴 페이지		
		@RequestMapping("/memberwithrawOK.do")
		public void withrawOK (JoinDTO dto, Model model, HttpServletResponse response, HttpSession session) throws Exception{
			//탈퇴시 암호 확인을 위해 회원정보를 가져오기 위해 dto값을 받는다
			JoinDTO memdto = login.selectUser(dto);
			//넘겨받은 dto값으로 회원정보를 가져오고 넘어온 결과값은 암화확인을 위해 memdto에 저장한다
			PrintWriter out = response.getWriter();
			//경고창 및 페이지 이동을 위한 PrintWriter선언
			boolean passmatch = passEncoder.matches(dto.getPwd(), memdto.getPwd());
			//탈퇴페이지에서 받은 pwd값과 DB에 저장되있는 pwd값이 동일한지 확인한다.
			if(memdto != null&&passmatch) {
				//회원정보가 있고 비밀번호가 동일하다면
				login.withraw(dto);
				//회원테이블 삭제 메서드로 이동
				out.println("<script>alert('Member withdraw Success'); location.href='main.do';</script>");
				//삭제 완료 메세지와 페이지이동
				session.invalidate();
				//회원이 탈퇴되었으므로 session의 값 삭제
			}else {
				out.println("<script>alert('Wrong Password'); location.href='member_withraw.do';</script>");
				//회원 정보가 없거나 pwd가 불일치할경우 경고창과 페이지이동
			}
		}
}
