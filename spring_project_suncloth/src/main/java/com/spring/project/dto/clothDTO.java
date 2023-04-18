package com.spring.project.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class clothDTO {
	// 멤버변수
	private int num;     
    private String name;
    private String content;
    private int mediumcode;
    private String tex;
    private int brandnum;
    private String icon;
    private int plus;
    private int saleprice;
    private int buyprice;
    private int deliday;
    private int deliprice;
    private String mainfile = null;
    private String file1 = null;
    private String file2 = null;
    private String file3 = null;
    private String file4 = null;
    private String file5 = null;
    private int withprdnum = 0;
    private Timestamp reg_date;
    private String bigpartname;
    private String mediumpartname;
    private String brandname;
}
