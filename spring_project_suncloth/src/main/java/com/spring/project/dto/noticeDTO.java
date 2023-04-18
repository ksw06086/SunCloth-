package com.spring.project.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class noticeDTO {
	// 멤버변수
	private int num;     
    private String id;
    private String subject;
    private String content;
    private Timestamp reg_date;
    private String file1;
    private int readcnt;
    private int nextnum;
    private int fwnum;
    private String nextsubject = null;
    private String fwsubject = null;
   

}
