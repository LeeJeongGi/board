//package com.spring.board.service;
//
//import javax.inject.Inject;
//
//import org.apache.commons.logging.Log;
//import org.apache.commons.logging.LogFactory;
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.social.connect.Connection;
//import org.springframework.social.google.api.Google;
//import org.springframework.social.google.api.impl.GoogleTemplate;
//import org.springframework.social.google.api.oauth2.UserInfo;
//import org.springframework.social.google.connect.GoogleConnectionFactory;
//import org.springframework.social.google.connect.GoogleOAuth2Template;
//import org.springframework.social.oauth2.AccessGrant;
//import org.springframework.social.oauth2.GrantType;
//import org.springframework.social.oauth2.OAuth2Operations;
//import org.springframework.social.oauth2.OAuth2Parameters;
//import org.springframework.stereotype.Service;
//
//import com.spring.board.common.JsonUtil;
//import com.spring.board.dao.UserDao;
//
//@Service
//public class LoginAuthService {
//	private static Log log = LogFactory.getLog(LoginAuthService.class);
//	private final static String DDI_EMAIL_ADDRESS = "@kr.doubledown.com";
//
//	@Value("${cookie.name}")
//	String cookieName;
//	@Value("${cookie.domain}")
//	String cookieDomain;
//	@Value("${cookie.expire}")
//	String cookieExpire;
//
//	@Inject
//	private GoogleConnectionFactory googleConnectionFactory;
//
//	@Inject
//	private OAuth2Parameters googleOAuth2Parameters;
//	@Inject
//	private UserDao userDao;
//
//	public String getGoogleLoginRedirectURL() {
//
//		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
//		String redirectUrl = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
//
//		return redirectUrl;
//	}
//
//	public UserInfo certifyAuth(String code) throws IllegalAccessException {
//
//		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
//		AccessGrant accessGrant = oauthOperations.exchangeForAccess(code, googleOAuth2Parameters.getRedirectUri(), null);
//
//		Connection<Google> connection = googleConnectionFactory.createConnection(accessGrant);
//		Google google = connection == null ? new GoogleTemplate(accessGrant.getAccessToken()) : connection.getApi();
//
//		String accessToken = accessGrant.getAccessToken();
//		Long expireTime = accessGrant.getExpireTime();
//
//		// 1. 토큰 유효기간 확인
//		validateExpireTime(expireTime, accessToken);
//
//		UserInfo userInfo = google.oauth2Operations().getUserinfo();
//
//		//		PlusOperations plusOperations = google.plusOperations();
//		//		Person person = plusOperations.getGoogleProfile();
//
//		// 2. Doubledown 사원이메일인지 확인 / DB에 있는 아이디만 접근가능
//
//		String userEmail = userInfo.getEmail();
//		validateUserEmail(userEmail);
//
//		return userInfo;
//	}
//
//	public void validateUserEmail(String userEmail) throws IllegalAccessException {
//
//		//email check
//		if (checkValidAddress(userEmail) == false) {
//			log.error("Your email is an unauthorized account. :: userEmail= " + userEmail);
//			throw new IllegalAccessException("Unauthorized access.");
//		}
//
//		//		if (checkExistAddress(userEmail) == false) {
//		//			log.error("Access Deny :: userEmail= " + userEmail);
//		//			throw new IllegalAccessException("Unauthorized access.");
//		//		}
//	}
//
//	public boolean checkValidAddress(String email) {
//		//email check
//		if (email.endsWith(DDI_EMAIL_ADDRESS) == false) {
//			return false;
//		} else {
//			return true;
//		}
//	}
//
//	//	public boolean checkExistAddress(String email) {
//	//		AdminUser user = adminUserDAO.selectAdminUserByEmail(email);
//	//		if (ObjectUtils.isEmpty(user)) {
//	//			return false;
//	//		} else {
//	//			return true;
//	//		}
//
//	//	}
//
//	public static void main(String[] args) throws Exception {
//
//		String clientId = "678671317229-u9clb6aanef1lgunrgr1it9q7hrnbuvv.apps.googleusercontent.com";
//		String clientSecret = "_LtSXysFPyM0Y0YOpv0WDE8R";
//		String code = "4/zgEdpNJ2rE3YC1UdRfYgBJHGqhnxsvQRO4Rml8P_U37nMDtUTDCzSjANR1n7l7nopA114CaQUMIpV9B-tnTyXUM";
//		GoogleOAuth2Template googleOAuth2Template = new GoogleOAuth2Template(clientId, clientSecret);
//
//		OAuth2Parameters param = new OAuth2Parameters();
//		googleOAuth2Template.buildAuthenticateUrl(GrantType.AUTHORIZATION_CODE, param);
//		AccessGrant exchangeForAccess = googleOAuth2Template.exchangeForAccess(code, "https://admin.dev.doubledowncasino2.com/certifyAuth2", param);
//		System.out.println(JsonUtil.convertToJsonString(exchangeForAccess));
//
//		String accessToken = exchangeForAccess.getAccessToken();
//		Google google = new GoogleTemplate(accessToken);
//		UserInfo userinfo = google.oauth2Operations().getUserinfo();
//		System.out.println(JsonUtil.convertToJsonString(userinfo));
//		System.out.println(userinfo.getEmail());
//		System.out.println(userinfo.getPicture());
//	}
//
//	//	public void generateLoginCookie2(HttpServletRequest req, HttpServletResponse res, UserInfo userInfo) throws Exception {
//	//
//	//		String userEmail = userInfo.getEmail();
//	//		AdminUser user = adminUserDAO.selectAdminUserByEmail(userEmail);
//	//
//	//		StringBuffer cookie = new StringBuffer();
//	//		cookie.append(userInfo.getId()).append(SiteCookieUtil.SEPERATOR);
//	//		cookie.append(Calendar.getInstance().getTimeInMillis()).append(SiteCookieUtil.SEPERATOR);
//	//		cookie.append(userInfo.getId()).append(SiteCookieUtil.SEPERATOR);
//	//		cookie.append(userInfo.getEmail()).append(SiteCookieUtil.SEPERATOR);
//	//		cookie.append(user.getUid()).append(SiteCookieUtil.SEPERATOR);
//	//		cookie.append(user.getName()).append(SiteCookieUtil.SEPERATOR);
//	//		cookie.append(userInfo.getPicture()).append(SiteCookieUtil.SEPERATOR);
//	//		cookie.append(user.getAuth()).append(SiteCookieUtil.SEPERATOR);
//	//		cookie.append(user.getFb_id()).append(SiteCookieUtil.SEPERATOR);
//	//		cookie.append(user.getAdditional_auth());
//	//
//	//		log.info("cookie data : " + cookie);
//	//
//	//		String cookieValue = SiteCookieUtil.encrypt(cookie.toString(), "UTF-8");
//	//		CookieUtils.setCookie(res, cookieName, cookieValue, cookieExpire, cookieDomain, "/");
//	//	}
//	//	
//	//	/**
//	//	 * 로그인 인증 쿠키 삭제
//	//	 * @param res
//	//	 */
//	//	public void deleteLoginCookie(HttpServletResponse res) {
//	//
//	//		CookieUtils.invalidateCookie(res, cookieName, cookieDomain);
//	//
//	//	}
//
//	private void validateExpireTime(Long expireTime, String accessToken) throws IllegalAccessException {
//
//		if (expireTime != null && expireTime < System.currentTimeMillis()) {
//			log.error("accessToken is expired. refresh token = " + accessToken);
//			throw new IllegalAccessException();
//		}
//	}
//}
