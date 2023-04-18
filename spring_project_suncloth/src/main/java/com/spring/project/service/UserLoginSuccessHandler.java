package com.spring.project.service;

import com.spring.project.dto.UserDTO;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


public class UserLoginSuccessHandler implements AuthenticationSuccessHandler{

	// 로그인이 성공한 경우에 실행할 코드
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		UserDTO vo = (UserDTO) authentication.getPrincipal();
		System.out.println("USERVO ==> " + vo);
		
		String msg = authentication.getName() + "님 환영합니다.";
		request.setAttribute("msg", msg);
		
		RequestDispatcher rd = request.getRequestDispatcher("/hostmain");
		rd.forward(request, response);
	}

}
