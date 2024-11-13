<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
 <c:set var="path" value="${pageContext.request.contextPath}"/>   
<!-- Footer -->
<footer class="sticky-footer bg-white">
   <div class="container my-auto">
      <div class="copyright text-center my-auto">
         <span>Copyright &copy; saerok 2023</span>
      </div>
   </div>
</footer>
<a class="scroll-to-top rounded" href="#page-top"> <i
   class="fas fa-angle-up"></i>
</a>
<!-- 로그아웃 모달 -->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">ATO 로그아웃</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">로그아웃 하시겠습니까?</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
                    <a class="btn btn-primary" href="${path}/logoutpage">로그아웃</a>
                </div>
            </div>
        </div>
    </div> 
    <script src="${path }/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>