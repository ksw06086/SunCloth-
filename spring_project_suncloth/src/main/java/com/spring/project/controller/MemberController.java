package com.spring.project.controller;

import com.spring.project.service.MemberServiceImpl;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.WebAttributes;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequiredArgsConstructor
public class MemberController {

	private final MemberServiceImpl service;
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@RequestMapping("main")
	public String main(HttpServletRequest req, Model model) {
		logger.info("url ==> main");
		if (req.getSession().getAttribute("memCnt") == null) {
			service.prdList(req, model);
			return "/suncloth/main";
		} else if ((Integer) req.getSession().getAttribute("memCnt") == 0) {
			service.prdList(req, model);
			return "/suncloth/main";
		} else if ((Integer) req.getSession().getAttribute("memCnt") == 1) {
			service.hostmain(req, model);
			return "/host/hostmain";
		}
		return "suncloth/main";
	}
	
	@RequestMapping("mymain")
	public String mymain(HttpServletRequest req, Model model) {
		logger.info("url ==> main");
		
		return "/suncloth/main";
	}
	
	@RequestMapping("inputForm")
	public String inputForm(HttpServletRequest req, Model model) {
		logger.info("url ==> inputForm");
		
		return "/suncloth/join_us";
	}
	
	@RequestMapping("o_inputForm")
	public String o_inputForm(HttpServletRequest req, Model model) {
		logger.info("url ==> o_inputForm");
		
		return "/suncloth/h_join_us";
	}
	
	@RequestMapping("confirmId")
	public String confirmId(HttpServletRequest req, Model model) {
		logger.info("url ==> confirmId");
		service.confirmId(req, model);
		
		return "/suncloth/confirmId";
	}
	
	@RequestMapping("emailsend")
	public String emailsend(HttpServletRequest req, Model model) throws Exception {
		logger.info("url ==> emailsend");
		service.emailsend(req, model);
		
		return "/suncloth/emailsend";
	}
	
	@RequestMapping("inputPro")
	public String inputPro(HttpServletRequest req, Model model) {
		logger.info("url ==> inputPro");
		service.inputPro(req, model);
		
		return "/suncloth/inputPro";
	}
	
	@RequestMapping("findid")
	public String findid(HttpServletRequest req, Model model) {
		logger.info("url ==> findid");
		
		return "/suncloth/findid";
	}
	
	@RequestMapping("findpwd")
	public String findpwd(HttpServletRequest req, Model model) {
		logger.info("url ==> findpwd");
		
		return "/suncloth/findpwd";
	}
	
	@RequestMapping("findidcomplete")
	public String findidcomplete(HttpServletRequest req, Model model) {
		logger.info("url ==> findidcomplete");
		service.findid(req, model);
		
		return "/suncloth/findcompleteid";
	}
	
	@RequestMapping("findpwdcomplete")
	public String findpwdcomplete(HttpServletRequest req, Model model) {
		logger.info("url ==> findpwdcomplete");
		service.findpwd(req, model);
		
		return "/suncloth/findcompletepwd";
	}
	
	@RequestMapping("mainSuccess")
	public String mainSuccess(HttpServletRequest req, Model model) {
		logger.info("url ==> mainSuccess");
		
		model.addAttribute("id", req.getParameter("id"));
		model.addAttribute("name", req.getParameter("names"));
		model.addAttribute("email", req.getParameter("email"));
		model.addAttribute("member", req.getParameter("member"));
		return "/suncloth/join_complete";
	}
	
	@RequestMapping("loginPro")
	public String loginPro(HttpServletRequest req, Model model) {
		logger.info("url ==> loginPro");
		service.loginPro(req, model);
		
		return "/suncloth/loginPro";
	}
	
	@RequestMapping("login")
	public String login(HttpServletRequest req, Model model) {
		logger.info("url ==> login");
		if(req.getParameter("member") == null) {
			return "/suncloth/g_login";
		} else if (Integer.parseInt(req.getParameter("member")) == 0) {
			return "/suncloth/g_login";
		} else {
			return "/suncloth/h_login";
		}
	}
	
	@RequestMapping("z_login")
	public String z_login(HttpServletRequest req, Model model) {
		logger.info("url ==> login");
		
		return "/suncloth/h_login";
	}
	
