package com.saerok.dy.note.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.saerok.dy.note.model.dao.NoteDao;
import com.saerok.dy.note.model.dto.Note;
import com.saerok.jh.employee.model.dto.Employee;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NoteServiceImpl implements NoteService {

	private final NoteDao dao;
	private final SqlSession session;

	// 받은 쪽지 조회
	@Override
	public List<Note> getReceivedNotes(String revName) {
		return dao.getReceivedNotes(session, revName);
	}

	// 보낸 쪽지 조회
	@Override
	public List<Note> getSentNotes(String empNo) {
		return dao.getSentNotes(empNo, session);
	}

	// 이름으로 사원 조회
	@Override
	public List<Employee> selectEmpByName(String empName) {
		return dao.selectEmpByName(session);
	}

	@Override
	@Transactional
	public boolean sendNote(Note note) {
		int result = dao.insertNote(session, note);
		return result > 0;
	}

	// 쪽지 삭제
	@Override
	public int deleteNote(Note noteNo) {
		return dao.deleteNote(session, noteNo);
	}

	// 번호로 쪽지 가져오기
	@Override
	public Note getNoteByNoteNo(int noteNo) {
		return dao.getNoteByNoteNo(noteNo, session);
	}
}
