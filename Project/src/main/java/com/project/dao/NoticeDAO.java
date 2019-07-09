package com.project.dao;

import java.util.List;

import com.project.dto.NoticeDTO;

public interface NoticeDAO {
		
	public int noticeRegister(NoticeDTO dto) throws Exception;
	
	public NoticeDTO noticeRead(int seq) throws Exception;
	
	public List<NoticeDTO> noticeList() throws Exception;
	
	public int noticeDelete(int seq) throws Exception;
	
	public int noticeUpdate(NoticeDTO dto) throws Exception;
} 
