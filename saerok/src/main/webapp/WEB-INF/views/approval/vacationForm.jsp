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
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!--휴가신청서 부분  -->
<form class="documentForm" name="basicForm" action="" method="POST"
	onsubmit="return check_onclick()">
	<div id="documentForm " class="documentForm"
		style="margin: 50px 50px 50px 50px; width: min-content;">
		<div class="basicForm">
			<table border="1" style="display: inline-block; text-align: center;">
				<tr>
					<td rowspan="2" colspan="4"
						style="color: black; font-size: 40px; font-weight: 600;">휴가신청서</td>
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
					<td colspan="3"
						style="color: black; height: 70px; width: 80px; font-size: 15px;">비상
						연 락 망</td>
					<td colspan="5"><input type="tel" placeholder="전화번호만 입력하세요."
						class="callNumber" name="appEmergncyCall" style="font-size: 18px;"
						required></td>
				</tr>


				<tr>
					<td colspan="3"
						style="color: black; height: 70px; width: 80px; font-size: 15px;">기
						간</td>
					<td colspan="5"><span> <input
							style="width: 160px; font-size: 18px;" type="date"
							name="leaveStart" id="startDate" />
					</span> &nbsp;&nbsp; ~ &nbsp;&nbsp; <span> <input
							style="width: 160px; font-size: 18px;" type="date"
							name="leaveFinish" id="endDate" />
					</span></td>
				</tr>
				<tr>
					<td
						style="color: black; width: 80px; height: 70px; font-size: 15px;">휴가
						구분</td>
					<td colspan="8">

						<div class="form-checkbox-wrap">
							<sapn class="form-inline"> <input type="radio"
								name="vacationType" class="input-radio" id="radio1" value="연차">
							&nbsp;&nbsp;&nbsp; <label for="radio1" class="form-radio">연차</label>
							</sapn>
							<sapn class="form-inline"> <input type="radio"
								name="vacationType" class="input-radio" id="radio2" value="반차">
							&nbsp;&nbsp;&nbsp; <label for="radio2" class="form-radio">반차</label>
							</sapn>

						</div>
					</td>
				</tr>
				<tr>
					<td style="color: black; width: 80px; font-size: 15px;">세부사항</td>
					<td colspan="8"><textarea class="form-control"
							style="height: 200px; width: 100%;" name="vacationDetail"
							class="fr-wrapper show-placeholder"></textarea></td>
				</tr>
				<tr>
					<td colspan="8"
						style="text-align: center; height: 100px; border-bottom: none;">위와
						같이 휴가를 신청하오니 허락하여 주시기 바랍니다.</td>
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
			<input type="hidden" name="appKinds" value="휴가신청서">
			<button type="submit" class="btn btn-primary" onclick="">등록</button>
			<!-- ${path}/approval/updateLeave -->
			<input type="text" style="border: none; width: 10px;" disabled>
			<button type="reset" class="btn btn-primary" onclick="">취소</button>
		</div>
	</div>
</form>




<!--휴가 기간  -->
<script type="text/javascript">
	// 시작일 < 종료일
	var start = document.getElementById('startDate');
	var end = document.getElementById('endDate');

	start.addEventListener('change', function() {
		if (start.value)
			end.min = start.value;
	}, false);
	end.addEventListener('change', function() {
		if (end.value)
			start.max = end.value;
	}, false);
</script>
<!-- 필수 입력 스크립트 -->
<script>
	function check_onclick() {
		var vacationForm = document.vacationForm;

		if (vacationForm.vacationType.value == ""
				|| vacationForm.vacationDetail.value == "") {
			Swal.fire({
				icon : 'error',
				title : '상세내용 또는 제목란이 비어있습니다.',
				text : '확인 후 등록하세요!'
			})
			return false;
		} else if (vacationForm.signText.value == "") {
			Swal.fire({
				icon : 'error',
				title : '서명 후 등록을 완료해주세요.',
				text : '확인 후 등록하세요!'
			})
			return false;
		} else {
			return true;
		}
	}
</script>

<!-- 서명 클릭 스크립트  -->

<script>
	$("#sign").one("click", function() {
		var signValue = $("input[name='writerName']").val();
		$("#signText").val(signValue);
	});
</script>

<!--비상연락망  아직 안됨 -->
<script>
	$(document).ready(
			function() {
				$('.callNumber').on(
						'input',
						function() {
							let phoneNumber = $(this).val().replace(/[^\d]/g,
									'');

							if (phoneNumber.length > 10) {
								phoneNumber = phoneNumber.slice(0, 10);
							}

							if (phoneNumber.length >= 3
									&& phoneNumber.length <= 6) {
								phoneNumber = phoneNumber.replace(
										/(\d{3})(\d{1,3})/, '$1-$2');
							} else if (phoneNumber.length > 6) {
								phoneNumber = phoneNumber.replace(
										/(\d{3})(\d{3})(\d{1,4})/, '$1-$2-$3');
							}

							$(this).val(phoneNumber);
						});
			});
</script>