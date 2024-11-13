package com.saerok.jh.employee.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.saerok.jh.employee.model.dto.Employee;
import com.saerok.jh.employee.model.service.EmployeeService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/human")
public class EmployeeController {
	@Autowired
	private final EmployeeService service;

	// 사원등록 화면전환
	@GetMapping("/insertemp")
	public String insertEmployee() {
		return "employee/insertemployee";

	}

	// 사원등록
	@PostMapping("/insertempEnd")
	public String insertEmployeeEnd(MultipartFile oriFileName, @RequestParam Map<String, Object> param, Model model,
			HttpSession session) {

		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String pwd = (String) param.get("empPw");
		String newpwd = encoder.encode(pwd);
		System.out.println("기존비밀번호" + pwd);
		System.out.println("암호화된 비밀번호" + newpwd);
		param.put("empPw", newpwd);

		int result = 0;
		log.debug("{}", oriFileName.getOriginalFilename());
		log.debug("{}", param);
		try {
			if (!oriFileName.isEmpty()) {
				// 원본 파일명

				String originalFileName = oriFileName.getOriginalFilename();

				// 서버에 저장할 파일명 생성 (현재 시간을 사용)
				String destFileName = System.currentTimeMillis() + "_" + originalFileName;

				// 파일을 서버에 저장하는 로직
				String path = session.getServletContext().getRealPath("/resources/upload/profile/");
				File destFile = new File(path, destFileName);
				oriFileName.transferTo(destFile);

				param.put("oriFileName", oriFileName);
				param.put("destFileName", destFileName);
				result = service.insertEmployeeEnd(param);
			}

			String msg, loc;
			if (result > 0) {
				return "redirect:/human/selectemp";

			} else {
				msg = "사원등록실패";
				loc = "";
			}

			model.addAttribute("msg", msg);
			model.addAttribute("loc", loc);

		} catch (IOException e) {
			e.printStackTrace();
			model.addAttribute("msg", "파일 업로드 실패!!!");
			model.addAttribute("loc", "index");
		}

		return "common/msg";
	}

	// 전체사원리스트
	@GetMapping("/selectemp")
	public String searchEmployee(Model model) {
		List<Employee> empList = service.selectEmployeeList();
		// log.debug("{}",empList);
		model.addAttribute("empList", empList);
		return "employee/empList";

	}

	// 사원수정
	@PostMapping("/updateemp")
	@ResponseBody
	public String updateEmployee(@RequestBody Employee e, Model model) {
		System.out.println(e);
		int result = service.updateEmployee(e);

		return result > 0 ? "성공" : "실패";
	}

	// 사원삭제
	@PostMapping("/deleteemp")
	@ResponseBody
	public String deleteEmployee(@RequestBody Employee empNo, Model model) {
		System.out.println(empNo);
		int result = service.deleteEmployee(empNo);

		return result > 0 ? "성공" : "실패";
	}

	// 에러페이지
	@GetMapping("/errorPage")
	public String error() {
		return "common/errorpage";

	}

	// 조직도 화면전환
	@GetMapping("/groupemp")
	public String groupEmployee() {
		return "employee/groupList";

	}

}