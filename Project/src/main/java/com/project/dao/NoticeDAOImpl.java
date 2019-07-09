package com.project.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.dto.NoticeDTO;

@Repository
public class NoticeDAOImpl implements NoticeDAO{

	@Autowired
	private SqlSessionTemplate template;
	
	@Override
	public int noticeRegister(NoticeDTO dto) throws Exception {
		return template.insert("noticeRegister",dto); 
	}

	@Override
	public NoticeDTO noticeRead(int seq) throws Exception {
		return template.selectOne("noticeRead",seq);
	}

	@Override
	public List<NoticeDTO> noticeList() throws Exception {
		return template.selectList("noticeList");
	}

	@Override
	public int noticeDelete(int seq) throws Exception {
		return template.delete("noticeDelete",seq);
	}

	@Override
	public int noticeUpdate(NoticeDTO dto) throws Exception {
		return template.insert("noticeModify",dto);
	}

}
