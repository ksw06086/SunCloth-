package com.spring.project.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class QnADTO {
	// 멤버변수
	private int num;
    private String writer;
    private String state;
    private String pwd;
    private String subject;
    private String content;
    private Timestamp reg_date;
    private String file1;
    private int ref;
    private int ref_step;
    private int ref_level;
    private String ip;
    private int nextnum;
    private int fwnum;
    private String nextsubject = null;
    private String fwsubject = null;
    private String nexttextType = null;
    private String fwtextType = null;
    private String writestate;
    private String textType;
}
