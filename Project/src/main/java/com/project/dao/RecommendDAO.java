package com.project.dao;

import java.util.Map;

import com.project.dto.RecommendDTO;

public interface RecommendDAO {

	public RecommendDTO selectFromBoard(Map<String, Object> map);

	public RecommendDTO selectFromReply(Map<String, Object> map);

	public void insertBoardLikeUp(Map<String, Object> map);

	public void insertBoardLikeDown(Map<String, Object> map);
	
	public void insertReplyLikeUp(Map<String, Object> map);
	
	public void insertReplyLikeDown(Map<String, Object> map);
	
	
	// 게시물
	public void RecUpdateLikeUpBoard(Map<String, Object> map);
	
	public void RecUpdateLikeDownBoard(Map<String, Object> map);

	public void RecUpdateDislikeDownBoard(Map<String, Object> map);
	
	public void RecUpdateDislikeUpBoard(Map<String, Object> map);

	
	
	// 답글
	public void RecUpdateLikeUpReply(Map<String, Object> map);
	
	public void RecUpdateLikeDownReply(Map<String, Object> map);
	
	public void RecUpdateDislikeDownReply(Map<String, Object> map);
	
	public void RecUpdateDislikeUpReply(Map<String, Object> map);

}
