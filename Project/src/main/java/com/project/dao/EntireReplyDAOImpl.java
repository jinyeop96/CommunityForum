package com.project.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.dto.EntireDTO;

@Repository
public class EntireReplyDAOImpl  implements EntireReplyDAO{
	
	@Autowired
	private SqlSessionTemplate template;
	
	
	@Override
	public List<EntireDTO> selectList(Map<String, Object> map) {
		return template.selectList("com.project.mapper.entireReply.selectList", map);
	}
	
	@Override
	public int getRecords(Map<String, Object> map) {
		return template.selectOne("com.project.mapper.entireReply.getRecords", map);
	}
	
	@Override
	public void updateReply(Map<String, Object> map) {
		template.update("com.project.mapper.entireReply.updateReplyOthers", map);
		template.update("com.project.mapper.entireReply.updateReply", map);
	}
	
	@Override
	public void updateLike(Map<String, Object> map) {
		template.update("com.project.mapper.entireReply.updateLike", map);
	}
	
	@Override
	public void updateDislike(Map<String, Object> map) {
		template.update("com.project.mapper.entireReply.updateDislike", map);
	}
}
