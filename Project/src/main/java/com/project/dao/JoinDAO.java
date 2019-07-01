package com.project.dao;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.project.dto.JoinDTO;


public interface JoinDAO {
	
	public List<JoinDTO> memberList(JoinDTO dto) throws Exception;
	
	public void insert(JoinDTO dto) throws Exception;
	
	public int findId(Map<String, Object> map) throws Exception;
	
	public int findnick(Map<String, Object> map) throws Exception;

	public String searchId(Map<String, Object> map) throws Exception;

	public String searchpwd(Map<String, Object> result) throws Exception;
	
	
	


	



	
}

	

