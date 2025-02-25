<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="loginEmployee"
	value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="CommuteMain" name="ATO" />
</jsp:include>
<jsp:include page="/WEB-INF/views/commute/commuteBar.jsp" />  
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
 <link rel="stylesheet" href="${path }/resources/css/emp.css">
 <style>
    #work-week-container {
        text-align: center;
        width: 900px; /* 원하는 너비 값으로 조절 */
        margin: 0 auto; /* 가운데 정렬을 위해 필요한 부분 */
    }
    #work-week-container > div {
        margin: 0 10px;
    }
</style>	
  <div class="home-container" class="div-padding div-margin page-wrapper">
                    <!-- <div class="div-padding"> -->
                        <div id="date-box">
                            <h4>
                                <button id="prev-btn"><i class="fas fa-chevron-left"></i></button>
                                <span id="date-text">2023.12</span>
                                <button id="next-btn"><i class="fas fa-chevron-right"></i></button>
                            </h4>
                        </div>

                        <div id="work-week-container">
                            <div id="work-week-time">
                                <div>
                                    <p class="font-14">이번주 누적</p>
                                    <h4 class="main-color" id="main-totalwork-time">0h 0m 0s</h4>
                                </div>
                                <div>
                                    <p class="font-14">이번주 초과</p>
                                    <h4 class="main-color" id="main-week-over-time">0h 0m 0s</h4>
                                </div>
                                <div>
                                    <p class="font-14">이번주 잔여</p>
                                    <h4 class="main-color" id="main-work-time">40h 0m 0s</h4>
                                </div>
                                <div>
                                    <p class="font-14">이번달 누적</p>
                                    <h4 class="color-gray" id="main-month-work-time">0h 0m 0s</h4>
                                </div>
                                <div>
                                    <p class="font-14">이번달 연장</p>
                                    <h4 class="color-gray" id="main-month-over-time">0h 0m 0s</h4>
                                </div>
                            </div>
                        </div>

                        <div id="work-info-container"></div>

                    </div>
                </div>
     
	<script>
        window.addEventListener('load',()=>{
                sendData();
                weekTimes();
        });
        
        let currentDate = new Date();

            function setCurrentDate() {
                const dateText = document.getElementById("date-text");
                const year = currentDate.getFullYear();
                const month = currentDate.getMonth() + 1;
                const monthText = month < 10 ? `0\${month}` : month;
                dateText.textContent = `\${year}.\${monthText}`;
            }

            setCurrentDate();

            document.getElementById("prev-btn").addEventListener("click", () => {
                    currentDate.setMonth(currentDate.getMonth() - 1);
                    setCurrentDate();
                     sendData();
                    
            });

                document.getElementById("next-btn").addEventListener("click", () => {
                    currentDate.setMonth(currentDate.getMonth() + 1);
                    setCurrentDate();
                    sendData();
            });
                
                // ajax 호출
                function sendData() {
                    const dateText = document.getElementById("date-text").textContent;
                    const container = document.querySelector("#work-info-container");
                    container.innerHTML = "";
                     $.ajax({
                        url : "${path }/commute/selectMonthWork.do",
                        data : {dateText},
                        contentType : "application/json; charset=utf-8",
                        success(data){
                            console.log(data);
                            const {weekDates, workList} = data;
                            console.log("weekDates", weekDates);
                            console.log("workList", workList);
                            
                            const container = document.querySelector("#work-info-container");
                            
                            const table = document.createElement("table");
                            table.classList.add("table-expand");

                            const tbody = document.createElement("tbody");
    						
                            
                            //주간별 정보
                            Object.keys(weekDates).sort().forEach(key  =>{
      
    	                        const row1 = document.createElement("tr");
    	                       row1.classList.add("table-expand-row");
    	                        row1.setAttribute("id","work-container-tr");
    	                        row1.dataset.openDetails = "";
    	        				row1.dataset.start = weekDates[key].start;
    	        				row1.dataset.end = weekDates[key].end;
    	        				
    	        				const tbody2 = document.createElement("tbody");
    							
    	        				row1.onclick = (e) =>{
    	        					const start = e.currentTarget.dataset.start;
    	        					const end = e.currentTarget.dataset.end;
    	        					$.ajax({
    	        						url : "${path }/commute/selectWeekDatas.do",
    	        						data : {start,end},
    	        						success:(data)=>{
    	        							console.log(data);
    	        							if(tbody2.innerHTML==""){
	    		        							data.forEach((datas) =>{
	    		        								const subTr = document.createElement("tr");
	    		        								const {empNo, outDtime, commuteNo, overtime, workingDay, inDtime, status, workingHours} = datas;
	    		        								const subTd1 = document.createElement("td");
	    		        								subTd1.textContent = changeWorkingDay(workingDay);
	    		        								
	    		        								const subTd2 = document.createElement("td");
	    		        								subTd2.textContent = changeTimeText(inDtime);
	    		        								
	    		        								const subTd3 = document.createElement("td");
	    		        								subTd3.textContent = changeTimeText(outDtime);
	    		        								
	    		        								const subTd4 = document.createElement("td");
	    		        								subTd4.classList.add("font-bold");
	    		        								//subTd4.textContent = changeWorkTime(workingHours+overtime);
	    		        								subTd4.textContent = changeWorkTimeNew(inDtime, outDtime);
	    		        								
	    		        								const subTd5 = document.createElement("td");
	    		        								subTd5.textContent = "기본 "+ changeWorkTime(workingHours) + " / 연장 " + changeWorkTime(overtime);
	    		        								
	    		        								const subTd6 = document.createElement("td");
	    		        								if(status == '연차'){
	    			        								subTd6.textContent = "완료(" + status + " 8.00h)";
	    		        								}
	    		        								else if(status == '반차'){
	    		        									subTd6.textContent = "완료(" + status + " 4.00h)";
	    		        								}
	    		        								else{
	    		        									subTd6.textContent = "";
	    		        								}
	    		        								
	    		        								subTr.append(subTd1,subTd2,subTd3,subTd4,subTd5,subTd6);
	    		        								tbody2.append(subTr);
	    		        							});
    	        							}
    	        						},
    	        						error :console.log
    	        					});
    	        				};
    	
    	                        const td1 = document.createElement("td");
    	                        td1.classList.add("border-bottom", "font-18");
    	                        td1.setAttribute("width", "400");
    	                        td1.textContent = key;
    	             
    	                        const start = weekDates[key].start.substring(5);
    	                        const end = weekDates[key].end.substring(5);
    	                        const workTime = weekDates[key].workTime;
    	                        const workOverTime = weekDates[key].workOverTime;
    	                        const span = document.createElement("span");
    	                        span.classList.add("font-14","color-gray");
    	                        span.textContent = " ( " + start + " ~ " + end + " ) ";
    	                        td1.append(span);
    	                        
    	                        const expandIcon = document.createElement("span");
    	                        expandIcon.classList.add("expand-icon");
    	                        td1.append(expandIcon);
    	
    	                        const td2 = document.createElement("td");
    	                        td2.classList.add("total-time-info");
    	                        td2.textContent = "누적 근무시간 " + changeWorkTime(workTime+workOverTime);
    							const span0 = document.createElement("span");
    							span0.classList.add("font-12","color-gray");
    							span0.textContent = " ( 초과 근무시간 " + changeWorkTime(workOverTime) +" )";
    							td2.append(span0);
    	                        
    	                        const row2 = document.createElement("tr");
    	                        row2.classList.add("table-expand-row-content");
    	
    	                        const td3 = document.createElement("td");
    	                        td3.colSpan = 6;
    	                        td3.classList.add("table-expand-row-nested");
    	
    	                        const nestedTable = document.createElement("table");
    	                        nestedTable.setAttribute("id", "date-table");
    	
    	                        const thead = document.createElement("thead");
    	
    	                        const headerRow = document.createElement("tr");
    	
    	                        const header1 = document.createElement("th");
    	                        header1.setAttribute("width", "50");
    	                        header1.textContent = "일자";
    	
    	                        const header2 = document.createElement("th");
    	                        header2.setAttribute("width", "100");
    	                        header2.textContent = "출근시간";
    	
    	                        const header3 = document.createElement("th");
    	                        header3.setAttribute("width", "100");
    	                        header3.textContent = "퇴근시간";
    	
    	                        const header4 = document.createElement("th");
    	                        header4.setAttribute("width", "100");
    	                        header4.textContent = "총근무시간";
    	
    	                        const header5 = document.createElement("th");
    	                        header5.setAttribute("width", "200");
    	                        header5.textContent = "근무시간 상세";
    	
    	                        const header6 = document.createElement("th");
    	                        header6.setAttribute("width", "100");
    	                        header6.textContent = "승인요청내역"; 
    	
    	                        
    	                        headerRow.append(header1,header2,header3,header4,header5);
    	                        thead.append(headerRow);
    	                        nestedTable.append(thead,tbody2);
    	                        td3.append(nestedTable);
    	                        row2.append(td3);
    	                        row1.append(td1,td2);
    	                        tbody.append(row1,row2);
    	                        
                            });
                            table.append(tbody);
                            container.append(table);

                        },
                        error:console.log
                    }); 
                }
                
    document.querySelector("#work-info-container").addEventListener('click',(e)=>{
     
    		$('[data-open-details]').click(function (e) {
            	  $(this).next().toggleClass('is-active');
            	  $(this).toggleClass('is-active');
    		});
    });

    // 시간으로 변경
    function changeTimeText(time) {
    	if(time !== null){
    	  const date = new Date(time); // Epoch 시간을 한국 시간으로 변환한 Date 객체 생성
    	  
    	  const hours = date.getHours().toString().padStart(2, '0'); 
    	  const minutes = date.getMinutes().toString().padStart(2, '0'); 
    	  const seconds = date.getSeconds().toString().padStart(2, '0'); 
    	  
    	  return `\${hours}:\${minutes}:\${seconds}`;				
    	}
    }

    function weekTimes(){
    	const today = new Date();
    	const todayDay = today.getDay(); // 오늘 날짜의 요일 (0: 일요일, 1: 월요일, ..., 6: 토요일)

    	const startDate = new Date(today); // 해당 주의 시작일
    	startDate.setDate(startDate.getDate() - todayDay);

    	const endDate = new Date(today); // 해당 주의 종료일
    	endDate.setDate(endDate.getDate() + (6 - todayDay));

    	const start = startDate.getFullYear() + "." + (startDate.getMonth() + 1) + "." + startDate.getDate();
    	const end = endDate.getFullYear() + "." + (endDate.getMonth() + 1) + "." + endDate.getDate();
    	  
    	$.ajax({
    		  url : "${path }/commute/weekTotalTime.do",
    		  data: { start, end },
    		  contentType : "application/json; charset=utf-8",
    		  success(data){
    			  console.log("Success", data);
    			  const {totalMonthOverTime ,totalMonthTime, weekOverTime ,weekTotalTime} = data;
    			  const mainTotalWorkTime = document.querySelector("#main-totalwork-time");
    			  const mainWeekOverTime = document.querySelector("#main-week-over-time");
    			  const mainWorkTime = document.querySelector("#main-work-time");
    			  const monthWorkTime = document.querySelector("#main-month-work-time");
    			  const monthOverTime = document.querySelector("#main-month-over-time")
    			  
    			  let times = 144000000 - (weekTotalTime + weekOverTime); // 40시간 - 주간 기본 근무시간
    			  mainTotalWorkTime.textContent = changeWorkTime(weekTotalTime + weekOverTime);
    			  mainWeekOverTime.textContent = changeWorkTime(weekOverTime);
    			  if(times < 0){
    				  mainWorkTime.textContent = changeWorkTime(0);
    			  }else{
    				  mainWorkTime.textContent = changeWorkTime(times);				  
    			  }
    			  monthWorkTime.textContent = changeWorkTime(totalMonthTime + totalMonthOverTime);
    			  monthOverTime.textContent = changeWorkTime(totalMonthOverTime);
    		  },
    		  error(error) {
    		        console.error("Error:", error);
    		    }
    		  
    	  });
    }

    // 총근무시간
    const resultElement = document.getElementById("result-container");

