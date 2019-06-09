package com.military.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.military.dto.EntireDTO;

@Repository
public class EntireDAOImpl implements EntireDAO {
	
	@Autowired
	private SqlSessionTemplate template;
	
	@Override
	public List<EntireDTO> selectList(int rowStart) {			// 전체 게시판 가져오기		
		return template.selectList("com.military.mapper.entire.selectList", rowStart);
	}
	
	@Override
	public int getRecords() {
		List<EntireDTO> list = template.selectList("getRecords");
		return list.size();
	}

	@Override
	public EntireDTO selectOne(int no) {			// no(게시글 번호) 넘겨서 특정 레코드만 가져오기
		return template.selectOne("selectOne", no);
	}
	

}
