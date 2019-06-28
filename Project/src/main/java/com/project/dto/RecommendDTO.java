package com.project.dto;

public class RecommendDTO {
	
	private int rec_no;
	private int board_no;
	private int reply_no;
	private int rec_like;
	private int rec_dislike;
	private String nickname;
	
	public int getRec_no() {
	return rec_no;
	}
	public void setRec_no(int rec_no) {
		this.rec_no = rec_no;
	}
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public int getReply_no() {
		return reply_no;
	}
	public void setReply_no(int reply_no) {
		this.reply_no = reply_no;
	}
	public int getRec_like() {
		return rec_like;
	}
	public void setRec_like(int rec_like) {
		this.rec_like = rec_like;
	}
	public int getRec_dislike() {
		return rec_dislike;
	}
	public void setRec_dislike(int rec_dislike) {
		this.rec_dislike = rec_dislike;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	
	

}
