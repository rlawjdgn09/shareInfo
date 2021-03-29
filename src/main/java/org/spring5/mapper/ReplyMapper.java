package org.spring5.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.spring5.domain.Criteria;
import org.spring5.domain.ReplyVO;

public interface ReplyMapper {
	
//	public List<ReplyVO> getReplyList(Long bno);
	
	public List<ReplyVO> getReplyList(@Param("cri") Criteria cri,@Param("bno")Long bno);
	
	public List<ReplyVO> getReplyListPaging(Criteria cri,Long bno);
	
	
	public int insertReply(ReplyVO replyVO);
	
	public ReplyVO readReply(Long rno);
	
	public int deleteReply(Long rno);
	
	public int modifyReply(ReplyVO replyVO);
	
	public Long getReplyCountByBno(Long bno);
}
