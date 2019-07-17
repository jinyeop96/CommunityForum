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
	public JoinDTO selectUser(JoinDTO dto) throws Exception {
		return template.selectOne("com.project.mappers.LoginDAO.selectUser", dto);
	}

	@Override
	public JoinDTO memeberinfo(String nickname) throws Exception{
		return template.selectOne("memberinfo", nickname);
	}
	@Override
	public void infoupdate(Map<String, Object> map) throws Exception{
		template.update("infoupdate", map);
	}
     
	@Override
	public int withraw(JoinDTO dto) throws Exception{
          
		return template.delete("memberwitraw", dto);
		}
    @Override
	public void changepwd(JoinDTO dto) {
		template.update( "pwdchange", dto);

		
	}
	
	
	
		
	

}
