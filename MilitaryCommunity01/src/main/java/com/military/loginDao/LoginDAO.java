package com.military.loginDao;

import com.military.loginDto.LoginDTO;

public interface LoginDAO {
	
	public LoginDTO selectUser(String username);
}
