package org.spring5.service;

import java.util.List;

import org.spring5.domain.BoardAttachVO;
import org.spring5.domain.BoardVO;
import org.spring5.domain.Criteria;
import org.spring5.mapper.BoardAttachMapper;
import org.spring5.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class BoardService {

	@Autowired
	private BoardMapper boardMapper;
	
	@Autowired
	private BoardAttachMapper boardAttachMapper;
	
	
	
//	public List<BoardVO> getBoardList() {
//		
//		return boardMapper.getBoardList();
//	}
	
	public List<BoardVO> getBoardList(Criteria cri){
		return boardMapper.getBoardListWithPaging(cri);
			
	}
	
	public int boardListCount(Criteria cri) {
		return boardMapper.boardListCount(cri);
	}
	public BoardVO readBoard(Long bno) {
		log.info(boardMapper.readBoard(bno));
		return boardMapper.readBoard(bno);
	}
	
	@Transactional
	public void insertBoard(BoardVO boardVO) {
			boardMapper.insertBoard(boardVO);
			if(boardVO.getAttachList()==null||boardVO.getAttachList().size()<=0)
			{
				return;
			}
			boardVO.getAttachList().forEach(attach->{
				attach.setBno(boardVO.getBno());
				boardAttachMapper.insert(attach);
			});
		 //boardMapper.insertBoard(boardVO);
	}
	
	public int modifyBoard(BoardVO boardVO)
	{
		return boardMapper.modifyBoard(boardVO);
	}
	public int removeBoard(Long bno)
	{
		return boardMapper.removeBoard(bno);
	}
	//bno마다 첨부파일 불러오기
	public List<BoardAttachVO> getAttachList(Long bno) {
		return boardAttachMapper.findByBno(bno);
	}

	
	public void upCountView(Long bno)
	{
		boardMapper.upCountView(bno);
	}
	
}
