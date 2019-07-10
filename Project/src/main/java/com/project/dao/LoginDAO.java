package com.project.dao;

import java.util.Map;

import com.project.dto.JoinDTO;
import com.project.dto.LoginDTO;

public interface LoginDAO {
	
	  public JoinDTO selectUser(JoinDTO dto)throws Exception;
	  
	  public JoinDTO memeberinfo(String nickname) throws Exception;

	  public void infoupdate(Map<String, Object> map) throws Exception;

	  public int withraw(JoinDTO dto) throws Exception;

	  public void changepwd(JoinDTO dto) throws Exception;
}
