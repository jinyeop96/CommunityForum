package com.project.controller;

import java.io.PrintWriter;
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
	//암호화를 위해 선언
	
	@Autowired
	public JoinDAOImpl join;
	
	
	@RequestMapping("/join.do")
	public String join() {
		return "join";
	}
    //회원가입페이지
 

	
	@RequestMapping("/join_ok.do")
	public void joinok(JoinDTO dto, Model model, HttpServletResponse response) throws Exception {
		// id,pwd,name,nickname,email값이 넘어오며 joindto로 자동매칭
		PrintWriter out = response.getWriter();
		//경고창과 페이지 이동을 위해 프린트라이터를 사용하기위해 선언해준다
		String inputpwd = dto.getPwd();
		// pwd암호화를 위해 dto에 자동매칭되있는 pwd를 inputpwd로 값을가져옴
		String bcryptpwd = bcryptEncoder.encode(inputpwd);
		//상위에 @Autowired되어있는 BCryptPasswordEncoder를 이용하여 비밀번호 암호화
		dto.setPwd(bcryptpwd);
		//암호화된 bcryptpwd를 다시 dto에 넣어준다
		this.join.insert(dto);
		//joindaoimple의 insert로 값들이 저장되어있는 dto를 넘겨준다
		out.println("<script>alert('JoinSuccess'); location.href='login.do';</script>");
		//경고창과 이동할 페이지 설정
		
	}
    //id중복 체크	
	@ResponseBody
	@RequestMapping("/idcheck.do")
	public  int checkId(String id) throws Exception{
		//join페이지 ajax에서 넘겨준 id값을 받아준다
		Map<String, Object> map = new HashMap<String, Object>();
		// Map에 넣어주기 위해 Map선언
		map.put("id", id);
		//"id"라는 키에 id값을 넣어준다
		int result = join.findId(map);
		//joindaoimple의 findId로 값들이 저장되어있는 map를 넘겨주고 결과값은 result변수에 넣어준다
		return result;
		//결과값이 들어간 result변수를 반환
	}
    //nickname중복 체크 	
	@ResponseBody
	@RequestMapping("/nickcheck.do")
	public  int checknick(String nickname) throws Exception{
		//join페이지 ajax에서 넘겨준 nickname값을 받아준다
		Map<String, Object> map = new HashMap<String, Object>();
		// Map에 넣어주기 위해 Map선언
		map.put("nickname", nickname);
		//"nickname"키에 nickname값을 넣어준다
		int result = join.findnick(map);
		//joindaoimple의 findnick로 값들이 저장되어있는 map를 넘겨주고 결과값은 result변수에 넣어준다
		return result;
		//결과값이 들어간 result변수 반환
	}
	
	//email중복 체크
	@ResponseBody
	@RequestMapping("/emailcheck.do")
	public  int checkemail(String email) throws Exception{
		//email중복 체크를 위해 넘어온 email값을 받아준다
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", email);
		//"email"키에 email값 넣어준다
		int result = join.findemail(map);
		//findemail에 map을 넘겨주어 결과값을 result변수에 넣어준다.
		return result;
		//결과값이 들어간 result를 반환해준다.
	}
	//ID찾기 페이지로 이동
	@RequestMapping("/id_search.do")
	public String idsearch() {
		return "idsearch";
	}
	//ID찾기
	@ResponseBody
	@RequestMapping("/searchIdOK.do")
	public String searchId(@RequestParam String name, @RequestParam String email) throws Exception{
		//아이디를 찾기위해 idsearch.jsp페이지에서 넘겨준값 name과 email파일을 넘겨받는다.
		Map<String, Object> result = new HashMap<String, Object>();
		//Map에 넘어온값을 넣기 위해 선언
		result.put("name", name);
		//name키에 name값을 넣어준다
		result.put("email", email);
		//email키에 email값을 넣어준다.
		  String id = join.searchId(result);
		//값이 들어가있는 result를 joinimpl에 있는 searchId로 넘겨주고 결과 값 (찾은 ID)를 받아준다.
		return id;
		//받아준 id를 idsearch.jsp로 넘져준다
	}
	
	//비밀번호 찾기 폼으로 이동
	@RequestMapping("pwd_search.do")
	public String pwdsearch() {
		return "pwdsearch";
	}
	
	//비밀번호 찾기폼
	@ResponseBody
	@RequestMapping("/searchpwdOK")
	public String searchpwd(@RequestParam String id, @RequestParam String email) throws Exception{
		//비밀번호를 찾기위한 id와 email입력값을 받아준다
		Map<String, Object> result = new HashMap<String, Object>();
		//id와 email를 넣어줄 Map을 선언
		String pwd = "";
		//비밀번호가 들어갈 변수 선언
		for(int i=0; i<12; i++) {
			pwd += (char)((Math.random()*26)+97);
		}
		//랜덤 비밀번호 생성하여 pwd변수에 저장
		String bcryptpwd = bcryptEncoder.encode(pwd);
		//for문에서 생성된 임시비밀번호를 암호화하여 bcryptpwd에 저장
		result.put("id", id);
		result.put("email", email);
		result.put("pwd", bcryptpwd);
		//임시비밀번호를 발급해주기위한 id값과 email값을 mapping 및 해당 id와 email값이 있는 열에 있는 pwd에 입력해줄 암호화된 bcryptpwd값을 넣어준다.
		int num = join.searchpwd(result);
		//joinImpl에 있는 searchpwd에 값들이 들어가있는 result를 넘겨주고 쿼리 실행값을 num변수로 받아온다
		
		if(num == 0) {
			pwd ="";
			return pwd;
			//searchpwd의 결과값이 0일때 pwd를 ""초기화하고 리턴해준다
		}else {
			return pwd;
			//searchpwd의 결과값이 0이 아닐때 위에 생성된 임시 비밀번호값이 들어가 있는 pwd를 반환
		}
	}
	
}
