<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="springform"
	uri="http://www.springframework.org/tags/form"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<!-- CKEditor JS 파일 포함 -->
<script src="${path}/resources/ckeditor/ckeditor.js"></script>

<!-- CKEditor 초기화 스크립트 -->
<script>
	window.onload = function() {
		CKEDITOR.replace("boardContent");
	};

	// 폼 제출 전 컨텐츠 업데이트 함수
	function updateContent() {
		CKEDITOR.instances.boardContent.updateElement();

		// 폼 제출 전에 필요한 경우 추가 로직이나 유효성 검사를 수행
		document.getElementById("form").submit();
	}
</script>

<html>
<head>
<title>게시글 작성</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
	<section>
		<div class="container px-5 my-5 px-5">
			<h2>게시글 작성</h2>
			<form name="form" id="form" role="form" method="post"
				action="${path}/board/save" enctype="multipart/form-data">
				<div class="col-lg-11">
					<table class="table table-boardered">
						<thead>
							<tr>
								<th style="text-align: center; background-color: #F2F2F2;">제목</th>
								<th> <input id="board-title" name="boardTitle" style="width: 500px;"
									type="text"></th>
							</tr>
						</thead>
					</table>
				</div>
				<textarea class="form-control" name="boardContent" id="boardContent"></textarea>
				<div>
					<!-- 저장 버튼 -->
					<button type="submit" class="btn btn-sm btn-success" id="writeBtn"
						onclick="updateContent();">저장</button>
					<%--  <!-- 목록 버튼 -->
                    <button type="button" class="btn btn-sm btn-primary"
                        onclick="window.location.href='${path}/board/noticelist';">목록</button> --%>
				</div>
			</form>
		</div>
	</section>
</body>
</html>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
