package com.project.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.dto.EntireDTO;

@Repository
public class EntireDAOImpl implements EntireDAO {
	
	@Autowired
	private SqlSessionTemplate template;
	
	//--------전체 게시물 ----------
	@Override
	//전체 레코드 수
	public int getRecords() {
		return template.selectList("com.project.mapper.entire.getRecords").size();
	}
	
	@Override
	// 레코드 전체 가져오기
	public List<EntireDTO> selectList(Map<String, Object> map) {	
		return template.selectList("com.project.mapper.entire.selectList", map);
	}
	
	
	
	// ------------------검색했을때--------------------
	@Override
	// 검색한 레코드 전체 수
	public int getSearchByTypeRecords(Map<String, Object> map) {
		return template.selectList("com.project.mapper.entire.getSearchByTypeRecords", map).size();
	}
	
	@Override
	// 검색한 레코드 전체 가져오기
	public List<EntireDTO> selectSearchData(Map<String, Object> map) {
		return template.selectList("com.project.mapper.entire.searchData", map);
	}

	
	
	
	//-------------content 관련 ----------------
	@Override
	public EntireDTO selectOne(int no) {			// no(게시글 번호) 넘겨서 특정 레코드만 가져오기
		return template.selectOne("com.project.mapper.entire.selectOne", no);
	}
	
	@Override
	public void updateView(int no) {
		template.update("com.project.mapper.entire.updateView", no);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
