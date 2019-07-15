package com.project.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.dao.*;
import com.project.dto.*;
import com.project.service.FileService;

@Controller
public class ReplyController {
	
	@Autowired 
	public ReplyDAOImpl reply;
	
	@Autowired
	public FileService fileService;
	
	@Resource(name="uploadPath")
	String uploadPath;
	
	
	Pagination pagination;
	Map<String, Object> map = new HashMap<String, Object>();
	
	//해당 글 답변 가져오기
		@RequestMapping("/replyList.do")
		public ModelAndView replyList(@RequestParam int board_no, @RequestParam int pageParam, ModelAndView mav  ) {
			pagination = new Pagination(reply.getRecords(board_no), pageParam, 10, 5);	// 10rows, 5 blocks
			
			map.put("rowStart", pagination.getRowStart());
			map.put("rowEnd", pagination.getRowEnd());
			map.put("board_no", board_no);
			
			
			mav.addObject("list", reply.selectList(map));
			mav.addObject("page", pagination);
			mav.addObject("pageParam", pageParam);
			mav.addObject("replyNum", reply.getRecords(board_no));
			mav.setViewName("ajax/replyList");
			return mav;
		}
		
		// 답변 쓰기
		@RequestMapping("/replyUpdate.do")
		@ResponseBody
		public void replyUpdate(HttpServletRequest request) {
			map.put("board_no", Integer.parseInt(request.getParameter("board_no")));
			map.put("reply_nickname", request.getParameter("reply_nickname").trim());
			map.put("reply_content", request.getParameter("reply_content")); 
			
			reply.updateReply(map);
		}

		// 답변 삭제
		@RequestMapping("/replyDelete.do")
		@ResponseBody
		public void replyDelete(HttpServletRequest request) {
			map.put("reply_no", Integer.parseInt(request.getParameter("reply_no")));
			
			reply.deleteReply(map);
			//알아서 결과값 리턴해줌
		}

		@RequestMapping("/replyEditOk.do")
		@ResponseBody
		public void replyEditOk(HttpServletRequest request) {
			map.put("reply_no", Integer.parseInt(request.getParameter("reply_no")));
			map.put("reply_content", request.getParameter("reply_content"));
			
			reply.editReplyOk(map);
			//알아서 결과값 리턴해줌
		}
		
}
