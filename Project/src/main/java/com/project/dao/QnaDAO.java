package com.project.dao;

import java.util.List;
import java.util.Map;

import com.project.dto.Criteria;
import com.project.dto.QnaDTO;

public interface QnaDAO {
	public int qna_insert(QnaDTO qnaDTO) throws Exception;
	
	public List<QnaDTO> qna_list(Criteria cri) throws Exception;
	
	public int qna_pwcheck(Map<String,Object> map) throws Exception;

	public int qna_count() throws Exception;
	
}
