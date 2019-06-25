package com.project.dto;

public class LoginDTO {
	
	private String j_id;
	private String j_pwd;
	private boolean useCookie;
	
	public boolean isUseCookie() {
		return useCookie;
	}
	public void setUseCookie(boolean useCookie) {
		this.useCookie = useCookie;
	}
	public String getJ_id() {
		return j_id;
	}
	public void setJ_id(String j_id) {
		this.j_id = j_id;
	}
	public String getJ_pwd() {
		return j_pwd;
	}
	public void setJ_pwd(String j_pwd) {
		this.j_pwd = j_pwd;
	}

	
}
