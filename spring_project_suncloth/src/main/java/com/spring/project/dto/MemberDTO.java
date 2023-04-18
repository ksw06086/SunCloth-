package com.spring.project.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;
import java.sql.Timestamp;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberDTO {
	
	// 멤버변수
	private String id = null;
	private String pwd = null;
	private String name = null;
	private String address = null;
	private String address1 = null;
	private String address2 = null;
	private String homephone = null;
	private String hp = null;
	private String email = null;
	private Date birth = null;
	private String birthtype = null;
	private String acchost = null;
	private String bank = null;
	private String acc = null;
	private Timestamp reg_date = null;
	private int plus = 0;
	private int visitcnt = 0;
	private int auth;
	private String key;
	private String hostmemo;
	private String authority;
	
	
}
