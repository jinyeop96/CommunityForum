package com.project.dao;

import java.util.Map;

import com.project.dto.JoinDTO;

public interface LoginDAO {
	
	  public JoinDTO selectUser(Map<String, Object> map)throws Exception;
}
