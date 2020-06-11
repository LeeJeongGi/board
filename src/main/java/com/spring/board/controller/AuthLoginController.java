package com.spring.board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.connect.Connection;
import org.springframework.social.google.api.Google;
import org.springframework.social.google.api.impl.GoogleTemplate;
import org.springframework.social.google.api.oauth2.UserInfo;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.AccessGrant;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.board.form.UserForm;
import com.spring.board.service.UserService;

@Controller
@RequestMapping(value = "/board")
public class AuthLoginController {

	/* GoogleLogin */
	@Autowired
	private GoogleConnectionFactory googleConnectionFactory;
	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;

	@Autowired
	private HttpSession session;
	@Autowired
	private UserService userService;

	private static Log log = LogFactory.getLog(AuthLoginController.class);

	// 구글 Callback호출 메소드
	@RequestMapping(value = "/googleSuccess", method = { RequestMethod.GET, RequestMethod.POST })
	public String googleSuccess(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

		String code = request.getParameter("code");

		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		AccessGrant accessGrant = oauthOperations.exchangeForAccess(code, googleOAuth2Parameters.getRedirectUri(), null);
		String accessToken = accessGrant.getAccessToken();
		Long expireTime = accessGrant.getExpireTime();

		if (expireTime != null && expireTime < System.currentTimeMillis()) {
			accessToken = accessGrant.getRefreshToken();
			log.debug("accessToken is expired. refresh token = {}" + accessToken);
		}

		log.debug("accessToken : " + accessToken);
		log.debug("expireTime : " + expireTime);
		log.debug("accessGrant : " + accessGrant);

		Connection<Google> connection = googleConnectionFactory.createConnection(accessGrant);
		Google google = connection == null ? new GoogleTemplate(accessGrant.getAccessToken()) : connection.getApi();

		UserInfo userinfo = google.oauth2Operations().getUserinfo();

		log.debug("확인 : " + userinfo.getName());
		log.debug("확인 : " + userinfo.getEmail());
		log.debug("확인 : " + userinfo.getId());

		log.debug("확인 : " + userinfo.getHd());
		log.debug("확인 : " + userinfo.getLocale());
		log.debug("확인 : " + userinfo.getPicture());
		log.debug("확인 : " + userinfo.getVerifiedEmail());

		UserForm userForm = new UserForm();
		userForm.setUserID(userinfo.getId());
		userForm.setUserEmail(userinfo.getEmail());
		userForm.setUserName(userinfo.getName());
		//디비데이터와 이메일 있는지 여부 비교
		log.debug("이메일 : " + userForm.getUserEmail());
		boolean isValidUser = userService.verifyUser(userForm);

		if (isValidUser) {
			session.setAttribute("userID", userinfo.getId());
		} else {
			log.debug("db에 있는 메일이 아닙니다.");
			return "redirect:/board/login";
		}
		return "redirect:/board/main?userID=" + userForm.getUserID();
	}

	/** 게시판 - 구글 로그인 이동 */
	@RequestMapping(value = "/auth")
	public String auth(Model model) throws Exception {

		/* 구글code 발행 */
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
		model.addAttribute("google_url", url);
		log.debug("구글:" + url);

		return "board/auth";
	}
}
