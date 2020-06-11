
package com.spring.board.service;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.UserDao;
import com.spring.board.dto.UserDto;
import com.spring.board.form.UserForm;

@Service
public class UserService {
	@Autowired
	private UserDao userDao;

	private static Log log = LogFactory.getLog(UserService.class);

	// 회원 가입 처리
	public UserDto getRegister(UserForm userForm) throws Exception {
		UserDto userDto = new UserDto();

		log.debug("============회원 가입 처리==============");
		int insertCnt = 0;
		insertCnt = userDao.getRegister(userForm);

		if (insertCnt > 0) {
			userDto.setResult("SUCCESS");
		} else {
			userDto.setResult("FAIL");
		}

		return userDto;
	}

	public UserDto getLogin(UserForm userForm) throws Exception {
		UserDto userDto = new UserDto();
		log.debug("==================로그인 처리=========================");

		userDto = userDao.getLogin(userForm);

		if (userDto.getUserPassword().equals(userForm.getUserPassword())) {
			userDto.setResult("SUCCESS");
		} else {
			userDto.setResult("FAIL");
		}

		return userDto;
	}

	public List<UserDto> getUserList() throws Exception {
		log.debug("==================유저 리스트 처리2=========================");

		List<UserDto> list = userDao.getUserList();

		return list;
	}

	public List<UserDto> getMyPage(UserForm userForm) throws Exception {
		log.debug("========나의 글 리스트 처리 ==============");

		List<UserDto> list = userDao.getMyPage(userForm);

		return list;
	}

	public UserDto getFriend(UserForm userForm) throws Exception {
		log.debug("========이웃 추가 기능 처리 ==============");
		UserDto userDto = new UserDto();
		int insertCnt = 0;

		//유저 항목에도 있고 삭제여부가 n인경우 이미 이웃이기 때문에 추가 등로을 못하게 막아준다.
		List<UserDto> friend = userDao.getFriendList(userForm);
		for (int i = 0; i < friend.size(); i++) {

			if (userForm.getUserFriend().equals(friend.get(i).getUserFriend()) && friend.get(i).getDel_yn().equals("N")) {
				userDto.setResult("FAIL2");
				return userDto;
			}
		}
		//유저 항목에는 있지만 지운 경험이 있을 경우 
		//del_yn을 y->n으로 변경해준다
		for (int i = 0; i < friend.size(); i++) {
			if (userForm.getUserFriend().equals(friend.get(i).getUserFriend())) {

				int updateFriend = userDao.tgetFriend(userForm);
				if (updateFriend > 0) {
					userDto.setResult("SUCCESS");

				} else {
					userDto.setResult("FAIL");
				}
				return userDto;
			}
		}

		insertCnt = userDao.getFriend(userForm);

		if (insertCnt > 0) {
			userDto.setResult("SUCCESS");

		} else {
			userDto.setResult("FAIL");
		}

		return userDto;
	}

	public UserDto delFriend(UserForm userForm) throws Exception {
		log.debug("======이웃 삭제 처리=========");
		UserDto userDto = new UserDto();
		int updateCnt = 0;

		updateCnt = userDao.delFriend(userForm);

		if (updateCnt > 0) {
			userDto.setResult("SUCCESS");

		} else {
			userDto.setResult("FAIL");
		}
		return userDto;
	}

	public UserDto getProfile(UserForm userForm) throws Exception {
		UserDto userDto = new UserDto();
		log.debug("==================유저 프로필 정보 추출=========================");

		if (userForm.getUserID() == null) {
			return userDto;
		}

		userDto = userDao.getProfile(userForm);

		return userDto;
	}

	public UserDto getIntroduce(UserForm userForm) throws Exception {
		UserDto userDto = new UserDto();
		log.debug("==================유저 소개글 저장=========================");
		int insertCnt = userDao.getIntroduce(userForm);

		if (insertCnt > 0) {
			userDto.setResult("SUCCESS");

		} else {
			userDto.setResult("FAIL");
		}

		return userDto;
	}

	public List<UserDto> getFriendList(UserForm userForm) throws Exception {

		log.debug("==================친구 리스트 추출=========================");

		List<UserDto> friend = userDao.getFriendList(userForm);

		//		for (int i = 0; i < friend.size(); i++) {
		//			if (friend.get(i).getDel_yn().equals("Y")) {
		//				friend.remove(i);
		//			}
		//		}

		return friend;
	}

	public boolean verifyUser(UserForm userForm) throws Exception {
		log.debug("==================디비에 있는 값인지 확인=========================");

		UserDto user = userDao.selectUser(userForm);

		log.debug("받아오는 이메일 : " + user.getUserEmail());
		log.debug("구글에 있는 이메일 : " + userForm.getUserEmail());

		if (user.getUserEmail().equals(userForm.getUserEmail())) {
			log.debug("true");
			return true;
		}

		return false;
	}

}