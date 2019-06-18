package com.military.dao;

import com.military.dto.LoginDTO;

public interface LoginDAO {
	
	public LoginDTO selectUser(String username);
}
