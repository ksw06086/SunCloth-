package com.spring.project.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class orderDTO {
	// 멤버변수
	private int num;   
    private String prdname;
	private String gid;
    private int prdnum;
    private int colorcode;
    private int sizecode;
    private int count;
    private int price;
    private Timestamp reg_date;
    private String bankname;
    private String pay_option;
    private String colorname;
    private String sizename;
    private String state;
    private int useplus;
    private int realprice;
    private String mainfile;
    private String depositname;
    private String usermessege;
    private int prdplus;


}
