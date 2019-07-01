package com.project.dao;

import java.util.Map;

import com.project.dto.JoinDTO;
import com.project.dto.LoginDTO;

public interface LoginDAO {
	
	  public LoginDTO selectUser(Map<String, Object> map)throws Exception;
	  
	  public JoinDTO memeberinfo(String nickname) throws Exception;

	  public void infoupdate(Map<String, Object> map) throws Exception;

	  public int withraw(Map<String, Object> map) throws Exception;
}
