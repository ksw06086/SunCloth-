package com.spring.project.service;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;

public interface MemberService {
	
	// 중복확인 처리
	public void confirmId(HttpServletRequest req, Model model);
	
	// 회원가입 처리
	public void inputPro(HttpServletRequest req, Model model);
	
	// 로그인 처리
	public void loginPro(HttpServletRequest req, Model model);
	
	// 회원탈퇴 처리
	public void deletePro(HttpServletRequest req, Model model);
	
	// 회원정보 수정 상세 페이지
	public void modifyView(HttpServletRequest req, Model model);
	
	// 환불계좌 수정 처리
	public void refundPro(HttpServletRequest req, Model model);
	
	// 회원정보 수정 처리
	public void modifyPro(HttpServletRequest req, Model model);
	
	// 글쓰기 페이지
	public void writeForm(HttpServletRequest req, Model model);
	
	// 공지 글쓰기 처리 페이지
	public void h_noticePro(MultipartHttpServletRequest req, Model model);
	
	// 공지 삭제 처리 페이지
	public void h_noticedeletePro(HttpServletRequest req, Model model);
	
	// 공지 View
	public void h_noticeupdateView(HttpServletRequest req, Model model);
	
	// 공지 수정 처리 페이지
	public void h_noticeupdatePro(HttpServletRequest req, Model model);
	
	
	// FAQ 처리 페이지들
	public void FAQList(HttpServletRequest req, Model model);

	public void h_FAQPro(HttpServletRequest req, Model model);
	
	public void h_FAQupdateView(HttpServletRequest req, Model model);

	public void h_FAQupdatePro(HttpServletRequest req, Model model);
	
	public void h_FAQdeletePro(HttpServletRequest req, Model model);
	
	// QnA 처리 페이지들
	public void QnAList(HttpServletRequest req, Model model);
	
	public void QnAPro(MultipartHttpServletRequest req, Model model);
	
	public void QnAupdateView(HttpServletRequest req, Model model);
	
	
	// review
	public void reviewupdateView(HttpServletRequest req, Model model);
	
	
	
	
	
	
	
	// big part
	public void bigpartPro(HttpServletRequest req, Model model);
	
	public void bigpartdelPro(HttpServletRequest req, Model model);

	// medium part
	public void mediumPro(HttpServletRequest req, Model model);
	
	public void mediumpartdelPro(HttpServletRequest req, Model model);

	// color part
	public void colorPro(HttpServletRequest req, Model model);
	
	public void colordelPro(HttpServletRequest req, Model model);

	// size part
	public void sizePro(HttpServletRequest req, Model model);
	
	public void sizedelPro(HttpServletRequest req, Model model);
	
}
