package com.project.dao;

import java.util.List;
import java.util.Map;

import com.project.dto.BoardDTO;

public interface ReplyDAO {
	
	public List<BoardDTO> selectList(Map<String, Object> map);	// board.jsp 에서 쓰이는 특정 글의 답변 다 가져오기

	public List<BoardDTO> selectAllList();	//hotel.jsp or restaurant.jsp에서 쓰일 답변 전체 가져오기
	
	public int getRecords(int board_no);	//답변 몇개인지
	
	public void updateReply(Map<String, Object> map);	// 답변 등록

	public void deleteReply(Map<String, Object> map);	// 답변 삭제

	public void editReplyOk(Map<String, Object> map);	// 답변 수정

	public void updateLikey(Map<String, Object> map);	// 답변 추천
}
