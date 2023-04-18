package com.spring.project.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class MyBoardDTO {
	// 멤버변수
	private int num;     
    private String writer;
    private String state;
    private String subject;
    private int readCnt; 
    private String file1;
    private String texttype;
    private String writestate;
    private Timestamp reg_date;
    private int fwnum;
    private int nextnum;
    

}
