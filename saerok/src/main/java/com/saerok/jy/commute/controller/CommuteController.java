package com.saerok.jy.commute.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.saerok.jh.employee.model.dto.Employee;
import com.saerok.jh.employee.model.service.EmployeeService;
import com.saerok.jy.commute.dto.Commute;
import com.saerok.jy.commute.dto.CommuteCal;
import com.saerok.jy.commute.service.CommuteService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


@Controller
@RequestMapping("/commute")
public class CommuteController {

	@Autowired
	private CommuteService commuteService;
	
	@Autowired
	private EmployeeService employeeService;
	
	DateTimeFormatter dayff = DateTimeFormatter.ofPattern("yy-MM"); //날짜 패턴 변경
	DateTimeFormatter dayfff = DateTimeFormatter.ofPattern("yyyy-MM-dd"); //날짜 패턴 변경
	DateTimeFormatter dayf = DateTimeFormatter.ofPattern("yy-MM-dd"); //날짜 패턴 변경
	LocalDateTime now = LocalDateTime.now(); //현재 시간
	
	// 금일 근무 기록 조회
	@GetMapping("/commute.do")
	public ResponseEntity<List<Commute>> selectCommuteList(HttpSession session, ModelAndView mv, Principal loginSession) {

		// 현재 로그인 중인 사원의 사원번호
		String empNo = loginSession.getName();
		String time = now.format(dayf); //현재날짜를 yy/MM/dd 형식으로 변경
		 Map<String,Object> param = new HashMap<>();
		 param.put("empNo", empNo);
		 param.put("time", time);
		
		 List<Commute> commuteList = commuteService.selectCommuteWorkList(param);
		 
		 return ResponseEntity.ok()
					.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
					.body(commuteList);
		
		
	}

	//출근하기 버튼 누를시 근무 시작 일시,시간 저장
	@ResponseBody
	@PostMapping("/workIn.do")
	public ResponseEntity<?> insertCommuteStatus(Principal loginSession) {
		String empNo = loginSession.getName();
	    
	    String time = now.format(dayf); //현재날짜를 yy/MM/dd 형식으로 변경
	    Map<String,Object> param = new HashMap<>();
	    Map<String,Object> status = new HashMap<>();
	    
	    param.put("empNo", empNo);
	    param.put("time", time);

	    Commute commute = commuteService.selectExsistWorkInList(param); //금일 출근기록이 있는지 확인

	    if(commute == null) {
	        int result = commuteService.insertCommuteStatus(empNo); // insert
	        status.put("status", "출근");
	    }else if(commute.getInDtime() != null) {
	    	status.put("status", "이미출근");
	    }
//	    
//	    if(commute.getStatus().equals("반차")) {
//	    	int result = commuteService.updateStartWork(param); //반차일시 반차 행 update
//	    	status.put("status", "성공");
//		}else if(commute.getStatus().equals("출장")) {
//			status.put("status", "출장");
//		}else if(commute.getStatus().equals("연차")) {
//			status.put("status", "연차");
//	    }else {
//	    	status.put("status", "실패");
//	    }
//	    
	    return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
				.body(status);
	}
	
	
	//퇴근하기 버튼 누를시 퇴근시간 update
	@PostMapping("/workOut.do")
	public ResponseEntity<?> updateCommuteEndTime(Principal loginSession){
		String empNo = loginSession.getName();
		String time = now.format(dayf);
		Map<String,Object> param = new HashMap<>();
		Map<String,Object> status = new HashMap<>();
		param.put("empNo", empNo);
		param.put("time", time);
		 
		Commute commute = commuteService.selectExsistWorkInList(param);
		
//		if(commute.getInDtime() != null) {
//	        int result = commuteService.updateCommuteEndTime(param); 
//	        status.put("status", "퇴근");
//	    }else if(commute.getOutDtime() != null) {
//	    	status.put("status", "이미퇴근");
//	    }
//		if (commute != null) {
//		    if (commute.getInDtime() != null) {
//		        int result = commuteService.updateCommuteEndTime(param);
//		        if (result > 0) {
//		            status.put("status", "퇴근");
//		        } else {
//		            status.put("status", "이미 퇴근");
//		        }
//		    }
//		} else {
//		    status.put("status", "출근 기록이 없음");
//		}
		
		if(commute == null) {
			status.put("status","출근전");
		}
		else if(commute.getOutDtime() == null ) {
			//퇴근시간 업데이트
			int result = commuteService.updateCommuteEndTime(param);
			status.put("status", "퇴근");	
		}
		else {
			status.put("status", "이미 퇴근");
		}
			
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
				.body(status);
	}
	
