package com.saerok.dy.note.model.dto;

import java.util.Date;

import com.saerok.jh.employee.model.dto.Employee;

import lombok.Data;

@Data
public class Note {
   private int noteNo;
   private Employee revEmp;
   private Employee sndEmp;
   private String revEmpNo;
   private String sndEmpNo;
   private String noteTitle;
   private String noteContent;
   private String readYn;
   private String delYn;
   private String tempYn;
   //private String regId;
   private Date regDtime;
   private String modId;
   private Date modDtime;
}