function changeWorkTimeNew(inDtime, outDtime) {
    var inDate = new Date(inDtime);
    var outDate = new Date(outDtime);

    var timeDifferenceInSeconds = Math.abs((outDate - inDate) / 1000);

    var overDay = Math.floor(timeDifferenceInSeconds / (3600 * 24));
    var overHour = Math.floor((timeDifferenceInSeconds % (3600 * 24)) / 3600);
    var overMin = Math.floor((timeDifferenceInSeconds % 3600) / 60);
    var overSec = Math.floor(timeDifferenceInSeconds % 60);

    // 결과를 HTML에 출력
    resultElement.textContent = `${overDay}일 ${overHour}시간 ${overMin}분 ${overSec}초`;
}
    /* function changeWorkTime(times){
    	const time = times / 1000;
    	const hours = Math.floor(time / 3600); // 시간 계산
    	const minutes = Math.floor((time % 3600) / 60); // 분 계산
    	const seconds = Math.floor(time % 60); // 초 계산
    	
    	return `\${hours}h \${minutes}m \${seconds}s`;	
    }
 */
/*     function changeWorkTimeNew(inDtime, outDtime) {
    	var inDate = new Date(inDtime);
    	var outDate = new Date(outDtime);
    	
    	var overDay = Math.trunc((outDate-inDate)/1000/3600/24);
    	var overHour = Math.trunc(((outDate-inDate)/1000/3600)%24);
    	var overMin = Math.trunc(((outDate-inDate)/1000/3600/24)%60);
    	var overSec = Math.trunc(((outDate-inDate)/1000/3600/24/60)%60);
    	
    	console.log("hjhjhj", overDay, overHour, overMin, overSec);
		
    	return `\${overHour}h \${overMin}m \${overSec}s`;
    }
     */
     
     function changeWorkTimeNew(inDtime, outDtime) {
    	    var inDate = new Date(inDtime);
    	    var outDate = new Date(outDtime);

    	    var timeDifferenceInSeconds = Math.abs((outDate - inDate) / 1000); // 초 단위로 차이 계산

    	    var overDay = Math.floor(timeDifferenceInSeconds / (3600 * 24)); // 일 수 계산
    	    var overHour = Math.floor((timeDifferenceInSeconds % (3600 * 24)) / 3600); // 시간 계산
    	    var overMin = Math.floor((timeDifferenceInSeconds % 3600) / 60); // 분 계산
    	    var overSec = Math.floor(timeDifferenceInSeconds % 60); // 초 계산

    	    console.log("hjhjhj", overDay, overHour, overMin, overSec);

    	    return `\${overHour}h \${overMin}m \${overSec}s`;
    	}
    // workingDay날짜 00일 (월)로 변경
    function changeWorkingDay(workingDay) {
     console.log("Input Date:", workingDay);
      const day = new Date(workingDay);
      console.log("Parsed Date:", day);
      const year = day.getFullYear();
      const month = day.getMonth()+1; // JavaScript의 Date 객체에서 월은 0부터 시작합니다.
      const date = day.getDate();
      
      const dayOfWeekNames = ["일", "월", "화", "수", "목", "금", "토"];
      const dayOfWeekIndex = day.getDay(); // 해당 날짜의 요일을 구합니다.
      const dayOfWeek = dayOfWeekNames[dayOfWeekIndex]; // 요일 이름을 배열에서 찾아옵니다.
      
      return `\${date}일 (\${dayOfWeek})`;
    }
    


    </script>

<script src="${path }/resources/js/emp.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