	//퇴근버튼 눌렀을시 오늘 근무시간 업데이트
	@PostMapping("/updateWorkTime.do")
	public ResponseEntity<?> updateWorkTime(Long daytimes, Principal loginSession) {
		
		long daytime = daytimes; // 기본근무시간
		long overtime = 0; //연장근무시간
		
		// 5시간 이상 일했을 시 점심시간 1시간 제외
		if(daytimes > 18000000) {
			daytime = daytimes - 3600000;
		}
		
		//근무시간이 8시간이 넘었을때 기본근무시간과 연장근무시간 처리
		if(daytime > 28800000) {
			overtime = daytime - 28800000;
			daytime = 28800000;
		}
		
		String empNo = loginSession.getName();
		String time = now.format(dayf);
		
		Map<String,Object> param = new HashMap<>();
		param.put("empNo", empNo);
		param.put("time", time);
		param.put("daytime", daytime);
		param.put("overtime", overtime);
		
		Commute commute = commuteService.selectCommuteList(param);
		int result = 0;
		if(commute.getStatus().equals("반차")) {
			result = commuteService.updateHalfDayOff(param); //반차 근무시간 업데이트시 4시간 추가 
		}else {
			result = commuteService.updateWorkTime(param); // 금일 근무시간 업데이트
		}
		
		Map<String,Object> status = new HashMap<>();
		if(result > 0)
			status.put("status", "성공");	
		
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
				.body(status);
	}
	
	// 달의 전체 /  그 달의 주차별 시작일, 종료일 가져오기 (table에 뿌려주는 용도)
		@ResponseBody
		@GetMapping("/selectMonthWork.do")
		public ResponseEntity<?> selectMonthWork(String dateText,Principal loginSession){
			
			String empNo = loginSession.getName();
			CommuteCal cal = new CommuteCal();
	 	    LocalDate currentDate = LocalDate.parse(dateText + ".01", DateTimeFormatter.ofPattern("yyyy.MM.dd"));
	 	 
	 	    Map<String, Map<String, Object>> weekDates = cal.updateDateText(currentDate);
		
		
			// 주간별 누적근무시간
			Map<String, Object> weekTime = new HashMap<>();

			// weekDates 맵의 모든 내부 맵을 순회
			for (String week : weekDates.keySet()) {

			    // 내부 맵에서 "start"와 "end" 값을 가져와서 새로운 맵에 추가
			    Map<String, Object> startEndMap = new HashMap<>();
			    startEndMap.put("empNo", empNo);
			    startEndMap.put("start", weekDates.get(week).get("start"));
			    startEndMap.put("end", weekDates.get(week).get("end"));
			    
			    //주간별 누적 기본 근무시간 가져오기
			    int workTimes = commuteService.selectWeekWorkTime(startEndMap);
			    
			    //주간별 연장 근무시간 가져오기
			    int weekOverTime = commuteService.selectWeekOverTime(startEndMap);
			    
			    weekTime.put(week, workTimes);
			    weekTime.put(week+"overtime", weekOverTime);
			    weekDates.get(week).put("workTime", weekTime.get(week));
			    weekDates.get(week).put("workOverTime", weekTime.get(week+"overtime"));
			    
			}

			Map<String, Object> response = new HashMap<>();
			response.put("weekDates", weekDates);

			return ResponseEntity.ok()
					.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
					.body(response);
		}
		
