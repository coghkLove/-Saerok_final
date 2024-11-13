package com.saerok.jj.apv.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.saerok.jh.employee.model.dto.Employee;
import com.saerok.jh.employee.model.service.EmployeeService;
import com.saerok.jj.apv.model.dto.AppLetter;
import com.saerok.jj.apv.model.dto.Approval;
import com.saerok.jj.apv.model.service.ApprovalService;

import jakarta.servlet.http.HttpSession;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@AllArgsConstructor
@RequestMapping("/approval")
@Slf4j
public class ApprovalController {

	private final ApprovalService service;
	private final EmployeeService empService;

	// 전체리스트 조회
	@GetMapping("/approvalList.do")
	public ModelAndView selectApproval(ModelAndView model) {
		List<Approval> approval = service.selectApproval();
		List<Employee> emp = empService.selectEmployeeList();
		List<Object> list = new ArrayList<>();
		list.add(approval);
		list.add(emp);
		model.addObject("list", approval);
		model.addObject("listEmp", emp);
		model.setViewName("approval/approvalList");
		return model;
	}

	// 내문서함 조회
	@GetMapping("/myApproval")
	public ModelAndView myApproval(ModelAndView model, Principal loginSession) {
		String empNo = loginSession.getName();
		List<Approval> myApprovalList = service.myApproval(empNo);
		List<Approval> myTodoApprovalList = service.myTodoApprovalList(empNo);
		model.addObject("myApprovalList", myApprovalList);
		model.addObject("myTodoApprovalList", myTodoApprovalList);
		model.setViewName("approval/myApproval");
		return model;
	}

	// 결재선 사원리스트불러오기
	@GetMapping("/checkDept")
	@ResponseBody
	public List<Map<String, Object>> deptName(Integer deptCode) {
		return service.deptName(deptCode);
	}

	// 폼양식 AJAX 이용
	@GetMapping("/docForms")
	public String loadDocumentForm(@RequestParam(value = "docType", defaultValue = "D1") String docType, Model model) {
		switch (docType) {
		case "D1":
			return "approval/docForms";// 일반
		case "D2":
			return "approval/vacationForm"; // 휴가
		case "D3":
			return "approval/cashForm"; // 지출
		default:
			throw new IllegalArgumentException("지정된 양식이 없습니다.");
		}
	}

	// 기본 폼양식
	@GetMapping("/basicForm")
	public void basicForm() {
	}

	// 폼 등록
	@PostMapping("/insertAppLetter.do")
	@Transactional
	public String insertAppLetter(MultipartFile upFile, AppLetter basicForm, String apporvalData, Model model,
			HttpSession session, @RequestParam String loginEmp) {

		List<Map> approvalList = null;
		try {
			approvalList = new ObjectMapper().readValue(apporvalData, List.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		// service.insertAppLetter(basicForm, approvalList);

		int result = 0;
		try {
			if (upFile != null && !upFile.isEmpty()) {
				String originalFileName = upFile.getOriginalFilename();
				String destFileName = System.currentTimeMillis() + "_" + originalFileName;
				String path = session.getServletContext().getRealPath("/resources/upload/approvalFile");
				File destFile = new File(path, destFileName);
				upFile.transferTo(destFile);
				basicForm.setOriFileName(originalFileName);
				basicForm.setReFileName(destFileName);
				result = service.insertAppLetter(basicForm, approvalList);

				String msg, loc;
				if (result > 0) {
					return "redirect:/approval/approvalList.do";
				} else {
					msg = "등록실패";
					loc = "/";
				}

				model.addAttribute("msg", msg);
				model.addAttribute("loc", loc);
			} else {
				// 파일이 비어있는 경우 처리
				model.addAttribute("msg", "파일이 비어있습니다.");
				model.addAttribute("loc", "/");
				return "common/msg";
			}
		} catch (IOException e) {
			e.printStackTrace();
			model.addAttribute("msg", "파일 업로드 실패!!!");
			model.addAttribute("loc", "/");
		}

		return "common/msg";
	}

	// 상세페이지
	@GetMapping("/approvalDetailView")
	public void approvalDetailView(String appSeq, Model model) {
		Approval approvalDetail = service.approvalDetailView(appSeq);
		model.addAttribute("approvalDetailView", approvalDetail);
	}

	// 결재 승인 반려 //최종결재완료
	@PostMapping("/updateApprovalStatus")
	@ResponseBody
	public Map<String,String> updateApprovalStatus(
			@RequestParam Map<String, String> paramMap, HttpSession session,
			Principal loginMember) {
	    
		paramMap.put("empNo", loginMember.getName());
		// 승인 또는 반려 처리
	    int updateResult = service.updateApprovalStatus(paramMap);

	    String apvState = paramMap.get("apvState");
	    String appSeq = paramMap.get("appSeq");
	    String approvalMessage="",resultCode="";
	    // 승인 처리
	    if(updateResult>0) {
		    if ("승인".equals(apvState)) {
		    	resultCode="300";
		    	approvalMessage= "결재가 승인 처리되었습니다.";
		    }
	
		    // 반려 처리 
		    if ("반려".equals(apvState)) {
		        String returnReason = paramMap.get("returnReason");
		        resultCode="200";
		        approvalMessage="결재가 반려 처리되었습니다. 반려 사유: " + (returnReason != null ? returnReason : "");
		    }
	    }

	   return Map.of("approvalMessage",approvalMessage,"resultCode",resultCode);
	}



}
