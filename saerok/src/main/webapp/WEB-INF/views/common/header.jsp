<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Arrays"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="loginEmployee"
	value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }" />
<!DOCTYPE html>
<html lang="utf-8">
<head>
<script src="https://kit.fontawesome.com/cbe4aa3844.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" />

<!-- Favicon -->
<link rel="shortcut icon" href="${path}/resources/img/logo-bage.png">
<link rel="icon" href="${path}/resources/img/logo-bage.png"
	type="image/x-icon">
<style>
.dropdown-list-image img {
	max-width: 50px;
	max-height: 50px;
	width: auto;
}

/* 부모 컨테이너에 대한 스타일 */
.dropdown-list-image {
	display: flex;
	align-items: center; /* 수직 가운데 정렬 */
}

.dropdown-list-image img {
	border-radius: 50%;
	max-width: 100%; /* 이미지가 부모 컨테이너를 넘지 않도록 설정 */
	margin-right: 5px; /* 이미지와 텍스트 간격 조절 */
}
</style>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Saerok</title>

<!-- Custom fonts for this template-->
<link href="${path }/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="${path}/resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body id="page-top">
	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<ul
			class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
			id="accordionSidebar">

			<!-- Sidebar - Brand -->
			<a
				class="sidebar-brand d-flex align-items-center justify-content-center"
				href="${path}/">
				<div class="sidebar-brand-icon rotate-n-15">
					<i class="fas fa-gift"></i>
				</div>
				<div class="sidebar-brand-text mx-3">아토</div>
			</a>
			<!-- 아토 누르면 메인페이지로 넘어가도록!! : 완료!! 화면전환 메소드는 loginController에 있음-->
			<!-- Divider -->
			<hr class="sidebar-divider my-0">
			<!-- Divider -->
			<hr class="sidebar-divider">
			<!-- Heading -->
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseHR"
				aria-expanded="true" aria-controls="collapseHR"> <i
					class="fas fa-fw fa-users"></i> <span>인사관리</span>
			</a>
				<div id="collapseHR" class="collapse" aria-labelledby="headingHR"
					data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<a class="collapse-item" href="${path }/human/insertemp">사원등록</a>
						<a class="collapse-item" href="${path }/human/selectemp">사원조회</a>
						<a class="collapse-item" href="${path }/human/groupemp">조직도</a>
					</div>
				</div></li>
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseWORK"
				aria-expanded="true" aria-controls="collapseWORK"> <i
					class="fas fa-fw fa-clock"></i> <span>근태관리</span>
			</a>
				<div id="collapseWORK" class="collapse"
					aria-labelledby="headingWORK" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<a class="collapse-item" href="${path }/commute/commuteMain.do">내
							근태현황</a> <a class="collapse-item"
							href="${path }/commute/commuteList.do">부서별 근태현황</a> 
							<a class="collapse-item" href="${path }/commute/AnnualList.do">연차현황</a>
					</div>
				</div></li>
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseSKD"
				aria-expanded="true" aria-controls="collapseSKD"> <i
					class="fas fa-fw fa-calendar-alt"></i> <span>일정관리</span>
			</a>
				<div id="collapseSKD" class="collapse" aria-labelledby="headingSKD"
					data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<a class="collapse-item" href="${path }/calendar/calendarmain">내
							일정</a> <%-- <a class="collapse-item" href="${path }/calendar/calendarview">일정조회</a> --%>
						<%--  <a class="collapse-item" href="${path }/calendar/calendarstarview">중요일정</a>
                         <a class="collapse-item" href="${path }/calendar/calendarwrite">일정작성</a> --%>
					</div>
				</div></li>
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseBoard"
				aria-expanded="true" aria-controls="collapseBoard"> <i
					class="fas fa-th-list"></i> <span>게시판</span>
			</a>
				<div id="collapseBoard" class="collapse"
					aria-labelledby="headingBoard" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<%-- <a class="collapse-item" href="${path }/board/write">작성하기</a> --%>
						<a class="collapse-item" href="${path }/board/boardlist">공지
							사항</a>
						<a class="collapse-item" href="${path }">부서별 게시판</a>

						<!-- <a class="collapse-item" href="">전체게시판</a> -->
						<!-- <a class="collapse-item" href="${path }/board/Part">부서별 게시판</a> -->
					</div>
				</div></li>
			<li class="nav-item"><a class="nav-link dpse-item "
				data-toggle="collapse" data-target="#collapseMsg"
				aria-expanded="true" aria-controls="collapseMsg"> <i
					class="fas fa-fw fa-envelope"></i> <span>쪽지</span>
			</a>
				<div id="collapseMsg" class="collapse" aria-labelledby="headingMsg"
					data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<a class="collapse-item" href="${path }/note/get">받은쪽지함</a> <a
							class="collapse-item" href="${path }/note/send">보낸쪽지함</a> <a
							class="collapse-item" href="${path }/note/basket">휴지통</a>
					</div>
				</div></li>
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseCharts"
				aria-expanded="true" aria-controls="collapseCharts"> <i
					class="fas fa-fw fa-chart-bar"></i> <span>지점관리</span>
			</a>
				<div id="collapseCharts" class="collapse"
					aria-labelledby="headingCharts" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<a class="collapse-item" href="${path }/sales/all">매출현황</a> <a
							class="collapse-item" href="${path }/sales/branch">지점별매출</a> <a
							class="collapse-item" href="${path }/orders">발주목록</a> <a
							class="collapse-item" href="${path }/branch/">지점조회</a>
					</div>
				</div></li>
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseStore"
				aria-expanded="true" aria-controls="collapseStore"> <i
					class="fas fa-fw fa-chart-line"></i> <span>점주전용</span>
			</a>
				<div id="collapseStore" class="collapse"
					aria-labelledby="headingStore" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<a class="collapse-item" href="${path }/owner/detail">매출관리</a> <a
							class="collapse-item" href="${path }/inventory">재고목록</a> <a
							class="collapse-item" href="${path }/owner/order/add">발주신청</a> <a
							class="collapse-item" href="${path }/owner/order/detail">발주목록</a>
						<!-- ㅎㅎ -->
					</div>
				</div></li>
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseEDSM"
				aria-expanded="true" aria-controls="collapseEDSM"> <i
					class="fas fa-fw fa-folder"></i> <span>전자결재</span>
			</a>
				<div id="collapseEDSM" class="collapse"
					aria-labelledby="headingEDSM" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<a class="collapse-item" href="${path }/approval/approvalList.do">전체
							문서함</a> <a class="collapse-item" href="${path }/approval/myApproval">내
							문서함</a> <a class="collapse-item" href="${path }/approval/basicForm">양식
							작성하기</a>

					</div>
				</div></li>
			<!-- Divider -->
			<hr class="sidebar-divider d-none d-md-block">

			<!-- Sidebar Toggler (Sidebar) -->
			<div class="text-center d-none d-md-inline">
				<button class="rounded-circle border-0" id="sidebarToggle">
				</button>
			</div>
		</ul>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
			<!-- Main Content -->
			<div id="content">
				<!-- Topbar -->
				<nav
					class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

					<!-- Sidebar Toggle (Topbar) -->
					<button id="sidebarToggleTop"
						class="btn btn-link d-md-none rounded-circle mr-3">
						<i class="fa fa-bars"></i>
					</button>

					<!-- Topbar Search -->
					<form
						class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
						<div class="input-group">
							<input type="text" class="form-control bg-light border-0 small"
								placeholder="Search for..." aria-label="Search"
								aria-describedby="basic-addon2">
							<div class="input-group-append">
								<button class="btn btn-primary" type="button">
									<i class="fas fa-search fa-sm"></i>
								</button>
							</div>
						</div>
					</form>

					<!-- Topbar Navbar -->
					<ul class="navbar-nav ml-auto">

						<!-- Nav Item - Search Dropdown (Visible Only XS) -->
						<li class="nav-item dropdown no-arrow d-sm-none"><a
							class="nav-link dropdown-toggle" href="#" id="searchDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <i class="fas fa-search fa-fw"></i>
						</a> <!-- Dropdown - Messages -->
							<div
								class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
								aria-labelledby="searchDropdown">
								<form class="form-inline mr-auto w-100 navbar-search">
									<div class="input-group">
										<input type="text"
											class="form-control bg-light border-0 small"
											placeholder="Search for..." aria-label="Search"
											aria-describedby="basic-addon2">
										<div class="input-group-append">
											<button class="btn btn-primary" type="button">
												<i class="fas fa-search fa-sm"></i>
											</button>
										</div>
									</div>
								</form>
							</div></li>

						<!-- 알림 -->
						<!-- Nav Item - Alerts -->
						<li class="nav-item dropdown no-arrow mx-1">
                            <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-bell fa-fw"></i>
                                알림
                                <span class="badge badge-danger badge-counter">3+</span>
                            </a>
                            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="alertsDropdown">
                                <h6 class="dropdown-header">
                                    새로운 알림이 있습니다.
                                </h6>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-primary">
                                            <i class="fas fa-file-alt text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">2024/02/06</div>
                                        <span class="font-weight-bold">오늘 24일인데 아직도?</span>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-success">
                                            <i class="fas fa-donate text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">알림날짜</div>
                                        알림내용!
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-warning">
                                            <i class="fas fa-exclamation-triangle text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">알림날짜</div>
                                        알림내용!
                                    </div>
                                </a>
                                <a class="dropdown-item text-center small text-gray-500" href="#">모든알림보기</a>
                            </div>
                        </li>

						<!-- Nav Item - Alerts -->
						<!--       <li class="nav-item dropdown no-arrow mx-1">
                            <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-bell fa-fw"></i>
                                Counter - Alerts
                                <span class="badge badge-danger badge-counter">3+</span>
                            </a>
                            Dropdown - Alerts
                            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="alertsDropdown">
                                <h6 class="dropdown-header">
                                    알림
                                </h6>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-primary">
                                            <i class="fas fa-file-alt text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">알림날짜</div>
                                        <span class="font-weight-bold">알림내용!</span>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-success">
                                            <i class="fas fa-donate text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">알림날짜</div>
                                        알림내용!
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-warning">
                                            <i class="fas fa-exclamation-triangle text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">알림날짜</div>
                                        알림내용!
                                    </div>
                                </a>
                                <a class="dropdown-item text-center small text-gray-500" href="#">모든알림보기</a>
                            </div>
                        </li> -->

						<!-- Nav Item - Messages-->
                        <li class="nav-item dropdown no-arrow mx-1">
                            <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-envelope fa-fw"></i>
                                Messages
                                <span class="badge badge-danger badge-counter">2</span>
                            </a>
                           <!--  Dropdown - Messages--> 
                            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="messagesDropdown">
                                <h6 class="dropdown-header">
                                    쪽지 알림
                                </h6>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="resources/img/message icon.png"
                                            alt="...">
                                        <div class="status-indicator bg-success"></div>
                                    </div>
                                    <div class="font-weight-bold">
                                        <div class="text-truncate">설 연휴 잘 보내셨습니까?</div>
                                        <div class="small text-gray-500">김도영 · 58m</div>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="resources/img/message icon.png"
                                            alt="...">
                                        <div class="status-indicator"></div>
                                    </div>
                                    <div>
                                        <div class="text-truncate">이력서 얼른 쓰세요.</div>
                                        <div class="small text-gray-500">유병승 · 1d</div>
                                    </div>
                                </a>
                                
					

						<div class="topbar-divider d-none d-sm-block"></div>

						<!-- Nav Item - User Information -->
						<li class="nav-item dropdown no-arrow"><a
							class="nav-link dropdown-toggle" href="#" id="userDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="fasle"> <span
								class="mr-2 d-none d-lg-inline text-gray-600 small">${loginEmployee.empName }</span>

						</a>
							<div
								class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
								aria-labelledby="userDropdown">
								<a class="dropdown-item" href="${path }/mypage"> <i
									class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> 마이페이지
								</a>
								<div class="dropdown-divider"></div>
								<a class="dropdown-item" href="${path}/logoutpage "
									data-toggle="modal" data-target="#logoutModal"> <i
									class="fas fa-sign-out-alt fa-sm fa-fw mr-2 tfext-gray-400"></i>
									로그아웃
								</a>
							</div></li>


					</ul>

				</nav>
				<!-- End of Topbar -->
				<script>
      function requestNote(url){
         fetch(url)
         .then(response=>response.text())
         .then(data=>{

             document.querySelector(".page-wrapper").innerHTML=data;
            }); 
      } 
      function searchEmp(){
         var empNameVal = $("#email").val();
         /* alert(empNameVal); */
         $.ajax({
            type: "GET", 
            url:"${path }/note/selectEmpByName",
            data: { 
                  empName: empNameVal
            },
            success : function(result){
               //todo 이름으로 검색한 결과들을 노출하는 로직을 짜야되요
               //결과가 있든 없든 여기다가 짜야됨
               //console.log(result.empList);
               var result0 = result.empList[0];
               console.log(result);
               $("#searchResult").html('');
               result.empList.forEach(e=>{
                  const $op=document.createElement("option");
                  $op.value=e.empNo+" "+e.empName;
                  
                  $("#searchResult").append($op);
               })
               
            },
            error : function(){
               //통신실패
               alert("실패");
            }
         }); 
         
      }
   </script>
				<!-- Scroll to Top Button -->