		// 주차 클릭시 start,end 사이 날짜 근무 가져오기
		@ResponseBody
		@GetMapping("/selectWeekDatas.do")
		public List<Commute> selectWeekDatas(String start, String end,Principal loginSession){
			
			String empNo = loginSession.getName();
			Map<String,Object> param = new HashMap<>();
			param.put("empNo", empNo);
			param.put("start", start);
			param.put("end", end);
			List<Commute> weekList = commuteService.selectWeekDatas(param);
			
//			return ResponseEntity.ok()
//					.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
//					.body(weekList);
			return weekList;
		}
		
		// 이번달, 금주의 누적시간 가져오기
		@GetMapping("/weekTotalTime.do")
		public ResponseEntity<?> weekTotalTime(String start, String end, Principal loginSession){

			String empNo = loginSession.getName();
			String monthTime = now.format(dayfff);
			
			
			Map<String,Object> param = new HashMap<>();
			Map<String,Object> time = new HashMap<>();
			param.put("empNo", empNo);
			param.put("start", start);
			param.put("end", end);
			param.put("monthTime", monthTime);
			// 금주 누적시간 가져오기
			int weekTotalTime = commuteService.weekTotalTime(param);
			time.put("weekTotalTime",weekTotalTime);
			
			// 금주 연장시간 가져오기
			int weekOverTime = commuteService.selectWeekOverTime(param);
			time.put("weekOverTime",weekOverTime);
			
			//이번달 기본 누적 시간 가져오기
			int totalMonthTime = commuteService.totalMonthTime(param);
			time.put("totalMonthTime", totalMonthTime);
			
			//이번달 연장 근무 시간 가져오기
			int totalMonthOverTime = commuteService.monthOverTime(param);
			time.put("totalMonthOverTime", totalMonthOverTime);
			
			return ResponseEntity.ok()
					.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
					.body(time);
		}
		
		@GetMapping("/empDeptView.do")
		public String empDeptView(@RequestParam String code, Model model) {
			model.addAttribute("deptCode", code);
			return "commute/commuteList";
		}
		
