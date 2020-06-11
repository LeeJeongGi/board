package com.spring.board.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.board.dto.UserDto;
import com.spring.board.form.UserForm;

@Repository
public class UserDao {

	@Resource(name = "sqlSession")
	private SqlSession sqlSession;

	private static final String NAMESPACE = "com.spring.board.boardMapper";

	/** 게시판 - 회원가입 */
	public int getRegister(UserForm userForm) throws Exception {
		return sqlSession.insert(NAMESPACE + ".getRegister", userForm);
	}

	/** 게시판 - 로그인 */
	public UserDto getLogin(UserForm userForm) throws Exception {
		return sqlSession.selectOne(NAMESPACE + ".getLogin", userForm);
	}

	/** 게시판 - 관리자 유저 조회 */
	public List<UserDto> getUserList() throws Exception {

		return sqlSession.selectList(NAMESPACE + ".getUserList");
	}

	/** 게시판 - 나의 리스트 조회 */
	public List<UserDto> getMyPage(UserForm userForm) throws Exception {

		return sqlSession.selectList(NAMESPACE + ".getMyPage", userForm);
	}

	/** 이웃 추가 */
	public int getFriend(UserForm userForm) throws Exception {
		return sqlSession.insert(NAMESPACE + ".getFriend", userForm);
	}

	/** 이웃 삭제 */
	public int delFriend(UserForm userForm) throws Exception {
		return sqlSession.insert(NAMESPACE + ".delFriend", userForm);
	}

	/** 삭제한 이웃 다시 이웃 추가 */
	public int tgetFriend(UserForm userForm) throws Exception {
		return sqlSession.insert(NAMESPACE + ".tgetFriend", userForm);
	}

	/** 친구들 불러오기 */
	public List<UserDto> getFriendList(UserForm userForm) throws Exception {

		return sqlSession.selectList(NAMESPACE + ".getFriendList", userForm);
	}

	/** 친구 게시판 수 */
	public int getFriendCnt(UserForm userForm) throws Exception {

		return sqlSession.selectOne(NAMESPACE + ".getFriendCnt", userForm);
	}

	/** 프로필 정보 가져오기 */
	public UserDto getProfile(UserForm userForm) throws Exception {
		return sqlSession.selectOne(NAMESPACE + ".getProfile", userForm);
	}

	/** 게시판 - 회원가입 */
	public int getIntroduce(UserForm userForm) throws Exception {
		return sqlSession.update(NAMESPACE + ".getIntroduce", userForm);
	}

	/** 디비 메일 확인 */
	public UserDto selectUser(UserForm userForm) throws Exception {
		return sqlSession.selectOne(NAMESPACE + ".selectUser", userForm);
	}
}
