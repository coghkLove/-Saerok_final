<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="loginEmployee"
	value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }" />
	<%@page import="java.util.List"%>
<%@page import="com.saerok.jy.schedule.dto.*"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="MainPage" name="ATO" />
</jsp:include>
<link rel="stylesheet" href="${path }/resources/css/emp.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
   <link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<!-- fullcalendar 언어 설정관련 script -->
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" />

<style>
.ato-login-img {
	max-width: 70%;
	max-height: 70%;
	width: auto;
}
</style>
<!--  <script>
       const empNo = "${loginEmployee.empNo}";
    </script> -->
<section>
	<div class="app-dashboard-body-content off-canvas-content"
		data-off-canvas-content>
		<!-- 상단 타이틀 -->
		<div class="home-topbar topbar-div">
			<div></div>
			<div></div>
			<div></div>
		</div>
		<!-- 본문시작 -->
		<div>
			<div class="page-wrapper">
				<div class="home-content">
					<div style="display: flex;">
						<!-- 본문 왼쪽 -->
						<div class="home-content-div">
							<div id="home-left" class="div-padding div-margin">
								<div style="height: 50px;"></div>
								<table id="home-my-tbl">
									<tbody>
										<tr>
											<td id="year" colspan="2" class="font-14">clock</td>
										</tr>
										<tr>
											<td colspan="2"><c:if test="${!empty loginEmployee}">
													<img
														src="${path}/resources/upload/profile/${loginEmployee.destFileName}"
														alt="" class="img">
												</c:if></td>
										</tr>
										<tr>
											<td colspan="2">${loginEmployee.empName}
												${loginEmployee.jobName}</td>
										</tr>
										<tr>
											<td colspan="2">${loginEmployee.deptName}</td>
										</tr>

										<tr>
											<td colspan="2" id="clock" style="color: black;">clock</td>
										</tr>
										<tr>
											<td class="font-14 font-bold">업무상태</td>
											<td class="text-right font-14 color-red font-bold"
												id="work-status">출근전</td>
										</tr>
										<tr>
											<td class="font-14 font-bold">출근시간</td>
											<td class="text-right font-14" id="startwork-time">미등록</td>
										</tr>
										<tr>
											<td class="font-14 font-bold">퇴근시간</td>
											<td class="text-right font-14" id="endwork-time">미등록</td>
										</tr>
										<tr class="btn-tr">
											<td><button class="font-bold" id="startBtn">출근</button></td>
											<td class="text-right"><button class="font-bold"
													id="endBtn">퇴근</button></td>
										</tr>
									</tbody>
								</table>

							</div>
						</div>
						<script>
window.addEventListener('load', function(){
	
    
    $.ajax({
 	   url : '${path }/commute/commute.do',
 	   method:'GET',
 	   contentType : "application/json; charset=utf-8",
 	   success(data){
 		   console.log(data);
 		   if(data){
 			   const {commuteNo,inDtime,outDtime,overtime,workingDay,status,lateYN,empNo,workingHours} = data[0];
 			   var starttime = new Date(inDtime);
 			   var endtime = new Date(outDtime);
 			   
 			   //하루 근무시간 계산
 			   const daytimes = endtime-starttime; //퇴근시간 - 출근시간
 			   console.log(daytimes);
 			   
 			   const workStatus = document.querySelector("#work-status");
 			  workStatus.textContent = status;
 			   
 			   if(inDtime){
 				 var hours = (starttime.getHours()); 
                 var minutes = starttime.getMinutes();
                 var seconds = starttime.getSeconds();
                 var startWorkTime = `\${hours < 10 ? '0' + hours : hours}:\${minutes < 10 ? '0'+minutes : minutes}:\${seconds < 10 ? '0'+seconds : seconds}`;
                 // 출근시간 정보 출력
                 document.querySelector('#startwork-time').textContent = startWorkTime;
 			   }
 			   
 			   if(outDtime){
  				  var hours = (endtime.getHours()); 
                  var minutes = endtime.getMinutes();
                  var seconds = endtime.getSeconds();
                  var endWorkTime = `\${hours < 10 ? '0' + hours : hours}:\${minutes < 10 ? '0'+minutes : minutes}:\${seconds < 10 ? '0'+seconds : seconds}`;
                  // 퇴근시간 정보 출력
 				  document.querySelector('#endwork-time').textContent = endWorkTime;
 			   }
 			   /* 
 			   if(daytimes > 0){
 				   //하루 근무시간 update
 				  updateWorkTime(daytimes);
 			   } */
 		   }
 	   },
 	   error : console.log
    });
   
});



