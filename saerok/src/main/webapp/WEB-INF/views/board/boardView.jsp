<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="loginEmployee"
	value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}" />

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
/* 추가 된 스타일 */
.titleArea {
	padding-top: 80px;
	margin: 0 auto;
	display: flex;
	flex-direction: column;
	align-items: center;
	text-align: center;
}

.container mt-3 {
	display: flex;
	flex-direction: column;
	justify-content: center;
	width: 1000px !important;
	padding: 0px !important;
	text-align: center;
}

.row {
	width: 900px;
	display: flex;
	flex-direction: column;
	align-items: center;
}

.space {
	width: 900px;
	display: flex;
	flex-direction: column;
	margin: 0px auto;
}

.table th {
	width: 300px;
}
</style>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<link
	href="https://cdn.datatables.net/v/dt/dt-1.13.8/datatables.min.css"
	rel="stylesheet" />
<script
	src="https://cdn.datatables.net/v/dt/dt-1.13.8/datatables.min.js"></script>

<div class="space">
	<div class="titleArea">
		<h2>공지사항</h2>
	</div>

	<div class="container mt-3">
		<div class="row">
			<table class="table table-bordered">
				<tr>

					<th style="text-align: center; background-color: #F2F2F2;">제목</th>
					<td><c:out value="${b.boardTitle}" /></td>
				</tr>
				<tr>
					<td style="text-align: center; background-color: #F2F2F2;">작성일</td>
					<td><fmt:formatDate value="${b.regDtime}" pattern="yyyy-MM-dd" /></td>
				</tr>
			</table>
			<table class="table table-bordered" style="text-align: center;">
				<thead>
					<tr>
						<th style="text-align: center; background-color: #F2F2F2;">내용</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><c:out value="${b.boardContent}" escapeXml="false" /></td>
					</tr>
				</tbody>
			</table>
			<div class="btn-container">
				<button id="list-btn" class="btn btn-outline-primary"
					onclick="listBtn();">목록</button>
			</div>
		</div>
	</div>
</div>





<script>
	//목록버튼 눌렀을 때 boardlist로 페이지이동 
	const listBtn = ()=> {
		location.replace("${path}/board/boardlist");
	}
	
	
</script>



<jsp:include page="/WEB-INF/views/common/footer.jsp" />
