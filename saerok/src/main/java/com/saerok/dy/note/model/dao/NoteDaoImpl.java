package com.saerok.dy.note.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.saerok.dy.note.model.dto.Note;
import com.saerok.jh.employee.model.dto.Employee;

@Repository
public class NoteDaoImpl implements NoteDao {

	// 받은 쪽지 조회
	@Override
	public List<Note> getReceivedNotes(SqlSession session, String revName) {
		return session.selectList("note.getReceivedNotes", revName);
	}

	// 보낸 쪽지 조회
	@Override
	public List<Note> getSentNotes(String empNo, SqlSession session) {

		Map<String, Object> params = new HashMap<>();
		params.put("empNo", empNo);
		return session.selectList("note.getSentNotes", params);
	}

	// 이름으로 사원 조회
	@Override
	public List<Employee> selectEmpByName(SqlSession session) {
		return session.selectList("note.selectEmpByName");
	}

	@Override
	public int insertNote(SqlSession session, Note note) {
		return session.insert("note.insertNote", note);
	}

	// 쪽지 삭제여부
	@Override
	public int updateNoteDelStatus(SqlSession sessoin, Note note) {
		return 0;
	}

	// 쪽지 번호로 가져오기
	@Override
	public Note getNoteByNoteNo(int noteNo, SqlSession session) {
		return session.selectOne("note.getNoteByNoteNo", noteNo);
	}

	// 쪽지 삭제
	@Override
	public int deleteNote(SqlSession session, Note noteNo) {
		return session.delete("note.deleteNote", noteNo);
	}
}