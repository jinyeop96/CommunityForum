package com.project.dao;

import java.util.List;
import java.util.Map;

import com.project.dto.BoardDTO;

public interface ReplyDAO {
	
	public List<BoardDTO> selectList(Map<String, Object> map);
	
	public int getRecords(int board_no);
	
	public void updateReply(Map<String, Object> map);
	
	public void updateLike(int reply_no);
	
	public void updateDislike(int reply_no);
}
