package org.spring5.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class ReplyPageDTO {

	private Long replyTotal;
	private List<ReplyVO> list;
	
	
}
