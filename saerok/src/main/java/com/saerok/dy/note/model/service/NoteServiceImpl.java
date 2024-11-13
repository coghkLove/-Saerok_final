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
      return result > 0; // 삼항 연산자로 변경하여 간결하게 표현
   }

   /*
    * @Override
    * 
    * @Transactional public boolean deleteToTrash(String empNo, int noteNo) { //
    * 휴지통으로 이동할 쪽지를 조회 Note note = dao.getNoteByNoteNo(noteNo, session);
    * 
    * // 로그인한 사용자의 쪽지만 삭제 가능하도록 if (note != null &&
    * empNo.equals(note.getSndEmpNo())) { // 쪽지의 DEL_YN 상태를 'Y'로 변경하여 휴지통으로 이동
    * note.setDelYn("Y"); int result = dao.updateNoteDelStatus(session, note);
    * return result > 0; } return false; }
    */

   @Override
   @Transactional
   public boolean deleteToTrash(String empNo, int noteNo) {
      Note note = dao.getNoteByNoteNo(noteNo, session);

      if (note != null && empNo.equals(note.getSndEmpNo())) {
         note.setDelYn("Y");
         int result = dao.updateNoteDelStatus(session, note);
         return result > 0;
      }
      return false;
   }

   // 쪽지 번호로 쪽지 가져오기
   @Override
   public Note getNoteByNoteNo(int noteNo) {
      return dao.getNoteByNoteNo(noteNo, session);
   }
}