package com.military.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.military.dto.EntireDTO;

@Repository
public class EntireReplyDAOImpl  implements EntireReplyDAO{
	
	@Autowired
	private SqlSessionTemplate template;
	
	
	@Override
	public List<EntireDTO> selectList(Map<String, Object> map) {
		return template.selectList("com.military.mapper.entireReply.selectList", map);
	}
	
	@Override
	public int getRecords() {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public void updateReply(Map<String, Object> map) {
		template.update("com.military.mapper.entireReply.updateReplyOthers", map);
		template.update("com.military.mapper.entireReply.updateReply", map);
		
	}
}
