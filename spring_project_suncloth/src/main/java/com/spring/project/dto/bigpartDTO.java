package com.spring.project.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class bigpartDTO {
	// 멤버변수
	private int bigcode;		// 대분류 코드
    private String bigname;		// 대분류 명

}
