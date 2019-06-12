package com.military.dao;

import java.util.List;
import java.util.Map;

import com.military.dto.EntireDTO;


public interface EntireDAO {

	public List<EntireDTO> selectList(Map<String, Object> map);
	
	public int getRecords();
	
	public EntireDTO selectOne(int no);

	public int getSearchByTypeRecords(Map<String, Object> map);
	
	public List<EntireDTO> selectSearchData(Map<String, Object> map);
	
	
	
	
	
}
