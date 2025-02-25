package com.saerok.jj.apv.model.dao;

import java.util.HashMap;
import java.util.List;

import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.saerok.jh.employee.model.dto.Employee;
import com.saerok.jj.apv.model.dto.AppLetter;
import com.saerok.jj.apv.model.dto.Approval;

import jakarta.servlet.http.HttpSession;

@Repository
public class ApprovalDaoImpl implements ApprovalDao {

	

	@Override
	public List<Approval> selectApproval(SqlSession session) {

		return session.selectList("approval.selectApproval");
	}

	@Override
	public Approval selectApprovalByNo(SqlSession session, String appKinds) {

		return session.selectOne("approval.selectApprovalByNo", appKinds);
	}

	

	// 결재선 리스트 불러오기
	@Override
	public List<Map<String, Object>> selectEmployeeList(SqlSession session, Integer deptCode) {
		// TODO Auto-generated method stub
		return session.selectList("approval.selectEmployeeByDeptName", deptCode);
	}

	// 품의서 등록

	@Override
	public int insertApproval(SqlSession session, Approval a) {
		return session.insert("approval.insertApproval", a);
	}

	@Override
	public int insertAppLetter(AppLetter appLetter, SqlSession session) {
		return session.insert("approval.insertAppLetter", appLetter);
	}

	@Override
	public int insertAppr(SqlSession session, AppLetter approval) {
		return session.insert("approval.insertAppr",approval);
	}

	@Override
	public int insertApprovalLine(SqlSession session, Map approvalList) {
		// TODO Auto-generated method stub
		return session.insert("approval.insertApprovalLine",approvalList);
	}
	
	
	//내문서함 조회
	@Override
	public List<Approval> myApproval(SqlSession session, String empNo) {
	    return session.selectList("approval.myApproval", empNo);
	}
	
	//결재할 문서
	@Override
	public List<Approval> myTodoApprovalList(SqlSession session, String empNo) {
	    return session.selectList("approval.myTodoApprovalList", empNo);
	}
	
	
	//상세
	@Override
	public Approval approvalDetailView(SqlSession session, String appSeq) {
	    return session.selectOne("approval.approvalDetailView", appSeq);
	}
	
	//결재 승인 반려
	@Override
	public int updateApprovalStatus(SqlSession session, Map<String, String> paramMap) {
	    return session.update("approval.updateApprovalStatus", paramMap);
	}
	
	//최종결재완료
	@Override
	public int updateApproval(SqlSession session, Map<String, String> paramMap) {
		// TODO Auto-generated method stub
		 return session.update("approval.updateApproval", paramMap);
	}

	
}
