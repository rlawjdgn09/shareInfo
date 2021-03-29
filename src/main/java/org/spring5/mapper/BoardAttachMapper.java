package org.spring5.mapper;

import java.util.List;

import org.spring5.domain.BoardAttachVO;

public interface BoardAttachMapper {
	public void insert(BoardAttachVO boardAttachVO);
	public void delete(String uuid);
	public List<BoardAttachVO> findByBno(Long bno);
}
