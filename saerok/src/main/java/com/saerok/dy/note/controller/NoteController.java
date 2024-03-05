package com.saerok.dy.note.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.saerok.dy.note.model.dto.Note;
import com.saerok.dy.note.model.service.NoteService;
import com.saerok.jh.employee.model.dto.Employee;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/note")

public class NoteController {

	@Autowired
	private final NoteService noteService;

	// 받은 쪽지함 페이지로 이동
	@GetMapping("/get")
	public String readNotePage(Model model, Principal loginMember) {

		List<Note> receivedNotes = noteService.getReceivedNotes(loginMember.getName());
		model.addAttribute("receivedNotes", receivedNotes);
		return "note/noteGet";
	}

	// 보낸 쪽지함 페이지로 이동
	@GetMapping("/send")
	public String sendNotePage(Principal loginSession, Model model) {
		// 현재 로그인 중인 사원의 사원번호
		String empNo = loginSession.getName();

		List<Note> sentNotes = noteService.getSentNotes(empNo);
		model.addAttribute("sentNotes", sentNotes);
		return "note/noteSend";
	}

	@PostMapping("/basket")
	@ResponseBody
	public String deleteNote(@RequestBody Note note, Model model) {
		int result = noteService.deleteNote(note);
		return result > 0 ? "성공" : "실패";
	}

	// 이름으로 사원 조회
	@GetMapping("/selectEmpByName")
	@ResponseBody
	public Map selectEmpByName(Model model, HttpServletRequest request) {
		String empName = request.getParameter("empName");
		List<Employee> empList = noteService.selectEmpByName(empName);
		Map result = new HashMap();
		result.put("empList", empList);

		return result;
	}

	@PostMapping("/send")
	@ResponseBody
	public String sendNote(Principal loginSession, @RequestParam String recipientName,
			@RequestParam String messageText) {

		// 현재 로그인 중인 사원의 사원번호
		String empNo = loginSession.getName();

		Note note = new Note();
		note.setRevEmpNo(recipientName.split(" ")[0]);
		note.setNoteContent(messageText);
		note.setSndEmpNo(empNo);
		// note.setModId(empNo);

		boolean isSentSuccessfully = noteService.sendNote(note);

		if (isSentSuccessfully) {
			return "쪽지를 전송하였습니다.";
		} else {
			return "쪽지 전송에 실패하였습니다.";
		}
	}

	// 쪽지 내용 가져오기
	@GetMapping("/getNoteByNoteNo")
	@ResponseBody
	public Note getNoteByNoteNo(int noteNo) {
		return noteService.getNoteByNoteNo(noteNo);
	}

}
