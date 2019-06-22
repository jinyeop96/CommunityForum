package com.project.dao;

import java.util.*;

import com.project.dto.BoardDTO;

public interface BoardDAO {
	
public List<BoardDTO> selectList(Map<String, Object> map);
	
	public int getRecords(String board_type);
	
	public int getRecordsBySerachType(Map<String, Object> map);
	
	public List<BoardDTO> selectSearchData(Map<String, Object> map);
	
	public BoardDTO selectOne(int no);
	
	public void updateView(int no);
	
	public void insertRecord(Map<String, Object> map);
}
