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
	public RecommendDTO selectFromBoard(Map<String, Object> map) {
		return template.selectOne("com.project.mappers.recommend.selectFromBoard", map);
	}

	@Override
	public RecommendDTO selectFromReply(Map<String, Object> map) {
		return template.selectOne("com.project.mappers.recommend.selectFromReply", map);
	}
	
	// 처음으로 공감할때
	@Override
	public void insertBoardLikeUp(Map<String, Object> map) {
		template.insert("com.project.mappers.recommend.insertBoardLikeUp", map);
	}
	
	@Override
	public void insertBoardLikeDown(Map<String, Object> map) {
		template.insert("com.project.mappers.recommend.insertBoardLikeDown", map);
	}

	@Override
	public void insertReplyLikeUp(Map<String, Object> map) {
		template.insert("com.project.mappers.recommend.insertReplyLikeUp", map);
	}
	
	@Override
	public void insertReplyLikeDown(Map<String, Object> map) {
		template.insert("com.project.mappers.recommend.insertReplyLikeDown", map);
	}
	
	/////////////////게시물
	
	// 좋아요
	@Override
	public void RecUpdateLikeUpBoard(Map<String, Object> map) {
		template.update("com.project.mappers.recommend.RecUpdateLikeUpBoard", map);
	}
	
	@Override
	public void RecUpdateLikeDownBoard(Map<String, Object> map) {
		template.update("com.project.mappers.recommend.RecUpdateLikeDownBoard", map);
	}

	//싫어요
	@Override
	public void RecUpdateDislikeDownBoard(Map<String, Object> map) {
		template.update("com.project.mappers.recommend.RecUpdateDislikeDownBoard", map);
	}

	public void RecUpdateDislikeUpBoard(Map<String, Object> map) {
		template.update("com.project.mappers.recommend.RecUpdateDislikeUpBoard", map);
	}

	
	
	
	
	
	
	/////////////////답글
	
	// 좋아요
	@Override
	public void RecUpdateLikeUpReply(Map<String, Object> map) {
		template.update("com.project.mappers.recommend.RecUpdateLikeUpReply", map);
	}
	
	@Override
	public void RecUpdateLikeDownReply(Map<String, Object> map) {
		template.update("com.project.mappers.recommend.RecUpdateLikeDownReply", map);
	}
	
	//싫어요
	@Override
	public void RecUpdateDislikeDownReply(Map<String, Object> map) {
		template.update("com.project.mappers.recommend.RecUpdateDislikeDownReply", map);
	}
	
	public void RecUpdateDislikeUpReply(Map<String, Object> map) {
		template.update("com.project.mappers.recommend.RecUpdateDislikeUpReply", map);
	}
	
	
	
}
