package com.military.dao;

import java.util.List;

import com.military.dto.EntireDTO;


public interface EntireDAO {

	public List<EntireDTO> selectList(int rowStart);
	
	public int getRecords();
	
	public EntireDTO selectOne(int no);
}