	@RequestMapping("logout")
	public String logout(HttpServletRequest req, Model model, HttpSession session) {
		logger.info("url ==> logout");
		session.invalidate();
		return "/suncloth/logoutPro";
	}
	
	@RequestMapping("modifyView")
	public String modifyView(HttpServletRequest req, Model model) {
		logger.info("url ==> modifyView");
		service.modifyView(req, model);
		
		return "/suncloth/modify_profile";
	}
	
	@RequestMapping("modifyacc")
	public String modifyacc(HttpServletRequest req, Model model) {
		logger.info("url ==> modifyacc");
		model.addAttribute("bank", req.getParameter("bank"));
		model.addAttribute("acc", req.getParameter("acc"));
		model.addAttribute("acchost", req.getParameter("acchost"));
		
		return "/suncloth/refundbankChange";
	}
	
	@RequestMapping("refundPro")
	public String refundPro(HttpServletRequest req, Model model) {
		logger.info("url ==> refundPro");
		service.refundPro(req, model);
		
		return "/suncloth/refundPro";
	}
	
	@RequestMapping("modifyPro")
	public String modifyPro(HttpServletRequest req, Model model) {
		logger.info("url ==> modifyPro");
		service.modifyPro(req, model);
		
		return "/suncloth/modifyPro";
	}
	

	@RequestMapping("notice")
	public String notice(HttpServletRequest req, Model model) {
		logger.info("url ==> notice");
		service.noticeList(req, model);
		
		return "/suncloth/notice";
	}
	
	@RequestMapping("noticeForm")
	public String noticeForm(HttpServletRequest req, Model model) {
		logger.info("url ==> noticeForm");
		service.h_noticeupdateView(req, model);
		
		return "/suncloth/noticeView";
	}
	
	@RequestMapping("FAQ")
	public String FAQ(HttpServletRequest req, Model model) {
		logger.info("url ==> FAQ");
		service.FAQList(req, model);
		
		return "/suncloth/FAQ";
	}
	
	@RequestMapping("FAQForm")
	public String FAQForm(HttpServletRequest req, Model model) {
		logger.info("url ==> FAQForm");
		service.h_FAQupdateView(req, model);
		
		return "/suncloth/FAQView";
	}
	
	@RequestMapping("QnA")
	public String QnA(HttpServletRequest req, Model model) {
		logger.info("url ==> QnA");
		service.QnAList(req, model);
		
		return "/suncloth/QnA";
	}
	
	@RequestMapping("QnAwrite")
	public String QnAwrite(HttpServletRequest req, Model model) {
		logger.info("url ==> QnAwrite");
		service.writeForm(req, model);
		
		return "/suncloth/QnAwrite";
	}
	
	@RequestMapping("QnAPro")
	public String QnAPro(MultipartHttpServletRequest req, Model model) {
		logger.info("url ==> QnAPro");
		service.QnAPro(req, model);
		
		return "/suncloth/QnAPro";
	}
	
	@RequestMapping("QnAForm")
	public String QnAForm(HttpServletRequest req, Model model) {
		logger.info("url ==> QnAForm");
		service.writeForm(req, model);
		if(req.getParameter("textType") != null && req.getParameter("textType").equals("close")) {
			model.addAttribute("num", req.getParameter("num"));
			model.addAttribute("number", req.getParameter("number"));
			model.addAttribute("pageNum", req.getParameter("pageNum"));
			model.addAttribute("choose", req.getParameter("choose"));
			return "/suncloth/QnAForm1";
		} else {
			service.QnAupdateView(req, model);
			if (req.getSession().getAttribute("memCnt") == null || (Integer)req.getSession().getAttribute("memCnt") == 0) {
				return "/suncloth/QnAForm2";
			} else {
				return "/suncloth/h_QnAForm2";
			}
		}
	}
	
	@RequestMapping("QnAupdate")
	public String QnAupdate(HttpServletRequest req, Model model) {
		logger.info("url ==> QnAupdate");
		service.QnAupdateView(req, model);
		
		return "/suncloth/QnAupdate";
	}
	
	@RequestMapping("QnAupdatePro")
	public String QnAupdatePro(MultipartHttpServletRequest req, Model model) {
		logger.info("url ==> QnAupdatePro");
		service.QnAupdatePro(req, model);
		
		return "/suncloth/QnAupdatePro";
	}
	
