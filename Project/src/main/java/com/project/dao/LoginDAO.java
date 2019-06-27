package com.project.dao;

import java.util.Map;

public interface LoginDAO {
	
	  public String selectUser(Map<String, Object> map)throws Exception;
}
