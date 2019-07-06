package com.project.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.ResponseBody;


import com.project.dao.LoginDAOImpl;
import com.project.dao.QnaDAOImpl;
import com.project.dto.Criteria;
import com.project.dto.PageDTO;
import com.project.dto.QnaDTO;

@Controller
public class QnaController {
	
	// DAOs
	@Autowired
	public LoginDAOImpl login;	// 嚥≪뮄�젃占쎌뵥 DAO
	


	
	
	@Autowired
	private QnaDAOImpl qnaDao;  //qna dao
	

	

	@RequestMapping("/allqna.do")	// qna 
	public String allqna() {
		return "qna_main";
	}

	@RequestMapping("/allqnalist.do")  //qna 由ъ뒪�듃
	public String allqnaList(Criteria cri, Model model) throws Exception{
		
		//�럹�씠吏� 泥섎━ 
		System.out.println("type"+cri.getKeyword());
		System.out.println("gopgo"+cri.getType());
		model.addAttribute("pageMaker", new PageDTO(cri,qnaDao.qna_count(cri)));

		model.addAttribute("list",qnaDao.qna_list(cri));
		return "qna_list";
	}
	
	@ResponseBody
	@RequestMapping("/qna_pwcheck")  //qna 鍮꾨�踰덊샇 �솗�씤
	public int qnapwcheck(String seq,String pw) throws Exception {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("seq",Integer.parseInt(seq));
		map.put("pw",pw);
		System.out.println("seq"+seq);
		System.out.println("pw"+pw);
		return qnaDao.qna_pwcheck(map);		
		
	}
	
	@ResponseBody
	@RequestMapping("/allqna.do/qnainsert.do")  //qna �벑濡�
	public int qndInsert(String content, String title, String name, String pw) throws Exception{
		System.out.println("content " + content);
		System.out.println("name" + name);
		System.out.println("title " + title);
		System.out.println("pw" + pw);
		QnaDTO qnaDTO = new QnaDTO();
		qnaDTO.setTitle(title);
		qnaDTO.setName(name);
		qnaDTO.setQna_content(content);
		qnaDTO.setPw(pw);
	
		return  qnaDao.qna_insert(qnaDTO);
		
	}

	//�궗�슜�옄 qna �닔�젙
	@ResponseBody
	@RequestMapping("allqnalist.do/qnamodify.do") 
	public int qnaModify(String seq, String content) throws Exception {
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("seq",Integer.parseInt(seq));
		map.put("content",content);
		
		return qnaDao.qnaModify(map);
	}
	
	//�궗�슜�옄 qna �궘�젣
	@ResponseBody
	@RequestMapping("allqnalist.do/qnaUserdelete")
	public int qnaUserDelete(String seq) throws Exception {
	
		return qnaDao.qnaUserDelete(Integer.parseInt(seq));
	}
	
	
	//愿�由ъ옄 �떟湲� �벑濡�
	@ResponseBody
	@RequestMapping(value="/allqnalist.do/adminreply.do")
	public int adminreply(String seq,String reply) throws Exception {
		System.out.println("seq" + seq);
		System.out.println("reply" + reply);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("seq",Integer.parseInt(seq));
		map.put("reply",reply);

		return qnaDao.insertReply(map);
	}
	
	//愿�由ъ옄 吏덈Ц �궘�젣
	@ResponseBody
	@RequestMapping("/allqnalist.do/qna_delete")
	public int qnadelete(String seq) throws Exception {
	
		return qnaDao.AdmindeleteQna(Integer.parseInt(seq));
	}
	
	
}

















