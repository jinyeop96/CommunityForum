package com.project.dao;

import java.util.Map;

import com.project.dto.LoginDTO;

public interface LoginDAO {
	
	  public LoginDTO selectUser(Map<String, Object> map)throws Exception;
}
