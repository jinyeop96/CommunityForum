package com.project.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.dao.*;
import com.project.dto.*;

@Controller
public class ReplyController {
	
	@Autowired 
	public ReplyDAOImpl reply;
	
	@Autowired
	public FileService fileService;
	
	@Autowired
	private RecommendService recommendService;
	
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
			mav.addObject("replyNum", reply.getRecords(board_no));
			mav.setViewName("ajax/replyList");
			return mav;
		}
		
		// 답변 쓰기
		@RequestMapping("/replyUpdate.do")
		@ResponseBody
		public int replyUpdate(HttpServletRequest request) {
			map.put("board_no", Integer.parseInt(request.getParameter("board_no")));
			map.put("reply_nickname", request.getParameter("reply_nickname").trim());
			map.put("reply_content", request.getParameter("reply_content")); 
			
			reply.updateReply(map);
			int pageParam = Integer.parseInt(request.getParameter("pageParam"));
			
			return pageParam;
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
		
		
		// 좋아요
		@RequestMapping("/replyUpdateLike.do")
		@ResponseBody
		public Map<String, Object> updateLike(@RequestParam int reply_no, HttpSession session) {
			return recommendService.replyUpdateLike(reply_no, session);
			
		}
		
		//싫어요
		@RequestMapping("/replyUpdateDislike.do")
		@ResponseBody
		public Map<String, Object> updateDislike(@RequestParam int reply_no, HttpSession session) {
			return recommendService.replyUpdateDisike(reply_no, session);
		}
}
