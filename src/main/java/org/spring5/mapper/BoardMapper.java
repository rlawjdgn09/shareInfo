package org.spring5.mapper;

import java.util.List;

import org.spring5.domain.BoardVO;
import org.spring5.domain.Criteria;

public interface BoardMapper {

	public List<BoardVO> getBoardList();

	public List<BoardVO> getBoardListWithPaging(Criteria cri);
	
	public int boardListCount(Criteria cri);
	
	public BoardVO readBoard(Long bno);
	
	public void insertBoard(BoardVO boardVO);

	public int modifyBoard(BoardVO boardVO);
	
	public int removeBoard(Long bno);
	
	public void upCountView(Long bno);
}
