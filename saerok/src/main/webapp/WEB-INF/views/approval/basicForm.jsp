
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="loginEmployee"
	value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }" />

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="일반품의서" name="title" />
</jsp:include>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>



<div class="modal fade" id="testModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content"
			style="width: 1000px; height: auto; left: -50%; display: flex; position: relative;">
			<div class="modal-header">
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close"></button>
				<h3 class="modal-title" id="exampleModalLabel">결재선</h3>
			</div>
			<div class="modal-body">
				<div style="display: flex;">
					<div style="box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); width: 300px;">
						<ul id="mixed" class="loadDeptButton">
							<li><span class="deptName" role="button"
								style="color: black;"> <i class="fas fa-search fa-fw"></i>
									인사팀-HR
							</span>
								<ul class="team-list"></ul></li>
							<li><span class="deptName" role="button"
								style="color: black;"> <i class="fas fa-fw fa-folder"></i>
									관리팀-MG
							</span>
								<ul class="team-list"></ul></li>
							<li><span class="deptName" role="button"
								style="color: black;"> <i class="fas fa-fw fa-folder"></i>
									영업-SA
							</span>
								<ul class="team-list"></ul></li>
							<li><span class="deptName" role="button"
								style="color: black;"> <i class="fas fa-fw fa-folder"></i>
									지점팀-STORE
							</span>
								<ul class="team-list"></ul></li>
						</ul>
					</div>
					<div>
						<input type="button" id="addButton" value="결재자추가"
							style="width: 100px; height: 50px;"> <input type="button"
							id="resetButton" value="취소" style="width: 50px; height: 50px;"><br>
						<!-- <input type="button" id="addReferButton" value="참조자추가"
							style="width: 100px; height: 50px; margin-top: 300px"> <input
							type="button" id="resetButton" value="취소"
							style="width: 50px; height: 50px;"> -->
					</div>
					<div style="display: flex; flex-direction: column;">
						<div
							style="margin-left: 100px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); padding: 10px;">
							결재자 선택</div>
						<div id="approverElement"
							style="margin-left: 100px; width: 300px; height: 300px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);">
							<!-- Your content here -->
						</div>
						<!-- <div
							style=" margin-left: 100px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); padding: 10px;">
							수신참조자 선책</div>

						<div id="referElement"
							style=" margin-left: 100px; height: 325.5px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);">
							Your content here
						</div> -->
					</div>
				</div>
			</div>


			<div class="modal-footer">
				<a class="btn" id="modalY" onclick="fn_modalClose();">예</a>
				<button class="btn" type="button" data-dismiss="modal">아니요</button>
			</div>
		</div>
	</div>
</div>

<script>
function fn_modalClose(){
	alert("등록완료 !!");
	$("#testModal").modal("hide");
	const approvalLineContainer = $($.makeArray($(".basicForm>table tr:first-child>td:gt(1)")).reverse());
	const addLineEmp=$("#approverElement>label");
	addLineEmp.each((i,e)=>{
		console.log(approvalLineContainer[i]);
		console.log(e);
		$(e).find("input[type=checkbox]").attr("type","hidden");
		$(approvalLineContainer[i]).html("");
				
		$(approvalLineContainer[i]).append(e);
	});
	 // 참조자 추가
    const referContainer = $("#referContainer"); 
    const addLineRefer = $("#referElement>label"); 
    referContainer.html(""); 
    addLineRefer.each((i,e)=>{
        $(e).find("input[type=checkbox]").attr("type","hidden");
        referContainer.append(e);
    });
	
}
function loadDeptInfo(depCode) {
    console.log('DEPT_CODE:', depCode);
}

//버튼 클릭 시 loadDeptInfo 호출
$(document).ready(function() {
    $('.loadDeptButton>li').click(function(e) {
        const deptName = e.currentTarget.children[0].innerText;
        const deptCodeName = deptName.substring(deptName.indexOf("-") + 1);
        let deptCode;
        switch(deptCodeName) {
            case "HR": deptCode = 100; break;
            case "MG": deptCode = 200; break;
            case "SA": deptCode = 300; break;
            case "STORE": deptCode = 400; break;
        }
        $.ajax({
            url: '${path}/approval/checkDept',
            method: 'GET',
            data: { deptCode: deptCode },
            success: function(response) {
                const ul = $(e.currentTarget).find(".team-list");
                ul.html("");

                response.forEach(e => {
                	  const $li = $("<li>");
                	  const $label=$("<label>");
                	  const $input=$("<input>").attr({"type":"checkbox","value":e.empNo,"class":"choiceEmp"});
                	  const $a = $("<span>").text(e.empName + " " + e.jobName);
                	  $li.on("click", function(event) {
                		
                	    event.stopPropagation();
                	  });
                	  $label.append($input).append($a);
                	  $li.append($label);
                	  ul.append($li);
                	});

            },
            error: function(xhr, status, error) {
                console.error('Failed:', error);
            }
        });
    });
});
</script>

