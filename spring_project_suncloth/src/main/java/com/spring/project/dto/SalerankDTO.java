package com.spring.project.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SalerankDTO {
	// 멤버변수
	private String prdname;     
    private int stock;
    private int cnttotal;
    private int pricetotal;
    

}
