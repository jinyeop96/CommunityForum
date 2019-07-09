package com.project.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.dao.RecommendService;

@Controller
public class RecommendController {
	
	@Autowired
	private RecommendService recommendService;
	
	@RequestMapping("recommend.do")
	@ResponseBody
	public Map<String, Object> recommend(int no, String recType, String likey, HttpSession session) {
		return recommendService.recommend(no, recType, likey, session);
	}

}
