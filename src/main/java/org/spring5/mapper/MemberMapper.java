package org.spring5.mapper;




import org.spring5.domain.MemberVO;

public interface MemberMapper {
	public void insertMember(MemberVO memberVO);
	
	public void insertMemberAuth(String memberId);
	
	public MemberVO selectInfo(String memberId);
	
	public void modifyMember(MemberVO memberVO);
	
	public void removeMember(MemberVO memberVO);
	
	public MemberVO readAuth(String memberId);
	
	
}
