package com.spring.board.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.dto.UserDto;
import com.spring.board.form.UserForm;
import com.spring.board.service.UserService;

@Controller
@RequestMapping(value = "/board")
public class LoginController {
	@Autowired
	private HttpSession session;
	@Autowired
	private UserService userService;

	/* GoogleLogin */
	@Autowired
	private GoogleConnectionFactory googleConnectionFactory;
	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;

	private static Log log = LogFactory.getLog(LoginController.class);

	/** 게시판 - 회원가입 페이지 이동 */
	@RequestMapping(value = "/register")
	public String register(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "board/register";
	}

	/** 게시판 - 회원 가입 */
	@RequestMapping(value = "/getRegister")
	@ResponseBody
	public UserDto getRegister(HttpServletRequest request, HttpServletResponse response, UserForm userForm) throws Exception {

		UserDto userDto = userService.getRegister(userForm);

		return userDto;
	}

	/** 게시판 - 로그인 페이지 이동*/
	@RequestMapping(value = "/login", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(HttpServletRequest request, HttpServletResponse response, Model model, UserForm userForm) throws Exception {

		/* 구글code 발행 */
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
		model.addAttribute("google_url", url);
		log.debug("구글:" + url);

		return "board/login";
	}

	/** 게시판 - 로그인 */
	@RequestMapping(value = "/getLogin")
	@ResponseBody
	public UserDto getLogin(HttpServletRequest request, HttpServletResponse response, Model model, UserForm userForm) throws Exception {

		UserDto userDto = userService.getLogin(userForm);
		session.setAttribute("userID", userDto.getUserID());
		return userDto;
	}

	/** 게시판 - 메인 페이지 이동 */
	@RequestMapping(value = "/main", method = { RequestMethod.GET, RequestMethod.POST })
	public String main(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

		String userID = request.getParameter("userID");
		UserForm userForm = new UserForm();
		userForm.setUserID(userID);

		if (userForm.getUserID() != null) {

			UserDto userProfile = userService.getProfile(userForm);
			log.debug("방문자 id : " + userProfile.getUserID());
			model.addAttribute("userDto", userProfile);

			log.debug("이웃의 이웃리스트를 출력해보자");
			List<UserDto> friendList = userService.getFriendList(userForm);
			model.addAttribute("userDto2", friendList);

			log.debug("게시글을 가져와보자");
		}

		return "board/main";
	}

	/** 게시판 - 로그아웃 페이지 이동 */
	@RequestMapping(value = "/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return "board/logout";
	}

	/** 게시판 - 관리자 페이지 이동 */
	@RequestMapping(value = "/admin")
	public String admin(Model model) throws Exception {

		List<UserDto> userDto = userService.getUserList();
		model.addAttribute("userDto", userDto);

		return "board/admin";
	}

	/** 게시판 - 개인 페이지 이동 */
	@RequestMapping(value = "/myPage")
	public String myPage(Model model, UserForm userForm) throws Exception {
		userForm.setUserID((String) session.getAttribute("userID"));
		List<UserDto> userDto = userService.getMyPage(userForm);
		model.addAttribute("userDto", userDto);

		return "board/myPage";
	}

	/** 이웃 추가 */
	@RequestMapping(value = "/getFriend")
	@ResponseBody
	public UserDto getFriend(@RequestParam Map<String, Object> param, UserForm userForm) throws Exception {
		log.debug("del_yn : " + userForm.getDel_yn());
		userForm.setUserFriend((String) param.get("userID"));
		userForm.setUserID((String) session.getAttribute("userID"));
		UserDto userDto = userService.getFriend(userForm);
		return userDto;
	}

	/** 이웃 삭제 */
	@RequestMapping(value = "/delFriend")
	@ResponseBody
	public UserDto delFriend(@RequestParam Map<String, Object> param, UserForm userForm) throws Exception {

		userForm.setUserFriend((String) param.get("userID"));
		userForm.setUserID((String) session.getAttribute("userID"));
		UserDto userDto = userService.delFriend(userForm);
		return userDto;
	}

	/** 게시판 - 개인 페이지 이동 */
	@RequestMapping(value = "/getIntroduce")
	public String getIntroduce(Model model, UserForm userForm, HttpServletRequest request, HttpServletResponse response) throws Exception {

		log.debug("블로그 소개 글" + request.getParameter("introduce"));
		userForm.setIntroContext(request.getParameter("introduce"));
		log.debug("userID : " + session.getAttribute("userID"));
		userForm.setUserID((String) session.getAttribute("userID"));
		UserDto userDto = userService.getIntroduce(userForm);
		//		if (userDto.getResult().equals("SUCCESS")) {
		//			session.setAttribute("introduce", request.getParameter("introduce"));
		//		}

		return "redirect:main?userID=" + userForm.getUserID();
	}

}
