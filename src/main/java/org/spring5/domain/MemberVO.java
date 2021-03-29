package org.spring5.domain;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	private String memberId;
	private String memberPassword;
	private String memberName;
	private String memberEmail;
	private String memberAddress;
	private String memberPhoneNumber;
	private Date joinDate;
	private char enabled;
	
	
	private List<AuthVO> authList;
}
