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
//가입
	@Override
	public void insert(JoinDTO dto) throws Exception {
		template.insert("insert", dto);
		
	}
//아이디 중복체크
	@Override
	public int findId(Map<String, Object> map) throws Exception {
		return template.selectOne("findid", map);
	}
//닉네임 중복체크
	@Override
	public int findnick(Map<String, Object> map) throws Exception {
		
		return template.selectOne("findnick", map);
	}
	//아이디 찾기 
	@Override
	public String searchId(Map<String, Object> map) throws Exception{
       return template.selectOne("searchId", map);
		
	}
	@Override
	public String searchpwd(Map<String, Object> map) throws Exception{
		return template.selectOne("searchpwd", map);
	}
}
