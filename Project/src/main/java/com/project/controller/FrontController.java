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
	public String transportTest(HttpServletRequest request, Model model) {
		String transportTest1_search = request.getParameter("transportTest1_search").trim();
		String transportTest2_search = request.getParameter("transportTest2_search").trim();
		
		if(transportTest1_search !=null && transportTest2_search !=null) {
			model.addAttribute("transportTest1_search", transportTest1_search);
			model.addAttribute("transportTest2_search", transportTest2_search);
			model.addAttribute("radio", Integer.parseInt(request.getParameter("radio")));
		}		
		model.addAttribute("board_type", request.getParameter("board_type"));
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
	
	@RequestMapping("/banner.do")
	@ResponseBody
	public ModelAndView banner(ModelAndView mav) {
		mav.setViewName("banner/banner");
		return mav;
	}
	
	@RequestMapping("/carousel.do")
	@ResponseBody
	public ModelAndView carousel(ModelAndView mav) {
		mav.setViewName("carousel/carousel");
		return mav;
	}
	
	@RequestMapping("/carouselPhone.do")
	@ResponseBody
	public ModelAndView carouselPhone(ModelAndView mav) {
		mav.setViewName("carouselPhone/carouselPhone");
		return mav;
	}
}

















