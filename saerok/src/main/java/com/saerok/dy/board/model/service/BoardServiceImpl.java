package com.saerok.dy.board.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.saerok.dy.board.model.dao.BoardDao;
import com.saerok.dy.board.model.dto.Board;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {

	private final BoardDao dao;
	private final SqlSession session;

	@Override
	public List<Board> boardList() {
		return dao.boardList(session);
	}

	// 공지사항 상세보기
	@Override
	public Board selectBoardByNo(int boardNo) {
		return dao.selectBoardByNo(session, boardNo);
	}

	// 부서별 게시판 구현
	@Override
	public List<Board> boardPart() {
		return dao.boardPart(session);
	}

	@Override
	public void save(Board board) {
		
		dao.save(board);
	}
}
