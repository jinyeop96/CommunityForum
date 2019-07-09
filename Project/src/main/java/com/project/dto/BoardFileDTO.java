package com.project.dto;

public class BoardFileDTO {
	
	private int board_no;
	private String boardfile_name;
	private String boardfile_date;
	private String board_type;
	
	
	
	
	public String getBoard_type() {
		return board_type;
	}
	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public String getBoardfile_name() {
		return boardfile_name;
	}
	public void setBoardfile_name(String boardfile_name) {
		this.boardfile_name = boardfile_name;
	}
	public String getBoardfile_date() {
		return boardfile_date;
	}
	public void setBoardfile_date(String boardfile_date) {
		this.boardfile_date = boardfile_date;
	}
	
	

}
