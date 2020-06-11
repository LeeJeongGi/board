package com.spring.board.common;

import com.spring.board.dto.BoardDto;
import com.spring.board.form.BoardForm;

public class PageUtil {

	public static String setPageUtil_2(BoardForm boardForm) {

		BoardDto boardDto = new BoardDto();
		String page = "";

		String boardSubject = boardForm.getBoard_subject();
		int boardHits = boardForm.getBoard_hits();
		String boardWriter = boardForm.getBoard_writer();
		String insDate = boardForm.getIns_user_id();
		//int filesLen = boardForm.getBoard_file().length();

		page += "<tr>";
		page += "<th>제목</th>";
		page += "<td>" + boardSubject + "</td>";
		page += "<th>조회수</th>";
		page += "<td>" + boardHits + "</td>";
		page += "</tr>";
		page += "<tr>";
		page += "<th>작성자</th>";
		page += "<td>" + boardWriter + "</td>";
		page += "<th>작성일시</th>";
		page += "<td>" + insDate + "</td>";
		page += "</tr>";
		page += "<tr>";
		page += "<th>내용</th>";
		page += "<td colspan='3'>" + boardSubject + "</td>";
		page += "</tr>";

		boardDto.setPage(page);
		boardDto.setBoard_subject(boardSubject);
		boardDto.setBoard_hits(boardHits);
		boardDto.setBoard_writer(boardWriter);
		boardDto.setIns_date(insDate);
		return boardDto.getPage();
	}
}
