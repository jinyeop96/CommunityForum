package com.project.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class FrontController {
	
	// get requests
	@RequestMapping("/main.do")	// index.jsp -> main.jsp
	public String main() {
		return "main";
	}
	
	@RequestMapping("/login.do")	// login.jsp로 이동
	public String login() {
		return "login";
	}

	@RequestMapping("/free.do")
	public String free() {
		return "free";
	}
	
	@RequestMapping("/OwyMember.do") 
	public String OwyMember() {
		return "OwyMember";
	}
	
	@RequestMapping("/plan.do")
	public String plan() {
		return "plan";
	}
	
	@RequestMapping("/future.do")
	public String future() {
		return "future";
	}
	
	@RequestMapping("/contents.do")
	public String contents() {
		return "contents";
	}
	
	@RequestMapping("/hotel.do")
	public String hotel(HttpServletRequest request, Model model) {
		String hotel_search = request.getParameter("hotel_search").trim();
		if( hotel_search != null) {
			model.addAttribute("hotel_search", hotel_search);
		}
		model.addAttribute("board_type", request.getParameter("board_type"));
		return "hotel";
	}
	
	@RequestMapping("/restaurant.do")
	public String restaurant(HttpServletRequest request, Model model) {
		String restaurant_search = request.getParameter("restaurant_search").trim();
		if( restaurant_search !=null) {
			model.addAttribute("restaurant_search", restaurant_search);
		}
		model.addAttribute("board_type", request.getParameter("board_type"));
		return "restaurant";
	}
	
	@RequestMapping("/transport.do")
	public String transport() {
		return "transport";
	}

	@RequestMapping("/hotelPopup.do")
	@ResponseBody
	public ModelAndView hotelPopup(HttpServletRequest request, ModelAndView mav ) {
		String hotel_search = request.getParameter("hotel_search").trim();
		if(hotel_search != null) {
			mav.addObject("hotel_search", hotel_search);
		}
		mav.addObject("board_type", request.getParameter("board_type"));
		mav.setViewName("ajax/hotelPopup");
		return mav;
	}
	
	@RequestMapping("/transportTest.do")
	public String transportTest() {
		return "transportTest";
	}

	@RequestMapping("/restaurantPopup.do")
	@ResponseBody
	public ModelAndView restaurantPopup(HttpServletRequest request, ModelAndView mav) {
		String restaurant_search = request.getParameter("restaurant_search").trim();
		if(restaurant_search !=null) {
			mav.addObject("restaurant_search", restaurant_search);
		}
		mav.addObject("board_type", request.getParameter("board_type"));
		mav.setViewName("ajax/restaurantPopup");
		return mav;
	}
}

















