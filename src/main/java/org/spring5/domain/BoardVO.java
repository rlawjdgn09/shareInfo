package org.spring5.domain;

import java.sql.Timestamp;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {
	private Long bno;
	private String category;
	private String title;
	private String contents;
	private Timestamp writeDate; 
	private Timestamp updateDate;
	private String memberId;
	private int countView;
	private String flag;
	
	
	private List<BoardAttachVO> attachList;
}
