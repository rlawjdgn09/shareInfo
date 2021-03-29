package org.spring5.service;

import java.util.List;

import org.spring5.domain.Criteria;
import org.spring5.domain.ReplyPageDTO;
import org.spring5.domain.ReplyVO;
import org.spring5.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyService {
	
	@Autowired
	private ReplyMapper replyMapper;
	
//
//	public List<ReplyVO> getReplyList(Long bno){
//		return replyMapper.getReplyList(bno);
//	}
	public ReplyPageDTO getReplyList(Criteria cri, Long bno) {
		log.info("Service");
		
		
		return new ReplyPageDTO(
						replyMapper.getReplyCountByBno(bno),
						replyMapper.getReplyList(cri, bno));
	}
	
	public List<ReplyVO> getReplyListPaging(Criteria cri,Long bno){
		return replyMapper.getReplyListPaging(cri, bno);
	}
	
	
	public int insertReply(ReplyVO replyVO) {
		return replyMapper.insertReply(replyVO);
	}
	public ReplyVO readReply(Long rno) {
		return replyMapper.readReply(rno);
	}
	
	public int deleteReply(Long rno) {
		return replyMapper.deleteReply(rno);
	}
	
	public int modifyReply( ReplyVO replyVO) {
		return replyMapper.modifyReply(replyVO);
	}
	
	
}