//출근 버튼 클릭 시
document.querySelector('#startBtn').addEventListener('click', function () {
	
	$.ajax({
	   url : '${path }/commute/workIn.do',
	   method : 'POST',
	   contentType : "application/json; charset=utf-8",
	   success(data){
			console.log(data);
	       if(data.status === "출근"){
	           alert("출근 성공입니다.");
	           location.reload();
	       }else if(data.status === '출장'){
	    	   alert("출장시에는 출근처리됩니다.");
	    	  return;
	       }else if(data.status === '연차'){
	    	   alert("연차중입니다.");
	    	   return;
	       }
	       else{
	           alert("이미 출근하셨습니다.");
	           	return;
	       }
	   },
	   error : console.log
   });
});

//퇴근하기 버튼 누를시
document.querySelector('#endBtn').addEventListener('click', function () {
	
	$.ajax({
		   url : '${path}/commute/workOut.do',
		   method : 'POST',
		   contentType : "application/json; charset=utf-8",
		   success(data){
			   console.log(data);
			   if(data.status === "퇴근"){
		           alert("퇴근 성공입니다.");
		           location.reload();
		       }else if(data.status === '출근전'){
		    	   alert("출근전입니다.");
		    	   return;
		       }
		       else{
		           alert("이미 퇴근하셨습니다.");
		           return;
		       }
			},
		   error : console.log
	 });
	});

const updateWorkTime = (daytimes) =>{
	
    $.ajax({
        url: '${path }/commute/updateWorkTime.do',
        method: 'POST',
        data: {daytimes},
        success(data) {
          console.log(data);
          getStartAndEndDateOfWeek();
        },
        error: console.log
      });
	};
   

</script>
						<!-- 본문 가운데 -->
						<div>
							<div id="home-center" class="div-padding div-margin">
								<div id="board-div" class="home-div">
									<ul class="nav nav-tabs mb-3">
										<li class="nav-item"><a href="#board" data-toggle="tab"
											aria-expanded="true" class="nav-link active"> <i
												class="mdi mdi-home-variant d-lg-none d-block mr-1"></i> <span
												class="d-none d-lg-block  font-weight-bold">공지사항</span>
										</a></li>
										<li class="nav-item"><a href="#approval"
											data-toggle="tab" aria-expanded="false" class="nav-link">
												<i class="mdi mdi-account-circle d-lg-none d-block mr-1"></i>
												<span class="d-none d-lg-block  font-weight-bold">결재</span>
										</a></li>
									</ul>
									
									<div class="tab-content">
										<div class="tab-pane active" id="board">
							<table class="table table-bordered" id="dataTable" width="100%"
							cellspacing="0">
							<thead>
								<tr>
									<th>번호</th>
									<th>구분</th>
									<th>제목</th>
									<th>작성자</th>
									<th>작성일</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${not empty noticeList}">
									<c:forEach var="b" items="${noticeList}">
										<tr>
											<td><c:out value="${b.boardNo}" /></td>
											<td><c:out value="${b.boardCategory}" /></td>
											<td><c:out value="${b.boardTitle }"/></td>
											<td><c:out value="${b.regId}" /></td>
											<td><fmt:formatDate value="${b.regDtime}"
													pattern="yyyy-MM-dd" /></td>
										</tr>
									</c:forEach>
								</c:if>
							</tbody>
						</table>
						<c:if test="${empty noticeList}">
							<p id="noticeFont">조회할 공지사항이 없습니다</p>
						</c:if>
										</div>
										
										<div class="tab-pane" id="approval">
										<%-- <h5 class="sign-h5" onclick="location.href='${path}/approval/approvalList.do?appCheck='결재중'';">결재 대기 문서</h5> --%>
										<table class="table table-bordered" id="dataTable"
												width="100%" cellspacing="0">
											<thead>
												<tr>
													<th>결재번호</th>
													<th>제목</th>
													<th>기안자</th>
													<th>기안일</th>
													<th>진행상태</th>
												</tr>
											</thead>
											<tbody>
												<c:if test="">
													<tr>
														<td colspan="4" class="home-sign-no">결재 대기 문서가 없습니다.</td>
													</tr>
												</c:if>
												<c:if test="">
													<c:forEach items="" var="app" varStatus="vs">
														<c:if test="">
															<tr class="div-sign-all-tbl-tr" data-no="" data-type="">
																<td></td>
																<td>
																	<c:choose>
																		<c:when test="">휴가신청서</c:when>
																		<c:when test="">기본신청서</c:when>
																		<c:when test="">지출결의서</c:when>
																	</c:choose>
																</td>
																<td class="div-sign-all-tbl-td-btn">
																	<c:forEach items="" var="signStatus" varStatus="vs">
																		<c:if test="">
																			<button class="tiny warning button">승인</button>
																		</c:if>
																		<c:if test="">
																			<button class="tiny warning button">반려</button>
																		</c:if>
																	</c:forEach>
																</td>
															</tr>
														</c:if>
													</c:forEach>
												</c:if>
											</tbody>
										</table>
								<!-- </div>  -->
									</div>
									</div>
								</div>
							</div>

							<div id="home-center" class="div-padding div-margin">
								<div class="card-header py-2">
									<h6 class="m-0 font-weight-bold text-primary">월별매출</h6>
								</div>
								<div class="chart-area">
									<canvas id="monthlySalesChart"></canvas>
								</div>
							</div>
						</div>
					</div>

					<!-- 본문 오른쪽 -->
					
					<div>
						<div id="home-right-div" class="div-padding div-margin">
						<div id='calendar'></div>
		<style>
       #calendar .fc-scroller {
        overflow-x: hidden !important;
        overflow-y: auto;
      }
      /* 일요일 날짜 빨간색 */
      .fc-day-sun a {
        color: red;
        text-decoration: none;
      }
      
      /* 토요일 날짜 파란색 */
