package com.project.dao;

import java.util.List;
import java.util.Map;

import com.project.dto.EntireDTO;

public interface EntireReplyDAO {
	
	public List<EntireDTO> selectList(Map<String, Object> map);
	
	public int getRecords(Map<String, Object> map);
	
	public void updateReply(Map<String, Object> map);
	
	public void updateLike(Map<String, Object> map);
	
	public void updateDislike(Map<String, Object> map);
}