		//부서별 월,주간 근태현황
		@ResponseBody
		@GetMapping("/selectDeptWork.do")
		public ResponseEntity<?> selectDeptWork(String dateText, String deptCode) {
		    String[] arr = dateText.split("\\.");
		    String date = arr[0].substring(2) + "/" + arr[1];

		    Map<String,Object> param = new HashMap<>();
		    param.put("date",date);
		    param.put("deptCode", deptCode);

		    CommuteCal cal = new CommuteCal();
		    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM");
		    LocalDate currentDate = LocalDate.parse(dateText + ".01", DateTimeFormatter.ofPattern("yyyy.MM.dd"));
		    
		    List<Employee> empList = employeeService.selectEmpDeptList(deptCode);


		    List<Map<String, Object>> workList = new ArrayList<>();

		    for(Employee emp : empList) {
		        Map<String, Object> work = new HashMap<>();
		        List<Map<String, Object>> weekDatesList = new ArrayList<>();
		        work.put("name", emp.getEmpName()); // 회원 이름
		        work.put("jobName", emp.getJobName()); // 회원 직급
		        work.put("DeptName", emp.getDeptName()); // 회원 부서
		        
		        // profile있을 시 프로필 보여주고 없으면 기본프로필 보여주기
		        String destFileName = emp.getDestFileName();
		        if(destFileName == null) {
		        	work.put("profile", "default.png");
		        }else {
		        	work.put("profile", emp.getDestFileName());
		        }

		        Map<String, Object> startEndMap = new HashMap<>();
		        startEndMap.put("empNo", emp.getEmpNo()); // 회원 pk no
		        startEndMap.put("monthTime", date); //선택한 달 ex)23/03
		    


		        // 선택한 달의 기본 누적근무 시간
		        int monthWorkTime = commuteService.totalMonthTime(startEndMap);
		        work.put("monthWorkTime", monthWorkTime);

		        // 선택한 달의 연장 누적근무 시간
		        int monthOverTime = commuteService.monthOverTime(startEndMap);
		        work.put("monthOverTime", monthOverTime);

		        // 선택한 달의 주차별 시작,끝날짜
		        Map<String, Map<String, Object>> weekDates = cal.updateDateText(currentDate);

		        for (String week : weekDates.keySet()) {
		            startEndMap.put("start", weekDates.get(week).get("start"));
		            startEndMap.put("end", weekDates.get(week).get("end"));

		            int workTimes = commuteService.selectWeekWorkTime(startEndMap);
		            int overTimes = commuteService.selectWeekOverTime(startEndMap);

		            Map<String, Object> weekMap = new HashMap<>();
		            weekMap.put("week", week);
		            weekMap.put("workTime", workTimes);
		            weekMap.put("overTime", overTimes);
		            weekMap.put("start", weekDates.get(week).get("start"));
		            weekMap.put("end", weekDates.get(week).get("end"));

		            weekDatesList.add(weekMap);
		        }

		        work.put("weekDates", weekDatesList);
		        workList.add(work);
		    }
		    
		    System.out.println("workList: " + workList);

		    return ResponseEntity.ok()
		            .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
		            .body(workList);
		}
	
		
		@ResponseBody
		@GetMapping("/searchEmpDept.do")
		public ResponseEntity<?> searchEmpDept( String dateText, String deptCode, String searchType, String searchKeyword) {

			String[] arr = dateText.split("\\.");
			    String date = arr[0].substring(2) + "/" + arr[1];

			    Map<String,Object> param = new HashMap<>();
			    param.put("date",date);
			    param.put("deptCode", deptCode);
			    param.put("searchType", searchType);
			    param.put("searchKeyword", searchKeyword);

			    CommuteCal cal = new CommuteCal();
			    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM");
			    LocalDate currentDate = LocalDate.parse(dateText + ".01", DateTimeFormatter.ofPattern("yyyy.MM.dd"));

			    List<Employee> empList = employeeService.empFinderDeptList(param);

			    List<Map<String, Object>> workList = new ArrayList<>();

			    for(Employee emp : empList) {
			        Map<String, Object> work = new HashMap<>();
			        List<Map<String, Object>> weekDatesList = new ArrayList<>();
			        work.put("empName", emp.getEmpName()); // 회원 이름
			        work.put("jobName", emp.getJobName()); // 회원 직급
			        work.put("DeptName", emp.getDeptName()); // 회원 부서
			        
			        // profile있을 시 프로필 보여주고 없으면 기본프로필 보여주기
			        String renameFilename = emp.getDestFileName();
			        if(renameFilename == null) {
			        	work.put("profile", "default.png");
			        }else {
			        	work.put("profile", emp.getDestFileName());
			        }

			        Map<String, Object> startEndMap = new HashMap<>();
			        startEndMap.put("empNo", emp.getEmpNo()); // 회원 pk no
			        startEndMap.put("monthTime", date); //선택한 달 ex)23/03

			        // 선택한 달의 기본 누적근무 시간
			        int monthWorkTime = commuteService.totalMonthTime(startEndMap);
			        work.put("monthWorkTime", monthWorkTime);

			        // 선택한 달의 연장 누적근무 시간
			        int monthOverTime = commuteService.monthOverTime(startEndMap);
			        work.put("monthOverTime", monthOverTime);

			        // 선택한 달의 주차별 시작,끝날짜
			        Map<String, Map<String, Object>> weekDates = cal.updateDateText(currentDate);

			        for (String week : weekDates.keySet()) {
			            startEndMap.put("start", weekDates.get(week).get("start"));
			            startEndMap.put("end", weekDates.get(week).get("end"));

			            int workTimes = commuteService.selectWeekWorkTime(startEndMap);
			            int overTimes = commuteService.selectWeekOverTime(startEndMap);

			            Map<String, Object> weekMap = new HashMap<>();
			            weekMap.put("week", week);
			            weekMap.put("workTime", workTimes);
			            weekMap.put("overTime", overTimes);
			            weekMap.put("start", weekDates.get(week).get("start"));
			            weekMap.put("end", weekDates.get(week).get("end"));

			            weekDatesList.add(weekMap);
			        }

			        work.put("weekDates", weekDatesList);
			        workList.add(work);
			    }

			    return ResponseEntity.ok()
			            .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
			            .body(workList);
		}
		


}
