package com.project.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.dto.RecommendDTO;

@Repository
public class RecommendDAOImpl implements RecommendDAO{

	@Autowired
	private SqlSessionTemplate template;
	
	// 해당 공감 레코드 가져오기

	@Override
	public RecommendDTO selectRecommend(Map<String, Object> map) {
		return template.selectOne("com.project.mappers.recommend.selectRecommend", map);
	}

	// 처음으로 공감할때
	
	@Override
	public void updateLikey(Map<String, Object> map) {
		template.update("com.project.mappers.recommend.updateLikey", map);
	}

	@Override
	public void insertNew(Map<String, Object> map) {
		template.update("com.project.mappers.recommend.insertNew", map);
	}
	
}
