package org.spring5.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.spring5.domain.Criteria;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler{

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		// TODO Auto-generated method stub
		log.warn("Login Success");
		Criteria cri = new Criteria();
		List<String> roleNames=new ArrayList<>();
		
		authentication.getAuthorities().forEach(authority->{
			roleNames.add(authority.getAuthority());
		});
		
		log.warn("ROLE NAMES: "+roleNames);
		
		if(roleNames.contains("ROLE_ADMIN"))
		{
			response.sendRedirect("/admin/adminMain");
			return;
		}
		if(roleNames.contains("ROLE_MEMBER"))
		{
			response.sendRedirect("/board/getBoardList"+cri.getListLink());
			return;
		}
		response.sendRedirect("/board/getBoardList"+cri.getListLink());
	}

}
