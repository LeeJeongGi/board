package com.spring.board.dto;

public class UserDto {
	String userID;
	String userPassword;
	String userName;
	String userGender;
	String userEmail;
	String result;
	String userFriend;
	String del_yn;
	String introContext;

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserGender() {
		return userGender;
	}

	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getUserFriend() {
		return userFriend;
	}

	public void setUserFriend(String userFriend) {
		this.userFriend = userFriend;
	}

	public String getDel_yn() {
		return del_yn;
	}

	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}

	public String getIntroContext() {
		return introContext;
	}

	public void setIntroContext(String introContext) {
		this.introContext = introContext;
	}

}
