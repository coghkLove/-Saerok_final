<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }" />
	<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="Emp" name="title"/>
	</jsp:include>
	<link rel="stylesheet" href="${path}/resources/css/empAnnual.css">
 	<jsp:include page="/WEB-INF/views/commute/commuteBar.jsp" />
	
			<div class="home-container">
						<!-- 상단 타이틀 -->
                    <!-- 본문 -->
                    <div class="div-padding">
                        <div id="date-box">
                            <h4 id="yearAnnual"></h4>
                        </div>
                         <div id="insert-Annual-box">
                            <p><a href="${path}/approval/basicForm"><span><i class="far fa-file"></i></span> 연차신청</a></p>
                        </div>

                        <div id="annual-container">
                            <div id="annual-info-box">
                                <div id="annual-user-box">
                                    <c:if test="">
										<p class="font-bold"><span><img src="" alt="" class="my-img"></span> ${loginEmployee.empName } <span>${loginEmployee.jobName }</span></p>
									</c:if>
									<c:if test="$">
										<p class="font-bold"><span><img src=""></span> ${loginEmployee.empName} <span>${loginEmployee.jobName }</span></p>
									</c:if>
                                </div>
                                <div>
                                    <p class="font-14 font-bold">총연차</p>
                                    <h4 class="main-color">${loginEmployee.issueAnnu}</h4>
                                </div>
                                <div>
                                    <p class="font-14 font-bold">사용 연차</p>
                                    <c:if test="${empty employee }">
                                    	<h4 class="main-color">0.0</h4>
                                    </c:if>
                                    <c:if test="">
	                                    <h4 class="main-color"></h4>
                                    </c:if>
                                </div>
                                <div>
                                    <p class="font-14 font-bold">잔여 연차</p>
                                     <c:if test="${empty employee }">
                                     	<h4 class="main-color">${loginEmployee.issueAnnu}</h4>
                                     </c:if>
                                     <c:if test="">
                                    	<h4 class="main-color"></h4>
                                     </c:if>                                     
                                </div>
                            </div>
                        </div>

                        <div id="search-box">
                            <label for="search-year">연차 사용기간 :</label>
                                <select id="search-year" name="search-year">
                                	<option selected>선택</option>
                                <c:forEach items="" var="year">
                                    <option value=""></option>
                                </c:forEach>
                                </select>
                        </div>

                        <div id="annual-detail-box">
                           <p>사용내역</p>
                           <div>
                                <table id="annual-detail-table">
                                    <thead>
                                        <tr>
                                            <th width="100">이름</th>
                                            <th width="100">부서명</th>
                                            <th width="100">휴가 종류</th>
                                            <th width="200">연차 사용기간</th>
                                            <th width="100">사용 연차</th>
                                            <th width="300">내용</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:if test="${empty leaveList }">
                                    		<tr>
	                                    		<td colspan="6">조회된 내역이 없습니다.</td>
                                    		</tr>
                                    	</c:if>
                                    	<c:if test="">
	                                    	<c:forEach items="" var="day">
		                                        <tr>
		                                            <td width="100">${loginEmployee.empName}</td>
		                                            <td width="100">${loginEmployee.deptName} </td>
		                                            <c:if test='${day.leaveClassify == "" }'>
			                                            <td width="100">연차</td>
		                                            </c:if>
		                                            <c:if test='${day.leaveClassify == "" }'>
			                                            <td width="100">반차</td>
		                                            </c:if>
		                                            <td width="200">${day.leaveStart} ~ ${day.leaveEnd }</td>
		                                            <td width="100"></td>
		                                            <td width="300">${day.leaveDetail }</td>
		                                        </tr>
	                                       </c:forEach>
                                    	</c:if>
                        
                                    </tbody>
                                </table>
                           </div>
                        </div>


                    </div>
                    <!-- 본문 end -->
                </div>
            </div>
<form name="" action="" method="">
	<input type="hidden" name=""/>
</form>
<script>
var yearNow = document.getElementById("yearAnnual");
        function clock() {
            var time = new Date();

            var year = time.getFullYear();
            var month = time.getMonth();
            var date = time.getDate();
           
           yearNow.innerHTML = `\${year}.\${month + 1}.\${date}`;
                
        }
 clock();
</script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<script src="${path}/resources/js/emp.js"></script>			