package com.military.dao;

import java.util.List;
import java.util.Map;

import com.military.dto.EntireDTO;

public interface EntireReplyDAO {
	
	public List<EntireDTO> selectList(Map<String, Object> map);
	
	public int getRecords();
	
	public void updateReply(Map<String, Object> map);
}
