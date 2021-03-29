package org.spring5.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ReplyVO {
	private Long rno;
	private String replyContent;
	private Timestamp replyDate;
	private Timestamp replyUpdateDate;
	private String memberId;
	private Long bno;

}
