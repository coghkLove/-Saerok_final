
package com.saerok.dy.board.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.saerok.dy.board.model.dto.Board;

public interface BoardDao {

	// 공지사항 조회
	List<Board> boardList(SqlSession session);

	// 부서별 조회
	List<Board> boardPart(SqlSession session);
	
	// 데이터 가져오기
	void save(SqlSession session, Board board);
	
	//공지사항 상세보기
	Board selectBoardByNo(SqlSession session, int boardNo);

	// 쪽지 저장
	void save(Board board);

}