	@RequestMapping("QnAdeletePro")
	public String QnAdeletePro(HttpServletRequest req, Model model) {
		logger.info("url ==> QnAdeletePro");
		service.QnAdeletePro(req, model);
		
		return "/suncloth/QnAdeletePro";
	}
	
	@RequestMapping("review")
	public String review(HttpServletRequest req, Model model) {
		logger.info("url ==> review");
		service.reviewList(req, model);
		
		return "/suncloth/review";
	}
	
	@RequestMapping("reviewwrite")
	public String reviewwrite(HttpServletRequest req, Model model) {
		logger.info("url ==> reviewwrite");
		service.writeForm(req, model);
		
		return "/suncloth/reviewwrite";
	}
	
	@RequestMapping("reviewPro")
	public String reviewPro(MultipartHttpServletRequest req, Model model) {
		logger.info("url ==> reviewPro");
		service.reviewPro(req, model);
		
		return "/suncloth/reviewPro";
	}
	
	@RequestMapping("reviewForm")
	public String reviewForm(HttpServletRequest req, Model model) {
		logger.info("url ==> reviewForm");
		service.reviewupdateView(req, model);
		
		return "/suncloth/reviewForm";
	}
	
	@RequestMapping("reviewdelete")
	public String reviewdelete(HttpServletRequest req, Model model) {
		logger.info("url ==> reviewdelete");
		service.reviewdeletePro(req, model);
		
		return "/suncloth/reviewdelete";
	}
	
	@RequestMapping("replyPro")
	public String replyPro(HttpServletRequest req, Model model) {
		logger.info("url ==> replyPro");
		service.replyPro(req, model);
		
		return "/suncloth/replyPro";
	}
	
	@RequestMapping("replydelete")
	public String replydelete(HttpServletRequest req, Model model) {
		logger.info("url ==> replydelete");
		service.replydeletePro(req, model);
		
		return "/suncloth/replydelete";
	}
	
	@RequestMapping("deletePro")
	public String deletePro(HttpServletRequest req, Model model) {
		logger.info("url ==> deletePro");
		service.deletePro(req, model);
		
		return "/suncloth/deletePro";
	}
	
	// hostmain
	@RequestMapping("hostmain")
	public String hostmain(HttpServletRequest req, Model model) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		String username = ((UserDetails) principal).getUsername();
		String password = ((UserDetails) principal).getPassword();
		req.getSession().setAttribute("memId", username);
		req.getSession().setAttribute("memCnt", 1);
		System.out.println(username);

		logger.info("url ==> hostmain");
		service.hostmain(req, model);
		
