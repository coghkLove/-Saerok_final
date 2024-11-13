
package com.saerok.dy.board.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.saerok.dy.board.model.dto.Board;

@Repository
public class BoardDaoImpl implements BoardDao {

	private final SqlSession sqlSession;

	public BoardDaoImpl(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 공지사항 조회
	@Override
	public List<Board> boardList(SqlSession session) {
		return session.selectList("board.boardAll");
	}

	// 공지사항 상세보기
	@Override
	public Board selectBoardByNo(SqlSession session, int boardNo) {
		return sqlSession.selectOne("board.selectBoardByNo", boardNo);
	}

	// 부서별 게시판 조회
	@Override
	public List<Board> boardPart(SqlSession session) {
		return session.selectList("board.boardPart");

	}

	// 게시글 저장
	@Override
	public void save(Board board) {
		sqlSession.insert("board.save", board);
	}

	
	// 게시글 데이터 저장
	@Override
	public void save(SqlSession session, Board board) {
		// TODO Auto-generated method stub

	}
}