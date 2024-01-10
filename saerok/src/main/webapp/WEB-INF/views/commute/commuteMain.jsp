<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="CommuteMain" name="ATO" />
</jsp:include>
<div class="preloader">
		<div class="lds-ripple">
			<div class="lds-pos"></div>
			<div class="lds-pos"></div>
		</div>
	</div>
<div id="main-wrapper" data-theme="light" data-layout="vertical"
		data-navbarbg="skin6" data-sidebartype="full"
		data-sidebar-position="fixed" data-header-position="fixed"
		data-boxed-layout="full">
<div class="page-wrapper" style=" background-color: white;">
				<div class="row" style="height: 100%;">
						<!-- 근태관리 사이드바 -->
					<div class="col-2" style="border-right: 1px solid rgba(0,0,0,.125);">
						<jsp:include page="/WEB-INF/views/commute/commuteBar.jsp" >
							<jsp:param value="${c}" name="c"/>
						</jsp:include>
					</div>
<div class="container-fluid" style="height: 100%">
				
				
<div class="col-10" id="workList">
            
						<script>
						$(function(){
							const currentDate = new Date();
							const year = currentDate.getFullYear(); // 이번년도
							const month = currentDate.getMonth() + 1; // 이번달
							const empNo = "${loginEmployee.empNo}"; // 로그인유저 사번
							$.ajax({
								type: "POST", 
								url: "${path}/selectCommuteList.do", // CommuteController의 URL
								dataType: "html", // HTML 방식
								data: { 
									year: year, 
									month: month, 
									empNo: empNo
								},
								success : function(result){
									$('#workListContainer').html(result); // HTML 태그 넣기
								},
								error : function(){
									alert("근무정보를 조회할 수 없습니다. \n관리자에게 문의하세요.");
								}
							});
						})
							
						</script>
					</div>
				</div>
			</div>
		</div>
	</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />