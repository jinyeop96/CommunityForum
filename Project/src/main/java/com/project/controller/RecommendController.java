package com.project.controller;

import java.util.HashMap;
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
	
	Map<String, Object> map = new HashMap<String, Object>();
	
	@RequestMapping("recommend.do")
	@ResponseBody
	public Map<String, Object> recommend(int no, String recType, String likey, HttpSession session) {
		map = recommendService.recommend(no, recType, likey, session);
		System.out.println(map.get("msg"));
		return map;
	}

}
