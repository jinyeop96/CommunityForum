package com.project.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.dto.Criteria;
import com.project.dto.PageDTO;
import com.project.dto.QnaDTO;
import com.project.dao.QnaDAOImpl;

@Controller
public class QnaController {
	
	@Autowired
	private QnaDAOImpl qnaDao;  //qna dao
	
	

	@RequestMapping("/allqna.do")	// qna 
	public String allqna() {
		return "qna_main";
	}

	@RequestMapping("/allqnalist.do")  //qna 리스트
	public String allqnaList(Criteria cri, Model model) throws Exception{
		
		//페이징 처리 
		model.addAttribute("pageMaker", new PageDTO(cri,qnaDao.qna_count()));	// (cri, qna_table의 레코드 수)

		model.addAttribute("list",qnaDao.qna_list(cri));
		return "qna_list";
	}
	
	@ResponseBody
	@RequestMapping("/qna_pwcheck")  //qna 비밀번호 확인
	public int qnapwcheck(String seq,String pw) throws Exception {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("seq",Integer.parseInt(seq)+1);
		map.put("pw",pw);
		System.out.println("seq"+seq);
		System.out.println("pw"+pw);
		return qnaDao.qna_pwcheck(map);		
		
	}
	
	@ResponseBody
	@RequestMapping("/allqna.do/qnainsert.do")  //qna 등록
	public int qndInsert(String content, String title, String pw) throws Exception{
		System.out.println("content " + content);
		System.out.println("title " + title);
		System.out.println("pw" + pw);
		QnaDTO qnaDTO = new QnaDTO();
		qnaDTO.setTitle(title);
		qnaDTO.setQna_content(content);
		qnaDTO.setPw(pw);
	
		return  qnaDao.qna_insert(qnaDTO);
		
	}
}
