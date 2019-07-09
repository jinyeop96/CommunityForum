package com.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.dao.NoticeDAOImpl;
import com.project.dto.NoticeDTO;


@Controller
public class GonggiController {
	@Autowired
	private NoticeDAOImpl noticeDao;
	
	
	@RequestMapping("/gonggi.do")	
	public String gonggi(Model model) throws Exception {
		
		List<NoticeDTO> list = noticeDao.noticeList();
		model.addAttribute("list",list);
		return "gonggi";
	}
	
	@RequestMapping(value="/gonggi.do/read.do/{seq}",method=RequestMethod.GET)
	public String readGonggi(Model model,@PathVariable int seq) throws Exception {
		model.addAttribute("NoticeDTO",noticeDao.noticeRead(seq));
		return "gonggiRead";
	}
	
	@RequestMapping(value="/gonggi.do/modify.do/{seq}",method=RequestMethod.GET)
	public String modifyGonngi(Model model, @PathVariable int seq) throws Exception {
		model.addAttribute("NoticeDTO",noticeDao.noticeRead(seq));
		return "gonggimodify";
	}
	
	@RequestMapping(value="/gonggiwriteUpdate",method=RequestMethod.POST)
	public String modifyGonngi(NoticeDTO dto) throws Exception {
		System.out.println("seq"+ dto.getSeq());
		System.out.println("content"+dto.getContent());
		System.out.println("title"+dto.getTitle());
		noticeDao.noticeUpdate(dto);
		return "redirect:/gonggi.do";
	}
	
	@RequestMapping(value="/gonggiwrite.do")
	public String gonggiWrite() {
		return "gonggiwrite";
	}
	
	@ResponseBody
	@RequestMapping(value="/gonggiDelete",method = RequestMethod.POST)
	public int gonggiDelete(int seq) throws Exception {
		return noticeDao.noticeDelete(seq);
	}
	
	@RequestMapping(value="gonggiwritePost.do",method=RequestMethod.POST)
	public String gonggiPost(NoticeDTO dto, RedirectAttributes rttr) {
		
		System.out.println("title : " + dto.getTitle());
		System.out.println("content : " + dto.getContent());
		int result = 0;
		try {
			result = noticeDao.noticeRegister(dto);
			if (result == 1) {
				rttr.addFlashAttribute("result","success");
			} else {
				rttr.addFlashAttribute("result","fail");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/gonggi.do";
	}
}
