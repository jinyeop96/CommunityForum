package com.project.dao;

import com.project.dto.LoginDTO;

public interface LoginDAO {
	
	public LoginDTO selectUser(String username);
}
