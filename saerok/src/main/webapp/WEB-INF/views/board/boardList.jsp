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
	src="https://cdn.datatables.net/v/dt/dt-1.13.8/datatables.min.js"></script>

<style>
#dataTable a {
	color: inherit;
	text-decoration: none;
}
</style>


<jsp:include page="/WEB-INF/views/common/header.jsp" />

<section id="ato-success">
	<div class="container-fluid">
		<form class="noticeList" id="updateBoardForm"
			action="${path}/board/boardlist" method="post">
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">공지사항</h6>
					<div class="d-flex justify-content-end">
						<button type="button" class="btn btn-facebook btn-block col-1"
							onclick="window.location.href='${path}/board/boardwrite';">작성하기</button>
					</div>
				</div>
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable" width="100%"
							cellspacing="0">
							<thead>
								<tr>
									<th scope="col" class="text-center">번호</th>
									<th scope="col" class="text-center">구분</th>
									<th scope="col" class="text-center">제목</th>
									<th scope="col" class="text-center">작성자</th>
									<th scope="col" class="text-center">작성일</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${not empty boardList}">
									<c:forEach var="b" items="${boardList}">
										<tr>
											<td><c:out value="${b.boardNo}" /></td>
											<td><c:out value="${b.boardCategory}" /></td>
											<td><a
												href="${path }/board/boardview?boardNo=${b.boardNo}"> <c:out
														value="${b.boardTitle}" escapeXml="true" />
											</a></td>
											<td><c:out value="${b.regId}" /></td>
											<td><fmt:formatDate value="${b.regDtime}"
													pattern="yyyy-MM-dd" /></td>
										</tr>
									</c:forEach>
								</c:if>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</form>
	</div>
</section>

<script>
	$(document).ready(function() {
		new DataTable('#dataTable', {
			info : false,
			ordering : true,
			paging : true,
			columns : [ null, null, null, null, null ]
		});
	});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
