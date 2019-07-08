package com.project.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.dto.Criteria;
import com.project.dto.QnaDTO;

@Repository
public class QnaDAOImpl implements QnaDAO {

	@Autowired
	private SqlSessionTemplate template;
	


	@Override
	public int qna_insert(QnaDTO qnaDTO) throws Exception {
		return template.insert("com.project.dao.QnaDAO.qna_insert",qnaDTO);
	}



	@Override
	public List<QnaDTO> qna_list(Criteria cri) throws Exception {
		return template.selectList("qna_list", cri);
	}



	@Override
	public int qna_pwcheck(Map<String, Object> map) throws Exception {
		return template.selectOne("qna_pwcheck",map);
	}



	@Override
	public int qna_count(Criteria cri) throws Exception {
		return template.selectOne("qna_count",cri);
	}



	@Override
	public int insertReply(Map<String,Object> map) throws Exception {
		return template.update("qna_reply_insert",map);
	}



	@Override
	public int AdmindeleteQna(int seq) throws Exception {
		return template.delete("qna_delete",seq);
	}



	@Override
	public int qnaModify(Map<String,Object> map) throws Exception {
		
		return template.update("qna_modify",map);
	}



	@Override
	public int qnaUserDelete(int seq) throws Exception {
		
		return template.delete("qna_user_delete",seq);
	}

}
