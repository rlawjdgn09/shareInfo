package org.spring5.controller;

import org.spring5.domain.Criteria;
import org.spring5.domain.MemberVO;
import org.spring5.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private PasswordEncoder pwencoder;
	
	//회원가입 페이지 호출
	@GetMapping("/insertMember")
	public void insertMember(Model  model)
	{
		
	}
	//사용자 정보 삽입
	@PostMapping("/insertMember")
	public String insertMember(MemberVO memberVO,RedirectAttributes rttr,Criteria cri){
		memberVO.setMemberPassword(pwencoder.encode(memberVO.getMemberPassword()));
		memberService.insertMember(memberVO);
		rttr.addFlashAttribute("cri", cri);
		return "redirect:/board/getBoardList"+cri.getListLink();
	}
	
	//사용자 수정페페이지 호출
	@PreAuthorize("principal.username==#memberId")
	@GetMapping("/modifyMember")
	public void modifyMember(String memberId,Model  model)
	{
		model.addAttribute("member",memberService.selectInfo(memberId));
	}
	//본인인 경우에만 수정 가능
	@PreAuthorize("principal.username==#memberId")
	@PostMapping("/modifyMember")
	public String modifyMember(MemberVO memberVO,RedirectAttributes rttr,Criteria cri)
	{
		memberService.modifyMember(memberVO);
	
		return "redirect:/board/getBoardList"+cri.getListLink();
	}
	//본인인 경우에 탈퇴 가능
	@PreAuthorize("principal.username==#memberVO.memberId")
	@PostMapping("/removeMember")
	public String removeMember(MemberVO memberVO,RedirectAttributes rttr,Criteria cri)
	{
		memberService.removeMember(memberVO);
	
		return "redirect:/board/getBoardList"+cri.getListLink();
	}
	
	
	
}
