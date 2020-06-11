package com.spring.board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.common.ResultUtil;
import com.spring.board.dto.BoardDto;
import com.spring.board.form.BoardForm;
import com.spring.board.form.UserForm;
import com.spring.board.service.BoardService;

@Controller
@RequestMapping(value = "/board")
public class BoardController {

	@Autowired
	private BoardService boardService;
	@Autowired
	private HttpSession session;

	private static Log log = LogFactory.getLog(BoardController.class);

	/** 게시판 - 목록 페이지 이동 */
	@RequestMapping(value = "/boardList")
	public String boardList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "board/boardList";
	}

	/** 게시판 - 목록 조회 */
	@RequestMapping(value = "/getBoardList")
	@ResponseBody
	public ResultUtil getBoardList(HttpServletRequest request, HttpServletResponse response, BoardForm boardForm) throws Exception {

		log.debug("작성자는 ? " + boardForm.getBoard_writer());

		//boardForm.setBoard_writer((String) session.getAttribute("userID"));
		ResultUtil resultUtils = boardService.getBoardList(boardForm);

		return resultUtils;
	}

	/** 게시판 - 상세 페이지 이동 */
	@RequestMapping(value = "/boardDetail")
	public String boardDetail(HttpServletRequest request, HttpServletResponse response, Model model,
			@RequestParam int boardSeq) throws Exception {
		BoardDto boardDto = new BoardDto();
		BoardForm boardForm = new BoardForm();

		boardForm.setBoard_seq(boardSeq);
		boardForm.setSearch_type("S");

		boardDto = boardService.getBoardDetail(boardForm);
		model.addAttribute("boardDto", boardDto);

		return "board/boardDetail";
	}

	/** 게시판 - 상세 조회 */
	@RequestMapping(value = "/getBoardDetail")
	@ResponseBody
	public BoardDto getBoardDetail(HttpServletRequest request, HttpServletResponse response, BoardForm boardForm, Model model) throws Exception {
		BoardDto boardDto = boardService.getBoardDetail(boardForm);

		return boardDto;
	}

	/** 게시판 - 작성 페이지 이동 */
	@RequestMapping(value = "/boardWrite")
	public String boardWrite(HttpServletRequest request, HttpServletResponse response) throws Exception {
		log.debug("userID : " + request.getParameter("userID"));
		return "board/boardWrite";
	}

	/** 게시판 - 등록 */
	@RequestMapping(value = "/insertBoard")
	@ResponseBody
	public BoardDto insertBoard(HttpServletRequest request, HttpServletResponse response, BoardForm boardForm) throws Exception {

		log.debug("userID : " + boardForm.getBoard_writer());
		BoardDto boardDto = boardService.insertBoard(boardForm);

		return boardDto;
	}

	/** 게시판 - 삭제 */
	@RequestMapping(value = "/deleteBoard")
	@ResponseBody
	public BoardDto deleteBoard(HttpServletRequest request, HttpServletResponse response, BoardForm boardForm) throws Exception {

		BoardDto boardDto = boardService.deleteBoard(boardForm);
		return boardDto;
	}

	/** 게시판 - 수정 페이지 이동 */
	@RequestMapping(value = "/boardUpdate")
	public String boardUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return "board/boardUpdate";
	}

	/** 게시판 - 수정 */
	@RequestMapping(value = "/updateBoard")
	@ResponseBody
	public BoardDto updateBoard(HttpServletRequest request, HttpServletResponse response, BoardForm boardForm) throws Exception {

		BoardDto boardDto = boardService.updateBoard(boardForm);

		return boardDto;
	}

	/** 게시판 - 답글 페이지 이동 */
	@RequestMapping(value = "/boardReply")
	public String boardReply(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return "board/boardReply";
	}

	/** 게시판 - 답글 등록 */
	@RequestMapping(value = "/insertBoardReply")
	@ResponseBody
	public BoardDto insertBoardReply(HttpServletRequest request, HttpServletResponse response, BoardForm boardForm) throws Exception {
		BoardDto boardDto = boardService.insertBoardReply(boardForm);

		return boardDto;
	}

	//	/** 게시판 - 첨부파일 다운로드 */
	//	@RequestMapping("/fileDownload")
	//	public String fileDownload(BoardForm boardForm, HttpServletRequest request, HttpServletResponse response,
	//			@RequestParam int boardSeq, @RequestParam List<MultipartFile> files) throws Exception {
	//		BoardFileForm boardFileForm = new BoardFileForm();
	//		boardForm.setBoard_seq(boardSeq);
	//		boardForm.setFiles(files);
	//		List<BoardFileForm> boardFileList = boardService.getBoardFileInfo(boardForm);
	//		Map<String, Object> fileInfo = new HashMap<String, Object>();
	//		for (int i = 0; i < boardFileList.size(); i++) {
	//			boardFileForm = boardFileList.get(i);
	//
	//			/** 첨부파일 정보 조회 */
	//
	//			fileInfo.put("fileNameKey", boardFileForm.getFile_name_key());
	//			fileInfo.put("fileName", boardFileForm.getFile_name());
	//			fileInfo.put("filePath", boardFileForm.getFile_path());
	//		}
	//		ModelAndView modelAndView = new ModelAndView("fileDownloadUtil", "fileInfo", fileInfo);
	//		
	//		return "board/boardDetail";
	//	}
	//	/** 게시판 - 관리자 페이지 이동 - 미완성 */
	//	@RequestMapping(value = "/friend")
	//	public String friend(Model model, BoardForm boardForm) throws Exception {
	//		UserForm userForm = new UserForm();
	//		userForm.setUserID((String) session.getAttribute("userID"));
	//		List<BoardDto> boardDto = boardService.getFboardList(userForm);
	//		model.addAttribute("boardDto", boardDto);
	//
	//		return "board/friend";
	//	}

	/** 게시판 - 이웃 페이지 이동 */
	@RequestMapping(value = "/friend")
	public String friend(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "board/friend";
	}

	/** 게시판 - 이웃 글 조회 */
	@RequestMapping(value = "/getfriend")
	@ResponseBody
	public ResultUtil getfriend(HttpServletRequest request, HttpServletResponse response, BoardForm boardForm) throws Exception {

		int current_page_no = boardForm.getCurrent_page_no();
		String function_name = boardForm.getFunction_name();
		UserForm userForm = new UserForm();
		userForm.setUserID((String) session.getAttribute("userID"));
		boardForm.setBoard_writer((String) session.getAttribute("userID"));
		ResultUtil resultUtils = boardService.getFboardList(userForm, current_page_no, function_name);

		return resultUtils;
	}
}
