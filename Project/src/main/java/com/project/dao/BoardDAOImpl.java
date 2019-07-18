package com.project.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.dto.BoardDTO;
import com.project.dto.BoardFileDTO;

@Repository
public class BoardDAOImpl implements BoardDAO{
	
	@Autowired
	private SqlSessionTemplate template;
	
	//--------전체 게시물 ----------
	@Override
	//전체 레코드 수
	public int getRecords(String board_type) {
		return template.selectList("com.project.mappers.board.getRecords", board_type).size();
	}
	
	@Override
	// 레코드 전체 가져오기
	public List<BoardDTO> selectList(Map<String, Object> map) {	
		return template.selectList("com.project.mappers.board.selectList", map);
	}

	@Override
	// 레코드 전체 가져오기
	public List<BoardDTO> selectUpBoardList(Map<String, Object> map) {	
		return template.selectList("com.project.mappers.board.selectUpBoardList", map);
	}
	
	
	
	// ------------------검색했을때--------------------
	@Override
	// 검색한 레코드 전체 수
	public int getRecordsBySerachType(Map<String, Object> map) {
		return template.selectList("com.project.mappers.board.getSearchByTypeRecords", map).size();
	}
	
	@Override
	// 검색한 레코드 전체 가져오기
	public List<BoardDTO> selectSearchData(Map<String, Object> map) {
		return template.selectList("com.project.mappers.board.searchData", map);
	}

	
	
	
	//-------------content 관련 ----------------
	@Override
	public BoardDTO selectOne(int board_no) {			// no(게시글 번호) 넘겨서 특정 레코드만 가져오기
		return template.selectOne("com.project.mappers.board.selectOne", board_no);
	}
	
	@Override
	public void updateView(int no) {
		template.update("com.project.mappers.board.updateView", no);
	}
	
	@Override
	public void updateLikey(Map<String, Object> map) {
		template.update("com.project.mappers.board.updateLikey", map);
	}

	@Override
	public int getLikes(int board_no) {
		return template.selectOne("com.project.mappers.board.getLikes", board_no);
	}
	
	@Override
	public int getDislikes(int board_no) {
		return template.selectOne("com.project.mappers.board.getDislikes", board_no);
	}
	
	@Override
	public int getLatest() {
		return template.selectOne("com.project.mappers.board.getLatest");
	}
	
	@Override
	public List<String> selectFile(int board_no) {
		return template.selectList("com.project.mappers.board.selectFile", board_no);
	}
	
	@Override
	public List<BoardFileDTO> selectAllFile(String board_type) {
		return template.selectList("com.project.mappers.board.selectAllFile", board_type);
	}
	
	@Override
	public int hasFile(int board_no) {
		return template.selectOne("com.project.mappers.board.hasFile", board_no);
		
	}
	
	@Override
	public void hasFileUp(int board_no) {
		template.update("com.project.mappers.board.hasFileUp", board_no);
	}
	
	@Override
	public void hasFileDown(int board_no) {
		template.update("com.project.mappers.board.hasFileDown", board_no);
	}
	
	
	// -----------------게시물 등록--------------
	@Override
	public void insertRecord(Map<String, Object> map) {
		template.insert("com.project.mappers.board.insertRecord", map);
	}
	
	@Override
	public void deleteFile(Map<String, Object> map) {
		template.delete("com.project.mappers.board.deleteFile", map);
	}

	@Override
	public void deleteAllFile(int board_no) {
		template.delete("com.project.mappers.board.deleteAllFile", board_no);
	}
	
	@Override
	public void insertFile(Map<String, Object> map) {
		template.insert("com.project.mappers.board.insertFile", map);		
	}
	
	// ---------게시물 삭제----------
	@Override
	public void boardDelete(int board_no) {
		template.delete("com.project.mappers.board.boardDelete", board_no);
	}
	
	// -------게시물 수정-------
	@Override
	public void updateContent(Map<String, Object> map) {
		template.update("com.project.mappers.board.updateContent", map);
	}
}
