package com.spring.project.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PluspayDTO {
	// 멤버변수
	private String gname;     
    private String gid;
    private int cnt;
    private int useplus;
    private int myplus;
    

}
