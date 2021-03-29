package org.spring5.service;

import org.spring5.domain.MemberVO;
import org.spring5.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MemberService {

	@Autowired
	private MemberMapper memberMapper;
	
	public void insertMember(MemberVO memberVO) {
		memberMapper.insertMember(memberVO);
		memberMapper.insertMemberAuth(memberVO.getMemberId());
		
	}
	
	public MemberVO selectInfo(String memberId) {
		return memberMapper.selectInfo(memberId);
	}
	
	public void modifyMember(MemberVO memberVO) {
		memberMapper.modifyMember(memberVO);
	}

	public void removeMember(MemberVO memberVO) {
		memberMapper.removeMember(memberVO);
	}

}
