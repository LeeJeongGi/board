package com.spring.board.form;

import com.fasterxml.jackson.annotation.JsonProperty;

public class UserInfo {

	@JsonProperty
	private String name;

	@JsonProperty("given_name")
	private String givenName;

	@JsonProperty("family_name")
	private String familyName;

	@JsonProperty
	private String gender;

	@JsonProperty
	private String picture;

	@JsonProperty
	private String link;

	@JsonProperty
	private String email;

	@JsonProperty("verified_email")
	private String verifiedEmail;

	@JsonProperty
	private String hd;

	@JsonProperty
	private String locale;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGivenName() {
		return givenName;
	}

	public void setGivenName(String givenName) {
		this.givenName = givenName;
	}

	public String getFamilyName() {
		return familyName;
	}

	public void setFamilyName(String familyName) {
		this.familyName = familyName;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getVerifiedEmail() {
		return verifiedEmail;
	}

	public void setVerifiedEmail(String verifiedEmail) {
		this.verifiedEmail = verifiedEmail;
	}

	public String getHd() {
		return hd;
	}

	public void setHd(String hd) {
		this.hd = hd;
	}

	public String getLocale() {
		return locale;
	}

	public void setLocale(String locale) {
		this.locale = locale;
	}

}
