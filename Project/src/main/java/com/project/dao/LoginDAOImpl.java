package com.project.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.dto.LoginDTO;

@Repository
public class LoginDAOImpl implements LoginDAO {
	
	@Autowired
	private SqlSessionTemplate template;

	@Override
	public LoginDTO selectUser(Map<String, Object> map) throws Exception {
		return template.selectOne("com.project.mappers.LoginDAO.selectUser", map);
	}


	
	
		
	

}
