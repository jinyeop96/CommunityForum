package com.project.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.dto.JoinDTO;

@Repository
public class JoinDAOImpl implements JoinDAO{
	
	@Autowired
	private SqlSessionTemplate template;

	@Override
	public List<JoinDTO> memberList(JoinDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insert(JoinDTO dto) throws Exception {
		template.insert("insert", dto);
		
	}

	@Override
	public int findId(Map<String, Object> map) throws Exception {
		return template.selectOne("findid", map);
	}

	@Override
	public int findnick(Map<String, Object> map) throws Exception {
		
		return template.selectOne("findnick", map);
	}



}
