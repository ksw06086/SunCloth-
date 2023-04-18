package com.spring.project.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BoardDTO {
	// 멤버변수
	private int num;     
    private String writer;
    private String pwd;
    private String subject;
    private String content;
    private int readCnt; 
    private int ref;     
    private int ref_step;
    private int ref_level;
    private Timestamp reg_date;
    private String ip;

}