		return "/host/hostmain";
	}
	
	@RequestMapping("boardView")
	public String boardView(HttpServletRequest req, Model model) {
		logger.info("url ==> boardView");
		
		return "/host/h_board";
	}
	
	@RequestMapping("h_notice")
	public String h_notice(HttpServletRequest req, Model model) {
		logger.info("url ==> h_notice");
		service.noticeList(req, model);
		
		return "/host/h_notice";
	}
	
	@RequestMapping("h_noticewrite")
	public String h_noticewrite(HttpServletRequest req, Model model) {
		logger.info("url ==> h_noticewrite");
		service.writeForm(req, model);
		
		return "/host/h_noticewrite";
	}
	
	@RequestMapping(value = "h_noticePro", method = RequestMethod.POST)
	public String h_noticePro(MultipartHttpServletRequest req, Model model) {
		logger.info("url ==> h_noticePro");
		service.h_noticePro(req, model);
		
		return "/host/h_noticePro";
	}
	
	@RequestMapping("h_noticedeletePro")
	public String h_noticedeletePro(HttpServletRequest req, Model model) {
		logger.info("url ==> h_noticedeletePro");
		service.h_noticedeletePro(req, model);
		
		return "/host/h_noticedeletePro";
	}
	
	@RequestMapping("h_noticeForm")
	public String h_noticeForm(HttpServletRequest req, Model model) {
		logger.info("url ==> h_noticeForm");
		service.h_noticeupdateView(req, model);
		
		return "/host/h_noticeupdate";
	}
	
	@RequestMapping("h_noticeUpdatePro")
	public String h_noticeUpdatePro(HttpServletRequest req, Model model) {
		logger.info("url ==> h_noticeUpdatePro");
		service.h_noticeupdatePro(req, model);
		
		return "/host/h_noticeUpdatePro";
	}
	
	@RequestMapping("h_noticeselect")
	public String h_noticeselect(HttpServletRequest req, Model model) {
		logger.info("url ==> h_noticeselect");
		service.noticeList(req, model);
		
		return "/host/h_notice";
	}
	
	@RequestMapping("h_FAQ")
	public String h_FAQ(HttpServletRequest req, Model model) {
		logger.info("url ==> h_FAQ");
		service.FAQList(req, model);
		
		return "/host/h_FAQ";
	}
	
	@RequestMapping("h_FAQwrite")
	public String h_FAQwrite(HttpServletRequest req, Model model) {
		logger.info("url ==> h_FAQwrite");
		service.writeForm(req, model);
		
		return "/host/h_FAQinputForm";
	}
	
	@RequestMapping("h_FAQPro")
	public String h_FAQPro(HttpServletRequest req, Model model) {
		logger.info("url ==> h_FAQPro");
		service.h_FAQPro(req, model);
		
		return "/host/h_FAQPro";
	}
	
	@RequestMapping("h_FAQdeletePro")
	public String h_FAQdeletePro(HttpServletRequest req, Model model) {
		logger.info("url ==> h_FAQdeletePro");
		service.h_FAQdeletePro(req, model);
		
		return "/host/h_FAQdeletePro";
	}
	
	@RequestMapping("h_FAQForm")
	public String h_FAQForm(HttpServletRequest req, Model model) {
		logger.info("url ==> h_FAQForm");
		service.h_FAQupdateView(req, model);
		
		return "/host/h_FAQupdate";
	}
	
	@RequestMapping("h_FAQUpdatePro")
	public String h_FAQUpdatePro(HttpServletRequest req, Model model) {
		logger.info("url ==> h_FAQUpdatePro");
		service.h_FAQupdatePro(req, model);
		
		return "/host/h_FAQUpdatePro";
	}
	
	@RequestMapping("h_FAQselect")
	public String h_FAQselect(HttpServletRequest req, Model model) {
		logger.info("url ==> h_FAQselect");
		service.FAQList(req, model);
		
		return "/host/h_FAQ";
	}
	
	@RequestMapping("h_QnA")
	public String h_QnA(HttpServletRequest req, Model model) {
		logger.info("url ==> h_QnA");
		service.QnAList(req, model);
		
		return "/host/h_QnA";
	}
	
	@RequestMapping("h_QnAwrite")
	public String h_QnAwrite(HttpServletRequest req, Model model) {
		logger.info("url ==> h_QnAwrite");
		service.writeForm(req, model);
		
		return "/host/h_QnAinputForm";
	}
	
	@RequestMapping(value = "h_QnAPro", method = RequestMethod.POST)
	public String h_QnAPro(MultipartHttpServletRequest req, Model model) {
		logger.info("url ==> h_QnAPro");
		service.QnAPro(req, model);
		
		return "/host/h_QnAPro";
	}
	
	@RequestMapping("h_QnAupdate")
	public String h_QnAupdate(HttpServletRequest req, Model model) {
		logger.info("url ==> h_QnAupdate");
		service.QnAreplyupdateView(req, model);
		
		return "/host/h_QnAupdate";
	}
	
	@RequestMapping("h_QnAupdatePro")
	public String h_QnAupdatePro(MultipartHttpServletRequest req, Model model) {
		logger.info("url ==> h_QnAupdatePro");
		service.QnAupdatePro(req, model);
		
		return "/host/h_QnAupdatePro";
	}
	
	@RequestMapping("h_review")
	public String h_review(HttpServletRequest req, Model model) {
		logger.info("url ==> h_review");
		service.reviewList(req, model);
		
		return "/host/h_review";
	}
	
	@RequestMapping("h_notwritechar")
	public String h_notwritechar(HttpServletRequest req, Model model) {
		logger.info("url ==> h_notwritechar");
		
		return "/host/h_notwritechar";
	}
	
	@RequestMapping("h_product")
	public String h_product(HttpServletRequest req, Model model) {
		logger.info("url ==> h_product");
		service.productList(req, model);
		
		return "/host/h_product";
	}

	// 중간파트 분류명 가져오기
	@RequestMapping("h_submedium")
	public String h_submedium(HttpServletRequest req, Model model) {
		logger.info("url ==> h_submedium");
		service.submedium(req, model);

		return "/host/h_submedium";
	}
	
	@RequestMapping("h_productinput")
	public String h_productinput(HttpServletRequest req, Model model) {
		logger.info("url ==> h_productinput");
		System.out.println("url => h_productinput");
		service.productwriteForm(req, model);
		
		return "/host/h_productinput";
	}
	
	@RequestMapping("h_subcategory")
	public String subcategory(HttpServletRequest req, Model model) {
		logger.info("url ==> subcategory");
		service.subcategory(req, model);
		
		return "/host/h_subcategory";
	}
	
	@RequestMapping("h_csinput")
	public String h_csinput(HttpServletRequest req, Model model) {
		logger.info("url ==> h_csinput");
		service.cswriteForm(req, model);
		
		return "/host/h_csinput";
	}
	
	@RequestMapping("h_productPro")
	public String h_productPro(MultipartHttpServletRequest req, Model model) {
		logger.info("url ==> h_productPro");
		service.productPro(req, model);
		
		return "/host/h_productPro";
	}
	
	@RequestMapping("h_csPro")
	public String h_csPro(HttpServletRequest req, Model model) {
		logger.info("url ==> h_csPro");
		service.csPro(req, model);
		
		return "/host/h_csPro";
	}
	
	@RequestMapping("h_productForm")
	public String h_productForm(HttpServletRequest req, Model model) {
		logger.info("url ==> h_productForm");
		service.h_productupdateView(req, model);
		
		return "/host/h_productupdateView";
	}
	
	@RequestMapping("h_csupdate")
	public String h_csupdate(HttpServletRequest req, Model model) {
		logger.info("url ==> h_csupdate");
		service.h_csupdateView(req, model);
		
		return "/host/h_csupdate";
	}

	@RequestMapping("subsize")
	public String subsize(HttpServletRequest req, Model model) {
		logger.info("url ==> subsize");
		service.subsize(req, model);

		return "/suncloth/subsize";
	}
	
	@RequestMapping("h_subsize")
	public String h_subsize(HttpServletRequest req, Model model) {
		logger.info("url ==> h_subsize");
		service.subsize(req, model);
		
		return "/host/h_subsize";
	}
	
	@RequestMapping("h_subcslist")
	public String h_subcslist(HttpServletRequest req, Model model) {
		logger.info("url ==> h_subcslist");
		service.h_subcslist(req, model);
		
		return "/host/h_subcslist";
	}
	
	@RequestMapping("h_productform2")
	public String h_productform2(HttpServletRequest req, Model model) {
		logger.info("url ==> h_productform2");
		service.h_productupdateView2(req, model);
		
		return "/host/h_productupdateView2";
	}
	
	@RequestMapping("h_productupdatePro1")
	public String h_productupdatePro1(HttpServletRequest req, Model model) {
		logger.info("url ==> h_productForm");
		service.h_productupdatePro(req, model);
		
		return "/host/h_productupdatePro";
	}
	
	@RequestMapping("h_csupdatePro")
	public String h_csupdatePro(HttpServletRequest req, Model model) {
		logger.info("url ==> h_csupdatePro");
		service.h_csupdatePro(req, model);
		
		return "/host/h_csupdatePro";
	}
	
	// 상품 메인파일 수정
	@RequestMapping("h_productmainfileupdatePro")
	public String h_productmainfileupdatePro(MultipartHttpServletRequest req, Model model) {
		logger.info("url ==> h_productmainfileupdatePro");
		service.h_productmainfileupdatePro(req, model);
		
		return "/host/h_productmainfileupdatePro";
	}
	
	// 상품 파일 수정
	@RequestMapping("h_productfilesupdatePro")
	public String h_productfilesupdatePro(MultipartHttpServletRequest req, Model model) {
		logger.info("url ==> h_productfilesupdatePro");
		service.h_productfilesupdatePro(req, model);
		
		return "/host/h_productfilesupdatePro";
	}
	
	// 상품 withitems 수정
	@RequestMapping("h_productwithitemsupdatePro")
	public String h_productwithitemsupdatePro(HttpServletRequest req, Model model) {
		logger.info("url ==> h_productwithitemsupdatePro");
		service.h_productwithitemsupdatePro(req, model);
		
		return "/host/h_productwithitemsupdatePro";
	}
	
	// 상품 삭제
	@RequestMapping("h_productdeletePro")
	public String h_productdeletePro(HttpServletRequest req, Model model) {
		logger.info("url ==> h_productdeletePro");
		service.h_productdeletePro(req, model);
		
		return "/host/h_productdeletePro";
	}
	
	// withitems
	@RequestMapping("withproductitems")
	public String withproductitems(HttpServletRequest req, Model model) {
		logger.info("url ==> withproductitems");
		service.withproductList(req, model);
		
		return "/host/withproductitems";
	}
	
	// 대분류 추가 처리
	@RequestMapping("h_bigpartPro")
	public String h_bigpartPro(HttpServletRequest req, Model model) {
		logger.info("url ==> h_bigpartPro");
		service.bigpartPro(req, model);
		
		return "/host/h_bigpartPro";
	}
	
	// 중분류 추가 처리
	@RequestMapping("h_mediumpartPro")
	public String h_mediumpartPro(HttpServletRequest req, Model model) {
		logger.info("url ==> h_mediumpartPro");
		service.mediumPro(req, model);
		
		return "/host/h_mediumpartPro";
	}
	
	// 컬러 추가 처리
	@RequestMapping("h_colorPro")
	public String h_colorPro(HttpServletRequest req, Model model) {
		logger.info("url ==> h_colorPro");
		service.colorPro(req, model);
		
		return "/host/h_colorPro";
	}
	
	@RequestMapping("h_sizePro")
	public String h_sizePro(HttpServletRequest req, Model model) {
		logger.info("url ==> h_sizePro");
		service.sizePro(req, model);
		
		return "/host/h_sizePro";
	}
	
	// 대분류 삭제 처리
	@RequestMapping("h_bigpartdelPro")
	public String h_bigpartdelPro(HttpServletRequest req, Model model) {
		logger.info("url ==> h_bigpartdelPro");
		service.bigpartdelPro(req, model);
		
		return "/host/h_bigpartdelPro";
	}
	
	// 중분류 삭제 처리
	@RequestMapping("h_mediumpartdelPro")
	public String h_mediumpartdelPro(HttpServletRequest req, Model model) {
		logger.info("url ==> h_mediumpartdelPro");
		service.mediumpartdelPro(req, model);
		
		return "/host/h_mediumpartdelPro";
	}
	
	// 컬러 삭제 처리
	@RequestMapping("h_colordelPro")
	public String h_colordelPro(HttpServletRequest req, Model model) {
		logger.info("url ==> h_colordelPro");
		service.colordelPro(req, model);
		
		return "/host/h_colordelPro";
	}
	
	// 사이즈 삭제 처리
	@RequestMapping("h_sizedelPro")
	public String h_sizedelPro(HttpServletRequest req, Model model) {
		logger.info("url ==> h_productForm");
		service.sizedelPro(req, model);
		
		return "/host/h_sizedelPro";
	}
	
	// 브랜드
	@RequestMapping("h_brand")
	public String h_brand(HttpServletRequest req, Model model) {
		logger.info("url ==> h_brand");
		service.brandList(req, model);
		
		return "/host/h_brand";
	}
	
	// 브랜드 등록
	@RequestMapping("h_brandinput")
	public String h_brandinput(HttpServletRequest req, Model model) {
		logger.info("url ==> h_brandinput");
		service.getMaxNum(req, model);
		
		return "/host/h_brandinput";
	}
	
	// 브랜드 등록 처리
	@RequestMapping("h_brandPro")
	public String h_brandPro(HttpServletRequest req, Model model) {
		logger.info("url ==> h_brandPro");
		service.brandPro(req, model);
		
		return "/host/h_brandPro";
	}
	
	// 브랜드 삭제
	@RequestMapping("h_branddeletePro")
	public String h_branddeletePro(HttpServletRequest req, Model model) {
		logger.info("url ==> h_branddeletePro");
		service.h_branddeletePro(req, model);
		
		return "/host/h_branddeletePro";
	}
	
	// 브랜드 수정 폼
	@RequestMapping("h_brandForm")
	public String h_brandForm(HttpServletRequest req, Model model) {
		logger.info("url ==> h_brandForm");
		service.h_brandupdateView(req, model);
		
		return "/host/h_brandupdate";
	}
	
	// 브랜드 수정 처리
	@RequestMapping("h_brandUpdatePro")
	public String h_brandUpdatePro(HttpServletRequest req, Model model) {
		logger.info("url ==> h_brandUpdatePro");
		service.h_brandupdatePro(req, model);
		
		return "/host/h_brandUpdatePro";
	}
	
	// 브랜드 검색 처리
	@RequestMapping("h_brandselect")
	public String h_brandselect(HttpServletRequest req, Model model) {
		logger.info("url ==> h_brandselect");
		service.brandList(req, model);
		
		return "/host/h_brandselect";
	}
	
	// 주문
	@RequestMapping("h_order")
	public String h_order(HttpServletRequest req, Model model) {
		logger.info("url ==> h_order");
		service.h_orderlist(req, model);
		
		return "/host/h_order";
	}
	
	// 회원
	@RequestMapping("h_member")
	public String h_member(HttpServletRequest req, Model model) {
		logger.info("url ==> h_member");
		service.memberlist(req, model);
		
		return "/host/h_member";
	}
	
	// 회원 수정 폼
	@RequestMapping("h_memberForm")
	public String h_memberForm(HttpServletRequest req, Model model) {
		logger.info("url ==> h_memberForm");
		service.memberForm(req, model);
		
		return "/host/h_memberForm";
	}
	
	// 회원 수정 처리
	@RequestMapping("h_memberPro")
	public String h_memberPro(HttpServletRequest req, Model model) {
		logger.info("url ==> h_memberPro");
		service.h_memberPro(req, model);
		
		return "/host/h_memberPro";
	}
	
	// 회원탈퇴 처리
	@RequestMapping("h_deletePro")
	public String h_deletePro(HttpServletRequest req, Model model) {
		logger.info("url ==> h_deletePro");
		service.h_deletePro(req, model);
		
		return "/host/h_deletePro";
	}
	
	// 통계
	@RequestMapping("h_clicktotal")
	public String h_clicktotal(HttpServletRequest req, Model model) {
		logger.info("url ==> h_clicktotal");
		service.clicktotal(req, model);
		
		return "/host/h_clicktotal";
	}
	
	// 새 멤버 목록
	@RequestMapping("h_newmembertotal")
	public String h_newmembertotal(HttpServletRequest req, Model model) {
		logger.info("url ==> h_newmembertotal");
		service.newmembertotal(req, model);
		
		return "/host/h_newmembertotal";
	}
	
	// 적립금 목록
	@RequestMapping("h_memberpluspay")
	public String h_memberpluspay(HttpServletRequest req, Model model) {
		logger.info("url ==> h_memberpluspay");
		service.pluspay(req, model);
		
		return "/host/h_memberpluspay";
	}
	
	// 분야 목록
	@RequestMapping("h_category")
	public String h_category(HttpServletRequest req, Model model) {
		logger.info("url ==> h_category");
		service.category(req, model);
		
		return "/host/h_category";
	}
	
	// 순위 목록
	@RequestMapping("h_salerank")
	public String h_salerank(HttpServletRequest req, Model model) {
		logger.info("url ==> h_salerank");
		service.salerank(req, model);
		
		return "/host/h_salerank";
	}
	
	// 주문통합 목록
	@RequestMapping("h_ordertotal")
	public String h_ordertotal(HttpServletRequest req, Model model) {
		logger.info("url ==> h_ordertotal");
		service.ordertotal(req, model);
		
		return "/host/h_ordertotal";
	}
	
	// 판매통합 목록
	@RequestMapping("h_saletotal")
	public String h_saletotal(HttpServletRequest req, Model model) {
		logger.info("url ==> h_saletotal");
		service.saletotal(req, model);
		
		return "/host/h_saletotal";
	}
	
	// only_asclo
	@RequestMapping("menulist")
	public String menulist(HttpServletRequest req, Model model) {
		logger.info("url ==> menulist");
		service.menuList(req, model);
		
		return "/suncloth/menulist";
	}
	
	// product_click
	@RequestMapping("productclick")
	public String productclick(HttpServletRequest req, Model model) {
		logger.info("url ==> productclick");
		service.productclick(req, model);
		
		return "/suncloth/product_click";
	}
	
	// order 폼
	@RequestMapping("orderform")
	public String orderform(HttpServletRequest req, Model model) {
		logger.info("url ==> orderform");
		service.orderform(req, model);
		
		return "/suncloth/order_form";
	}
	
	// 주문 처리
	@RequestMapping("orderPro")
	public String orderPro(HttpServletRequest req, Model model) {
		logger.info("url ==> orderPro");
		service.orderPro(req, model);
		
		return "/suncloth/orderPro";
	}
	
	// 주문 리스트 목록
	@RequestMapping("order")
	public String order(HttpServletRequest req, Model model) {
		logger.info("url ==> order");
		service.orderlist(req, model);
		
		return "/suncloth/order";
	}
	
	// find 지도
	@RequestMapping("findroad")
	public String findroad(HttpServletRequest req, Model model) {
		logger.info("url ==> findroad");
		
		return "/suncloth/findroad";
	}
	
	// 장바구니 추가
	@RequestMapping("cartAdd")
	public String cartAdd(HttpServletRequest req, Model model) {
		logger.info("url ==> cartAdd");
		service.cartPro(req, model);
		
		return "/suncloth/cartPro";
	}
	
	// 장바구니
	@RequestMapping("cart")
	public String cart(HttpServletRequest req, Model model) {
		logger.info("url ==> cart");
		service.cartlist(req, model);
		
		return "/suncloth/cart";
	}
	
	// 장바구니 삭제
	@RequestMapping("cartdel")
	public String cartdel(HttpServletRequest req, Model model) {
		logger.info("url ==> cartdel");
		service.cartdeletePro(req, model);
		
		return "/suncloth/cartdelPro";
	}
	
	// 장바구니 삭제
	@RequestMapping("cartalldel")
	public String cartalldel(HttpServletRequest req, Model model) {
		logger.info("url ==> cartalldel");
		service.cartalldeletePro(req, model);
		
		return "/suncloth/cartdelPro";
	}
	
	// 찜하기 추가
	@RequestMapping("wishlistAdd")
	public String wishlistAdd(HttpServletRequest req, Model model) {
		logger.info("url ==> wishlistAdd");
		service.wishlistPro(req, model);
		
		return "/suncloth/wishlistPro";
	}
	
	// 찜하기 리스트
	@RequestMapping("wishlist")
	public String wishlist(HttpServletRequest req, Model model) {
		logger.info("url ==> wishlist");
		service.wishlist(req, model);
		
		return "/suncloth/wishlist";
	}
	
	// 찜하기 삭제
	@RequestMapping("wishlistdel")
	public String wishlistdel(HttpServletRequest req, Model model) {
		logger.info("url ==> wishlistdel");
		service.wishlistdeletePro(req, model);
		
		return "/suncloth/wishlistdelPro";
	}
	
	// 찜하기 전체 삭제
	@RequestMapping("wishlistalldel")
	public String wishlistalldel(HttpServletRequest req, Model model) {
		logger.info("url ==> wishlistalldel");
		service.wishlistalldeletePro(req, model);
		
		return "/suncloth/wishlistdelPro";
	}
	
	// 마이페이지
	@RequestMapping("mypage")
	public String mypage(HttpServletRequest req, Model model) {
		logger.info("url ==> mypage");
		service.mypagelist(req, model);
		
		return "/suncloth/mypage";
	}
	
	// 마일리지 페이지
	@RequestMapping("mileage")
	public String mileage(HttpServletRequest req, Model model) {
		logger.info("url ==> mileage");
		service.mileagelist(req, model);
		
		return "/suncloth/mileage";
	}
	
	// 내 게시물 페이지
	@RequestMapping("my_board")
	public String my_board(HttpServletRequest req, Model model) {
		logger.info("url ==> my_board");
		service.myboard(req, model);
		
		return "/suncloth/myboard";
	}
	
	// 상품
	@RequestMapping("searchlist")
	public String searchlist(HttpServletRequest req, Model model) {
		logger.info("url ==> searchlist");
		service.searchList(req, model);
		
		return "/suncloth/searchlist";
	}
	
	// 권한이 없는 사용자에게 안내 페이지 출력 - 403 에러
	@RequestMapping("/suncloth/denied")
	public String denied(HttpServletRequest req, Model model, Authentication auth) {
		logger.info("경로 : denied");
		AccessDeniedException ade = (AccessDeniedException) req.getAttribute(WebAttributes.ACCESS_DENIED_403);
		
		model.addAttribute("errMsg", ade);
		return "suncloth/denied";
	}
}
