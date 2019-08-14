package com.project.dao;

import java.util.List;
import java.util.Map;

import com.project.dto.RecommendDTO;

public interface RecommendDAO {

	public RecommendDTO selectRecommend(Map<String, Object> map);

	public List<RecommendDTO> selectByNickname(String nickname);

	public void insertNew(Map<String, Object> map);
	
	public void updateLikey(Map<String, Object> map);
	
	

}
