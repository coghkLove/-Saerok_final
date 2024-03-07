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

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<!-- 전체 리스트 출력 -->
<div class="container-fluid">
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">받은 쪽지함</h6>
		</div>
		<div class="card-body">
			<div class="table-responsive">
				<!-- 쪽지 쓰기 버튼 -->
				<button type="button" class="btn btn-primary" id="sendMsgModal"
					data-toggle="modal" data-target="#msgModal">쪽지 쓰기</button>
				<br> <br>
				<table class="table table-bordered" id="dataTable" width="100%"
					cellspacing="0">
					<thead>
						<tr>
							<th><input type="checkbox" id="selectAll" /></th>
							<th>번호</th>
							<th>보낸사람</th>
							<th>날짜</th>
							<th>삭제</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${not empty receivedNotes}">
							<c:forEach var="note" items="${receivedNotes}">
								<tr>
									<td><input type="checkbox" class="noteCheckBox"
										value="${note.noteNo}" /></td>
									<td><c:out value="${note.noteNo}" /></td>
									<td onclick="revMessage('${note.sndEmp.empNo}');"><c:out
											value="${note.sndEmp.empName }" /></td>
									<td><fmt:formatDate value="${note.regDtime}"
											pattern="yyyy-MM-dd HH:mm:ss" /></td>
									<td>
										<!-- 삭제 버튼 -->
										<button type="button" class="btn btn-danger"
											onclick="deleteNote(${note.noteNo})">삭제</button>
									</td>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<script>
    $(document).ready(function () {
        // 모든 체크박스를 선택하거나 해제하는 기능
        $("#selectAll").click(function () {
            $('.noteCheckBox').prop('checked', $(this).prop('checked'));
        });

        // 개별 체크박스를 선택할 때 전체 체크박스의 상태를 확인하여 필요한 경우 전체 체크박스를 선택하거나 해제하는 기능
        $('.noteCheckBox').click(function () {
            if ($(this).prop("checked") == false) {
                $("#selectAll").prop('checked', false);
            }
            if ($('.noteCheckBox:checked').length == $('.noteCheckBox').length) {
                $("#selectAll").prop('checked', true);
            }
        });

        $('#send-btn').click(function () {
            var recipientName = $('#recipient-name').val();
            var messageText = $('#message-text').val();

            // AJAX로 데이터 전송
            $.ajax({
                type: 'POST',
                url: '${path}/note/send', 
                data: {
                    recipientName: recipientName,
                    messageText: messageText
                },
                success: function(response) {
                    alert(response);
                    $("#exampleModal").modal("hide");
                    location.replace("${path}/note/get");
                },
                error: function(error) {
                    console.error("에러 발생",error);
                    alert("쪽지 전송에 실패하였습니다.");
                }
            });
        });

        // 쪽지 삭제 함수
        function confirmDelete(noteNo) {
            var isDelete = confirm("쪽지를 삭제하시겠습니까?");

            if (isDelete) {
                deleteNote(noteNo);
            }
        }

        function deleteNote(noteNo) {
            $.ajax({
                type: 'POST',
                url: '${path}/note/deleteNote',
                data: {
                    noteNo: noteNo
                },
                success: function (response) {
                    alert(response);
                    location.reload();
                },
                error: function (error) {
                    console.error("에러 발생:", error);
                    alert("쪽지 삭제에 실패하였습니다.");
                }
            });
        }

        $('.btn-danger').click(function() {
            var noteNo = $(this).closest('tr').find('td:first').text();
            confirmDelete(noteNo);
        });
    });
</script>


<script
	src="${path }/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
