package com.saerok.dy.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.saerok.dy.board.model.dto.Board;
import com.saerok.dy.board.model.service.BoardService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private final BoardService boardService;

	// 공지사항 페이지로 이동
	@GetMapping("/boardlist")
	public String noticeList(Model model) {
		List<Board> boardList = boardService.boardList();
		model.addAttribute("boardList", boardList);
		return "board/boardList";
	}

	// 공지사항 상세보기 페이지
	@GetMapping("/boardview")
	public String selectBoardByNo(@RequestParam int boardNo, Model model) {
		
		// 게시글 상세보기 로직 구현
		Board board = boardService.selectBoardByNo(boardNo);
		model.addAttribute("b", board);
		return "board/boardView";
	}

	// 공지사항 작성 페이지로 이동하는 로직
	@GetMapping("/boardwrite")
	public String boardWrite() {
		return "board/boardWrite";
	}

	// 게시글 저장
	@PostMapping("/save")
	public String saveBoard(@ModelAttribute Board board, Model model) {
		
		// 현재 로그인 중인 사원의 사원번호
		String empNo = SecurityContextHolder.getContext().getAuthentication().getName();
		board.setRegId(empNo);
		model.addAttribute("content", board.getBoardContent());
		// 게시글 저장 로직 수행
		try {
			boardService.save(board);
			
			// 게시글 저장 후 목록 불러오기
			List<Board> boardList = boardService.boardList();
			model.addAttribute("boardList", boardList);
			model.addAttribute("msg", "new ! 게시글을 등록하였습니다.");
			model.addAttribute("loc", "board/boardlist");
		} catch (Exception e) {
			model.addAttribute("msg", "게시글을 다시 작성해주세요.");
			model.addAttribute("loc", "board/boardwrite");
		}
		return "common/msg";
	}
}