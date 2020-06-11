package com.spring.board.form;

public class UserForm extends CommonForm {
	String userID;
	String userPassword;
	String userName;
	String userEmail;
	String userGender;
	String userFriend;
	String del_yn;
	String introContext;

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userId) {
		this.userID = userId;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public void setUserPassword(String userPw) {
		this.userPassword = userPw;
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
