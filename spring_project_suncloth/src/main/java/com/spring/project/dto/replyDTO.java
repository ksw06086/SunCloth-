package com.spring.project.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class replyDTO {
	// 멤버변수
	private int num;     
    private String writer;
    private String subject;
    private String content;
    private Timestamp reg_date;
    private int ref;
    private String ip;
   

}