/*       .fc-day-sat a {
        color: blue;
        text-decoration: none;
      } */
      .fc-license-message{
         display: none;
      }
    </style>
 <script>
    $('#cancelModifyBtn').on('click', function () {
        // 취소 버튼 클릭 시 모달 닫기
        $('#calendarModal').modal('hide');
        $('#calendarModal').modal('show');
    });</script> 

         <script>
                  document.addEventListener('DOMContentLoaded', function() {
                	  
                     var calendarEl = document.getElementById('calendar');
                     var calendar = new FullCalendar.Calendar(calendarEl, {
                             googleCalendarApiKey: 'AIzaSyDZTRgjuENE0svix_V-Fzl6EKEOttucbHw',
                               eventSources: [
                                   {
                                       googleCalendarId: 'ko.south_korea#holiday@group.v.calendar.google.com',
                                       color: 'pink',
                                       textColor: 'black'
                                   }
                               ],
                        initialView : 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
                        headerToolbar : { // 헤더에 표시할 툴 바
                          /*  start : 'prev next today',
                           center : 'title',
                           end : 'dayGridMonth,dayGridWeek,dayGridDay' */
                           
                        },
                     
                        selectable : true, // 달력 일자 드래그 설정가능
                        droppable : true,
                        editable : true,
                        locale: 'ko', // 한국어 설정
                        eventDisplay:'block',
                        dateClick: function(info) {
                           $("#addCalendarBtn").click();
                           //alert('clicked ' + info.dateStr);
                         },
                        //DB에서 List 불러오기
                events : [ 
                               <%--  <%List<Schedule> scheduleList = (List<Schedule>) request.getAttribute("scheduleList");%>
                                 <%if (scheduleList != null) {%>
                                 <%for (Schedule schedule : scheduleList) {%>
                                 {
                                    title : '<%=schedule.getSkdTitle()%>',
                                     start : '<%=schedule.getSkdStart()%>',
                                     end : '<%=schedule.getSkdEnd()%>',
                                     backgroundColor : '#03a' + Math.round(Math.random() * 0xfff).toString(16),
                                 borderColor : '#FFFFFF'
                                  },
                        <%}
                     }%> --%>
                                 ]
                     });  
 
                   // 캘린더 렌더링
                   calendar.render();
           
                  });
                  
               </script>
	<!-- 						<h5 style="padding: 20px">이번주 신제품</h5>
 -->
 
 <br>
            <div id="carouselExampleIndicators" class="carousel slide"
               data-ride="carousel">
               <div class="carousel-inner" role="listbox">
                  <div class="carousel-item">
                     <%-- <img class="img-fluid"
                        src="${paht }/resources/upload/IMG_2341.jpg" alt="First slide">
                  </div>
                  <div class="carousel-item">
                     <img class="img-fluid"
                        src="${path }/resources/upload/IMG_2342.jpg" alt="Second slide">
                  </div>
                  <div class="carousel-item active">
                     <img class="img-fluid"
                        src="${path }/resources/upload/IMG_2343.jpg" alt="Third slide">
                  </div>
               </div>
               <a class="carousel-control-prev" href="#carouselExampleIndicators"
                  role="button" data-slide="prev"> <span
                  class="carousel-control-prev-icon" aria-hidden="true"></span> <span
                  class="sr-only">Previous</span>
               </a> <a class="carousel-control-next" href="#carouselExampleIndicators"
                  role="button" data-slide="next"> <span
                  class="carousel-control-next-icon" aria-hidden="true"></span> <span
                  class="sr-only">Next</span>
               </a> --%>
            </div>  
 
						</div>
					</div>
				</div>

				<!-- 본문 오른쪽 -->
 				 <div>
					<div id="home-right-div" class="div-padding div-margin">
						<!-- <h5 style="padding: 20px">최근 알림</h5> -->
						<div class="notification-list">
							<div class="left-noti"></div>
							<div class="right-noti"></div>
						</div>
					</div>
				</div> 
			</div>
		</div>
	</div>


	<!-- Page level plugins -->
	<script src="/vendor/chart.js/Chart.min.js"></script>

	<!-- Page level custom scripts -->
	<script src="/js/demo/chart-area-demo.js"></script>
	<script src="/js/demo/chart-pie-demo.js"></script>
	<script src="/js/demo/chart-bar-demo.js"></script>

