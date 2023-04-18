package com.spring.project.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class BrandDTO {
	// 멤버변수
	private int num;     
    private String name;
    private Timestamp reg_date;
    private String hp = "";

}
