<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="loginEmployee"
	value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }" />
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<link
	href="https://cdn.datatables.net/v/dt/dt-1.13.8/datatables.min.css"
	rel="stylesheet" />

<script
	src="https://cdn.datatables.net/v/dt/dt-1.13.8/datatables.min.js">
	
</script>

<jsp:include page="/WEB-INF/views/common/header.jsp">

	<jsp:param name="" value="전자결재리스트" />
</jsp:include>

<!--모달창-->
<div clas="container-fluid">

	<div class="card shadow mb-4">

		<div class="card-header py-3">
			<ul class="nav nav-tabs mb-3">
				<li class="nav-item"><a href="#board" data-toggle="tab"
					aria-expanded="true" class="nav-link active"> <i
						class="mdi mdi-home-variant d-lg-none d-block mr-1"></i> <span
						class="d-none d-lg-block  font-weight-bold">내가 쓴 문서</span>
				</a></li>
				<li class="nav-item"><a href="#proceeding" data-toggle="tab"
					aria-expanded="false" class="nav-link"> <i
						class="mdi mdi-account-circle d-lg-none d-block mr-1"></i> <span
						class="d-none d-lg-block  font-weight-bold">결재해야할 문서</span>
				</a></li>
				<li class="nav-item"><a href="#complete" data-toggle="tab"
					aria-expanded="false" class="nav-link"> <i
						class="mdi mdi-account-circle d-lg-none d-block mr-1"></i> <span
						class="d-none d-lg-block  font-weight-bold">완료한 문서</span>
				</a></li>
			</ul>
			<!-- 나의 문서  -->
			<div class="tab-content">
				<div class="tab-pane active" id="board">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable" width="100%"
							cellspacing="0">
							<thead>
								<tr>
									<th>결재번호</th>
									<th>제목</th>
									<th>기안자</th>
									<th>신청일</th>
									<th>상태</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="m" items="${myApprovalList}">
									<tr>
										<td>${m.appSeq}</td>
										<td><c:out value="${m.letterTitle }" /></td>
										<td><c:out value="${m.appEmpName}" /></td>
										<td><c:out value="${m.appWriteDate}" /></td>
										<td><c:out value="${m.appCheck}" /></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<!--결재진행 문서  -->
				<div class="tab-pane" id="proceeding">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable" width="100%"
							cellspacing="0">
							<thead>
								<tr>
									<th>결재번호</th>
									<th>제목</th>
									<th>신청일</th>
									<th>결재자</th>
									<th>진행상태</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="currentAppSeq" value="0" />
								<c:forEach var="m" items="${myTodoApprovalList}">
									<c:if test="${m.appCheck eq '결재중'}">
										<c:if test="${currentAppSeq ne m.appSeq }">
											<c:set var="currentAppSeq" value="${m.appSeq}" />
											<tr>
												<td>${m.appSeq}</td>
												<td><c:out value="${m.letterTitle }" /></td>
												<td><c:out value="${m.appWriteDate}" /></td>
												<td><c:out value="${m.empNos}" /> 
												<c:forEach var="b" items="${m.apvWriter}" varStatus="i">
														<c:choose>
															<c:when test="${i.index == 0}">
									                            ${b.apvEmpNo} 
									                        </c:when>
															<c:otherwise>
									                          , ${b.apvEmpNo}
									                     </c:otherwise>
														</c:choose>
												</c:forEach>
												</td>
												<td onclick="showDetail('${m.appSeq}')" style="color: red; cursor: pointer;"><c:out
														value="${m.appCheck}" />
												</td>
											</tr>
										</c:if>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<!-- 완료 문서 -->
				<div class="tab-pane" id="complete">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable" width="100%"
							cellspacing="0">
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
								<c:set var="currentAppSeq" value="0" />
								<c:forEach var="m" items="${myTodoApprovalList}">
									<c:if test="${m.appCheck eq '결재완료'}">
										<c:if test="${currentAppSeq ne m.appSeq }">
											<c:set var="currentAppSeq" value="${m.appSeq}" />
											<tr>
												<td>${m.appSeq}</td>
												<td><c:out value="${m.letterTitle }" /></td>
												<td><c:out value="${m.appWriteDate}" /></td>
												<td><c:out value="${m.empNos}" /> 
												<c:forEach var="b"
														items="${m.apvWriter}" varStatus="i">
														<c:choose>
															<c:when test="${i.index == 0}">
									                            ${b.apvEmpNo} 
									                        </c:when>
															<c:otherwise>
									                          , ${b.apvEmpNo}
									                     </c:otherwise>
														</c:choose>
												</c:forEach>
												</td>
												<td onclick="showDetail('${m.appSeq}')" style="color: blue; cursor: pointer;"><c:out
														value="${m.appCheck}" />
												</td>
											</tr>
										</c:if>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!--결재 상세페이지  -->
<script>
function showDetail(appSeq) {
    const width = 800;
    const height = 600;
    const left = (window.screen.width / 2) - (width / 2);
    const top = (window.screen.height / 2) - (height / 2);

    const detailUrl = '${path}/approval/approvalDetailView?appSeq=' + appSeq;
    window.open(detailUrl, '_blank', 'width=' + width + ',height=' + height + ',top=' + top + ',left=' + left);
}
</script>



<script>
	$(document).ready(function() {

		new DataTable('#dataTable', {
			info : false,
			ordering : true,
			paging : true
		});
	});
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<%-- <c:forEach var="m" items="${myTodoApprovalList}">
										<tr>
											<td>${m.appSeq}</td>
											<td><c:out value="${m.letterTitle }" /></td>
											<td><c:out value="${m.appWriteDate}" /></td>
											<td><c:out value="${m.empNos}" />
												<c:forEach var="b" items="${m.apvWriter}"
													varStatus="i">
													<c:choose>
														<c:when test="${i.index == 0}">
								                            ${b.apvEmpName} 
								                        </c:when>
													<c:otherwise>
								                          , ${b.apvEmpName}
								                     </c:otherwise>
													</c:choose>
												</c:forEach>
												
											</td>
											<td><c:out value="${m.appCheck}" /></td>
										</tr>
								</c:forEach> --%>