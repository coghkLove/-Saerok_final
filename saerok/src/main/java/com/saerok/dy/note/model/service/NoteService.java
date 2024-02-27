package com.saerok.dy.note.model.service;

import java.util.List;

import com.saerok.dy.note.model.dto.Note;
import com.saerok.jh.employee.model.dto.Employee;

public interface NoteService {
   

    // 받은 쪽지함 조회
    List<Note> getReceivedNotes(String revName);
 
    // 보낸 쪽지함 조회
    List<Note> getSentNotes(String empNo);

    // 이름으로 사원 조회
    List<Employee> selectEmpByName(String empName);

    // 쪽지 전송
	boolean sendNote(Note note);

	// 번호로 쪽지 가져오기
	Note getNoteByNoteNo(int noteNo);

	// 쪽지 삭제
	int deleteNote(Note noteNo);
}