package com.spring.board;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring.board.service.BoardService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:/config/test-servlet-context.xml", "classpath:/config/test-root-context.xml" })
public class BoardTest {

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());

	@SuppressWarnings("unused")
	@Autowired
	private BoardService boardService;

	@Test
	public void test() {

		try {

			//List<BoardDto> boardList = boardService.getBoardList(boardForm);

			//logger.info("boardList.size() : [{}]", boardList.size());

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
