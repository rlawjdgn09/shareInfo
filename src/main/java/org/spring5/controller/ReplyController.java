package org.spring5.controller;

import org.spring5.domain.Criteria;
import org.spring5.domain.ReplyPageDTO;
import org.spring5.domain.ReplyVO;
import org.spring5.service.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;

@RequestMapping("/replies/")
@RestController
@Log4j
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;
	
	//페이지마다 댓글 리스트 호출
	@GetMapping(value = "/getReplyList/{bno}/{page}",
			produces = {"application/xml; charset = UTF-8",
						"application/json; charset = UTF-8"})
	public ResponseEntity<ReplyPageDTO> getReplyList(@PathVariable("page") int page, @PathVariable("bno") Long bno){
		Criteria cri = new Criteria(page,10);
		
	
		return new ResponseEntity<> (replyService.getReplyList(cri, bno), HttpStatus.OK);
	}
	
	//댓글 등록
	@PostMapping(value = "/insertReply",
			 consumes = "application/json; charset=UTF-8",
			 produces = "text/plain; charset = UTF-8")
	public ResponseEntity<String> insertReply(@RequestBody ReplyVO replyVO) {
		
		return replyService.insertReply(replyVO) ==1
			? new ResponseEntity<>("success", HttpStatus.OK)
			: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	//댓글 수정시 해당 댓글 내용 불러오기
	
	@GetMapping(value = "/{rno}",
			produces = {"application/xml; charset = UTF-8",
						"application/json; charset = UTF-8"})
	public ResponseEntity<ReplyVO> readReply(@PathVariable("rno") Long rno) {
	return new ResponseEntity<>(replyService.readReply(rno), HttpStatus.OK);
	
	}
	
	// 댓글 수정하기
	@RequestMapping(method = { RequestMethod.PUT, RequestMethod.PATCH },
				value = "/{rno}",
				consumes = "application/json",
				produces = { "text/plain; charset = UTF-8" })  
	public ResponseEntity<String> modifyReply (@RequestBody ReplyVO replyVO,
									  @PathVariable("rno") Long rno) {
	replyVO.setRno(rno);
	
	
	return replyService.modifyReply(replyVO) == 1
		   ? new ResponseEntity<>("success", HttpStatus.OK)
		   : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	
	}
	
	//댓글 삭제하기
	@DeleteMapping(value= "/{rno}",
			   produces = { "text/plain; charset = UTF-8" })  
	public ResponseEntity<String> replyDelete(@RequestBody ReplyVO replyVO, @PathVariable("rno") Long rno) {

	
	return replyService.deleteReply(rno) == 1
		   ? new ResponseEntity<>("success", HttpStatus.OK)
		   : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
}



}
	

