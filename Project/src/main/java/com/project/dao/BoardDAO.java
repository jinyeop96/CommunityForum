package com.project.dao;

import java.util.*;

import com.project.dto.BoardDTO;
import com.project.dto.BoardFileDTO;

public interface BoardDAO {
	
	//일반
	public List<BoardDTO> selectList(Map<String, Object> map);	// 게시판 글 다 가져옴
	
	public int getRecords(String board_type);	// 게시물 몇개인지 가져옴 (게시판 별로 작동)

	
	// 검색
	public List<BoardDTO> selectSearchData(Map<String, Object> map);	//검색한거 가져옴
	
	public int getRecordsBySerachType(Map<String, Object> map);	// 검색한 게시물 몇개인지 가져옴
	
	
	// 특정게시물
	public BoardDTO selectOne(int no);	// 해당 게시물 가져옴
	
	public void updateView(int no);		// 조회수 up
	
	public void insertRecord(Map<String, Object> map);	// 게시글 등록
	
	
	// 게시글 좋아요&싫어요
	public void updateLikey(Map<String, Object> map);	// 게시글 좋아요 +1z

	public int getLikes(int board_no);	// 게시글 좋아요
	
	public int getDislikes(int board_no);	// 게시글 싫어요 가져오기
	
	
	//게시글 수정&삭제
	public void boardDelete(int board_no);	// 게시물 삭제
	
	public void updateContent(Map<String, Object> map);	// 게시물 수정
	
	
	// 파일 첨부 관련
	public void insertFile(Map<String, Object> map);	// 파일 첨부
	
	public void deleteFile(Map<String, Object> map);	// 파일 삭제

	public void deleteAllFile(int board_no);	// 파일 삭제
	
	public int getLatest();	// board와 boardfile 테이블이 다르기 때문에 board먼저 insert 해주고 바로 글번호 가져옴
	
	public List<String> selectFile(int board_no);	// boardfile에 해당 글번호의 파일들 가져옴

	public List<BoardFileDTO> selectAllFile(String board_type);	// boardfile에 해당 글번호의 파일들 가져옴
	
	public int hasFile(int board_no);	// 파일 여부
	
	public void hasFileUp(int board_no); // 첨부파일 있으면 board_hasFile +1

	public void hasFileDown(int board_no);// 첨부파일 없으면 board_hasFile -1
	
}
