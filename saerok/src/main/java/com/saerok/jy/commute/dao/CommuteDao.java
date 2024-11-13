package com.saerok.jy.commute.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;

import com.saerok.jy.commute.dto.Commute;


public interface CommuteDao {

// 근무기록 조회
Commute selectCommuteList(SqlSession session, Map<String, Object> param);

List<Commute> selectCommuteWorkList(SqlSession session, Map<String, Object> param);

// 금일 출근 기록이 있는지 확인
Commute selectExsistWorkInList(SqlSession session, Map<String, Object> param);


// 출근하기 버튼 누를 시 근무 시작 일시 저장
int insertCommuteStatus(SqlSession session, String empNo);

// 퇴근하기 버튼 누를 시 퇴근 시간 저장
int updateCommuteEndTime(SqlSession session, Map<String, Object> param);

// 퇴근하기 버튼 누를 시 오늘 근무 시간 저장
int updateWorkTime(SqlSession session, Map<String,Object> param);

// 반차 근무 시간 출력 시 4시간 추가 
int updateHalfDayOff(SqlSession session, Map<String, Object> param);

// table 내 그 달의 주차별 시작, 종료일 출력 (전체 조회)
List<Commute> selectMonthWork(SqlSession session, Map<String, Object> param);

// 주간별 누적 기본 근무 시간
int selectWeekWorkTime(SqlSession session, Map<String, Object> startEndMap);

// 주간별 연장 근무시간 
int selectWeekOverTime(SqlSession session, Map<String, Object> startEndMap);

// 주차 클릭시 start / end 사이 근무 출력 
List<Commute> selectWeekDatas(SqlSession session, Map<String, Object> param);

// 이번달, 금주 누적시간 가져오기 
int weekTotalTime(SqlSession session, Map<String, Object> param);

// 이번달 기본 누적 시간 
int totalMonthTime(SqlSession session, Map<String, Object> param);

// 이번달 연장 근무 시간 
int monthOverTime(SqlSession session, Map<String, Object> startEndMap);

int checkStartwork(SqlSession session, Map<String, Object> param);

int updateStartWork(SqlSession session, Map<String, Object> param);


}