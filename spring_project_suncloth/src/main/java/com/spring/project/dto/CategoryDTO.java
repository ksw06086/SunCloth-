package com.spring.project.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CategoryDTO {
	// 멤버변수
	private String mediname;     
    private String bigname;
    private int cnttotal;
    private int pricetotal;

}