<script>
/* 결재자 추가  */
$(document).ready(function() {
    function addPeople(selector, limit, elementId, alertMessage) {
        const selectedPeople = $(selector).find("input:checked");
        const existingPeople = $(elementId).find("input[name='order']").map(function() {
            return $(this).val();
        }).get();
		let approvalLine=[];
        selectedPeople.each(function(index, elem) {
            const order = index + 1;
            // 이미 선택된 사람인지 확인
            if (existingPeople.includes(order.toString())) {
                $(elem).prop("checked", false);
            } else {
                const line = $(elem).parent().clone();
                const obj={};
                obj["empNo"]=line.find(".choiceEmp").val();
                obj["order"]=order;
                line.css("display", "block");
                $(elementId).append(line);
                approvalLine.push(obj);
            }
        });
        
        const orderInput = $("<input>").attr({"type": "hidden", "name": "apporvalData", 
                	"value": JSON.stringify(approvalLine)});
        $(basicForm).find("input[name=apporvalData]").remove();
        $(basicForm).append(orderInput);

        const selectedCount = $(elementId).find("input[name='order']").length;
        if (selectedCount > limit) {
            alert(alertMessage);
            selectedPeople.prop("checked", false);
        }
    }

    // 결재자 추가 버튼 클릭 이벤트
    $("#addButton").click(function() {
        addPeople(".team-list>li", 3, "#approverElement", "결재선은 3명까지만 가능합니다.");
    });

    // 참조자 추가 버튼 클릭 이벤트
    $("#addReferButton").click(function() {
        addPeople(".team-list>li", 5, "#referElement", "참조인은 5명까지만 가능합니다.");
    });
    
    // 취소 버튼 클릭 이벤트
    $("#resetButton").click(function() {
        $("#approverElement").empty();
        $("#referElement").empty();
    });
});


</script>
<!--모달창 띄우기  -->
<script>
	$(function(){
		$('#testBtn').click(function(e) {
			e.preventDefault();
			$('#testModal').modal("show");
		});	
		$(document).on('click','#testBtn2',function(e) {
			e.preventDefault();
			$('#testModal').modal("show");
		});	
	})
	
	
	<!-- 조직도 -->
	$(document).ready(function() {
		  $('.team-list').hide(); // 부서 하위 목록 숨김

		  $('.deptName').click(function() {
		    $(this).siblings('.team-list').toggle();
		  });

		  $('.team-list li').click(function() {
		    // 하위 목록의 클릭 이벤트 처리
		    console.log('List item clicked:', $(this).text());
		  });
		});
</script>


<strong>&nbsp; 문서 종류 : </strong>
<select id="selectDoc" name="selectDoc" class="form-select"
	onchange="loadDocumentForm(this.value)">
	<option value="D1">기본 신청서</option>
	<option value="D2">휴가신청서</option>
	<option value="D3">지출 결의서</option>
</select>



