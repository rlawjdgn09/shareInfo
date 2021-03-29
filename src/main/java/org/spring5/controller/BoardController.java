package org.spring5.controller;

import java.util.List;

import org.spring5.domain.BoardAttachVO;
import org.spring5.domain.BoardVO;
import org.spring5.domain.Criteria;
import org.spring5.domain.pageDTO;
import org.spring5.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;


@Controller
@Log4j
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	
	//보드 리스트 페이지 호출
	@GetMapping("/getBoardList")
	public void getBoardList(Model model,Criteria cri )
	{
		
		log.info("getBoardList");
		model.addAttribute("pageMaker",new pageDTO(cri,boardService.boardListCount(cri)));
	}
	//rest 리스트 목록 조회
//	@GetMapping(value="/restGetBoardList",
//			produces="application/json; charset=utf-8")
//	public ResponseEntity<List<BoardVO>> restGetBoardList(){
//		
//		return new ResponseEntity<>(boardService.getBoardList(),HttpStatus.OK);
//	}
	
	@GetMapping(value="/restGetBoardList",
			produces="application/json; charset=utf-8")
	public ResponseEntity<List<BoardVO>> restGetBoardList(Criteria cri){
		
		return new ResponseEntity<>(boardService.getBoardList(cri),HttpStatus.OK);
	}
	
	//게시판 상세 페이지 호출
	@GetMapping("/readBoard")
	public void readBoard(Model model,Long bno,Criteria cri) {
		//조회수 증가
		boardService.upCountView(bno);
		model.addAttribute("board", boardService.readBoard(bno));
		model.addAttribute("cri", cri);
	}
	//글쓰기 페이지 호출
	@GetMapping("/insertBoard")
	public void insertBoard(Model model) {
		
	}
	//게시판 등록
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/insertBoard")
	public String insertBoard(BoardVO boardVO,RedirectAttributes rttr){
		
		if(boardVO.getAttachList()!=null) {
			boardVO.getAttachList().forEach(attach->log.info(attach));
			
		}
		boardService.insertBoard(boardVO);
		//log.info("========================="+boardVO.getBno());
		rttr.addFlashAttribute("result",boardVO.getBno());
		
		
		return "redirect:/board/getBoardList";
	}
	
	//게시판 수정 페이지 호출
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/modifyBoard")
	public void modifyBoard(Model model,Long bno,Criteria cri) {
		model.addAttribute("cri", cri);
		model.addAttribute("board", boardService.readBoard(bno));
	}
	//게시판 수정
	@PreAuthorize("principal.username==#boardVO.memberId")
	@PostMapping("/modifyBoard")
	public String modifyBoard(BoardVO boardVO, Criteria cri,RedirectAttributes rttr) {
		log.info("boardVO: "+boardVO);
		if(boardService.modifyBoard(boardVO)==1)
		{
			log.info("수정 성공");
			rttr.addFlashAttribute("result","modify");
		}
		rttr.addAttribute("pageNum",cri.getPageNum());
		rttr.addAttribute("amount",cri.getAmount());
		
		return "redirect:/board/getBoardList";
	}
	//게시판 삭제 요청
	@PreAuthorize("principal.username==#memberId")
	@PostMapping("/removeBoard")
	public String boardDelete(Long bno,Criteria cri ,RedirectAttributes rttr, String memberId) {
		
		
		if(boardService.removeBoard(bno)==1) {
			rttr.addFlashAttribute("result","remove");
		}
		rttr.addAttribute("pageNum",cri.getPageNum());
		rttr.addAttribute("amount",cri.getAmount());
		
		
		return "redirect:/board/getBoardList";
	}
	//검색에 따른 토탈
	@GetMapping(value="/restBoardGetTotalPageCnt",
			produces="application/json; charset=utf-8")
	@ResponseBody
	public ResponseEntity<Integer> restBoardGetTotalPageCnt( Criteria cri) {
		int result = boardService.boardListCount(cri);
		return new ResponseEntity<>(result,HttpStatus.OK);
	}
	
	@GetMapping(value="/getAttachList",
			produces="application/json; charset=utf-8")
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){
		return new ResponseEntity<>(boardService.getAttachList(bno),HttpStatus.OK);
	}
	
}
	
