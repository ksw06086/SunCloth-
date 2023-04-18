package com.spring.project.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class stockDTO {
	// 멤버변수
	private int num;     
    private int prdnum;
    private int colorcode;
    private int sizecode;
    private String state;
    private int maxcount;
    private int count;
    private String colorname;
    private String sizename;
    

}
