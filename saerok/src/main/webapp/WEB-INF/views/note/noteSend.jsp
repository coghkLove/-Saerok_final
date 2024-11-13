<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="loginEmployee"
   value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}" />
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<!-- 모달 창 -->
<div class="modal fade" id="noteContentModal" tabindex="-1"
   role="dialog" aria-labelledby="noteContentModalTitle"
   aria-hidden="true">
   <div class="modal-dialog" role="document">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title" id="noteContentModalTitle">쪽지 내용</h5>
            <button type="button" class="close" data-dismiss="modal"
               aria-label="Close">
               <span aria-hidden="true">&times;</span>
            </button>
         </div>
         <div class="modal-body" id="noteContentModalBody">
            <!-- 쪽지 내용이 여기에 표시됩니다. -->
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
         </div>
      </div>
   </div>
</div>

<!-- 전체 리스트 출력 -->
<div class="container-fluid">
   <!-- DataTales Example -->
   <div class="card shadow mb-4">
      <div class="card-header py-3">
         <h6 class="m-0 font-weight-bold text-primary">보낸 쪽지함</h6>
      </div>
      <div class="card-body">
         <div class="table-responsive">
            <table class="table table-bordered" id="dataTable" width="100%"
               cellspacing="0">
               <thead>
                  <tr>
                     <th>번호</th>
                     <th>받는사람</th>
                     <th>날짜</th>
                     <th>삭제</th>
                  </tr>
               </thead>
               <tbody>
                  <c:if test="${not empty sentNotes}">
                     <c:forEach var="note" items="${sentNotes}">
                        <tr>
                           <td><c:out value="${note.noteNo}" /></td>
                           <td><a href="javascript:void(0);"
                              onclick="showNoteContent(${note.noteNo})"> <c:out
                                    value="${note.revEmp.empName}" />
                           </a></td>
                           <td><fmt:formatDate value="${note.regDtime}"
                                 pattern="yyyy-MM-dd HH:mm:ss" /></td>
                           <%-- <td><c:out value="${note.readYn}" /></td> --%>
                           <td>
                              <!-- 삭제 버튼 -->
                              <button type="button" class="btn btn-danger"
                                 onclick="confirmDelete(${note.noteNo})">삭제</button>
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
        // DataTable 초기화
        $('#dataTable').DataTable({
            info: false,
            ordering: true,
            paging: true
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
                success: function (response) {
                    alert(response);
                    $("#Modal").modal("hide");
                    location.replace("${path}/note/send");
                },
                error: function (error) {
                    console.log("에러에러", error);
                    alert("쪽지쪽지");
                }
            });
        });
    });

    function confirmDelete(noteNo) {
        // 삭제 여부를 확인하는 confirm 창 띄우기
        var isDelete = confirm("쪽지를 삭제하시겠습니까?");

        if (isDelete) {
            // 확인을 눌렀을 때 휴지통으로 이동
            deleteNote(noteNo);
        }
    }

    function deleteNote(noteNo) {
        // AJAX를 사용하여 서버에 삭제 요청
        $.ajax({
            type: 'POST',
            url: '${path}/note/basket',
            data: {
                noteNo: noteNo
            },
            success: function (response) {
                alert(response);
                // 휴지통으로 이동하는 동작 수행
                location.replace("${path}/note/basket");
            },
            error: function (error) {
                console.error("에러 발생:", error);
                alert("쪽지 삭제에 실패하였습니다.");
            }
        });
    }
    function showNoteContent(noteNo) {
        // AJAX로 쪽지 내용을 서버에서 가져옴
        $.ajax({
            type: 'GET',
            url: '${path}/note/getNoteByNoteNo',
            data: {
                noteNo: noteNo
            },
            success: function (음표) {
                // 모달 창에 쪽지 내용을 표시
                $('#noteContentModalBody').html('<pre>' + note.noteContent + '</pre>');
                $('#noteContentModal').modal('show');
            },
            error: function (error) {
                console.error("에러 발생:", error);
                alert("쪽지 내용을 불러오는 데 실패했습니다.");
            }
        });
    }
    function sendMessage(empNo) {
        alert(empNo);
    }
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
