package com.project.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.dto.JoinDTO;




@Repository
public class LoginDAOImpl implements LoginDAO {
	
	@Autowired
	private SqlSessionTemplate template;

	@Override
	public JoinDTO selectUser(Map<String, Object> map) throws Exception {

		return template.selectOne("selectUser", map);
	}


	
	
		
	

}
