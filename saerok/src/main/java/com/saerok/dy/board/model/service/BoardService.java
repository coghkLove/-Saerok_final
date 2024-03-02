package com.saerok.dy.board.model.service;

import java.util.List;

import com.saerok.dy.board.model.dto.Board;

public interface BoardService {
    List<Board> boardList();
  
    // 공지사항 상세보기
    Board selectBoardByNo(int boardNo);
    
    // 부서별 게시판 구현
    List<Board> boardPart();
    
    // 게시글 저장
    void save(Board board);
   
}