<form class="documentForm" name="basicForm"
	action="${path }/approval/insertAppLetter.do" method="POST"
	enctype="multipart/form-data">
	<input type="hidden" name="loginEmp" value="${loginEmployee.empNo }">
	<div id="documentForm " class="documentForm"
		style="margin: 50px 50px 50px 50px; width: min-content;">
		<div class="basicForm">
			<table border="1" style="display: inline-block; text-align: center;">
				<tr>
					<td rowspan="2" colspan="4"
						style="color: black; font-size: 40px; font-weight: 600;">품의서</td>
					<td rowspan="2" style="color: black; font-size: 20px;"><input
						type="button" id="testBtn2" class="rounded-circle border-0"
						value="결재" /></td>
					<td style="color: black; font-size: 15px;">최초승인자</td>
					<td style="color: black; font-size: 15px;">중간승인자</td>
					<td style="color: black; font-size: 15px;">최종승인자</td>
				</tr>
				<tr>

				</tr>
				<tr>
					<td colspan="2" style="color: black; height: 70px;">수신참조자</td>
					<td colspan="6" id="referContainer" style="height: 70px;"></td>
				</tr>
				<tr>
					<td
						style="color: black; height: 70px; width: 80px; font-size: 15px;">성
						명</td>
					<td><input type="text" name="writerName"
						style="border: none; background: transparent; text-align: center;"
						value="${ loginEmployee.empName }" readonly></td>
					<td style="color: black; width: 80px; font-size: 15px;">부 서</td>
					<td><input type="text"
						style="border: none; background: transparent; text-align: center;"
						value="${ loginEmployee.deptName }" readonly></td>
					<td style="color: black; width: 80px; font-size: 15px;">직 급</td>
					<td colspan="3"><input type="text"
						style="border: none; background: transparent;"
						value="${ loginEmployee.jobName }" readonly></td>
				</tr>
				<tr>
					<td style="color: black; height: 50px; width: 80px;">제 목</td>
					<td colspan="8"><textarea class="form-control"
							name="letterTitle" id="loaTitle"
							style="width: 100%; height: 50px; resize: none; overflow: hidden;"></textarea></td>
				</tr>
				<tr>
					<td colspan="8" style="height: 90px;">
						<div class="custom-file">
							<input type="file" class="custom-file-input" name="upFile"
								id="upFile1"> <label class="custom-file-label"
								for="upFile1">파일을 선택하세요</label>
						</div>
					</td>
				</tr>
				<tr>
					<td style="color: black; height: 70px; width: 300px;">상세내용</td>


					<td colspan="8"><textarea class="form-control"
							name="letterDetail" id="loaContent" cols="151px" rows="11px"
							style="width: 100%; height: 300px; border: none; resize: none; overflow: hidden; font-size: 25px;"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="8"
						style="text-align: center; height: 100px; border-bottom: none;">위와
						같은 품의사유로, 검토 후 결재 바랍니다.</td>
				</tr>
				<tr style="color: black; border-top: none; border-bottom: none;">
					<td colspan="8" style="text-align: center; height: 100px;">
						2024년 &nbsp; 1 월 &nbsp; 31일 &nbsp;</td>
				</tr>

				<tr>
					<td colspan="8"
						style="color: black; text-align: right; height: 100px; padding-right: 50px;">
						<input type="button" name="sign" id="sign"
						style="font-size: 15px; width: 70px; height: 30px; border: none; text-align: center; border-radius: 20px; margin-right: 10px"
						value="서명" /> <textArea name="signText" id="signText"
							style="width: 100px; border: none; text-align: center; resize: none; font-size: 24px;"
							readonly="readonly"></textArea>
					</td>
				</tr>
			</table>
		</div>
		<div id="button" style="text-align: center; margin-top: 10px">
			<input type="hidden" name="basicForm" value="품의서">
			<button type="submit" class="btn btn-primary" onclick="">등록</button>
			<!-- ${path}/approval/updateLeave -->
			<input type="text" style="border: none; width: 10px;" disabled>
			<button type="reset" class="btn btn-primary" onclick="">취소</button>
		</div>
	</div>
</form>

<script>
	//AJAX양식선택
	function loadDocumentForm(docType) {
		$.ajax({
			url : '${path}/approval/docForms',
			type : 'GET',
			data : {
				docType : docType
			},
			success : function(response) {
				// 여기서 반환된 내용을 처리하거나 표시합니다.
				$(".documentForm").html(response);
			},
			error : function(error) {
				console.error('문서 양식을 불러오는 중 오류가 발생했습니다.');
			}
		});
	}
</script>

<!-- 필수 입력 스크립트 -->


<!-- 지출결의서폼 비고 +/- -->
<script>
	function fn_addForm() {
		alert("추가함");
		var newRow = '<tr>'
				+ '<td colspan="2"><input type="text" name="erDetail" id="erDetail"></td>'
				+ '<td colspan="2"><input type="text" name="erAmount" id="erAmount"></td>'
				+ '<td colspan="3"><input type="text" name="erReference" id="erReference" value="-"></td>'
				+ '<td><button type="button" class="deleteButton" onclick="fn_deleteForm(this);">삭제</button></td>'
				+ '</tr>';

		// 생성된 행을 마지막 행으로 추가
		$("#putContents").after(newRow);
	}

	function fn_deleteForm(button) {
		// 현재 버튼이 속한 행을 선택하고 삭제합니다.
		$(button).closest('tr').remove();
	}
</script>


<script>
    $("input[name=upFile]").change(e=>{
        const fileName=e.target.files[0].name;
        $(e.target).next(".custom-file-label").text(fileName);
    });
</script>













<jsp:include page="/WEB-INF/views/common/footer.jsp" />