</section>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


<script>
const monthlySalesData = {
    labels: [],
    sales: []
};

<c:forEach items="${monthlySalesTotals}" var="record">
    monthlySalesData.labels.push("${record.SALESMONTH}");
    monthlySalesData.sales.push(${record.TOTALSALES}); 
</c:forEach>

const ctx = document.getElementById('monthlySalesChart').getContext('2d');
const gradient = ctx.createLinearGradient(0, 0, 0, 400);
gradient.addColorStop(0, 'rgba(0, 123, 255, 0.5)');
gradient.addColorStop(1, 'rgba(0, 123, 255, 0)');

const monthlySalesChart = new Chart(ctx, {
    type: 'line',
    data: {
        labels: monthlySalesData.labels,
        datasets: [{
            label: '월간 매출액',
            backgroundColor: gradient,
            borderColor: 'rgba(0, 123, 255, 1)',
            data: monthlySalesData.sales,
            fill: true,
            pointBackgroundColor: 'white',
            pointBorderColor: 'rgba(0, 123, 255, 1)',
            pointHoverBackgroundColor: 'rgba(0, 123, 255, 1)',
            pointHoverBorderColor: 'white'
        }]
    },
    options: {
        responsive: true,
        title: {
            display: true,
            text: '월간 매출 추이',
            fontColor: 'black',
            fontSize: 20
        },
        scales: {
            yAxes: [{
                gridLines: {
                    drawBorder: true,
                    color: 'lightgrey'
                },
                ticks: {
                    beginAtZero: true,
                    fontColor: 'black'
                }
            }],
            xAxes: [{
                gridLines: {
                    drawBorder: true,
                    color: 'lightgrey'
                },
                ticks: {
                    fontColor: 'black'
                }
            }]
        },
        legend: {
            labels: {
                fontColor: 'black'
            }
        },
        hover: {
            mode: 'nearest',
            intersect: true
        },
        tooltips: {
            mode: 'index',
            intersect: false
        }
    }
});
</script>
<script src="${path}/resources/js/emp.js"></script>

<!-- Core plugin JavaScript-->
<script src="${path}/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

<!— Custom scripts for all pages—>
<script src="${path}/resources/js/sb-admin-2.min.js"></script>
<br>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />