package com.spring.project.service;

import com.spring.project.dto.*;
import com.spring.project.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService{

	private final MemberRepository memberRepository;
	
	private final BCryptPasswordEncoder passwordEncoder; // 비밀번호 암호화 객체
	
	@Override
	public void confirmId(HttpServletRequest req, Model model) {
		// 3단계. 화면으로 입력받은 값을 받아온다.
		String strId = req.getParameter("id");
		int member = Integer.parseInt(req.getParameter("member"));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("strId", strId);
		map.put("member", member);
		
		// 5단계. 중복된 아이디가 있는지 확인
		int cnt = memberRepository.idCheck(map);
		
		// jsp에 값을 넘길때에는 set Attribute
		// 6단계. requset나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		model.addAttribute("selectCnt", cnt);
		model.addAttribute("id", strId);
		model.addAttribute("member", member);
	}
	
	// email 메세지 보내기
	public void emailsend(HttpServletRequest req, Model model) throws Exception {
		
		
		StringBuffer temp = new StringBuffer();
		Random rnd = new Random();
		for(int i = 0; i < 6; i++) {
			int rIndex = rnd.nextInt(2);
			switch (rIndex) {
			case 0:
				// A-Z
				temp.append((char) ((int) (rnd.nextInt(26)) + 65));
				break;
			case 1:
				// 0~9
				temp.append((rnd.nextInt(10)));
			}
		}
		String key = temp.toString();
		
		String email = req.getParameter("idname") + "@" +
				req.getParameter("urlcode");
		System.out.println(email);
		memberRepository.sendmail(email, key);
		
		req.setAttribute("key", key);
	}
	
	// 회원가입 처리
	@Override
	public void inputPro(HttpServletRequest req, Model model) {
		// 3단계. 입력받은 값을 받아오기
		int member = Integer.parseInt(req.getParameter("memberNum"));
		
		// vo 바구니를 생성한다.
		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setId(req.getParameter("id"));
		memberDTO.setPwd(req.getParameter("pwd"));
		memberDTO.setName(req.getParameter("name"));
		memberDTO.setHp(req.getParameter("telphone1") + "-" +
				req.getParameter("telphone2") + "-" +
				req.getParameter("telphone3"));
		memberDTO.setEmail(req.getParameter("idName") + "@" +
				req.getParameter("urlcode"));
		if(member == 0) {
			memberDTO.setAddress(req.getParameter("address"));
			memberDTO.setAddress1(req.getParameter("address1"));
			memberDTO.setAddress2(req.getParameter("address2"));
			
			
			if(!req.getParameter("tel1").equals("") &&
					!req.getParameter("tel2").equals("") &&
					!req.getParameter("tel3").equals("")) {
				memberDTO.setHomephone(req.getParameter("tel1") + "-" +
					req.getParameter("tel2") + "-" +
					req.getParameter("tel3"));
			}
			
			
			String birth = req.getParameter("birth");
			memberDTO.setBirth(Date.valueOf(birth));
			System.out.println(memberDTO.getBirth());
			
			memberDTO.setBirthtype(req.getParameter("birthtype"));
			
			memberDTO.setAcchost(req.getParameter("acchost"));
			
			memberDTO.setBank(req.getParameter("bank"));
			
			memberDTO.setAcc(req.getParameter("acc"));
			
			// reg_date
			memberDTO.setReg_date(new Timestamp(System.currentTimeMillis()));
		}
		if(member == 1) {
			Map<String, Object> map = new HashMap<String, Object>();
			System.out.println("암호화 전의 비밀번호: " + memberDTO.getPwd());
			
			// 비밀번호 암호화
			memberDTO.setPwd(passwordEncoder.encode(memberDTO.getPwd()));
			System.out.println("암호화 후의 비밀번호: " + memberDTO.getPwd());
			memberDTO.setAuthority("USER_MANAGER");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("member", member);
		map.put("vo", memberDTO);
		
		int cnt = memberRepository.insertMember(map);
		
		// 5단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		model.addAttribute("insertCnt", cnt);
		model.addAttribute("id", memberDTO.getId());
		model.addAttribute("name", memberDTO.getName());
		model.addAttribute("email", memberDTO.getEmail());
		model.addAttribute("member", member);
	}
	
	// 로그인 처리
	@Override
	public void loginPro(HttpServletRequest req, Model model) {
		// 3단계. 입력받은 값을 받아오기
		String strid = req.getParameter("id");
		String strpwd = req.getParameter("pwd");
		int member = Integer.parseInt(req.getParameter("member"));
		System.out.println("member : " + member);
		System.out.println("strid : " + strid);
		System.out.println("strpwd : " + strpwd);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", strid);
		map.put("pwd", strpwd);
		map.put("member", member);
		
		// 5단계. 로그인 정보가 있는지 확인
		int selectCnt = memberRepository.idPwdCheck(map);
		if(selectCnt == 1) {
			// memId 대소문자 구분
			// session에 id를 설정
			if(member == 0) {
				memberRepository.visit(strid);
				memberRepository.visitplus(strid);
			}
			req.getSession().setAttribute("memId", strid);
			req.getSession().setAttribute("memCnt", member);
		}
		// 5단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		model.addAttribute("cnt", selectCnt);
		model.addAttribute("member", member);
		
	}
	
	// 회원탈퇴
	@Override
	public void deletePro(HttpServletRequest req, Model model) {
		// 3단계. 입력받은 값을 받아오기
		String strid = (String) req.getSession().getAttribute("memId");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("strid", strid);
		map.put("member", 0);
		
		// 5-1단계. 로그인 정보가 있는지 확인
		int selectCnt = memberRepository.idCheck(map);
		int deleteCnt = 0;
		
		// 5-2단계. 있으면 로그인한 id로 삭제
		if(selectCnt == 1) {
			deleteCnt = memberRepository.deleteMember(strid);
			req.getSession().removeAttribute("memId");
			req.getSession().removeAttribute("memCnt");
		}
		// 5단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		model.addAttribute("scnt", selectCnt);
		model.addAttribute("dcnt", deleteCnt);
	}
	
	// 회원정보 수정 상세 페이지
	@Override
	public void modifyView(HttpServletRequest req, Model model) {
		// 3단계. 입력받은 값을 받아오기
		String strid = (String)req.getSession().getAttribute("memId");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("strId", strid);
		map.put("member", 0);
		
		// 5-1단계. 로그인 정보가 있는지 확인
		int selectCnt = memberRepository.idCheck(map);
		
		// 5-2단계. 있으면 로그인한 id로 정보 조회
		if(selectCnt == 1) {
			MemberDTO memberDTO = memberRepository.getMemberInfo(strid);
			model.addAttribute("vo", memberDTO);
		}
		
		// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		model.addAttribute("scnt", selectCnt);
		
	}
	
	@Override
	public void modifyPro(HttpServletRequest req, Model model) {
		// 3단계. 화면으로부터 입력받은 값을 받아오기
		// vo 바구니를 생성한다.
		MemberDTO dto = new MemberDTO();
		dto.setId((String) req.getSession().getAttribute("memId"));
		dto.setPwd(req.getParameter("pwd"));
		dto.setName(req.getParameter("name"));
		dto.setAddress(req.getParameter("address"));
		dto.setAddress1(req.getParameter("address1"));
		dto.setAddress2(req.getParameter("address2"));
		
		
		if(!req.getParameter("tel1").equals("") &&
				!req.getParameter("tel2").equals("") &&
				!req.getParameter("tel3").equals("")) {
		dto.setHomephone(req.getParameter("tel1") + "-" +
				req.getParameter("tel2") + "-" +
				req.getParameter("tel3"));
		}
		
		dto.setHp(req.getParameter("telphone1") + "-" +
				req.getParameter("telphone2") + "-" +
				req.getParameter("telphone3"));
		
		dto.setEmail(req.getParameter("idName") + "@" +
				req.getParameter("urlcode"));
		
		dto.setBirth(Date.valueOf(req.getParameter("birth")));
		System.out.println(dto.getBirth());
		
		dto.setBirthtype(req.getParameter("birthtype"));
		
		dto.setAcchost(req.getParameter("acchost"));
		
		dto.setBank(req.getParameter("bank"));
		
		dto.setAcc(req.getParameter("acc"));
		
		int cnt = memberRepository.updateMember(dto);
		// 5단계. 회원정보 수정
		
		// 5단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		model.addAttribute("updateCnt", cnt);
	}

	@Override
	public void refundPro(HttpServletRequest req, Model model) {
		// 3단계. 입력받은 값을 받아오기
		String strid = (String)req.getSession().getAttribute("memId");
		String strpwd = req.getParameter("pwd");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", strid);
		map.put("pwd", strpwd);
		map.put("member", 0);
		
		// 5-1단계. 로그인 정보가 있는지 확인
		int selectCnt = memberRepository.idPwdCheck(map);
		
		// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		model.addAttribute("scnt", selectCnt);
		model.addAttribute("bank", req.getParameter("bank"));
		model.addAttribute("acc", req.getParameter("acc"));
		model.addAttribute("acchost", req.getParameter("acchost"));
	}

	// 글쓰기 페이지
	@Override
	public void writeForm(HttpServletRequest req, Model model) {
		// 3단계. 입력받은 값을 받아오기
		// 제목글(답변글이 아닌 경우)
		int num = 0;
		int ref = 0;
		int ref_step = 0; // 글의 순서
		int ref_level = 0; // 글의 들여쓰기
		int choose = Integer.parseInt(req.getParameter("choose"));
		int pageNum = 0;
		
		// 답변글에 대한 글작성시
		if(req.getParameter("num") != null) {
			if(choose == 3) {
				List<QnADTO> dto = memberRepository.getQnAArticle(Integer.parseInt(req.getParameter("num")));
				model.addAttribute("vo", dto.get(1));
			}
		}
		if(choose == 3) {
			pageNum = Integer.parseInt(req.getParameter("pageNum"));
			model.addAttribute("pageNum", pageNum);
		}
		
		// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		model.addAttribute("num", num);
		model.addAttribute("ref", ref);
		model.addAttribute("ref_step", ref_step);
		model.addAttribute("ref_level", ref_level);
		model.addAttribute("choose", choose);
	}

	// 공지 글쓰기
	@Override
	public void h_noticePro(MultipartHttpServletRequest req, Model model) {
		// 3단계. 입력받은 값을 받아와 바구니 담음
		noticeDTO dto = new noticeDTO();
		
		// db에서 reg_date가 default로 sysdate로 작성해놓았으므로
		// 별도로 지정안할시 sysdate로 적용되고, 지정할 경우 로컬이 우선순위
		dto.setReg_date(new Timestamp(System.currentTimeMillis()));
		
		
		
		
		MultipartFile file = req.getFile("file1");
		String saveDir = req.getSession().getServletContext().getRealPath("/resources/fileready/");
		// 업로드할 파일이 위치하게될 물리적인 경로
		String realDir = "C:\\Dev50\\workspace\\JSP_PJ\\WebContent\\fileready\\";
		// 인코딩 타입 : 한글 파일명이 열화되는 것을 방지함
		String encType = "UTF-8";
		try {
			file.transferTo(new File(saveDir+file.getOriginalFilename()));

			FileInputStream fis = new FileInputStream(saveDir + file.getOriginalFilename());
			FileOutputStream fos = new FileOutputStream(realDir + file.getOriginalFilename());
			
			int data = 0;
			
			// 논리적인 경로에 저장된 임시 파일을 물리적인 경로로 복사함
			while((data = fis.read()) != -1) {
			fos.write(data);
			}
			fis.close();
			fos.close();
			
			dto.setNum(Integer.parseInt(req.getParameter("num")));
			dto.setId((String)req.getSession().getAttribute("memId"));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			dto.setFile1(file.getOriginalFilename());
			int choose = Integer.parseInt(req.getParameter("choose"));
			System.out.println("choose   " + req.getParameter("choose"));
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("vo", dto);
			map.put("choose", choose);
			// 5단계. 글쓰기 처리
			int insertCnt = memberRepository.insertBoard(map);
			
			// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
			model.addAttribute("icnt", insertCnt);
			model.addAttribute("choose", choose);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}

	public void noticeList(HttpServletRequest req, Model model) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		// 페이징 처리 계산 처리
		int pageSize = 0;  // 한페이지당 출력할 글 갯수
		int pageBlock = 5; // 한 블럭당 페이지 갯수
		
		int cnt = 0; 	   // 글 갯수
		int srhCnt = 0;	   // 검색한 글 갯수
		int start = 0;	   // 현재페이지 시작 글번호
		int end = 0; 	   // 현재페이지 마지막 글번호
		int number = 0;	   // 출력용 글번호
		String pageNum = ""; // 페이지 번호
		int currentPage = 0; // 현재 페이지
		
		int pageCount = 0; // 페이지 갯수
		int startPage = 0; // 시작 페이지
		int endPage = 0;   // 마지막 페이지
		int choose = Integer.parseInt(req.getParameter("choose"));
		int searchType = 0;
		String searchText = "";
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 검색하기 위한 조건들
		if(req.getParameter("firstday") != null && req.getParameter("lastday") != null) {
			map.put("firstday", Date.valueOf(req.getParameter("firstday")));
			map.put("lastday", Date.valueOf(req.getParameter("lastday")));
		}
		System.out.println("srchTdae " + req.getParameter("firstday"));
		System.out.println("srchdaye " + req.getParameter("lastday"));
		if(req.getParameter("searchType") != null) {
			searchType = Integer.parseInt(req.getParameter("searchType"));
			System.out.println("srchType" + req.getParameter("searchType"));
		}
		map.put("searchType", searchType);
		if(req.getParameter("srch") != null) {
			searchText = req.getParameter("srch");
			System.out.println("srchtext" + searchText);
		}
		map.put("searchText", searchText);
		map.put("choose", choose);
		
		// 5-1단계. 글 갯수 구하기
		srhCnt = memberRepository.getSelectNoticeCnt(map);
		cnt = memberRepository.getArticleCnt(map);
		System.out.println("srh :" + srhCnt);
		System.out.println("cnt :" + cnt);
		
		// 5-2단계. 페이지 갯수 구하기
		pageNum = req.getParameter("pageNum");
		
		// 페이지 사이즈 구하기
		if(req.getParameter("pageSize") == null) {
			pageSize = 10;
		} else {
			pageSize = Integer.parseInt(req.getParameter("pageSize"));
		}
		
		if(pageNum == null) {
			pageNum = "1"; // 첫페이지를 1페이지로 지정
		}
		
		// 글 30건 기준
		
		// 현재 페이지 출력
		currentPage = Integer.parseInt(pageNum); // 현재페이지 : 1
		System.out.println(currentPage);
		
		// 페이지 갯수 6 = 30/5 + 0;
		pageCount = (srhCnt / pageSize) + (srhCnt % pageSize == 0 ? 0 : 1); // 페이지 갯수 + 나머지 있으면 1
		
		// 현재페이지 시작 글번호(페이지별)
		start = (currentPage - 1) * pageSize + 1;
		
		// 현재페이지 마지막 글번호
		end = start + pageSize - 1;
		
		System.out.println("start : " + start);
		System.out.println("end : " + end);
		map.put("start", start);
		map.put("end", end);
		
		if(end > srhCnt) end = srhCnt;
		
		// 출력용 글번호
		number = cnt - (currentPage - 1) * pageSize;
		
		System.out.println("number : " + number);
		System.out.println("pageSize : " + pageSize);
		
		if(srhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			List<noticeDTO> list = memberRepository.getNoticeList(map);
			model.addAttribute("list", list); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
			System.out.println("list : " + list);
		}
		
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		// 1 = (1/3)*3+1
		startPage = (currentPage / pageBlock) * pageBlock + 1;
		
		if(currentPage % pageBlock == 0) startPage -= pageBlock;
		System.out.println("startPage : " + startPage);
		
		// 마지막페이지
		// 3 = 1 + 3 - 1
		endPage = startPage + pageBlock - 1;
		if(endPage > pageCount) endPage = pageCount;
		System.out.println("endpage : " + endPage);
		
		System.out.println("========================");
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("cnt", cnt); // 글갯수
		model.addAttribute("srhCnt", srhCnt); // 검색한 글갯수
		model.addAttribute("number", number); // 출력용 글번호
		model.addAttribute("pageNum", pageNum); // 페이지번호
		model.addAttribute("choose", choose); // 종류 번호
		model.addAttribute("dayNum", req.getParameter("dayNum")); // 날짜 선택된 것
		model.addAttribute("schType", searchType); // 타입
		
		if(srhCnt>0) {
			model.addAttribute("startPage", startPage); // 시작페이지
			model.addAttribute("endPage", endPage); // 마지막 페이지
			model.addAttribute("pageBlock", pageBlock); // 출력할 페이지 갯수
			model.addAttribute("pageCount", pageCount); // 페이지 갯수
			model.addAttribute("currentPage", currentPage); // 현재 페이지
		}
		
		
	}

	@Override
	public void h_noticedeletePro(HttpServletRequest req, Model model) {
		// 3단계. 입력받은 값을 받아오기
		String pageNum = req.getParameter("pageNum");
		String[] checked = null;
		if(req.getParameterValues("noticechecks") != null) {
			checked = req.getParameterValues("noticechecks");
		} else {
			checked = new String[]{req.getParameter("onenum")};
		}
		System.out.println("checked : " + checked[0]);
		
		// 5-1단계. 패스워드 인증
		int deleteCnt = 0;
		
		// 5-2단계. 맞으면 게시글 삭제
		deleteCnt = memberRepository.deleteNoticeBoard(checked);
		
		// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		model.addAttribute("dcnt", deleteCnt);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("choose", req.getParameter("choose"));
	}
	
	@Override
	public void h_noticeupdateView(HttpServletRequest req, Model model) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		int number = Integer.parseInt(req.getParameter("number"));  // 출력용 글번호
		String pageNum = req.getParameter("pageNum"); // 페이지 번호
		int num = Integer.parseInt(req.getParameter("num")); // 식별자
		int choose = Integer.parseInt(req.getParameter("choose")); // 공지 = 1
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		map.put("choose", choose);
		
		// 4단계. 다형성 적용, 싱글톤 방식으로 dao 객체 생성
		memberRepository.addReadCnt(map);
		
		// 5-2단계. 상세페이지 조회
		List<noticeDTO> dto = memberRepository.getnoticeArticle(num);
		
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		model.addAttribute("number", number);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("num", num);
		model.addAttribute("vo", dto.get(1));
		model.addAttribute("choose", choose); // 종류 번호
	}

	@Override
	public void h_noticeupdatePro(HttpServletRequest req, Model model) {
		// 3단계. 입력받은 값을 받아오기
		int num = Integer.parseInt(req.getParameter("num"));
		String pageNum = req.getParameter("pageNum");
		int choose = Integer.parseInt(req.getParameter("choose"));
		noticeDTO dto = new noticeDTO();
		dto.setNum(num);
		dto.setContent(req.getParameter("content"));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("vo", dto);
		map.put("choose", choose);
		
		// 5단계. 글 수정 처리
		int updateCnt = memberRepository.updateBoard(map);
		
		// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		model.addAttribute("cnt", updateCnt);
		model.addAttribute("num", num);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("choose", choose); // 종류 번호
	}
	
	// FAQ 리스트
	@Override
	public void FAQList(HttpServletRequest req, Model model) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		// 페이징 처리 계산 처리
		int pageSize = 0;  // 한페이지당 출력할 글 갯수
		int pageBlock = 5; // 한 블럭당 페이지 갯수
		
		int cnt = 0; 	   // 글 갯수
		int srhCnt = 0;	   // 검색한 글 갯수
		int start = 0;	   // 현재페이지 시작 글번호
		int end = 0; 	   // 현재페이지 마지막 글번호
		int number = 0;	   // 출력용 글번호
		String pageNum = ""; // 페이지 번호
		int currentPage = 0; // 현재 페이지
		
		int pageCount = 0; // 페이지 갯수
		int startPage = 0; // 시작 페이지
		int endPage = 0;   // 마지막 페이지
		int choose = Integer.parseInt(req.getParameter("choose"));
		Date firstday = null;
		Date lastday = null;
		int searchType = 0;
		String searchText = "";
		String[] state = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		
		// 검색하기 위한 조건들
		if(req.getParameterValues("state") != null) {
			state = req.getParameterValues("state");
		}
		map.put("state", state);
		if(req.getParameter("firstday") != null && req.getParameter("lastday") != null) {
			map.put("firstday", Date.valueOf(req.getParameter("firstday")));
			map.put("lastday", Date.valueOf(req.getParameter("lastday")));
		}
		System.out.println("srchTdae " + req.getParameter("firstday"));
		System.out.println("srchdaye " + req.getParameter("lastday"));
		if(req.getParameter("searchType") != null) {
			searchType = Integer.parseInt(req.getParameter("searchType"));
			System.out.println("srchType" + req.getParameter("searchType"));
		}
		map.put("searchType", searchType);
		if(req.getParameter("srch") != null) {
			searchText = req.getParameter("srch");
			System.out.println("srchtext" + searchText);
		}
		map.put("searchText", searchText);
		map.put("choose", choose);
		
		// 5-1단계. 글 갯수 구하기
		srhCnt = memberRepository.getSelectFAQCnt(map);
		cnt = memberRepository.getArticleCnt(map);
		
		// 5-2단계. 페이지 갯수 구하기
		pageNum = req.getParameter("pageNum");
		
		// 페이지 사이즈 구하기
		if(req.getParameter("pageSize") == null) {
			pageSize = 10;
		} else {
			pageSize = Integer.parseInt(req.getParameter("pageSize"));
		}
		
		if(pageNum == null) {
			pageNum = "1"; // 첫페이지를 1페이지로 지정
		}
		
		// 글 30건 기준
		
		// 현재 페이지 출력
		currentPage = Integer.parseInt(pageNum); // 현재페이지 : 1
		System.out.println(currentPage);
		
		// 페이지 갯수 6 = 30/5 + 0;
		pageCount = (srhCnt / pageSize) + (srhCnt % pageSize == 0 ? 0 : 1); // 페이지 갯수 + 나머지 있으면 1
		
		// 현재페이지 시작 글번호(페이지별)
		start = (currentPage - 1) * pageSize + 1;
		
		// 현재페이지 마지막 글번호
		end = start + pageSize - 1;
		
		System.out.println("start : " + start);
		System.out.println("end : " + end);
		map.put("start", start);
		map.put("end", end);
		
		if(end > cnt) end = srhCnt;
		
		// 출력용 글번호
		number = cnt - (currentPage - 1) * pageSize;
		
		System.out.println("number : " + number);
		System.out.println("pageSize : " + pageSize);
		
		if(srhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			List<FAQDTO> list = memberRepository.getFAQList(map);
			model.addAttribute("list", list); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		}
		
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		// 1 = (1/3)*3+1
		startPage = (currentPage / pageBlock) * pageBlock + 1;
		
		if(currentPage % pageBlock == 0) startPage -= pageBlock;
		System.out.println("startPage : " + startPage);
		
		// 마지막페이지
		// 3 = 1 + 3 - 1
		endPage = startPage + pageBlock - 1;
		if(endPage > pageCount) endPage = pageCount;
		System.out.println("endpage : " + endPage);
		
		System.out.println("========================");
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("cnt", cnt); // 글갯수
		model.addAttribute("srhCnt", srhCnt); // 검색한 글갯수
		model.addAttribute("number", number); // 출력용 글번호
		model.addAttribute("pageNum", pageNum); // 페이지번호
		model.addAttribute("choose", choose); // 종류 번호
		model.addAttribute("dayNum", req.getParameter("dayNum")); // 날짜 선택된 것
		model.addAttribute("schType", searchType); // 타입
		
		if(cnt>0) {
			model.addAttribute("startPage", startPage); // 시작페이지
			model.addAttribute("endPage", endPage); // 마지막 페이지
			model.addAttribute("pageBlock", pageBlock); // 출력할 페이지 갯수
			model.addAttribute("pageCount", pageCount); // 페이지 갯수
			model.addAttribute("currentPage", currentPage); // 현재 페이지
		}
	}

	@Override
	public void h_FAQPro(HttpServletRequest req, Model model) {
		// 3단계. 입력받은 값을 받아와 바구니 담음
		FAQDTO dto = new FAQDTO();
		
		// db에서 reg_date가 default로 sysdate로 작성해놓았으므로
		// 별도로 지정안할시 sysdate로 적용되고, 지정할 경우 로컬이 우선순위
		dto.setReg_date(new Timestamp(System.currentTimeMillis()));
		dto.setWriter((String)req.getSession().getAttribute("memId"));
		dto.setState(req.getParameter("state"));
		dto.setSubject(req.getParameter("subject"));
		dto.setContent(req.getParameter("content"));
		int choose = Integer.parseInt(req.getParameter("choose"));
		System.out.println("choose   " + req.getParameter("choose"));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("vo", dto);
		map.put("choose", choose);
		
		// 5단계. 글쓰기 처리
		int insertCnt = memberRepository.insertBoard(map);
		
		// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("icnt", insertCnt);
		req.setAttribute("choose", choose);
	}
	
	@Override
	public void h_FAQupdateView(HttpServletRequest req, Model model) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		int number = Integer.parseInt(req.getParameter("number"));  // 출력용 글번호
		String pageNum = req.getParameter("pageNum"); // 페이지 번호
		int num = Integer.parseInt(req.getParameter("num")); // 식별자
		int choose = Integer.parseInt(req.getParameter("choose")); // 공지 = 1
		
		// 5-2단계. 상세페이지 조회
		List<FAQDTO> dto = memberRepository.getFAQArticle(num);
		
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("number", number);
		req.setAttribute("pageNum", pageNum);
		req.setAttribute("num", num);
		req.setAttribute("vo", dto.get(1));
		req.setAttribute("choose", choose); // 종류 번호
	}

	@Override
	public void h_FAQupdatePro(HttpServletRequest req, Model model) {
		// 3단계. 입력받은 값을 받아오기
		int num = Integer.parseInt(req.getParameter("num"));
		String pageNum = req.getParameter("pageNum");
		int choose = Integer.parseInt(req.getParameter("choose"));
		FAQDTO dto = new FAQDTO();
		dto.setNum(num);
		dto.setState(req.getParameter("state"));
		dto.setContent(req.getParameter("content"));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("vo", dto);
		map.put("choose", choose);
		
		// 5단계. 글 수정 처리
		int updateCnt = memberRepository.updateBoard(map);
		
		// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("cnt", updateCnt);
		req.setAttribute("num", num);
		req.setAttribute("pageNum", pageNum);
		req.setAttribute("choose", choose); // 종류 번호
	}

	@Override
	public void h_FAQdeletePro(HttpServletRequest req, Model model) {
		// 3단계. 입력받은 값을 받아오기
		String pageNum = req.getParameter("pageNum");
		String[] checked = null;
		if(req.getParameterValues("FAQchecks") != null) {
			checked = req.getParameterValues("FAQchecks");
		} else {
			checked = new String[]{req.getParameter("onenum")};
		}
		System.out.println("checked : " + checked[0]);
		
		// 5-1단계. 패스워드 인증
		int deleteCnt = 0;
		
		// 5-2단계. 맞으면 게시글 삭제
		deleteCnt = memberRepository.deleteFAQBoard(checked);
		
		// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("dcnt", deleteCnt);
		req.setAttribute("pageNum", pageNum);
		req.setAttribute("choose", req.getParameter("choose"));
	}

	
	// Q&A 리스트
	@Override
	public void QnAList(HttpServletRequest req, Model model) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		// 페이징 처리 계산 처리
		int pageSize = 0;  // 한페이지당 출력할 글 갯수
		int pageBlock = 5; // 한 블럭당 페이지 갯수
		
		int cnt = 0; 	   // 글 갯수
		int srhCnt = 0;	   // 검색한 글 갯수
		int start = 0;	   // 현재페이지 시작 글번호
		int end = 0; 	   // 현재페이지 마지막 글번호
		int number = 0;	   // 출력용 글번호
		String pageNum = ""; // 페이지 번호
		int currentPage = 0; // 현재 페이지
		
		int pageCount = 0; // 페이지 갯수
		int startPage = 0; // 시작 페이지
		int endPage = 0;   // 마지막 페이지
		int choose = Integer.parseInt(req.getParameter("choose"));
		Date firstday = null;
		Date lastday = null;
		int searchType = 0;
		String searchText = "";
		String[] state = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		
		// 검색하기 위한 조건들
		if(req.getParameterValues("Qtype") != null) {
			state = req.getParameterValues("Qtype");
		}
		map.put("state", state);
		if(req.getParameter("firstday") != null && req.getParameter("lastday") != null) {
			map.put("firstday", Date.valueOf(req.getParameter("firstday")));
			map.put("lastday", Date.valueOf(req.getParameter("lastday")));
		}
		System.out.println("srchTdae " + req.getParameter("firstday"));
		System.out.println("srchdaye " + req.getParameter("lastday"));
		if(req.getParameter("searchType") != null) {
			searchType = Integer.parseInt(req.getParameter("searchType"));
			System.out.println("srchType" + req.getParameter("searchType"));
		}
		map.put("searchType", searchType);
		if(req.getParameter("srch") != null) {
			searchText = req.getParameter("srch");
			System.out.println("srchtext" + searchText);
		}
		map.put("searchText", searchText);
		map.put("choose", choose);
		map.put("strid", null);
		
		// 5-1단계. 글 갯수 구하기
		srhCnt = memberRepository.getSelectQnACnt(map);
		cnt = memberRepository.getArticleCnt(map);
		
		// 5-2단계. 페이지 갯수 구하기
		pageNum = req.getParameter("pageNum");
		
		// 페이지 사이즈 구하기
		if(req.getParameter("pageSize") == null) {
			pageSize = 10;
		} else {
			pageSize = Integer.parseInt(req.getParameter("pageSize"));
		}
		
		if(pageNum == null) {
			pageNum = "1"; // 첫페이지를 1페이지로 지정
		}
		
		// 글 30건 기준
		
		// 현재 페이지 출력
		currentPage = Integer.parseInt(pageNum); // 현재페이지 : 1
		System.out.println(currentPage);
		
		// 페이지 갯수 6 = 30/5 + 0;
		pageCount = (srhCnt / pageSize) + (srhCnt % pageSize == 0 ? 0 : 1); // 페이지 갯수 + 나머지 있으면 1
		
		// 현재페이지 시작 글번호(페이지별)
		start = (currentPage - 1) * pageSize + 1;
		
		// 현재페이지 마지막 글번호
		end = start + pageSize - 1;
		
		System.out.println("start : " + start);
		System.out.println("end : " + end);
		map.put("start", start);
		map.put("end", end);
		
		if(end > cnt) end = srhCnt;
		
		// 출력용 글번호
		number = cnt - (currentPage - 1) * pageSize;
		
		System.out.println("number : " + number);
		System.out.println("pageSize : " + pageSize);
		
		if(srhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			List<QnADTO> list = memberRepository.getQnAList(map);
			model.addAttribute("list", list); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		}
		
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		// 1 = (1/3)*3+1
		startPage = (currentPage / pageBlock) * pageBlock + 1;
		
		if(currentPage % pageBlock == 0) startPage -= pageBlock;
		System.out.println("startPage : " + startPage);
		
		// 마지막페이지
		// 3 = 1 + 3 - 1
		endPage = startPage + pageBlock - 1;
		if(endPage > pageCount) endPage = pageCount;
		System.out.println("endpage : " + endPage);
		
		System.out.println("========================");
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("cnt", cnt); // 글갯수
		model.addAttribute("srhCnt", srhCnt); // 검색한 글갯수
		model.addAttribute("number", number); // 출력용 글번호
		model.addAttribute("pageNum", pageNum); // 페이지번호
		model.addAttribute("choose", choose); // 종류 번호
		model.addAttribute("dayNum", req.getParameter("dayNum")); // 날짜 선택된 것
		model.addAttribute("schType", searchType); // 타입
		
		if(cnt>0) {
			model.addAttribute("startPage", startPage); // 시작페이지
			model.addAttribute("endPage", endPage); // 마지막 페이지
			model.addAttribute("pageBlock", pageBlock); // 출력할 페이지 갯수
			model.addAttribute("pageCount", pageCount); // 페이지 갯수
			model.addAttribute("currentPage", currentPage); // 현재 페이지
		}
		
	}

	
	// Q&A 작성 처리
	@Override
	public void QnAPro(MultipartHttpServletRequest req, Model model) {
		// 3단계. 입력받은 값을 받아와 바구니 담음
		QnADTO dto = new QnADTO();
		
		// db에서 reg_date가 default로 sysdate로 작성해놓았으므로
		// 별도로 지정안할시 sysdate로 적용되고, 지정할 경우 로컬이 우선순위
		dto.setReg_date(new Timestamp(System.currentTimeMillis()));
		
		
		MultipartFile file = req.getFile("file1");
		String saveDir = req.getSession().getServletContext().getRealPath("/resources/fileready/");
		// 업로드할 파일이 위치하게될 물리적인 경로
		String realDir = "C:\\Dev50\\workspace\\JSP_PJ\\WebContent\\fileready\\";
		// 인코딩 타입 : 한글 파일명이 열화되는 것을 방지함
		String encType = "UTF-8";
		try {
			if(String.valueOf(file.getOriginalFilename()) != "") {
				file.transferTo(new File(saveDir+file.getOriginalFilename()));

				FileInputStream fis = new FileInputStream(saveDir + file.getOriginalFilename());
				FileOutputStream fos = new FileOutputStream(realDir + file.getOriginalFilename());
				
				int data = 0;
				
				// 논리적인 경로에 저장된 임시 파일을 물리적인 경로로 복사함
				while((data = fis.read()) != -1) {
				fos.write(data);
				}
				fis.close();
				fos.close();
				dto.setFile1(file.getOriginalFilename());
			}
			dto.setNum(Integer.parseInt(req.getParameter("num")));
			dto.setWriter((String)req.getSession().getAttribute("memId"));
			dto.setState(req.getParameter("Qtype"));
			dto.setPwd(req.getParameter("pwd"));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			dto.setTextType(req.getParameter("textType"));
			dto.setRef(Integer.parseInt(req.getParameter("ref")));
			dto.setRef_step(Integer.parseInt(req.getParameter("ref_step"))); // 글의 순서
			dto.setRef_level(Integer.parseInt(req.getParameter("ref_level"))); // 글의 들여쓰기
			// url에 localhost대신 본인 IP를 입력하면 그 ip를 읽어서 바구니에 담는다.
			// http://192.168.219.118:80/JSP_mvcBoard/boardList.bo
			dto.setIp(req.getRemoteAddr());
			int choose = Integer.parseInt(req.getParameter("choose"));

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("vo", dto);
			map.put("choose", choose);
			
			// 5단계. 글쓰기 처리
			int insertCnt = memberRepository.insertBoard(map);
			
			// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
			model.addAttribute("icnt", insertCnt);
			model.addAttribute("choose", choose);
			model.addAttribute("pageNum", req.getParameter("pageNum"));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// QnA 상세 페이지
	@Override
	public void QnAupdateView(HttpServletRequest req, Model model) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		int number = Integer.parseInt(req.getParameter("number"));  // 출력용 글번호
		String pageNum = req.getParameter("pageNum"); // 페이지 번호
		int num = Integer.parseInt(req.getParameter("num")); // 식별자
		int choose = Integer.parseInt(req.getParameter("choose")); // QnA = 3
		int pwdCnt = 1;
		
		if(req.getSession().getAttribute("memCnt") != "1" && 
				req.getParameter("textType") == null && req.getParameter("pwd") != null) {
			pwdCnt = memberRepository.numPwdCheck(num, req.getParameter("pwd"));
		}
		
		
		// 5-2단계. 상세페이지 조회
		List<QnADTO> dto = memberRepository.getQnAArticle(num);
		
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		model.addAttribute("number", number);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("num", num);
		model.addAttribute("vo", dto.get(1));
		model.addAttribute("choose", choose); // 종류 번호
		model.addAttribute("cnt", pwdCnt);
	}

	// QnA 수정 처리
	public void QnAupdatePro(MultipartHttpServletRequest req, Model model) {
		
		MultipartFile file = req.getFile("file1");
		String saveDir = req.getSession().getServletContext().getRealPath("/resources/fileready/");
		// 업로드할 파일이 위치하게될 물리적인 경로
		String realDir = "C:\\Dev50\\workspace\\JSP_PJ\\WebContent\\fileready\\";
		// 인코딩 타입 : 한글 파일명이 열화되는 것을 방지함
		String encType = "UTF-8";
		try {
			QnADTO dto = new QnADTO();
			if(file.getOriginalFilename() != null) {
				file.transferTo(new File(saveDir+file.getOriginalFilename()));

				FileInputStream fis = new FileInputStream(saveDir + file.getOriginalFilename());
				FileOutputStream fos = new FileOutputStream(realDir + file.getOriginalFilename());
				
				int data = 0;
				
				// 논리적인 경로에 저장된 임시 파일을 물리적인 경로로 복사함
				while((data = fis.read()) != -1) {
				fos.write(data);
				}
				fis.close();
				fos.close();
				dto.setFile1(file.getOriginalFilename());
			}
			
			// 3단계. 입력받은 값을 받아오기
			int num = Integer.parseInt(req.getParameter("num"));
			String pageNum = req.getParameter("pageNum");
			int choose = Integer.parseInt(req.getParameter("choose"));
			dto.setNum(num);
			dto.setContent(req.getParameter("content"));
			dto.setTextType(req.getParameter("textType"));
			dto.setPwd(req.getParameter("pwd"));
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("vo", dto);
			map.put("choose", choose);

			// 5단계. 글 수정 처리
			int updateCnt = memberRepository.updateBoard(map);
			
			// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
			model.addAttribute("cnt", updateCnt);
			model.addAttribute("num", num);
			model.addAttribute("pageNum", pageNum);
			model.addAttribute("choose", choose); // 종류 번호
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// QnA 답글 수정 폼
	public void QnAreplyupdateView(HttpServletRequest req, Model model) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		int number = Integer.parseInt(req.getParameter("number"));  // 출력용 글번호
		String pageNum = req.getParameter("pageNum"); // 페이지 번호
		int num = Integer.parseInt(req.getParameter("num")); // 식별자
		int choose = Integer.parseInt(req.getParameter("choose")); // QnA = 3
		int ref = Integer.parseInt(req.getParameter("ref"));
		int pwdCnt = 1;
		
		if((Integer)req.getSession().getAttribute("memCnt") != 1 && 
				req.getParameter("textType") == null) {
			pwdCnt = memberRepository.numPwdCheck(num, req.getParameter("pwd"));
		}
		List<QnADTO> basevo = memberRepository.getQnAArticle(ref);
		
		// 5-2단계. 상세페이지 조회
		List<QnADTO> dto = memberRepository.getQnAArticle(num);
		
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		model.addAttribute("number", number);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("num", num);
		model.addAttribute("basevo", basevo.get(1));
		model.addAttribute("vo", dto.get(1));
		model.addAttribute("choose", choose); // 종류 번호
		model.addAttribute("cnt", pwdCnt);
	}

	// QnA 삭제
	public void QnAdeletePro(HttpServletRequest req, Model model) {
		// 3단계. 입력받은 값을 받아오기
		String pageNum = req.getParameter("pageNum");
		String[] checked = null;
		if(req.getParameterValues("QnAchecks") != null) {
			checked = req.getParameterValues("QnAchecks");
		} else {
			checked = new String[]{req.getParameter("onenum")};
		}
		System.out.println("checked : " + checked[0]);
		
		// 5-1단계. 패스워드 인증
		int deleteCnt = 0;
		
		// 5-2단계. 맞으면 게시글 삭제
		deleteCnt = memberRepository.deleteQnABoard(checked);
		
		// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		model.addAttribute("dcnt", deleteCnt);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("choose", req.getParameter("choose"));
	}
	
	// review 리스트
	public void reviewList(HttpServletRequest req, Model model) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		// 페이징 처리 계산 처리
		int pageSize = 0;  // 한페이지당 출력할 글 갯수
		int pageBlock = 5; // 한 블럭당 페이지 갯수
		
		int cnt = 0; 	   // 글 갯수
		int srhCnt = 0;	   // 검색한 글 갯수
		int start = 0;	   // 현재페이지 시작 글번호
		int end = 0; 	   // 현재페이지 마지막 글번호
		int number = 0;	   // 출력용 글번호
		String pageNum = ""; // 페이지 번호
		int currentPage = 0; // 현재 페이지
		
		int pageCount = 0; // 페이지 갯수
		int startPage = 0; // 시작 페이지
		int endPage = 0;   // 마지막 페이지
		int choose = Integer.parseInt(req.getParameter("choose"));
		Date firstday = null;
		Date lastday = null;
		int searchType = 0;
		String searchText = "";
		Map<String, Object> map = new HashMap<String, Object>();
		
		
		// 검색하기 위한 조건들
		if(req.getParameter("firstday") != null && req.getParameter("lastday") != null) {
			map.put("firstday", Date.valueOf(req.getParameter("firstday")));
			map.put("lastday", Date.valueOf(req.getParameter("lastday")));
		}
		System.out.println("srchTdae " + req.getParameter("firstday"));
		System.out.println("srchdaye " + req.getParameter("lastday"));
		if(req.getParameter("searchType") != null) {
			searchType = Integer.parseInt(req.getParameter("searchType"));
			System.out.println("srchType" + req.getParameter("searchType"));
		}
		map.put("searchType", searchType);
		if(req.getParameter("srch") != null) {
			searchText = req.getParameter("srch");
			System.out.println("srchtext" + searchText);
		}
		map.put("searchText", searchText);
		map.put("choose", choose);
		map.put("strid", null);
		
		// 5-1단계. 글 갯수 구하기
		srhCnt = memberRepository.getSelectreviewCnt(map);
		cnt = memberRepository.getArticleCnt(map);
		
		// 5-2단계. 페이지 갯수 구하기
		pageNum = req.getParameter("pageNum");
		
		// 페이지 사이즈 구하기
		if(req.getParameter("pageSize") == null) {
			pageSize = 10;
		} else {
			pageSize = Integer.parseInt(req.getParameter("pageSize"));
		}
		
		if(pageNum == null) {
			pageNum = "1"; // 첫페이지를 1페이지로 지정
		}
		
		// 글 30건 기준
		
		// 현재 페이지 출력
		currentPage = Integer.parseInt(pageNum); // 현재페이지 : 1
		System.out.println(currentPage);
		
		// 페이지 갯수 6 = 30/5 + 0;
		pageCount = (srhCnt / pageSize) + (srhCnt % pageSize == 0 ? 0 : 1); // 페이지 갯수 + 나머지 있으면 1
		
		// 현재페이지 시작 글번호(페이지별)
		start = (currentPage - 1) * pageSize + 1;
		
		// 현재페이지 마지막 글번호
		end = start + pageSize - 1;
		
		System.out.println("start : " + start);
		System.out.println("end : " + end);
		map.put("start", start);
		map.put("end", end);
		
		if(end > cnt) end = srhCnt;
		
		// 출력용 글번호
		number = cnt - (currentPage - 1) * pageSize;
		
		System.out.println("number : " + number);
		System.out.println("pageSize : " + pageSize);
		
		if(srhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			List<reviewDTO> list = memberRepository.getreviewList(map);
			model.addAttribute("list", list); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		}
		
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		// 1 = (1/3)*3+1
		startPage = (currentPage / pageBlock) * pageBlock + 1;
		
		if(currentPage % pageBlock == 0) startPage -= pageBlock;
		System.out.println("startPage : " + startPage);
		
		// 마지막페이지
		// 3 = 1 + 3 - 1
		endPage = startPage + pageBlock - 1;
		if(endPage > pageCount) endPage = pageCount;
		System.out.println("endpage : " + endPage);
		
		System.out.println("========================");
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("cnt", cnt); // 글갯수
		model.addAttribute("srhCnt", srhCnt); // 검색한 글갯수
		model.addAttribute("number", number); // 출력용 글번호
		model.addAttribute("pageNum", pageNum); // 페이지번호
		model.addAttribute("choose", choose); // 종류 번호
		model.addAttribute("dayNum", req.getParameter("dayNum")); // 날짜 선택된 것
		model.addAttribute("schType", searchType); // 타입
		
		if(cnt>0) {
			model.addAttribute("startPage", startPage); // 시작페이지
			model.addAttribute("endPage", endPage); // 마지막 페이지
			model.addAttribute("pageBlock", pageBlock); // 출력할 페이지 갯수
			model.addAttribute("pageCount", pageCount); // 페이지 갯수
			model.addAttribute("currentPage", currentPage); // 현재 페이지
		}
	}
	
	// review 글쓰기 처리
	public void reviewPro(MultipartHttpServletRequest req, Model model) {
		// 3단계. 입력받은 값을 받아와 바구니 담음
		reviewDTO dto = new reviewDTO();
		
		// db에서 reg_date가 default로 sysdate로 작성해놓았으므로
		// 별도로 지정안할시 sysdate로 적용되고, 지정할 경우 로컬이 우선순위
		dto.setReg_date(new Timestamp(System.currentTimeMillis()));
		
		
		
		
		
		MultipartFile file = req.getFile("file1");
		String saveDir = req.getSession().getServletContext().getRealPath("/resources/fileready/");
		// 업로드할 파일이 위치하게될 물리적인 경로
		String realDir = "C:\\Dev50\\workspace\\JSP_PJ\\WebContent\\fileready\\";
		// 인코딩 타입 : 한글 파일명이 열화되는 것을 방지함
		String encType = "UTF-8";
		try {
			if(file.getOriginalFilename() != null) {
				file.transferTo(new File(saveDir+file.getOriginalFilename()));

				FileInputStream fis = new FileInputStream(saveDir + file.getOriginalFilename());
				FileOutputStream fos = new FileOutputStream(realDir + file.getOriginalFilename());
				
				int data = 0;
				
				// 논리적인 경로에 저장된 임시 파일을 물리적인 경로로 복사함
				while((data = fis.read()) != -1) {
				fos.write(data);
				}
				fis.close();
				fos.close();
				dto.setFile1(file.getOriginalFilename());
			}
			
			dto.setNum(Integer.parseInt(req.getParameter("num")));
			dto.setWriter((String)req.getSession().getAttribute("memId"));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			dto.setIp(req.getRemoteAddr());
			int choose = Integer.parseInt(req.getParameter("choose"));
			System.out.println("choose   " + req.getParameter("choose"));
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("vo", dto);
			map.put("choose", choose);
			
			// 5단계. 글쓰기 처리
			int insertCnt = memberRepository.insertBoard(map);
			
			// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
			model.addAttribute("icnt", insertCnt);
			model.addAttribute("choose", choose);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	// review 상세 페이지
	@Override
	public void reviewupdateView(HttpServletRequest req, Model model) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		int number = Integer.parseInt(req.getParameter("number"));  // 출력용 글번호
		String pageNum = req.getParameter("pageNum"); // 페이지 번호
		int num = Integer.parseInt(req.getParameter("num")); // 식별자
		int choose = Integer.parseInt(req.getParameter("choose")); // review = 4
		int pwdCnt = 1;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		map.put("choose", choose);
		
		// 4단계. 다형성 적용, 싱글톤 방식으로 dao 객체 생성
		memberRepository.addReadCnt(map);
		
		// 5-2단계. 상세페이지 조회
		List<reviewDTO> dto = memberRepository.getreviewArticle(num);
		
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		model.addAttribute("number", number);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("num", num);
		model.addAttribute("vo", dto.get(1));
		model.addAttribute("choose", choose); // 종류 번호
		model.addAttribute("cnt", pwdCnt);
		
		
		
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		// 페이징 처리 계산 처리
		int pageSize = 5;  // 한페이지당 출력할 글 갯수
		int pageBlock = 5; // 한 블럭당 페이지 갯수
		
		int srhCnt = 0;	   // 검색한 글 갯수
		int start = 0;	   // 현재페이지 시작 글번호
		int end = 0; 	   // 현재페이지 마지막 글번호
		int r_number = 0;	   // 출력용 글번호
		String rpageNum = ""; // 페이지 번호
		int currentPage = 0; // 현재 페이지
		
		int pageCount = 0; // 페이지 갯수
		int startPage = 0; // 시작 페이지
		int endPage = 0;   // 마지막 페이지
		
		// 5-1단계. 글 갯수 구하기
		srhCnt = memberRepository.getSelectreplyCnt(num);
		
		// 5-2단계. 페이지 갯수 구하기
		rpageNum = req.getParameter("pageNum");
		
		if(rpageNum == null) {
			rpageNum = "1"; // 첫페이지를 1페이지로 지정
		}
		
		// 글 30건 기준
		
		// 현재 페이지 출력
		currentPage = Integer.parseInt(rpageNum); // 현재페이지 : 1
		System.out.println(currentPage);
		System.out.println("srhcnt : " + srhCnt);
		
		// 페이지 갯수 6 = 30/5 + 0;
		pageCount = (srhCnt / pageSize) + (srhCnt % pageSize == 0 ? 0 : 1); // 페이지 갯수 + 나머지 있으면 1
		
		// 현재페이지 시작 글번호(페이지별)
		start = (currentPage - 1) * pageSize + 1;
		
		// 현재페이지 마지막 글번호
		end = start + pageSize - 1;
		
		System.out.println("start : " + start);
		System.out.println("end : " + end);
		map.put("start", start);
		map.put("end", end);
		
		if(end > srhCnt) end = srhCnt;
		
		// 출력용 글번호
		r_number = srhCnt - (currentPage - 1) * pageSize;
		
		System.out.println("number : " + r_number);
		System.out.println("pageSize : " + pageSize);
		
		if(srhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			List<replyDTO> list = memberRepository.getreplyList(map);
			model.addAttribute("list", list); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		}
		
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		// 1 = (1/3)*3+1
		startPage = (currentPage / pageBlock) * pageBlock + 1;
		
		if(currentPage % pageBlock == 0) startPage -= pageBlock;
		System.out.println("startPage : " + startPage);
		
		// 마지막페이지
		// 3 = 1 + 3 - 1
		endPage = startPage + pageBlock - 1;
		if(endPage > pageCount) endPage = pageCount;
		System.out.println("endpage : " + endPage);
		
		System.out.println("========================");
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("srhCnt", srhCnt); // 검색한 글갯수
		model.addAttribute("r_number", r_number); // 출력용 글번호
		model.addAttribute("rpageNum", rpageNum); // 페이지번호
		
		if(srhCnt>0) {
			model.addAttribute("startPage", startPage); // 시작페이지
			model.addAttribute("endPage", endPage); // 마지막 페이지
			model.addAttribute("pageBlock", pageBlock); // 출력할 페이지 갯수
			model.addAttribute("pageCount", pageCount); // 페이지 갯수
			model.addAttribute("currentPage", currentPage); // 현재 페이지
		}
	}

	// 답글 처리
	public void replyPro(HttpServletRequest req, Model model) {
		int number = Integer.parseInt(req.getParameter("number"));  // 출력용 글번호
		String pageNum = req.getParameter("pageNum"); // 페이지 번호
		int num = Integer.parseInt(req.getParameter("num")); // 식별자
		int choose = Integer.parseInt(req.getParameter("choose")); // review = 4
		String strpwd = req.getParameter("pwd");
		String strid = (String) req.getSession().getAttribute("memId");
		// 3단계. 입력받은 값을 받아와 바구니 담음
		replyDTO dto = new replyDTO();
		
		// db에서 reg_date가 default로 sysdate로 작성해놓았으므로
		// 별도로 지정안할시 sysdate로 적용되고, 지정할 경우 로컬이 우선순위
		dto.setReg_date(new Timestamp(System.currentTimeMillis()));
		dto.setWriter((String)req.getSession().getAttribute("memId"));
		dto.setRef(Integer.parseInt(req.getParameter("num")));
		dto.setIp(req.getRemoteAddr());
		dto.setContent(req.getParameter("content"));
		System.out.println("choose   " + req.getParameter("choose"));
		
		// 4단계. 다형성 적용, 싱글톤 방식으로 dao 객체 생성
		Map<String, Object> membermap = new HashMap<String, Object>();
		membermap.put("id", strid);
		membermap.put("pwd", strpwd);
		membermap.put("member", (Integer)req.getSession().getAttribute("memCnt"));
		int pwdCnt = 0;
		if(req.getSession().getAttribute("memId") != null) {
			pwdCnt = memberRepository.idPwdCheck(membermap);
		}
		int insertCnt = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("vo", dto);
		map.put("choose", 5);
		
		// 5단계. 글쓰기 처리
		if(pwdCnt == 1) {
			insertCnt = memberRepository.insertBoard(map);
		}
		
		// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		model.addAttribute("number", number);
		model.addAttribute("num", num);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("icnt", insertCnt);
		model.addAttribute("pcnt", pwdCnt);
		model.addAttribute("choose", choose);
	}

	// 답글 삭제
	public void replydeletePro(HttpServletRequest req, Model model) {
		int number = Integer.parseInt(req.getParameter("number"));  // 출력용 글번호
		String pageNum = req.getParameter("pageNum"); // 페이지 번호
		int num = Integer.parseInt(req.getParameter("num")); // 식별자
		int choose = Integer.parseInt(req.getParameter("choose")); // review = 4
		String rpageNum = req.getParameter("rpageNum");
		// 3단계. 입력받은 값을 받아오기
		String[] checked = null;
		if(req.getParameterValues("replychecks") != null) {
			checked = req.getParameterValues("replychecks");
		} else {
			checked = new String[]{req.getParameter("onenum")};
		}
		System.out.println("checked : " + checked[0]);
		
		// 5-1단계. 패스워드 인증
		int deleteCnt = 0;
		
		// 5-2단계. 맞으면 게시글 삭제
		deleteCnt = memberRepository.deletereplyBoard(checked);
		
		// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		model.addAttribute("rpageNum", rpageNum);
		model.addAttribute("number", number);
		model.addAttribute("num", num);
		model.addAttribute("dcnt", deleteCnt);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("choose", choose);
	}

	// review 글 삭제
	public void reviewdeletePro(HttpServletRequest req, Model model) {
		// 3단계. 입력받은 값을 받아오기
		String pageNum = req.getParameter("pageNum");
		String[] checked = null;
		if(req.getParameterValues("reviewchecks") != null) {
			checked = req.getParameterValues("reviewchecks");
		} else {
			checked = new String[]{req.getParameter("onenum")};
		}
		System.out.println("checked : " + checked[0]);
		
		// 5-1단계. 패스워드 인증
		int deleteCnt = 0;
		
		// 5-2단계. 맞으면 게시글 삭제
		deleteCnt = memberRepository.deletereviewBoard(checked);
		System.out.println("deleteCnt : " + deleteCnt);
		
		// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		model.addAttribute("dcnt", deleteCnt);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("choose", req.getParameter("choose"));
	}
	
	// brand 목록 조회
	public void brandList(HttpServletRequest req, Model model) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		// 페이징 처리 계산 처리
		int pageSize = 0;  // 한페이지당 출력할 글 갯수
		int pageBlock = 5; // 한 블럭당 페이지 갯수
		
		int cnt = 0; 	   // 글 갯수
		int srhCnt = 0;	   // 검색한 글 갯수
		int start = 0;	   // 현재페이지 시작 글번호
		int end = 0; 	   // 현재페이지 마지막 글번호
		int number = 0;	   // 출력용 글번호
		String pageNum = ""; // 페이지 번호
		int currentPage = 0; // 현재 페이지
		
		int pageCount = 0; // 페이지 갯수
		int startPage = 0; // 시작 페이지
		int endPage = 0;   // 마지막 페이지
		int searchType = 0;
		String searchText = "";
		Map<String, Object> map = new HashMap<String, Object>();
		
		
		// 검색하기 위한 조건들
		if(req.getParameter("searchType") != null) {
			searchType = Integer.parseInt(req.getParameter("searchType"));
			System.out.println("srchType" + req.getParameter("searchType"));
		}
		map.put("searchType", searchType);
		if(req.getParameter("srch") != null) {
			searchText = req.getParameter("srch");
			System.out.println("srchtext" + searchText);
		}
		map.put("searchText", searchText);
		
		// 5-1단계. 글 갯수 구하기
		srhCnt = memberRepository.getSelectbrandCnt(map);
		cnt = memberRepository.getbrandCnt();
		
		// 5-2단계. 페이지 갯수 구하기
		pageNum = req.getParameter("pageNum");
		
		// 페이지 사이즈 구하기
		if(req.getParameter("pageSize") == null) {
			pageSize = 10;
		} else {
			pageSize = Integer.parseInt(req.getParameter("pageSize"));
		}
		
		if(pageNum == null) {
			pageNum = "1"; // 첫페이지를 1페이지로 지정
		}
		
		// 글 30건 기준
		
		// 현재 페이지 출력
		currentPage = Integer.parseInt(pageNum); // 현재페이지 : 1
		System.out.println(currentPage);
		
		// 페이지 갯수 6 = 30/5 + 0;
		pageCount = (srhCnt / pageSize) + (srhCnt % pageSize == 0 ? 0 : 1); // 페이지 갯수 + 나머지 있으면 1
		
		// 현재페이지 시작 글번호(페이지별)
		start = (currentPage - 1) * pageSize + 1;
		
		// 현재페이지 마지막 글번호
		end = start + pageSize - 1;
		
		System.out.println("start : " + start);
		System.out.println("end : " + end);
		map.put("start", start);
		map.put("end", end);
		
		if(end > cnt) end = srhCnt;
		
		// 출력용 글번호
		number = cnt - (currentPage - 1) * pageSize;
		
		System.out.println("number : " + number);
		System.out.println("pageSize : " + pageSize);
		
		if(srhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			List<BrandDTO> list = memberRepository.getbrandList(map);
			model.addAttribute("list", list); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		}
		
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		// 1 = (1/3)*3+1
		startPage = (currentPage / pageBlock) * pageBlock + 1;
		
		if(currentPage % pageBlock == 0) startPage -= pageBlock;
		System.out.println("startPage : " + startPage);
		
		// 마지막페이지
		// 3 = 1 + 3 - 1
		endPage = startPage + pageBlock - 1;
		if(endPage > pageCount) endPage = pageCount;
		System.out.println("endpage : " + endPage);
		
		System.out.println("========================");
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("cnt", cnt); // 글갯수
		model.addAttribute("srhCnt", srhCnt); // 검색한 글갯수
		model.addAttribute("number", number); // 출력용 글번호
		model.addAttribute("pageNum", pageNum); // 페이지번호
		model.addAttribute("schType", searchType); // 타입
		
		if(cnt>0) {
			model.addAttribute("startPage", startPage); // 시작페이지
			model.addAttribute("endPage", endPage); // 마지막 페이지
			model.addAttribute("pageBlock", pageBlock); // 출력할 페이지 갯수
			model.addAttribute("pageCount", pageCount); // 페이지 갯수
			model.addAttribute("currentPage", currentPage); // 현재 페이지
		}
		
	}
	
	// brand 등록 처리
	public void brandPro(HttpServletRequest req, Model model) {
		// 3단계. 입력받은 값을 받아오기
		// dto 바구니를 생성한다.
		BrandDTO dto = new BrandDTO();
		dto.setName(req.getParameter("name"));
		if(!req.getParameter("telphone1").equals("") &&
				!req.getParameter("telphone2").equals("") &&
				!req.getParameter("telphone3").equals("")) {
		dto.setHp(req.getParameter("telphone1") + "-" +
				req.getParameter("telphone2") + "-" +
				req.getParameter("telphone3"));
		}
		// reg_date
		dto.setReg_date(new Timestamp(System.currentTimeMillis()));
		
		int cnt = memberRepository.insertBrand(dto);
		
		// 5단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("icnt", cnt);
	}

	public void getMaxNum(HttpServletRequest req, Model model) {
		int Num = memberRepository.getbrandMaxNum();
		
		model.addAttribute("num", Num);
	}

	// brand 삭제
	public void h_branddeletePro(HttpServletRequest req, Model model) {
		// 3단계. 입력받은 값을 받아오기
		String pageNum = req.getParameter("pageNum");
		String[] checked = null;
		if(req.getParameterValues("brandchecks") != null) {
			checked = req.getParameterValues("brandchecks");
		} else {
			checked = new String[]{req.getParameter("onenum")};
		}
		System.out.println("checked : " + checked[0]);
		
		// 5-1단계. 패스워드 인증
		int deleteCnt = 0;
		
		// 5-2단계. 맞으면 게시글 삭제
		deleteCnt = memberRepository.deletebrand(checked);
		
		// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		model.addAttribute("dcnt", deleteCnt);
		model.addAttribute("pageNum", pageNum);
	}

	// brand 수정 폼
	public void h_brandupdateView(HttpServletRequest req, Model model) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		int number = Integer.parseInt(req.getParameter("number"));  // 출력용 글번호
		String pageNum = req.getParameter("pageNum"); // 페이지 번호
		int num = Integer.parseInt(req.getParameter("num")); // 식별자
		
		// 5-2단계. 상세페이지 조회
		BrandDTO dto = memberRepository.getbrand(num);
		
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		model.addAttribute("number", number);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("num", num);
		model.addAttribute("vo", dto);
	}

	// brand 수정 처리
	public void h_brandupdatePro(HttpServletRequest req, Model model) {
		// 3단계. 입력받은 값을 받아오기
		int num = Integer.parseInt(req.getParameter("num"));
		String pageNum = req.getParameter("pageNum");
		BrandDTO dto = new BrandDTO();
		dto.setNum(num);
		dto.setName(req.getParameter("name"));
		if(!req.getParameter("telphone1").equals("") &&
				!req.getParameter("telphone2").equals("") &&
				!req.getParameter("telphone3").equals("")) {
		dto.setHp(req.getParameter("telphone1") + "-" +
				req.getParameter("telphone2") + "-" +
				req.getParameter("telphone3"));
		}
		
		// 5단계. 글 수정 처리
		int updateCnt = memberRepository.updateBrand(dto);
		
		// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		model.addAttribute("cnt", updateCnt);
		model.addAttribute("num", num);
		model.addAttribute("pageNum", pageNum);
	}

	
	// product 목록 조회
	public void productList(HttpServletRequest req, Model model) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		// 페이징 처리 계산 처리
		int pageSize = 0;  // 한페이지당 출력할 글 갯수
		int pageBlock = 5; // 한 블럭당 페이지 갯수
		
		int cnt = 0; 	   // 글 갯수
		int srhCnt = 0;	   // 검색한 글 갯수
		int brandsrhCnt = 0;	   // 검색한 글 갯수
		int bigsrhCnt = 0;	   // 검색한 글 갯수
		int mediumsrhCnt = 0;	   // 검색한 글 갯수
		int start = 0;	   // 현재페이지 시작 글번호
		int end = 0; 	   // 현재페이지 마지막 글번호
		int number = 0;	   // 출력용 글번호
		String pageNum = ""; // 페이지 번호
		int currentPage = 0; // 현재 페이지
		
		int pageCount = 0; // 페이지 갯수
		int startPage = 0; // 시작 페이지
		int endPage = 0;   // 마지막 페이지
		int searchType = 0;
		String searchText = "";
		Map<String, Object> map = new HashMap<String, Object>();
		
		
		// 검색하기 위한 조건들
		if(req.getParameter("searchType") != null) {
			searchType = Integer.parseInt(req.getParameter("searchType"));
			System.out.println("srchType" + req.getParameter("searchType"));
		}
		map.put("searchType", searchType);
		if(req.getParameter("srch") != null) {
			searchText = req.getParameter("srch");
			System.out.println("srchtext" + searchText);
		}
		map.put("searchText", searchText);
		
		// 5-1단계. 글 갯수 구하기
		srhCnt = memberRepository.getSelectproductCnt(map);
		bigsrhCnt = memberRepository.getSelectbigpartCnt();
		if(req.getParameter("onecategory") != null && req.getParameter("onecategory") != "") {
			mediumsrhCnt = memberRepository.getSelectmediumpartCnt(Integer.parseInt(req.getParameter("onecategory")));
		}
		brandsrhCnt = memberRepository.getbrandCnt();
		cnt = memberRepository.getproductCnt();
		
		// 5-2단계. 페이지 갯수 구하기
		pageNum = req.getParameter("pageNum");
		
		// 페이지 사이즈 구하기
		if(req.getParameter("pageSize") == null) {
			pageSize = 10;
		} else {
			pageSize = Integer.parseInt(req.getParameter("pageSize"));
		}
		
		if(pageNum == null) {
			pageNum = "1"; // 첫페이지를 1페이지로 지정
		}
		
		// 글 30건 기준
		
		// 현재 페이지 출력
		currentPage = Integer.parseInt(pageNum); // 현재페이지 : 1
		System.out.println(currentPage);
		
		// 페이지 갯수 6 = 30/5 + 0;
		pageCount = (srhCnt / pageSize) + (srhCnt % pageSize == 0 ? 0 : 1); // 페이지 갯수 + 나머지 있으면 1
		
		// 현재페이지 시작 글번호(페이지별)
		start = (currentPage - 1) * pageSize + 1;
		
		// 현재페이지 마지막 글번호
		end = start + pageSize - 1;
		
		System.out.println("start : " + start);
		System.out.println("end : " + end);
		map.put("start", start);
		map.put("end", end);
		
		if(end > cnt) end = srhCnt;
		
		// 출력용 글번호
		number = cnt - (currentPage - 1) * pageSize;
		
		System.out.println("number : " + number);
		System.out.println("pageSize : " + pageSize);
		
		if(srhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			List<clothDTO> list = memberRepository.getproductList(map);
			model.addAttribute("list", list); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		}
		if(bigsrhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			List<bigpartDTO> biglist = memberRepository.getbigpartallList();
			model.addAttribute("biglist", biglist); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		}
		
		if(mediumsrhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			List<mediumpartDTO> medilist = memberRepository.getmediumallList(Integer.parseInt(req.getParameter("onecategory")));
			model.addAttribute("medilist", medilist); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		}
		
		if(brandsrhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			List<BrandDTO> brandlist = memberRepository.getbrandallList();
			model.addAttribute("brandlist", brandlist); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		}
		
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		// 1 = (1/3)*3+1
		startPage = (currentPage / pageBlock) * pageBlock + 1;
		
		if(currentPage % pageBlock == 0) startPage -= pageBlock;
		System.out.println("startPage : " + startPage);
		
		// 마지막페이지
		// 3 = 1 + 3 - 1
		endPage = startPage + pageBlock - 1;
		if(endPage > pageCount) endPage = pageCount;
		System.out.println("endpage : " + endPage);
		
		System.out.println("========================");	 	
	 	
		req.setAttribute("pageSize", pageSize);
		req.setAttribute("cnt", cnt); // 글갯수
		req.setAttribute("mediumsrhCnt", mediumsrhCnt);
		req.setAttribute("bigsrhCnt", bigsrhCnt);
		req.setAttribute("brandsrhCnt", brandsrhCnt);
		req.setAttribute("srhCnt", srhCnt); // 검색한 글갯수
		req.setAttribute("number", number); // 출력용 글번호
		req.setAttribute("pageNum", pageNum); // 페이지번호
		req.setAttribute("schType", searchType); // 타입
		
		if(cnt>0) {
			req.setAttribute("startPage", startPage); // 시작페이지
			req.setAttribute("endPage", endPage); // 마지막 페이지
			req.setAttribute("pageBlock", pageBlock); // 출력할 페이지 갯수
			req.setAttribute("pageCount", pageCount); // 페이지 갯수
			req.setAttribute("currentPage", currentPage); // 현재 페이지
		}
		
	}

	// product 글쓰기 폼
	public void productwriteForm(HttpServletRequest req, Model medel) {
		int brandsrhCnt = 0;	   // 검색한 글 갯수
		int bigsrhCnt = 0;	   // 검색한 글 갯수
			
		// 5-1단계. 글 갯수 구하기
		bigsrhCnt = memberRepository.getSelectbigpartCnt();
		brandsrhCnt = memberRepository.getbrandCnt();
		
		if(bigsrhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			List<bigpartDTO> biglist = memberRepository.getbigpartallList();
			req.setAttribute("biglist", biglist); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		}
		
		if(brandsrhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			List<BrandDTO> brandlist = memberRepository.getbrandallList();
			req.setAttribute("brandlist", brandlist); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		}
			
	
		// 기본 값들
		req.setAttribute("bigsrhCnt", bigsrhCnt);
		req.setAttribute("brandsrhCnt", brandsrhCnt);
	}
	
	// subcategory
	public void subcategory(HttpServletRequest req, Model medel) {
		int mediumsrhCnt = 0;
			
		// 5-1단계. 글 갯수 구하기
		mediumsrhCnt = memberRepository.getSelectmediumpartCnt(Integer.parseInt(req.getParameter("bigpart")));
		
		if(mediumsrhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			List<mediumpartDTO> medilist = memberRepository.getmediumallList(Integer.parseInt(req.getParameter("bigpart")));
			req.setAttribute("medilist", medilist); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		}
			
		req.setAttribute("mediumsrhCnt", mediumsrhCnt);
	}

	// bigpart 추가 처리
	public void bigpartPro(HttpServletRequest req, Model medel) {
		// 3단계. 입력받은 값을 받아오기
		String name = req.getParameter("name");
		
		int cnt = memberRepository.insertBigpart(name);
		
		// 5단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("icnt", cnt);
	}

	// mediumpart 추가 처리
	public void mediumPro(HttpServletRequest req, Model medel) {
		// 3단계. 입력받은 값을 받아오기
		String name = req.getParameter("name");
		int bcode = Integer.parseInt(req.getParameter("bcode"));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("name", name);
		map.put("bcode", bcode);
		
		// 4단계. 다형성 적용, 싱글톤 방식으로 memberRepository 객체 생성
		int cnt = memberRepository.insertmediumpart(map);
		
		// 5단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("icnt", cnt);
	}

	// color 추가 처리
	public void colorPro(HttpServletRequest req, Model medel) {
		// 3단계. 입력받은 값을 받아오기
		String name = req.getParameter("name");
		
		// 4단계. 다형성 적용, 싱글톤 방식으로 memberRepository 객체 생성
		int cnt = memberRepository.insertcolorpart(name);
		
		// 5단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("icnt", cnt);
		req.setAttribute("num", req.getParameter("num"));
	}

	// size 추가 처리
	public void sizePro(HttpServletRequest req, Model medel) {
		// 3단계. 입력받은 값을 받아오기
		String name = req.getParameter("name");
		
		// 4단계. 다형성 적용, 싱글톤 방식으로 memberRepository 객체 생성
		int cnt = memberRepository.insertsizepart(name);
		
		// 5단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("icnt", cnt);
		req.setAttribute("num", req.getParameter("num"));
	}

	
	// 대분류 삭제처리
	public void bigpartdelPro(HttpServletRequest req, Model medel) {
		// 3단계. 입력받은 값을 받아오기
		int num = Integer.parseInt(req.getParameter("name"));
		
		// 4단계. 다형성 적용, 싱글톤 방식으로 memberRepository 객체 생성
		int cnt = memberRepository.deletebigpart(num);
		
		// 5단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("icnt", cnt);
	}
	
	// 중분류 삭제처리
	public void mediumpartdelPro(HttpServletRequest req, Model medel) {
		// 3단계. 입력받은 값을 받아오기
		int num = Integer.parseInt(req.getParameter("name"));
		
		// 4단계. 다형성 적용, 싱글톤 방식으로 memberRepository 객체 생성
		int cnt = memberRepository.deletemediumpart(num);
		
		// 5단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("icnt", cnt);
	}

	// 컬러 삭제처리
	public void colordelPro(HttpServletRequest req, Model medel) {
		// 3단계. 입력받은 값을 받아오기
		int num = Integer.parseInt(req.getParameter("name"));
		
		// 4단계. 다형성 적용, 싱글톤 방식으로 memberRepository 객체 생성
		int cnt = memberRepository.deletecolorpart(num);
		
		// 5단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("icnt", cnt);
		req.setAttribute("num", req.getParameter("num"));
	}

	// 사이즈 삭제처리
	public void sizedelPro(HttpServletRequest req, Model medel) {
		// 3단계. 입력받은 값을 받아오기
		int num = Integer.parseInt(req.getParameter("name"));
		
		// 4단계. 다형성 적용, 싱글톤 방식으로 memberRepository 객체 생성
		int cnt = memberRepository.deletesizepart(num);
		
		// 5단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("icnt", cnt);
		req.setAttribute("num", req.getParameter("num"));
	}

	// 상품 등록 처리
	public void productPro(MultipartHttpServletRequest req, Model medel) {
		// 3단계. 입력받은 값을 받아와 바구니 담음
		clothDTO dto = new clothDTO();
		
		// db에서 reg_date가 default로 sysdate로 작성해놓았으므로
		// 별도로 지정안할시 sysdate로 적용되고, 지정할 경우 로컬이 우선순위
		dto.setReg_date(new Timestamp(System.currentTimeMillis()));
		
		
		MultipartFile file = req.getFile("file1");
		String saveDir = req.getSession().getServletContext().getRealPath("/resources/fileready/");
		// 업로드할 파일이 위치하게될 물리적인 경로
		String realDir = "C:\\Dev50\\workspace\\JSP_PJ\\WebContent\\fileready\\";
		// 인코딩 타입 : 한글 파일명이 열화되는 것을 방지함
		String encType = "UTF-8";
		try {
			if(String.valueOf(file.getOriginalFilename()) != "") {
				file.transferTo(new File(saveDir+file.getOriginalFilename()));

				FileInputStream fis = new FileInputStream(saveDir + file.getOriginalFilename());
				FileOutputStream fos = new FileOutputStream(realDir + file.getOriginalFilename());
				
				int data = 0;
				
				// 논리적인 경로에 저장된 임시 파일을 물리적인 경로로 복사함
				while((data = fis.read()) != -1) {
				fos.write(data);
				}
				fis.close();
				fos.close();
				dto.setFile1(file.getOriginalFilename());
			}
			file = req.getFile("file2");
			if(String.valueOf(file.getOriginalFilename()) != "") {
				System.out.println("file2 =" + String.valueOf(file.getOriginalFilename()));
				file.transferTo(new File(saveDir+file.getOriginalFilename()));

				FileInputStream fis = new FileInputStream(saveDir + file.getOriginalFilename());
				FileOutputStream fos = new FileOutputStream(realDir + file.getOriginalFilename());
				
				int data = 0;
				
				// 논리적인 경로에 저장된 임시 파일을 물리적인 경로로 복사함
				while((data = fis.read()) != -1) {
				fos.write(data);
				}
				fis.close();
				fos.close();
				dto.setFile2(file.getOriginalFilename());
			}
			file = req.getFile("file3");
			if (String.valueOf(file.getOriginalFilename()) != "") {
				file.transferTo(new File(saveDir + file.getOriginalFilename()));

				FileInputStream fis = new FileInputStream(saveDir + file.getOriginalFilename());
				FileOutputStream fos = new FileOutputStream(realDir + file.getOriginalFilename());

				int data = 0;

				// 논리적인 경로에 저장된 임시 파일을 물리적인 경로로 복사함
				while ((data = fis.read()) != -1) {
					fos.write(data);
				}
				fis.close();
				fos.close();
				dto.setFile3(file.getOriginalFilename());
			}
			file = req.getFile("file4");
			if(String.valueOf(file.getOriginalFilename()) != "") {
				file.transferTo(new File(saveDir+file.getOriginalFilename()));

				FileInputStream fis = new FileInputStream(saveDir + file.getOriginalFilename());
				FileOutputStream fos = new FileOutputStream(realDir + file.getOriginalFilename());
				
				int data = 0;
				
				// 논리적인 경로에 저장된 임시 파일을 물리적인 경로로 복사함
				while((data = fis.read()) != -1) {
				fos.write(data);
				}
				fis.close();
				fos.close();
				dto.setFile4(file.getOriginalFilename());
			}
			file = req.getFile("file5");
			if(String.valueOf(file.getOriginalFilename()) != "") {
				file.transferTo(new File(saveDir+file.getOriginalFilename()));

				FileInputStream fis = new FileInputStream(saveDir + file.getOriginalFilename());
				FileOutputStream fos = new FileOutputStream(realDir + file.getOriginalFilename());
				
				int data = 0;
				
				// 논리적인 경로에 저장된 임시 파일을 물리적인 경로로 복사함
				while((data = fis.read()) != -1) {
				fos.write(data);
				}
				fis.close();
				fos.close();
				dto.setFile5(file.getOriginalFilename());
			}
			file = req.getFile("mainfile");
			if(String.valueOf(file.getOriginalFilename()) != "") {
				file.transferTo(new File(saveDir+file.getOriginalFilename()));

				FileInputStream fis = new FileInputStream(saveDir + file.getOriginalFilename());
				FileOutputStream fos = new FileOutputStream(realDir + file.getOriginalFilename());
				
				int data = 0;
				
				// 논리적인 경로에 저장된 임시 파일을 물리적인 경로로 복사함
				while((data = fis.read()) != -1) {
				fos.write(data);
				}
				fis.close();
				fos.close();
				dto.setMainfile(file.getOriginalFilename());
			}

			if(req.getParameter("tpart") == null || req.getParameter("tpart").equals("")) {
				dto.setMediumcode(0);
			} else {
				dto.setMediumcode(Integer.parseInt(req.getParameter("tpart")));
			}
			dto.setName(req.getParameter("name"));
			dto.setTex(req.getParameter("tex"));
			dto.setBrandnum(Integer.parseInt(req.getParameter("brands")));
			dto.setIcon(req.getParameter("icon"));
			if(req.getParameter("plus").equals("plus")) {
				dto.setPlus(Integer.parseInt(req.getParameter("pluspay")));
			} else {
				dto.setPlus(0);
			}
			dto.setSaleprice(Integer.parseInt(req.getParameter("saleprice")));
			dto.setBuyprice(Integer.parseInt(req.getParameter("buyprice")));
			dto.setDeliday(Integer.parseInt(req.getParameter("delidate")));
			if(req.getParameter("delipay").equals("pluspay")) {
				dto.setDeliprice(Integer.parseInt(req.getParameter("deliprice")));
			} else if(req.getParameter("delipay").equals("basepay")) {
				dto.setDeliprice(2500);
			} else {
				dto.setDeliprice(0);
			}
			dto.setContent(req.getParameter("content"));
			if(!req.getParameter("withitem").equals("")) {
				dto.setWithprdnum(Integer.parseInt(req.getParameter("withitem")));
			}
			System.out.println(dto.toString());
			
			// 5단계. 글쓰기 처리
			int insertCnt = memberRepository.insertproduct(dto);
			
			// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
			req.setAttribute("icnt", insertCnt);
			req.setAttribute("pageNum", req.getParameter("pageNum"));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// with상품 목록 조회
	public void withproductList(HttpServletRequest req, Model medel) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		// 페이징 처리 계산 처리
		int pageSize = 5;  // 한페이지당 출력할 글 갯수
		int pageBlock = 5; // 한 블럭당 페이지 갯수
		
		int cnt = 0; 	   // 글 갯수
		int srhCnt = 0;	   // 검색한 글 갯수
		int start = 0;	   // 현재페이지 시작 글번호
		int end = 0; 	   // 현재페이지 마지막 글번호
		int number = 0;	   // 출력용 글번호
		String pageNum = ""; // 페이지 번호
		int currentPage = 0; // 현재 페이지
		
		int pageCount = 0; // 페이지 갯수
		int startPage = 0; // 시작 페이지
		int endPage = 0;   // 마지막 페이지
		int searchType = 0;
		String searchText = "";
		Map<String, Object> map = new HashMap<String, Object>();
		
		
		// 검색하기 위한 조건들
		if(req.getParameter("searchType") != null) {
			searchType = Integer.parseInt(req.getParameter("searchType"));
			System.out.println("srchType" + req.getParameter("searchType"));
		}
		map.put("searchType", searchType);
		if(req.getParameter("srch") != null) {
			searchText = req.getParameter("srch");
			System.out.println("srchtext" + searchText);
		}
		map.put("searchText", searchText);
		
		// 5-1단계. 글 갯수 구하기
		srhCnt = memberRepository.getSelectproductCnt(map);
		cnt = memberRepository.getproductCnt();
		
		// 5-2단계. 페이지 갯수 구하기
		pageNum = req.getParameter("pageNum");
		
		if(pageNum == null) {
			pageNum = "1"; // 첫페이지를 1페이지로 지정
		}
		
		// 글 30건 기준
		
		// 현재 페이지 출력
		currentPage = Integer.parseInt(pageNum); // 현재페이지 : 1
		System.out.println(currentPage);
		
		// 페이지 갯수 6 = 30/5 + 0;
		pageCount = (srhCnt / pageSize) + (srhCnt % pageSize == 0 ? 0 : 1); // 페이지 갯수 + 나머지 있으면 1
		
		// 현재페이지 시작 글번호(페이지별)
		start = (currentPage - 1) * pageSize + 1;
		
		// 현재페이지 마지막 글번호
		end = start + pageSize - 1;
		
		System.out.println("start : " + start);
		System.out.println("end : " + end);
		map.put("start", start);
		map.put("end", end);
		
		if(end > cnt) end = srhCnt;
		
		// 출력용 글번호
		number = cnt - (currentPage - 1) * pageSize;
		
		System.out.println("number : " + number);
		System.out.println("pageSize : " + pageSize);
		
		if(srhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			List<clothDTO> list = memberRepository.getproductList(map);
			req.setAttribute("list", list); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		}
		
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		// 1 = (1/3)*3+1
		startPage = (currentPage / pageBlock) * pageBlock + 1;
		
		if(currentPage % pageBlock == 0) startPage -= pageBlock;
		System.out.println("startPage : " + startPage);
		
		// 마지막페이지
		// 3 = 1 + 3 - 1
		endPage = startPage + pageBlock - 1;
		if(endPage > pageCount) endPage = pageCount;
		System.out.println("endpage : " + endPage);
		
		System.out.println("========================");	 	
	 	
		req.setAttribute("pageSize", pageSize);
		req.setAttribute("cnt", cnt); // 글갯수
		req.setAttribute("srhCnt", srhCnt); // 검색한 글갯수
		req.setAttribute("number", number); // 출력용 글번호
		req.setAttribute("pageNum", pageNum); // 페이지번호
		req.setAttribute("schType", searchType); // 타입
		
		if(cnt>0) {
			req.setAttribute("startPage", startPage); // 시작페이지
			req.setAttribute("endPage", endPage); // 마지막 페이지
			req.setAttribute("pageBlock", pageBlock); // 출력할 페이지 갯수
			req.setAttribute("pageCount", pageCount); // 페이지 갯수
			req.setAttribute("currentPage", currentPage); // 현재 페이지
		}
	}

	// 상품 수정 폼
	public void h_productupdateView(HttpServletRequest req, Model medel) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		int number = Integer.parseInt(req.getParameter("number"));  // 출력용 글번호
		String pageNum = req.getParameter("pageNum"); // 페이지 번호
		int num = Integer.parseInt(req.getParameter("num")); // 식별자
		
		// 5-2단계. 상세페이지 조회
		clothDTO dto = memberRepository.getproduct(num);
		
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("number", number);
		req.setAttribute("pageNum", pageNum);
		req.setAttribute("num", num);
		req.setAttribute("vo", dto);
		
		int brandsrhCnt = 0;	   // 검색한 글 갯수
		int bigsrhCnt = 0;	   // 검색한 글 갯수
		
		// 5-1단계. 글 갯수 구하기
		bigsrhCnt = memberRepository.getSelectbigpartCnt();
		brandsrhCnt = memberRepository.getbrandCnt();
		
		if(bigsrhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			List<bigpartDTO> biglist = memberRepository.getbigpartallList();
			req.setAttribute("biglist", biglist); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		}
		
		if(brandsrhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			List<BrandDTO> brandlist = memberRepository.getbrandallList();
			req.setAttribute("brandlist", brandlist); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		}
		

		// 기본 값들
		req.setAttribute("bigsrhCnt", bigsrhCnt);
		req.setAttribute("brandsrhCnt", brandsrhCnt);
	}

	// 파일 수정 폼
	public void h_productupdateView2(HttpServletRequest req, Model medel) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		String pageNum = req.getParameter("pageNum"); // 페이지 번호
		int num = Integer.parseInt(req.getParameter("num")); // 식별자
		
		// 5-2단계. 상세페이지 조회
		clothDTO dto = memberRepository.getproduct(num);
		
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("pageNum", pageNum);
		req.setAttribute("num", num);
		req.setAttribute("vo", dto);
	}

	// 상품 수정 처리
	public void h_productupdatePro(HttpServletRequest req, Model medel) {
		// 3단계. 입력받은 값을 받아와 바구니 담음
		clothDTO dto = new clothDTO();
		
		// db에서 reg_date가 default로 sysdate로 작성해놓았으므로
		// 별도로 지정안할시 sysdate로 적용되고, 지정할 경우 로컬이 우선순위
		int number = Integer.parseInt(req.getParameter("number"));  // 출력용 글번호
		String pageNum = req.getParameter("pageNum"); // 페이지 번호
		int num = Integer.parseInt(req.getParameter("num")); // 식별자
		dto.setNum(num);
		dto.setMediumcode(Integer.parseInt(req.getParameter("tpart")));
		dto.setName(req.getParameter("name"));
		dto.setTex(req.getParameter("tex"));
		dto.setBrandnum(Integer.parseInt(req.getParameter("brands")));
		dto.setIcon(req.getParameter("icon"));
		if(req.getParameter("plus").equals("plus")) {
			dto.setPlus(Integer.parseInt(req.getParameter("pluspay")));
		} else {
			dto.setPlus(0);
		}
		dto.setSaleprice(Integer.parseInt(req.getParameter("saleprice")));
		dto.setBuyprice(Integer.parseInt(req.getParameter("buyprice")));
		dto.setDeliday(Integer.parseInt(req.getParameter("delidate")));
		if(req.getParameter("delipay").equals("pluspay")) {
			dto.setDeliprice(Integer.parseInt(req.getParameter("deliprice")));
		} else if(req.getParameter("delipay").equals("basepay")) {
			dto.setDeliprice(2500);
		} else {
			dto.setDeliprice(0);
		}
		dto.setContent(req.getParameter("content"));
		
		// 5단계. 글쓰기 처리
		int insertCnt = memberRepository.updateproduct(dto);
		
		// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("icnt", insertCnt);
		req.setAttribute("number", number);
		req.setAttribute("pageNum", pageNum);
		req.setAttribute("num", num);

	

	}

	// mainfile 수정
	public void h_productmainfileupdatePro(MultipartHttpServletRequest req, Model medel) {
		// 3단계. 입력받은 값을 받아와 바구니 담음
		clothDTO dto = new clothDTO();
		
		MultipartFile file = req.getFile("mainfile");
		String saveDir = req.getSession().getServletContext().getRealPath("/resources/fileready/");
		// 업로드할 파일이 위치하게될 물리적인 경로
		String realDir = "C:\\Dev50\\workspace\\JSP_PJ\\WebContent\\fileready\\";
		// 인코딩 타입 : 한글 파일명이 열화되는 것을 방지함
		String encType = "UTF-8";
		try {
			if(file.getOriginalFilename() != null) {
				file.transferTo(new File(saveDir+file.getOriginalFilename()));

				FileInputStream fis = new FileInputStream(saveDir + file.getOriginalFilename());
				FileOutputStream fos = new FileOutputStream(realDir + file.getOriginalFilename());
				
				int data = 0;
				
				// 논리적인 경로에 저장된 임시 파일을 물리적인 경로로 복사함
				while((data = fis.read()) != -1) {
				fos.write(data);
				}
				fis.close();
				fos.close();
				dto.setMainfile(file.getOriginalFilename());
			}
			int number = Integer.parseInt(req.getParameter("number"));  // 출력용 글번호
			String pageNum = req.getParameter("pageNum"); // 페이지 번호
			int num = Integer.parseInt(req.getParameter("num")); // 식별자
			dto.setNum(num);
			
			// 5단계. 글쓰기 처리
			int insertCnt = memberRepository.updatemainfileproduct(dto);
			
			// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
			req.setAttribute("icnt", insertCnt);
			req.setAttribute("number", number);
			req.setAttribute("pageNum", pageNum);
			req.setAttribute("num", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// files 수정
	public void h_productfilesupdatePro(MultipartHttpServletRequest req, Model medel) {
		// 3단계. 입력받은 값을 받아와 바구니 담음
		clothDTO dto = new clothDTO();
		
		MultipartFile file = req.getFile("file1");
		String saveDir = req.getSession().getServletContext().getRealPath("/resources/fileready/");
		// 업로드할 파일이 위치하게될 물리적인 경로
		String realDir = "C:\\Dev50\\workspace\\JSP_PJ\\WebContent\\fileready\\";
		// 인코딩 타입 : 한글 파일명이 열화되는 것을 방지함
		String encType = "UTF-8";
		try {
			if(file.getOriginalFilename() != null) {
				file.transferTo(new File(saveDir+file.getOriginalFilename()));

				FileInputStream fis = new FileInputStream(saveDir + file.getOriginalFilename());
				FileOutputStream fos = new FileOutputStream(realDir + file.getOriginalFilename());
				
				int data = 0;
				
				// 논리적인 경로에 저장된 임시 파일을 물리적인 경로로 복사함
				while((data = fis.read()) != -1) {
				fos.write(data);
				}
				fis.close();
				fos.close();
				dto.setFile1(file.getOriginalFilename());
			}
			file = req.getFile("file1");
			if(file.getOriginalFilename() != null) {
				file.transferTo(new File(saveDir+file.getOriginalFilename()));

				FileInputStream fis = new FileInputStream(saveDir + file.getOriginalFilename());
				FileOutputStream fos = new FileOutputStream(realDir + file.getOriginalFilename());
				
				int data = 0;
				
				// 논리적인 경로에 저장된 임시 파일을 물리적인 경로로 복사함
				while((data = fis.read()) != -1) {
				fos.write(data);
				}
				fis.close();
				fos.close();
				dto.setFile1(file.getOriginalFilename());
			}
			file = req.getFile("file2");
			if(file.getOriginalFilename() != null) {
				file.transferTo(new File(saveDir+file.getOriginalFilename()));

				FileInputStream fis = new FileInputStream(saveDir + file.getOriginalFilename());
				FileOutputStream fos = new FileOutputStream(realDir + file.getOriginalFilename());
				
				int data = 0;
				
				// 논리적인 경로에 저장된 임시 파일을 물리적인 경로로 복사함
				while((data = fis.read()) != -1) {
				fos.write(data);
				}
				fis.close();
				fos.close();
				dto.setFile2(file.getOriginalFilename());
			}
			file = req.getFile("file3");
			if(file.getOriginalFilename() != null) {
				file.transferTo(new File(saveDir+file.getOriginalFilename()));

				FileInputStream fis = new FileInputStream(saveDir + file.getOriginalFilename());
				FileOutputStream fos = new FileOutputStream(realDir + file.getOriginalFilename());
				
				int data = 0;
				
				// 논리적인 경로에 저장된 임시 파일을 물리적인 경로로 복사함
				while((data = fis.read()) != -1) {
				fos.write(data);
				}
				fis.close();
				fos.close();
				dto.setFile3(file.getOriginalFilename());
			}
			file = req.getFile("file4");
			if(file.getOriginalFilename() != null) {
				file.transferTo(new File(saveDir+file.getOriginalFilename()));

				FileInputStream fis = new FileInputStream(saveDir + file.getOriginalFilename());
				FileOutputStream fos = new FileOutputStream(realDir + file.getOriginalFilename());
				
				int data = 0;
				
				// 논리적인 경로에 저장된 임시 파일을 물리적인 경로로 복사함
				while((data = fis.read()) != -1) {
				fos.write(data);
				}
				fis.close();
				fos.close();
				dto.setFile4(file.getOriginalFilename());
			}
			file = req.getFile("file5");
			if(file.getOriginalFilename() != null) {
				file.transferTo(new File(saveDir+file.getOriginalFilename()));

				FileInputStream fis = new FileInputStream(saveDir + file.getOriginalFilename());
				FileOutputStream fos = new FileOutputStream(realDir + file.getOriginalFilename());
				
				int data = 0;
				
				// 논리적인 경로에 저장된 임시 파일을 물리적인 경로로 복사함
				while((data = fis.read()) != -1) {
				fos.write(data);
				}
				fis.close();
				fos.close();
				dto.setFile5(file.getOriginalFilename());
			}
			int number = Integer.parseInt(req.getParameter("number"));  // 출력용 글번호
			String pageNum = req.getParameter("pageNum"); // 페이지 번호
			int num = Integer.parseInt(req.getParameter("num")); // 식별자
			
			// 5단계. 글쓰기 처리
			int insertCnt = memberRepository.updatefilesproduct(dto);
			
			// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
			req.setAttribute("icnt", insertCnt);
			req.setAttribute("number", number);
			req.setAttribute("pageNum", pageNum);
			req.setAttribute("num", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// withitems 수정
	public void h_productwithitemsupdatePro(HttpServletRequest req, Model medel) {
		int number = Integer.parseInt(req.getParameter("number"));  // 출력용 글번호
		String pageNum = req.getParameter("pageNum"); // 페이지 번호
		int num = Integer.parseInt(req.getParameter("num")); // 식별자
		// 3단계. 입력받은 값을 받아와 바구니 담음
		clothDTO dto = new clothDTO();
		
		if(req.getParameter("withitem") != "") {
			dto.setWithprdnum(Integer.parseInt(req.getParameter("withitem")));
		}
		
		// 5단계. 글쓰기 처리
		int insertCnt = memberRepository.updatewithitemsproduct(dto);
		
		// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("icnt", insertCnt);
		req.setAttribute("number", number);
		req.setAttribute("pageNum", pageNum);
		req.setAttribute("num", num);
	}

	// product 삭제
	public void h_productdeletePro(HttpServletRequest req, Model medel) {
		// 3단계. 입력받은 값을 받아오기
		String pageNum = req.getParameter("pageNum");
		String[] checked = null;
		if(req.getParameterValues("productchecks") != null) {
			checked = req.getParameterValues("productchecks");
		} else {
			checked = new String[]{req.getParameter("onenum")};
		}
		System.out.println("checked : " + checked[0]);
		
		// 5-1단계. 패스워드 인증
		int deleteCnt = 0;
		
		// 5-2단계. 맞으면 게시글 삭제
		deleteCnt = memberRepository.deleteproduct(checked);
		
		// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("dcnt", deleteCnt);
		req.setAttribute("pageNum", pageNum);
	}

	// 메뉴 리스트 조회
	public void menuList(HttpServletRequest req, Model medel) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		// 페이징 처리 계산 처리
		String name = req.getParameter("name");
		int pageSize = 0;  // 한페이지당 출력할 글 갯수
		int pageBlock = 5; // 한 블럭당 페이지 갯수
		
		int srhCnt = 0;	   // 검색한 글 갯수
		int start = 0;	   // 현재페이지 시작 글번호
		int end = 0; 	   // 현재페이지 마지막 글번호
		int number = 0;	   // 출력용 글번호
		String pageNum = ""; // 페이지 번호
		int currentPage = 0; // 현재 페이지
		
		int pageCount = 0; // 페이지 갯수
		int startPage = 0; // 시작 페이지
		int endPage = 0;   // 마지막 페이지
		
		// 5-1단계. 글 갯수 구하기
		srhCnt = memberRepository.getSelectprdCnt(name);
		
		// 5-2단계. 페이지 갯수 구하기
		pageNum = req.getParameter("pageNum");
		
		// 페이지 사이즈 구하기
		if(req.getParameter("pageSize") == null) {
			pageSize = 20;
		} else {
			pageSize = Integer.parseInt(req.getParameter("pageSize"));
		}
		
		if(pageNum == null) {
			pageNum = "1"; // 첫페이지를 1페이지로 지정
		}
		
		// 글 30건 기준
		
		// 현재 페이지 출력
		currentPage = Integer.parseInt(pageNum); // 현재페이지 : 1
		System.out.println(currentPage);
		
		// 페이지 갯수 6 = 30/5 + 0;
		pageCount = (srhCnt / pageSize) + (srhCnt % pageSize == 0 ? 0 : 1); // 페이지 갯수 + 나머지 있으면 1
		
		// 현재페이지 시작 글번호(페이지별)
		start = (currentPage - 1) * pageSize + 1;
		
		// 현재페이지 마지막 글번호
		end = start + pageSize - 1;
		
		System.out.println("start : " + start);
		System.out.println("end : " + end);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("name", name);
		map.put("start", start);
		map.put("end", end);
		
		if(end > srhCnt) end = srhCnt;
		
		// 출력용 글번호
		number = srhCnt - (currentPage - 1) * pageSize;
		
		System.out.println("number : " + number);
		System.out.println("pageSize : " + pageSize);
		
		if(srhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			List<clothDTO> list = memberRepository.getprdList(map);
			req.setAttribute("list", list); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		}
		
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		// 1 = (1/3)*3+1
		startPage = (currentPage / pageBlock) * pageBlock + 1;
		
		if(currentPage % pageBlock == 0) startPage -= pageBlock;
		System.out.println("startPage : " + startPage);
		
		// 마지막페이지
		// 3 = 1 + 3 - 1
		endPage = startPage + pageBlock - 1;
		if(endPage > pageCount) endPage = pageCount;
		System.out.println("endpage : " + endPage);
		
		System.out.println("========================");	 	
	 	
		req.setAttribute("name", name);
		req.setAttribute("pageSize", pageSize);
		req.setAttribute("srhCnt", srhCnt); // 검색한 글갯수
		req.setAttribute("number", number); // 출력용 글번호
		req.setAttribute("pageNum", pageNum); // 페이지번호
		
		if(srhCnt>0) {
			req.setAttribute("startPage", startPage); // 시작페이지
			req.setAttribute("endPage", endPage); // 마지막 페이지
			req.setAttribute("pageBlock", pageBlock); // 출력할 페이지 갯수
			req.setAttribute("pageCount", pageCount); // 페이지 갯수
			req.setAttribute("currentPage", currentPage); // 현재 페이지
		}
	}

	// 상품 상세 조회
	public void productclick(HttpServletRequest req, Model medel) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		int num = Integer.parseInt(req.getParameter("num")); // 식별자
		
		// 5-2단계. 상세페이지 조회
		clothDTO dto = memberRepository.getproduct(num);
		
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("num", num);
		req.setAttribute("vo", dto);
		
		int colorsrhCnt = 0;
		String opart = req.getParameter("color");
		String size = req.getParameter("size");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("prdnum", num);
		
		// 5-1단계. 글 갯수 구하기
		colorsrhCnt = memberRepository.getSelectcolorCnt(num);
		
		if(colorsrhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			List<colorDTO> colorlist = memberRepository.getSelectcolorList(num);
			req.setAttribute("colorlist", colorlist); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		}
		
		if(req.getParameter("color") != null && !req.getParameter("color").equals("")
				&& req.getParameter("size") != null && !req.getParameter("size").equals("")) {
			map.put("colorcode", Integer.parseInt(opart));
			map.put("sizecode", Integer.parseInt(size));
			stockDTO stockvo = memberRepository.getcs(map);
			req.setAttribute("svo", stockvo); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		}
		
		// 기본 값들
		req.setAttribute("colorsrhCnt", colorsrhCnt);

	}

	// 주문 상세 폼
	public void orderform(HttpServletRequest req, Model medel) {
		int prdnum = Integer.parseInt(req.getParameter("num"));
		int colorcode = Integer.parseInt(req.getParameter("colorcode"));
		int sizecode = Integer.parseInt(req.getParameter("sizecode"));
		int count = Integer.parseInt(req.getParameter("count"));
		// 3단계. 입력받은 값을 받아오기
		String strid = (String)req.getSession().getAttribute("memId");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("strId", strid);
		map.put("member", 0);
		map.put("prdnum", prdnum);
		map.put("colorcode", colorcode);
		map.put("sizecode", sizecode);
		map.put("count", count);
		
		// 5-1단계. 로그인 정보가 있는지 확인
		int selectCnt = memberRepository.idCheck(map);
		int CountChkCnt = memberRepository.countChk(map);
		
		// 5-2단계. 있으면 로그인한 id로 정보 조회
		if(selectCnt == 1 && CountChkCnt >= 0) {
			MemberDTO guestvo = memberRepository.getMemberInfo(strid);
			req.setAttribute("gvo", guestvo);
			clothDTO clothvo = memberRepository.getproduct(prdnum);
			req.setAttribute("cvo", clothvo);
			stockDTO stockvo = memberRepository.getcs(map);
			req.setAttribute("svo", stockvo);
			req.setAttribute("count", count);
			
		}
		
		// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("swh", req.getParameter("swh"));
		req.setAttribute("swit", req.getParameter("swit"));
		req.setAttribute("num", prdnum);
		req.setAttribute("scnt", selectCnt);
		req.setAttribute("ucnt", CountChkCnt);
		
	}

	// 사이즈 컬러 상품 추가 폼
	public void cswriteForm(HttpServletRequest req, Model medel) {
		int num = Integer.parseInt(req.getParameter("num"));
		int colorsrhCnt = 0;
		int sizesrhCnt = 0;
				
		// 5-2단계. 상세페이지 조회
		clothDTO dto = memberRepository.getproduct(num);
		req.setAttribute("vo", dto);
		
		colorsrhCnt = memberRepository.getcolorCnt();
		sizesrhCnt = memberRepository.getsizeCnt();

		
		if(colorsrhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			List<colorDTO> colorlist = memberRepository.getcolorList();
			req.setAttribute("colorlist", colorlist); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		}
		
		if(sizesrhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			List<sizeDTO> sizelist = memberRepository.getsizeList();
			req.setAttribute("sizelist", sizelist); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		}
		
		req.setAttribute("num", num);
		req.setAttribute("colorsrhCnt", colorsrhCnt);
		req.setAttribute("sizesrhCnt", sizesrhCnt);
		req.setAttribute("pageNum", req.getParameter("pageNum"));
	}

	// 사이즈 컬러 상품 추가 처리
	public void csPro(HttpServletRequest req, Model medel) {
		// 3단계. 입력받은 값을 받아와 바구니 담음
		int num = Integer.parseInt(req.getParameter("num"));
		stockDTO dto = new stockDTO();
		dto.setColorcode(Integer.parseInt(req.getParameter("color")));
		dto.setSizecode(Integer.parseInt(req.getParameter("size")));
		dto.setState(req.getParameter("state"));
		dto.setCount(Integer.parseInt(req.getParameter("stock")));
		dto.setMaxcount(Integer.parseInt(req.getParameter("maxcount")));
		dto.setPrdnum(num);
		
		// 5단계. 글쓰기 처리
		int insertCnt = memberRepository.insertcs(dto);
		
		// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("icnt", insertCnt);
		req.setAttribute("pageNum", req.getParameter("pageNum"));
	}

	// cs 수정 폼
	public void h_csupdateView(HttpServletRequest req, Model medel) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		String pageNum = req.getParameter("pageNum"); // 페이지 번호
		int num = Integer.parseInt(req.getParameter("num")); // 식별자
		
		// 5-2단계. 상세페이지 조회
		clothDTO dto = memberRepository.getproduct(num);
		
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("pageNum", pageNum);
		req.setAttribute("num", num);
		req.setAttribute("vo", dto);
		
		int colorsrhCnt = 0;
		
		// 5-1단계. 글 갯수 구하기
		colorsrhCnt = memberRepository.getSelectcolorCnt(num);
		
		
		if(colorsrhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			List<colorDTO> colorlist = memberRepository.getSelectcolorList(num);
			req.setAttribute("colorlist", colorlist); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		}
		
		// 기본 값들
		req.setAttribute("colorsrhCnt", colorsrhCnt);
	}
	
	// subsize
	public void subsize(HttpServletRequest req, Model model) {
		int sizesrhCnt = 0;
		int num = Integer.parseInt(req.getParameter("num")); // 식별자
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		map.put("colorcode", Integer.parseInt(req.getParameter("color")));
		
		// 5-1단계. 글 갯수 구하기
		sizesrhCnt = memberRepository.getSelectsizeCnt(map);
		
		if(sizesrhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			List<sizeDTO> sizelist = memberRepository.getSelectsizeList(map);
			model.addAttribute("sizelist", sizelist); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		}
		model.addAttribute("sizesrhCnt", sizesrhCnt);
	}

	// submedium
	public void submedium(HttpServletRequest req, Model model) {
		int medisrhCnt = 0;
		int num =  Integer.parseInt(req.getParameter("bigpart"));

		// 5-1단계. 갯수 구하기
		medisrhCnt = memberRepository.getSelectmediumpartCnt(num);
		System.out.println("mediCnt = " + medisrhCnt);
		if(medisrhCnt > 0) {
			// 5-2단계. 목록 조회
			List<mediumpartDTO> medilist = memberRepository.getmediumallList(num);
			System.out.println("medilist = " + medilist.size());
			model.addAttribute("medilist", medilist); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		}
		model.addAttribute("medisrhCnt", medisrhCnt);
	}
	
	public void h_subcslist(HttpServletRequest req, Model medel) {
		int num = Integer.parseInt(req.getParameter("num")); // 식별자
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("prdnum", num);
		map.put("colorcode", Integer.parseInt(req.getParameter("color")));
		map.put("sizecode", Integer.parseInt(req.getParameter("size")));
		
		stockDTO stockvo = memberRepository.getcs(map);
		req.setAttribute("stockvo", stockvo); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
	}

	public void h_csupdatePro(HttpServletRequest req, Model medel) {
		// 3단계. 입력받은 값을 받아와 바구니 담음
		stockDTO dto = new stockDTO();
		
		// db에서 reg_date가 default로 sysdate로 작성해놓았으므로
		// 별도로 지정안할시 sysdate로 적용되고, 지정할 경우 로컬이 우선순위
		String pageNum = req.getParameter("pageNum"); // 페이지 번호
		int num = Integer.parseInt(req.getParameter("num")); // 식별자
		dto.setPrdnum(num);
		dto.setColorcode(Integer.parseInt(req.getParameter("color")));
		dto.setSizecode(Integer.parseInt(req.getParameter("size")));
		dto.setCount(Integer.parseInt(req.getParameter("stock")));
		dto.setState(req.getParameter("state"));
		dto.setMaxcount(Integer.parseInt(req.getParameter("maxcount")));
		
		// 5단계. 글쓰기 처리
		int insertCnt = memberRepository.updatecs(dto);
		
		// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("icnt", insertCnt);
		req.setAttribute("pageNum", pageNum);
		req.setAttribute("num", num);
	}

	// 주문 처리
	public void orderPro(HttpServletRequest req, Model medel) {
		// 3단계. 입력받은 값을 받아와 바구니 담음
		orderDTO dto = new orderDTO();
		
		int pluspay = 0;
		int asd = 0;
		// db에서 reg_date가 default로 sysdate로 작성해놓았으므로
		// 별도로 지정안할시 sysdate로 적용되고, 지정할 경우 로컬이 우선순위
		dto.setGid((String)req.getSession().getAttribute("memId"));
		dto.setPrdnum(Integer.parseInt(req.getParameter("num")));
		System.out.println(dto.getPrdnum());
		dto.setColorcode(Integer.parseInt(req.getParameter("color")));
		dto.setSizecode(Integer.parseInt(req.getParameter("size")));
		dto.setCount(Integer.parseInt(req.getParameter("count")));
		dto.setRealprice(Integer.parseInt(req.getParameter("price")));
		dto.setPrice(Integer.parseInt(req.getParameter("price")));
		dto.setBankname(req.getParameter("bank"));
		dto.setPay_option(req.getParameter("howpay"));
		dto.setReg_date(new Timestamp(System.currentTimeMillis()));
		if(req.getParameter("howpay").equals("notacc")) {
			dto.setState("입금전");
			dto.setDepositname(req.getParameter("depositname"));
		} else {
			dto.setState("배송준비중");
		}
		
		if(req.getParameter("pluspay") != null && req.getParameter("pluspay") != "") {
			pluspay = Integer.parseInt(req.getParameter("pluspay"));
			int prdplus = Integer.parseInt(req.getParameter("prdplus")) * Integer.parseInt(req.getParameter("count"));
			dto.setUseplus(pluspay);
			dto.setPrice(Integer.parseInt(req.getParameter("price")) - pluspay);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("pluspay", pluspay);
			map.put("prdplus", prdplus);
			map.put("strid", (String)req.getSession().getAttribute("memId"));
			asd = memberRepository.updategplus(map);
		}
		
		
		int updateCnt = memberRepository.orderupdatecs(dto);
		
		if(updateCnt != 0) {
			int insertCnt = memberRepository.insertorder(dto);
			req.setAttribute("icnt", insertCnt);
			if(!req.getParameter("swit").equals("") && req.getParameter("swit") != null) {
				if(req.getParameter("swh").equals("1")) {
					memberRepository.deletecart(Integer.parseInt(req.getParameter("swit")));
				} else if(req.getParameter("swh").equals("2")) {
					memberRepository.deletewish(Integer.parseInt(req.getParameter("swit")));
				}
			}
		}
		
		// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("ucnt", updateCnt);
	}

	// 주문 목록 리스트
	public void orderlist(HttpServletRequest req, Model medel) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		// 페이징 처리 계산 처리
		int pageSize = 10;  // 한페이지당 출력할 글 갯수
		int pageBlock = 5; // 한 블럭당 페이지 갯수
		
		int cnt = 0; 	   // 글 갯수
		int srhCnt = 0;	   // 검색한 글 갯수
		int brandsrhCnt = 0;	   // 검색한 글 갯수
		int bigsrhCnt = 0;	   // 검색한 글 갯수
		int mediumsrhCnt = 0;	   // 검색한 글 갯수
		int start = 0;	   // 현재페이지 시작 글번호
		int end = 0; 	   // 현재페이지 마지막 글번호
		int number = 0;	   // 출력용 글번호
		String pageNum = ""; // 페이지 번호
		int currentPage = 0; // 현재 페이지
		
		int pageCount = 0; // 페이지 갯수
		int startPage = 0; // 시작 페이지
		int endPage = 0;   // 마지막 페이지
		String state = "";
		Date firstday = null;
		Date lastday = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 검색하기 위한 조건들
		if(req.getParameter("firstday") != null && req.getParameter("lastday") != null) {
			firstday = Date.valueOf(req.getParameter("firstday"));
			lastday = Date.valueOf(req.getParameter("lastday"));
		}
		map.put("firstday", firstday);
		map.put("lastday", lastday);
		System.out.println("srchTdae" + req.getParameter("firstday"));
		System.out.println("srchdaye" + req.getParameter("lastday"));
		if(req.getParameter("state") != null) {
			state = req.getParameter("state");
			System.out.println("state" + state);
		}
		map.put("state", state);
		map.put("strid", (String)req.getSession().getAttribute("memId"));
		
		// 5-1단계. 글 갯수 구하기
		srhCnt = memberRepository.getSelectOrderCnt(map);
		cnt = memberRepository.getorderCnt();
		
		// 5-2단계. 페이지 갯수 구하기
		pageNum = req.getParameter("pageNum");
		
		if(pageNum == null) {
			pageNum = "1"; // 첫페이지를 1페이지로 지정
		}
		
		// 글 30건 기준
		
		// 현재 페이지 출력
		currentPage = Integer.parseInt(pageNum); // 현재페이지 : 1
		System.out.println(currentPage);
		
		// 페이지 갯수 6 = 30/5 + 0;
		pageCount = (srhCnt / pageSize) + (srhCnt % pageSize == 0 ? 0 : 1); // 페이지 갯수 + 나머지 있으면 1
		
		// 현재페이지 시작 글번호(페이지별)
		start = (currentPage - 1) * pageSize + 1;
		
		// 현재페이지 마지막 글번호
		end = start + pageSize - 1;
		
		System.out.println("start : " + start);
		System.out.println("end : " + end);
		map.put("start", start);
		map.put("end", end);
		
		if(end > cnt) end = srhCnt;
		
		// 출력용 글번호
		number = cnt - (currentPage - 1) * pageSize;
		
		System.out.println("number : " + number);
		System.out.println("pageSize : " + pageSize);
		Map<String, Object> smap = new HashMap<String, Object>();
		smap.put("count", 0);
		
		if(req.getParameter("statenumber") != null) {
			smap.put("num", Integer.parseInt(req.getParameter("num")));
			smap.put("state", Integer.parseInt(req.getParameter("statenumber")));
			int updateCnt = memberRepository.updatestate(smap);
			req.setAttribute("ucnt", updateCnt);
			req.setAttribute("snum", Integer.parseInt(req.getParameter("statenumber")));
		}
		
		
		if(srhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			List<orderDTO> list = memberRepository.getorderList(map);
			req.setAttribute("list", list); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		}
		
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		// 1 = (1/3)*3+1
		startPage = (currentPage / pageBlock) * pageBlock + 1;
		
		if(currentPage % pageBlock == 0) startPage -= pageBlock;
		System.out.println("startPage : " + startPage);
		
		// 마지막페이지
		// 3 = 1 + 3 - 1
		endPage = startPage + pageBlock - 1;
		if(endPage > pageCount) endPage = pageCount;
		System.out.println("endpage : " + endPage);
		
		System.out.println("========================");	 	
	 	
		req.setAttribute("pageSize", pageSize);
		req.setAttribute("cnt", cnt); // 글갯수
		req.setAttribute("mediumsrhCnt", mediumsrhCnt);
		req.setAttribute("bigsrhCnt", bigsrhCnt);
		req.setAttribute("brandsrhCnt", brandsrhCnt);
		req.setAttribute("srhCnt", srhCnt); // 검색한 글갯수
		req.setAttribute("number", number); // 출력용 글번호
		req.setAttribute("pageNum", pageNum); // 페이지번호
		
		if(cnt>0) {
			req.setAttribute("startPage", startPage); // 시작페이지
			req.setAttribute("endPage", endPage); // 마지막 페이지
			req.setAttribute("pageBlock", pageBlock); // 출력할 페이지 갯수
			req.setAttribute("pageCount", pageCount); // 페이지 갯수
			req.setAttribute("currentPage", currentPage); // 현재 페이지
		}
	}

	// 장바구니 추가
	public void cartPro(HttpServletRequest req, Model medel) {
		int prdnum = Integer.parseInt(req.getParameter("num"));
		int colorcode = Integer.parseInt(req.getParameter("colorcode"));
		int sizecode = Integer.parseInt(req.getParameter("sizecode"));
		int count = Integer.parseInt(req.getParameter("count"));
		// 3단계. 입력받은 값을 받아오기
		String strid = (String)req.getSession().getAttribute("memId");
		
		// 3단계. 입력받은 값을 받아와 바구니 담음
		cartDTO dto = new cartDTO();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("strId", strid);
		map.put("member", 0);
		map.put("prdnum", prdnum);
		map.put("colorcode", colorcode);
		map.put("sizecode", sizecode);
		map.put("count", count);
		
		// 5-1단계. 로그인 정보가 있는지 확인
		int selectCnt = memberRepository.idCheck(map);
		int CountChkCnt = memberRepository.countChk(map);
		
		// 5-2단계. 있으면 로그인한 id로 정보 조회
		if(selectCnt == 1 && CountChkCnt >= 0) {
			// db에서 reg_date가 default로 sysdate로 작성해놓았으므로
			// 별도로 지정안할시 sysdate로 적용되고, 지정할 경우 로컬이 우선순위
			dto.setGid((String)req.getSession().getAttribute("memId"));
			dto.setPrdnum(Integer.parseInt(req.getParameter("num")));
			System.out.println(dto.getPrdnum());
			dto.setColorcode(Integer.parseInt(req.getParameter("colorcode")));
			dto.setSizecode(Integer.parseInt(req.getParameter("sizecode")));
			dto.setCount(Integer.parseInt(req.getParameter("count")));
			dto.setPrice(Integer.parseInt(req.getParameter("price")));
			dto.setReg_date(new Timestamp(System.currentTimeMillis()));
		}
		
		int insertCnt = memberRepository.insertcart(dto);
		if(insertCnt != 0) {
			if(req.getParameter("swit") != null && !req.getParameter("swit").equals("")) {
				memberRepository.deletewish(Integer.parseInt(req.getParameter("swit")));
			}
		}
		req.setAttribute("icnt", insertCnt);
		req.setAttribute("scnt", selectCnt);
		req.setAttribute("ucnt", CountChkCnt);
	}

	// 장바구니 목록 리스트
	public void cartlist(HttpServletRequest req, Model medel) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		// 페이징 처리 계산 처리
		int pageSize = 10;  // 한페이지당 출력할 글 갯수
		int pageBlock = 5; // 한 블럭당 페이지 갯수
		
		int cnt = 0; 	   // 글 갯수
		int srhCnt = 0;	   // 검색한 글 갯수
		int brandsrhCnt = 0;	   // 검색한 글 갯수
		int bigsrhCnt = 0;	   // 검색한 글 갯수
		int mediumsrhCnt = 0;	   // 검색한 글 갯수
		int start = 0;	   // 현재페이지 시작 글번호
		int end = 0; 	   // 현재페이지 마지막 글번호
		int number = 0;	   // 출력용 글번호
		String pageNum = ""; // 페이지 번호
		int currentPage = 0; // 현재 페이지
		
		int pageCount = 0; // 페이지 갯수
		int startPage = 0; // 시작 페이지
		int endPage = 0;   // 마지막 페이지
		
		// 5-1단계. 글 갯수 구하기
		srhCnt = memberRepository.getSelectCartCnt((String)req.getSession().getAttribute("memId"));
		cnt = memberRepository.getcartCnt();
		
		// 5-2단계. 페이지 갯수 구하기
		pageNum = req.getParameter("pageNum");
		
		if(pageNum == null) {
			pageNum = "1"; // 첫페이지를 1페이지로 지정
		}
		
		// 글 30건 기준
		
		// 현재 페이지 출력
		currentPage = Integer.parseInt(pageNum); // 현재페이지 : 1
		System.out.println(currentPage);
		
		// 페이지 갯수 6 = 30/5 + 0;
		pageCount = (srhCnt / pageSize) + (srhCnt % pageSize == 0 ? 0 : 1); // 페이지 갯수 + 나머지 있으면 1
		
		// 현재페이지 시작 글번호(페이지별)
		start = (currentPage - 1) * pageSize + 1;
		
		// 현재페이지 마지막 글번호
		end = start + pageSize - 1;
		
		System.out.println("start : " + start);
		System.out.println("end : " + end);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("strId", (String)req.getSession().getAttribute("memId"));
		map.put("start", start);
		map.put("end", end);
		
		if(end > cnt) end = srhCnt;
		
		// 출력용 글번호
		number = cnt - (currentPage - 1) * pageSize;
		
		System.out.println("number : " + number);
		System.out.println("pageSize : " + pageSize);
		
		if(srhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			List<orderDTO> list = memberRepository.getcartList(map);
			req.setAttribute("list", list); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		}
		
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		// 1 = (1/3)*3+1
		startPage = (currentPage / pageBlock) * pageBlock + 1;
		
		if(currentPage % pageBlock == 0) startPage -= pageBlock;
		System.out.println("startPage : " + startPage);
		
		// 마지막페이지
		// 3 = 1 + 3 - 1
		endPage = startPage + pageBlock - 1;
		if(endPage > pageCount) endPage = pageCount;
		System.out.println("endpage : " + endPage);
		
		System.out.println("========================");	 	
	 	
		req.setAttribute("pageSize", pageSize);
		req.setAttribute("cnt", cnt); // 글갯수
		req.setAttribute("mediumsrhCnt", mediumsrhCnt);
		req.setAttribute("bigsrhCnt", bigsrhCnt);
		req.setAttribute("brandsrhCnt", brandsrhCnt);
		req.setAttribute("srhCnt", srhCnt); // 검색한 글갯수
		req.setAttribute("number", number); // 출력용 글번호
		req.setAttribute("pageNum", pageNum); // 페이지번호
		
		if(cnt>0) {
			req.setAttribute("startPage", startPage); // 시작페이지
			req.setAttribute("endPage", endPage); // 마지막 페이지
			req.setAttribute("pageBlock", pageBlock); // 출력할 페이지 갯수
			req.setAttribute("pageCount", pageCount); // 페이지 갯수
			req.setAttribute("currentPage", currentPage); // 현재 페이지
		}
	}

	// 장바구니 삭제
	public void cartdeletePro(HttpServletRequest req, Model medel) {
		// 3단계. 입력받은 값을 받아오기
		
		// 5-1단계. 패스워드 인증
		int deleteCnt = 0;
		
		// 5-2단계. 맞으면 게시글 삭제
		deleteCnt = memberRepository.deletecart(Integer.parseInt(req.getParameter("num")));
		
		// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("dcnt", deleteCnt);
	}

	// 장바구니 모두 삭제
	public void cartalldeletePro(HttpServletRequest req, Model medel) {
		// 3단계. 입력받은 값을 받아오기
		
		// 5-1단계. 패스워드 인증
		int deleteCnt = 0;
		
		// 5-2단계. 맞으면 게시글 삭제
		deleteCnt = memberRepository.deleteallcart((String)req.getSession().getAttribute("memId"));
		
		// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("dcnt", deleteCnt);
	}

	// 마일리지 리스트
	public void mileagelist(HttpServletRequest req, Model medel) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		// 페이징 처리 계산 처리
		int pageSize = 10;  // 한페이지당 출력할 글 갯수
		int pageBlock = 5; // 한 블럭당 페이지 갯수
		
		int cnt = 0; 	   // 글 갯수
		int srhCnt = 0;	   // 검색한 글 갯수
		int brandsrhCnt = 0;	   // 검색한 글 갯수
		int bigsrhCnt = 0;	   // 검색한 글 갯수
		int mediumsrhCnt = 0;	   // 검색한 글 갯수
		int start = 0;	   // 현재페이지 시작 글번호
		int end = 0; 	   // 현재페이지 마지막 글번호
		int number = 0;	   // 출력용 글번호
		String pageNum = ""; // 페이지 번호
		int currentPage = 0; // 현재 페이지
		
		int pageCount = 0; // 페이지 갯수
		int startPage = 0; // 시작 페이지
		int endPage = 0;   // 마지막 페이지
		String state = "";
		Date firstday = null;
		Date lastday = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 검색하기 위한 조건들
		if(req.getParameter("firstday") != null && req.getParameter("lastday") != null) {
			firstday = Date.valueOf(req.getParameter("firstday"));
			lastday = Date.valueOf(req.getParameter("lastday"));
		}
		map.put("firstday", firstday);
		map.put("lastday", lastday);
		System.out.println("srchTdae" + req.getParameter("firstday"));
		System.out.println("srchdaye" + req.getParameter("lastday"));
		if(req.getParameter("state") != null) {
			state = req.getParameter("state");
			System.out.println("state" + state);
		}
		map.put("state", state);
		map.put("strid", (String)req.getSession().getAttribute("memId"));
		
		// 5-1단계. 글 갯수 구하기
		srhCnt = memberRepository.getSelectOrderCnt(map);
		cnt = memberRepository.getorderCnt();
		
		// 5-2단계. 페이지 갯수 구하기
		pageNum = req.getParameter("pageNum");
		
		if(pageNum == null) {
			pageNum = "1"; // 첫페이지를 1페이지로 지정
		}
		
		// 글 30건 기준
		
		// 현재 페이지 출력
		currentPage = Integer.parseInt(pageNum); // 현재페이지 : 1
		System.out.println(currentPage);
		
		// 페이지 갯수 6 = 30/5 + 0;
		pageCount = (srhCnt / pageSize) + (srhCnt % pageSize == 0 ? 0 : 1); // 페이지 갯수 + 나머지 있으면 1
		
		// 현재페이지 시작 글번호(페이지별)
		start = (currentPage - 1) * pageSize + 1;
		
		// 현재페이지 마지막 글번호
		end = start + pageSize - 1;
		
		System.out.println("start : " + start);
		System.out.println("end : " + end);
		map.put("start", start);
		map.put("end", end);
		
		if(end > cnt) end = srhCnt;
		
		// 출력용 글번호
		number = cnt - (currentPage - 1) * pageSize;
		
		System.out.println("number : " + number);
		System.out.println("pageSize : " + pageSize);
		
		
		if(srhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			List<orderDTO> list = memberRepository.getplusList(map);
			req.setAttribute("list", list); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
			MemberDTO dto = memberRepository.getMemberInfo((String)req.getSession().getAttribute("memId"));
			req.setAttribute("myplus", dto.getPlus());
			int refundplus = memberRepository.getrefundplus((String)req.getSession().getAttribute("memId"));
			req.setAttribute("refundplus", refundplus);
		}
		
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		// 1 = (1/3)*3+1
		startPage = (currentPage / pageBlock) * pageBlock + 1;
		
		if(currentPage % pageBlock == 0) startPage -= pageBlock;
		System.out.println("startPage : " + startPage);
		
		// 마지막페이지
		// 3 = 1 + 3 - 1
		endPage = startPage + pageBlock - 1;
		if(endPage > pageCount) endPage = pageCount;
		System.out.println("endpage : " + endPage);
		
		System.out.println("========================");	 	
	 	
		req.setAttribute("pageSize", pageSize);
		req.setAttribute("cnt", cnt); // 글갯수
		req.setAttribute("mediumsrhCnt", mediumsrhCnt);
		req.setAttribute("bigsrhCnt", bigsrhCnt);
		req.setAttribute("brandsrhCnt", brandsrhCnt);
		req.setAttribute("srhCnt", srhCnt); // 검색한 글갯수
		req.setAttribute("number", number); // 출력용 글번호
		req.setAttribute("pageNum", pageNum); // 페이지번호
		
		if(cnt>0) {
			req.setAttribute("startPage", startPage); // 시작페이지
			req.setAttribute("endPage", endPage); // 마지막 페이지
			req.setAttribute("pageBlock", pageBlock); // 출력할 페이지 갯수
			req.setAttribute("pageCount", pageCount); // 페이지 갯수
			req.setAttribute("currentPage", currentPage); // 현재 페이지
		}
	}

	// 마이페이지 리스트
	public void mypagelist(HttpServletRequest req, Model medel) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("firstday", null);
		map.put("lastday", null);
		map.put("state", null);
		map.put("strId", (String)req.getSession().getAttribute("memId"));
		map.put("state", "입금전");
		
		// 5-2단계. 게시글 목록 조회
		int srhCnt = memberRepository.getSelectOrderCnt(map);
		int beforeCnt = memberRepository.selectstateCnt(map);
		map.put("state", "배송준비중");
		int delistartCnt = memberRepository.selectstateCnt(map);
		map.put("state", "배송중");
		int delingCnt = memberRepository.selectstateCnt(map);
		map.put("state", "배송완료");
		int deliendCnt = memberRepository.selectstateCnt(map);
		map.put("state", "주문취소");
		int cancelCnt = memberRepository.selectstateCnt(map);
		map.put("state", "환불완료");
		int refundendCnt = memberRepository.selectstateCnt(map);
		if(srhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			map.put("start", 0);
			map.put("end", srhCnt);
			List<orderDTO> list = memberRepository.getorderList(map);
			req.setAttribute("list", list); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
			MemberDTO dto = memberRepository.getMemberInfo((String)req.getSession().getAttribute("memId"));
			req.setAttribute("myplus", dto.getPlus());
			int refundplus = memberRepository.getrefundplus((String)req.getSession().getAttribute("memId"));
			req.setAttribute("refundplus", refundplus);
		}
		
		req.setAttribute("srhCnt", srhCnt);
		req.setAttribute("becnt", beforeCnt);
		req.setAttribute("dscnt", delistartCnt);
		req.setAttribute("dicnt", delingCnt);
		req.setAttribute("decnt", deliendCnt);
		req.setAttribute("ccnt", cancelCnt);
		req.setAttribute("rcnt", refundendCnt);
		
	}

	// 회원 목록
	public void memberlist(HttpServletRequest req, Model medel) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		// 페이징 처리 계산 처리
		int pageSize = 10;  // 한페이지당 출력할 글 갯수
		int pageBlock = 5; // 한 블럭당 페이지 갯수
		
		int cnt = 0; 	   // 글 갯수
		int srhCnt = 0;	   // 검색한 글 갯수
		int brandsrhCnt = 0;	   // 검색한 글 갯수
		int bigsrhCnt = 0;	   // 검색한 글 갯수
		int mediumsrhCnt = 0;	   // 검색한 글 갯수
		int start = 0;	   // 현재페이지 시작 글번호
		int end = 0; 	   // 현재페이지 마지막 글번호
		int number = 0;	   // 출력용 글번호
		String pageNum = ""; // 페이지 번호
		int currentPage = 0; // 현재 페이지
		
		int pageCount = 0; // 페이지 갯수
		int startPage = 0; // 시작 페이지
		int endPage = 0;   // 마지막 페이지
		Date firstday = null;
		Date lastday = null;
		int searchType = 0;
		String searchText = "";
		String month = "";
		int pluspay = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 검색하기 위한 조건들
		if(req.getParameter("firstday") != null && req.getParameter("lastday") != null) {
			firstday = Date.valueOf(req.getParameter("firstday"));
			lastday = Date.valueOf(req.getParameter("lastday"));
		}
		System.out.println("srchTdae" + req.getParameter("firstday"));
		System.out.println("srchdaye" + req.getParameter("lastday"));
		if(req.getParameter("searchType") != null) {
			searchType = Integer.parseInt(req.getParameter("searchType"));
			System.out.println("srchType" + searchType);
		}
		if(req.getParameter("srch") != null) {
			searchText = req.getParameter("srch");
			System.out.println("srchtext" + searchText);
		}
		map.put("firstday", firstday);
		map.put("lastday", lastday);
		map.put("searchType", searchType);
		map.put("searchText", searchText);
		map.put("month", month);
		map.put("pluspay", pluspay);
		
		// 5-1단계. 글 갯수 구하기
		srhCnt = memberRepository.getSelectmemberCnt(map);
		cnt = memberRepository.getmemberCnt();
		
		// 5-2단계. 페이지 갯수 구하기
		pageNum = req.getParameter("pageNum");
		
		if(pageNum == null) {
			pageNum = "1"; // 첫페이지를 1페이지로 지정
		}
		
		// 글 30건 기준
		
		// 현재 페이지 출력
		currentPage = Integer.parseInt(pageNum); // 현재페이지 : 1
		System.out.println(currentPage);
		
		// 페이지 갯수 6 = 30/5 + 0;
		pageCount = (srhCnt / pageSize) + (srhCnt % pageSize == 0 ? 0 : 1); // 페이지 갯수 + 나머지 있으면 1
		
		// 현재페이지 시작 글번호(페이지별)
		start = (currentPage - 1) * pageSize + 1;
		
		// 현재페이지 마지막 글번호
		end = start + pageSize - 1;
		
		System.out.println("start : " + start);
		System.out.println("end : " + end);
		Map<String, Object> semap = new HashMap<String, Object>();
		semap.put("start", start);
		semap.put("end", end);
		
		if(end > cnt) end = srhCnt;
		
		// 출력용 글번호
		number = cnt - (currentPage - 1) * pageSize;
		
		System.out.println("number : " + number);
		System.out.println("pageSize : " + pageSize);
		
		if(srhCnt > 0) {
			// 5-2단계. 있으면 로그인한 id로 정보 조회
			List<MemberDTO> list = memberRepository.getMemberlist(semap);
			req.setAttribute("list", list);
		}
		
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		// 1 = (1/3)*3+1
		startPage = (currentPage / pageBlock) * pageBlock + 1;
		
		if(currentPage % pageBlock == 0) startPage -= pageBlock;
		System.out.println("startPage : " + startPage);
		
		// 마지막페이지
		// 3 = 1 + 3 - 1
		endPage = startPage + pageBlock - 1;
		if(endPage > pageCount) endPage = pageCount;
		System.out.println("endpage : " + endPage);
		
		System.out.println("========================");	 	
	 	
		req.setAttribute("pageSize", pageSize);
		req.setAttribute("cnt", cnt); // 글갯수
		req.setAttribute("mediumsrhCnt", mediumsrhCnt);
		req.setAttribute("bigsrhCnt", bigsrhCnt);
		req.setAttribute("brandsrhCnt", brandsrhCnt);
		req.setAttribute("srhCnt", srhCnt); // 검색한 글갯수
		req.setAttribute("number", number); // 출력용 글번호
		req.setAttribute("pageNum", pageNum); // 페이지번호
		
		if(cnt>0) {
			req.setAttribute("startPage", startPage); // 시작페이지
			req.setAttribute("endPage", endPage); // 마지막 페이지
			req.setAttribute("pageBlock", pageBlock); // 출력할 페이지 갯수
			req.setAttribute("pageCount", pageCount); // 페이지 갯수
			req.setAttribute("currentPage", currentPage); // 현재 페이지
		}
	}
	

	// 회원 수정
	public void memberForm(HttpServletRequest req, Model medel) {
		String strid = req.getParameter("id");
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("firstday", null);
		map.put("lastday", null);
		map.put("state", null);
		map.put("strId", strid);
		map.put("state", "배송준비중");
		
		// 5-2단계. 게시글 목록 조회
		int delistartCnt = memberRepository.selectstateCnt(map);
		map.put("state", "배송중");
		int delingCnt = memberRepository.selectstateCnt(map);
		map.put("state", "배송완료");
		int deliendCnt = memberRepository.selectstateCnt(map);
		map.put("state", "환불완료");
		int refundendCnt = memberRepository.selectstateCnt(map);
		map.put("state", "환불신청");
		int refundingCnt = memberRepository.selectstateCnt(map);
		
		// 5-2단계. 게시글 목록 조회
		int orderCnt = memberRepository.getSelectOrderCnt(map);
		req.setAttribute("orderCnt", orderCnt); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		// QnA
		Map<String, Object> QnAmap = new HashMap<String, Object>();
		QnAmap.put("state", null);
		QnAmap.put("firstday", null);
		QnAmap.put("lastday", null);
		QnAmap.put("searchType", 0);
		QnAmap.put("searchText", null);
		QnAmap.put("strId", strid);
		
		int qnaCnt = memberRepository.getSelectQnACnt(map);
		req.setAttribute("qnaCnt", qnaCnt);
		
		// reviewCnt
		Map<String, Object> remap = new HashMap<String, Object>();
		map.put("firstday", null);
		map.put("lastday", null);
		map.put("searchType", 0);
		map.put("searchText", null);
		map.put("strId", strid);
		int reviewCnt = memberRepository.getSelectreviewCnt(map);
		req.setAttribute("reviewCnt", reviewCnt);
		MemberDTO dto = memberRepository.getMemberInfo(strid);
		req.setAttribute("vo", dto);
		
		req.setAttribute("dscnt", delistartCnt);
		req.setAttribute("dicnt", delingCnt);
		req.setAttribute("decnt", deliendCnt);
		req.setAttribute("recnt", refundendCnt);
		req.setAttribute("ricnt", refundingCnt);
		req.setAttribute("pageNum", req.getParameter("pageNum"));
		
	}

	// 회원 수정 처리
	public void h_memberPro(HttpServletRequest req, Model medel) {
		String hostmemo = req.getParameter("hostmemo");
		String strid = req.getParameter("id");
		String pageNum = req.getParameter("pageNum");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("hostmemo", hostmemo);
		map.put("strId", strid);
		
		int updateCnt = memberRepository.updatehostmemoMember(map);
		
		req.setAttribute("ucnt", updateCnt);
		req.setAttribute("pageNum", pageNum);
	}
	
	// 회원 강탈
	public void h_deletePro(HttpServletRequest req, Model medel) {
		// 3단계. 입력받은 값을 받아오기
		String strid = req.getParameter("id");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("strId", strid);
		map.put("member", 0);
		
		// 5-1단계. 로그인 정보가 있는지 확인
		int selectCnt = memberRepository.idCheck(map);
		int deleteCnt = 0;
		
		// 5-2단계. 있으면 로그인한 id로 삭제
		if(selectCnt == 1) {
			deleteCnt = memberRepository.deleteMember(strid);
		}
		// 5단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("scnt", selectCnt);
		req.setAttribute("dcnt", deleteCnt);
		req.setAttribute("pageNum", req.getParameter("pageNum"));
	}

	// 관리자 주문 목록 리스트
	public void h_orderlist(HttpServletRequest req, Model medel) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		// 페이징 처리 계산 처리
		int pageSize = 10;  // 한페이지당 출력할 글 갯수
		int pageBlock = 5; // 한 블럭당 페이지 갯수
		
		int cnt = 0; 	   // 글 갯수
		int srhCnt = 0;	   // 검색한 글 갯수
		int start = 0;	   // 현재페이지 시작 글번호
		int end = 0; 	   // 현재페이지 마지막 글번호
		int number = 0;	   // 출력용 글번호
		String pageNum = ""; // 페이지 번호
		int currentPage = 0; // 현재 페이지
		
		int pageCount = 0; // 페이지 갯수
		int startPage = 0; // 시작 페이지
		int endPage = 0;   // 마지막 페이지
		String state = "";
		Date firstday = null;
		Date lastday = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 검색하기 위한 조건들
		if(req.getParameter("firstday") != null && req.getParameter("lastday") != null) {
			firstday = Date.valueOf(req.getParameter("firstday"));
			lastday = Date.valueOf(req.getParameter("lastday"));
		}
		map.put("firstday", firstday);
		map.put("lastday", lastday);
		System.out.println("srchTdae" + req.getParameter("firstday"));
		System.out.println("srchdaye" + req.getParameter("lastday"));
		if(req.getParameter("state") != null) {
			state = req.getParameter("state");
			System.out.println("state" + state);
		}
		map.put("state", state);
		map.put("strId", null);
		
		if(req.getParameter("ordernum") != null && req.getParameter("ordernum") != "" 
				&& req.getParameter("orderstate") != null && req.getParameter("orderstate") != ""
				&& req.getParameter("gid") != null && req.getParameter("gid") != ""
				&& req.getParameter("prdnum") != null && req.getParameter("prdnum") != "") {
				Map<String, Object> sumap = new HashMap<String, Object>();
				sumap.put("ordernum", Integer.parseInt(req.getParameter("ordernum")));
				sumap.put("orderstate", req.getParameter("orderstate"));
				sumap.put("gid", req.getParameter("gid"));
				sumap.put("prdnum", Integer.parseInt(req.getParameter("prdnum")));
				int stateswitch = memberRepository.h_updatestate(sumap);
		}
		// 5-1단계. 글 갯수 구하기
		srhCnt = memberRepository.getSelectOrderCnt(map);
		cnt = memberRepository.getorderCnt();
		
		// 5-2단계. 페이지 갯수 구하기
		pageNum = req.getParameter("pageNum");
		
		if(pageNum == null) {
			pageNum = "1"; // 첫페이지를 1페이지로 지정
		}
		
		// 글 30건 기준
		
		// 현재 페이지 출력
		currentPage = Integer.parseInt(pageNum); // 현재페이지 : 1
		System.out.println(currentPage);
		
		// 페이지 갯수 6 = 30/5 + 0;
		pageCount = (srhCnt / pageSize) + (srhCnt % pageSize == 0 ? 0 : 1); // 페이지 갯수 + 나머지 있으면 1
		
		// 현재페이지 시작 글번호(페이지별)
		start = (currentPage - 1) * pageSize + 1;
		
		// 현재페이지 마지막 글번호
		end = start + pageSize - 1;
		
		System.out.println("start : " + start);
		System.out.println("end : " + end);
		map.put("start", start);
		map.put("end", end);
		
		if(end > cnt) end = srhCnt;
		
		// 출력용 글번호
		number = cnt - (currentPage - 1) * pageSize;
		
		System.out.println("number : " + number);
		System.out.println("pageSize : " + pageSize);
		
		
		if(srhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			List<orderDTO> list = memberRepository.getorderList(map);
			req.setAttribute("list", list); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		}
		
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		// 1 = (1/3)*3+1
		startPage = (currentPage / pageBlock) * pageBlock + 1;
		
		if(currentPage % pageBlock == 0) startPage -= pageBlock;
		System.out.println("startPage : " + startPage);
		
		// 마지막페이지
		// 3 = 1 + 3 - 1
		endPage = startPage + pageBlock - 1;
		if(endPage > pageCount) endPage = pageCount;
		System.out.println("endpage : " + endPage);
		
		System.out.println("========================");	 	
	 	
		req.setAttribute("pageSize", pageSize);
		req.setAttribute("cnt", cnt); // 글갯수
		req.setAttribute("srhCnt", srhCnt); // 검색한 글갯수
		req.setAttribute("number", number); // 출력용 글번호
		req.setAttribute("pageNum", pageNum); // 페이지번호
		
		if(cnt>0) {
			req.setAttribute("startPage", startPage); // 시작페이지
			req.setAttribute("endPage", endPage); // 마지막 페이지
			req.setAttribute("pageBlock", pageBlock); // 출력할 페이지 갯수
			req.setAttribute("pageCount", pageCount); // 페이지 갯수
			req.setAttribute("currentPage", currentPage); // 현재 페이지
		}
	}

	// 방문자 토탈
	public void clicktotal(HttpServletRequest req, Model medel) {
		String year = null;
		
		year = req.getParameter("yearname");
		
		if(year == null) {
			year = "2023";
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("year", year);
		
		int[] clicktotal = memberRepository.getclicktotal(map);
		
		req.setAttribute("clicktotal", clicktotal);
		
	}

	// 신규멤버
	public void newmembertotal(HttpServletRequest req, Model medel) {
		String year = null;
		
		year = req.getParameter("yearname");
		
		if(year == null) {
			year = "2023";
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("year", year);
		
		int[] newmembertotal = memberRepository.getnewmembertotal(map);
		
		req.setAttribute("newtotal", newmembertotal);
	}

	// 주문 통합
	public void ordertotal(HttpServletRequest req, Model medel) {
		String year = null;
		
		year = req.getParameter("yearname");
		
		if(year == null) {
			year = "2023";
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("year", year);
		
		int[] oredermembertotal = memberRepository.getordermembertotal(map);
		int[] orederCnttotal = memberRepository.getorderCnttotal(map);
		int[] orederpricetotal = memberRepository.getorderpricetotal(map);
		
		req.setAttribute("omtotal", oredermembertotal);
		req.setAttribute("octotal", orederCnttotal);
		req.setAttribute("optotal", orederpricetotal);
	}

	// 판매 토탈
	public void saletotal(HttpServletRequest req, Model medel) {
		String year = null;
		
		year = req.getParameter("yearname");
		
		if(year == null) {
			year = "2023";
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("year", year);
		
		int[] orederCnttotal = memberRepository.getorderCnttotal(map);
		int[] orederpricetotal = memberRepository.getorderpricetotal(map);
		int[] orederrealpricetotal = memberRepository.getorderrealpricetotal(map);
		int[] orederrefundtotal = memberRepository.getorderrefundtotal(map);
		
		req.setAttribute("octotal", orederCnttotal);
		req.setAttribute("optotal", orederpricetotal);
		req.setAttribute("orptotal", orederrealpricetotal);
		req.setAttribute("ortotal", orederrefundtotal);
		
	}

	// 카테고리 순위
	public void category(HttpServletRequest req, Model medel) {
		String year = null;
		int number = 1;	   // 출력용 글번호	
		
		year = req.getParameter("yearname");
		
		if(year == null) {
			year = "2023";
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("year", year);
		
		List<CategoryDTO> list = memberRepository.getCategoryrank(map);
		
		req.setAttribute("list", list);
		req.setAttribute("number", number); // 출력용 글번호
	}

	// 판매순위
	public void salerank(HttpServletRequest req, Model medel) {
		String year = null;
		int number = 1;	   // 출력용 글번호	
		
		year = req.getParameter("yearname");
		
		if(year == null) {
			year = "2023";
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("year", year);
		
		List<SalerankDTO> list = memberRepository.getSalerank(map);
		
		req.setAttribute("list", list);
		req.setAttribute("number", number); // 출력용 글번호
	}

	// 적립금 순위
	public void pluspay(HttpServletRequest req, Model medel) {
		int number = 1;	   // 출력용 글번호	
		
		
		List<PluspayDTO> list = memberRepository.getPluspay();
		
		req.setAttribute("list", list);
		req.setAttribute("number", number); // 출력용 글번호
	}
	
	// 관리자 메인
	public void hostmain(HttpServletRequest req, Model medel) {
		// 4단계. 다형성 적용, 싱글톤 방식으로 memberRepository 객체 생성
		int monthorederCnttotal = memberRepository.getmonthorderCnttotal();
		int monthorederrealpricetotal = memberRepository.getmonthorderrealpricetotal();
		
		int dayorederCnttotal = memberRepository.getdayorderCnttotal();
		int todayorederrealprice = memberRepository.getdayorderrealpricetotal();
		int daycancelCnttotal = memberRepository.getdaycancelCnttotal();
		int todayclicktotal = memberRepository.getdayclicktotal();
		int todayQnACnt = memberRepository.selectQnACnt();
		int todaynewmemberCnt = memberRepository.selectnewmember();

		int[] orederpricetotal = new int[8];
		int[] payendCnt = new int[8];
		int[] delistartCnt = new int[8];
		int[] delingCnt = new int[8];
		int[] deliendCnt = new int[8];
		int[] cancelCnt = new int[8];
		int[] reviewCnt = new int[8];
		
		for(int i = 0; i < 7; i++) {
			orederpricetotal[i] = memberRepository.getweekpricetotal(i);
			payendCnt[i] = memberRepository.selectPayendCnt(i);
			delistartCnt[i] = memberRepository.selectDeliStartCnt(i);
			delingCnt[i] = memberRepository.selectDeliingCnt(i);
			deliendCnt[i] = memberRepository.selectDeliEndCnt(i);
			cancelCnt[i] = memberRepository.selectCancelCnt(i);
			reviewCnt[i] = memberRepository.selectReviewCnt(i);
		}
		
		orederpricetotal[7] = memberRepository.getweekpricetotalMax();
		payendCnt[7] = memberRepository.selectMaxPayendCnt();
		delistartCnt[7] = memberRepository.selectMaxDeliStartCnt();
		delingCnt[7] = memberRepository.selectMaxDeliingCnt();
		deliendCnt[7] = memberRepository.selectMaxDeliEndCnt();
		cancelCnt[7] = memberRepository.selectMaxCancelCnt();
		reviewCnt[7] = memberRepository.selectMaxReviewCnt();
		
		int[] day = new int[7];
		int[] month = new int[7];
		String[] year = new String[2];
		java.util.Date date = new java.util.Date(); 
		day[0] = date.getDate();
		month[0] = date.getMonth()+1;
		year[0] = date.toLocaleString().substring(0, 4);
		for(int i = 1; i<7; i++) {
			date.setDate(date.getDate() - 1);
			day[i] = date.getDate();
			month[i] = date.getMonth()+1;
		}
		year[1] = date.toLocaleString().substring(0, 4);
		
		req.setAttribute("day", day);
		req.setAttribute("month", month);
		req.setAttribute("year", year);
		
		req.setAttribute("monthorederCnttotal", monthorederCnttotal);
		req.setAttribute("monthorederrealpricetotal", monthorederrealpricetotal);
		
		req.setAttribute("dayorederCnttotal", dayorederCnttotal);
		req.setAttribute("todayorederrealprice", todayorederrealprice);
		req.setAttribute("daycancelCnttotal", daycancelCnttotal);
		req.setAttribute("todayclicktotal", todayclicktotal);
		req.setAttribute("todayQnACnt", todayQnACnt);
		req.setAttribute("todaynewmemberCnt", todaynewmemberCnt);
		
		req.setAttribute("orederpricetotal", orederpricetotal);
		req.setAttribute("payendCnt", payendCnt);
		req.setAttribute("delistartCnt", delistartCnt);
		req.setAttribute("delingCnt", delingCnt);
		req.setAttribute("deliendCnt", deliendCnt);
		req.setAttribute("cancelCnt", cancelCnt);
		req.setAttribute("reviewCnt", reviewCnt);
	}

	// 내 게시물
	public void myboard(HttpServletRequest req, Model medel) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		// 페이징 처리 계산 처리
		int pageSize = 0;  // 한페이지당 출력할 글 갯수
		int pageBlock = 5; // 한 블럭당 페이지 갯수
		
		int cnt = 0; 	   // 글 갯수
		int srhCnt = 0;	   // 검색한 글 갯수
		int start = 0;	   // 현재페이지 시작 글번호
		int end = 0; 	   // 현재페이지 마지막 글번호
		int number = 0;	   // 출력용 글번호
		String pageNum = ""; // 페이지 번호
		int currentPage = 0; // 현재 페이지
		
		int pageCount = 0; // 페이지 갯수
		int startPage = 0; // 시작 페이지
		int endPage = 0;   // 마지막 페이지
		String strid = (String)req.getSession().getAttribute("memId");
		int searchType = 0;
		String searchText = "";
		
		// 검색하기 위한 조건들
		if(req.getParameter("searchType") != null) {
			searchType = Integer.parseInt(req.getParameter("searchType"));
			System.out.println("srchType" + searchType);
		}
		if(req.getParameter("srch") != null) {
			searchText = req.getParameter("srch");
			System.out.println("srchtext" + searchText);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchType", searchType);
		map.put("searchText", searchText);
		map.put("strId", strid);
		
		// 5-1단계. 글 갯수 구하기
		srhCnt = memberRepository.getSelectMyBoardCnt(map);
		cnt = memberRepository.getMyBoardCnt(strid);
		
		// 5-2단계. 페이지 갯수 구하기
		pageNum = req.getParameter("pageNum");
		
		// 페이지 사이즈 구하기
		if(req.getParameter("pageSize") == null) {
			pageSize = 10;
		} else {
			pageSize = Integer.parseInt(req.getParameter("pageSize"));
		}
		
		if(pageNum == null) {
			pageNum = "1"; // 첫페이지를 1페이지로 지정
		}
		
		// 글 30건 기준
		
		// 현재 페이지 출력
		currentPage = Integer.parseInt(pageNum); // 현재페이지 : 1
		System.out.println(currentPage);
		
		// 페이지 갯수 6 = 30/5 + 0;
		pageCount = (srhCnt / pageSize) + (srhCnt % pageSize == 0 ? 0 : 1); // 페이지 갯수 + 나머지 있으면 1
		
		// 현재페이지 시작 글번호(페이지별)
		start = (currentPage - 1) * pageSize + 1;
		
		// 현재페이지 마지막 글번호
		end = start + pageSize - 1;
		
		System.out.println("start : " + start);
		System.out.println("end : " + end);
		map.put("start", start);
		map.put("end", end);
		
		if(end > cnt) end = srhCnt;
		
		// 출력용 글번호
		number = cnt - (currentPage - 1) * pageSize;
		
		System.out.println("number : " + number);
		System.out.println("pageSize : " + pageSize);
		
		if(srhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			List<MyBoardDTO> list = memberRepository.myboard(map);
			req.setAttribute("list", list); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		}
		
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		// 1 = (1/3)*3+1
		startPage = (currentPage / pageBlock) * pageBlock + 1;
		
		if(currentPage % pageBlock == 0) startPage -= pageBlock;
		System.out.println("startPage : " + startPage);
		
		// 마지막페이지
		// 3 = 1 + 3 - 1
		endPage = startPage + pageBlock - 1;
		if(endPage > pageCount) endPage = pageCount;
		System.out.println("endpage : " + endPage);
		
		System.out.println("========================");
		
		req.setAttribute("pageSize", pageSize);
		req.setAttribute("cnt", cnt); // 글갯수
		req.setAttribute("srhCnt", srhCnt); // 검색한 글갯수
		req.setAttribute("number", number); // 출력용 글번호
		req.setAttribute("pageNum", pageNum); // 페이지번호
		req.setAttribute("schType", searchType); // 타입
		
		if(cnt>0) {
			req.setAttribute("startPage", startPage); // 시작페이지
			req.setAttribute("endPage", endPage); // 마지막 페이지
			req.setAttribute("pageBlock", pageBlock); // 출력할 페이지 갯수
			req.setAttribute("pageCount", pageCount); // 페이지 갯수
			req.setAttribute("currentPage", currentPage); // 현재 페이지
		}
		
	}

	// 찜하기 추가
	public void wishlistPro(HttpServletRequest req, Model medel) {
		int prdnum = Integer.parseInt(req.getParameter("num"));
		int colorcode = Integer.parseInt(req.getParameter("colorcode"));
		int sizecode = Integer.parseInt(req.getParameter("sizecode"));
		int count = Integer.parseInt(req.getParameter("count"));
		// 3단계. 입력받은 값을 받아오기
		String strid = (String)req.getSession().getAttribute("memId");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("strId", strid);
		map.put("member", 0);
		
		map.put("prdnum", prdnum);
		map.put("colorcode", colorcode);
		map.put("sizecode", sizecode);
		map.put("count", count);
		
		// 3단계. 입력받은 값을 받아와 바구니 담음
		wishDTO dto = new wishDTO();
		
		// 5-1단계. 로그인 정보가 있는지 확인
		int selectCnt = memberRepository.idCheck(map);
		int CountChkCnt = memberRepository.countChk(map);
		
		// 5-2단계. 있으면 로그인한 id로 정보 조회
		if(selectCnt == 1 && CountChkCnt >= 0) {
			// db에서 reg_date가 default로 sysdate로 작성해놓았으므로
			// 별도로 지정안할시 sysdate로 적용되고, 지정할 경우 로컬이 우선순위
			dto.setGid((String)req.getSession().getAttribute("memId"));
			dto.setPrdnum(Integer.parseInt(req.getParameter("num")));
			System.out.println(dto.getPrdnum());
			dto.setColorcode(Integer.parseInt(req.getParameter("colorcode")));
			dto.setSizecode(Integer.parseInt(req.getParameter("sizecode")));
			dto.setCount(Integer.parseInt(req.getParameter("count")));
			dto.setPrice(Integer.parseInt(req.getParameter("price")));
			dto.setReg_date(new Timestamp(System.currentTimeMillis()));
		}
		
		int insertCnt = memberRepository.insertwish(dto);
		if(insertCnt != 0) {
			if(req.getParameter("swit") != null) {
				memberRepository.deletecart(Integer.parseInt(req.getParameter("swit")));
			}
		}
		req.setAttribute("icnt", insertCnt);
		req.setAttribute("scnt", selectCnt);
		req.setAttribute("ucnt", CountChkCnt);
	}

	// 찜하기 목록 리스트
	public void wishlist(HttpServletRequest req, Model medel) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		// 페이징 처리 계산 처리
		int pageSize = 10;  // 한페이지당 출력할 글 갯수
		int pageBlock = 5; // 한 블럭당 페이지 갯수
		
		int cnt = 0; 	   // 글 갯수
		int srhCnt = 0;	   // 검색한 글 갯수
		int brandsrhCnt = 0;	   // 검색한 글 갯수
		int bigsrhCnt = 0;	   // 검색한 글 갯수
		int mediumsrhCnt = 0;	   // 검색한 글 갯수
		int start = 0;	   // 현재페이지 시작 글번호
		int end = 0; 	   // 현재페이지 마지막 글번호
		int number = 0;	   // 출력용 글번호
		String pageNum = ""; // 페이지 번호
		int currentPage = 0; // 현재 페이지
		
		int pageCount = 0; // 페이지 갯수
		int startPage = 0; // 시작 페이지
		int endPage = 0;   // 마지막 페이지
		
		// 5-1단계. 글 갯수 구하기
		srhCnt = memberRepository.getSelectWishCnt((String)req.getSession().getAttribute("memId"));
		cnt = memberRepository.getWishCnt();
		
		// 5-2단계. 페이지 갯수 구하기
		pageNum = req.getParameter("pageNum");
		
		if(pageNum == null) {
			pageNum = "1"; // 첫페이지를 1페이지로 지정
		}
		
		// 글 30건 기준
		
		// 현재 페이지 출력
		currentPage = Integer.parseInt(pageNum); // 현재페이지 : 1
		System.out.println(currentPage);
		
		// 페이지 갯수 6 = 30/5 + 0;
		pageCount = (srhCnt / pageSize) + (srhCnt % pageSize == 0 ? 0 : 1); // 페이지 갯수 + 나머지 있으면 1
		
		// 현재페이지 시작 글번호(페이지별)
		start = (currentPage - 1) * pageSize + 1;
		
		// 현재페이지 마지막 글번호
		end = start + pageSize - 1;
		
		System.out.println("start : " + start);
		System.out.println("end : " + end);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("strId", (String)req.getSession().getAttribute("memId"));
		map.put("start", start);
		map.put("end", end);
		
		if(end > cnt) end = srhCnt;
		
		// 출력용 글번호
		number = cnt - (currentPage - 1) * pageSize;
		
		System.out.println("number : " + number);
		System.out.println("pageSize : " + pageSize);
		
		if(srhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			List<orderDTO> list = memberRepository.getwishList(map);
			req.setAttribute("list", list); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		}
		
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		// 1 = (1/3)*3+1
		startPage = (currentPage / pageBlock) * pageBlock + 1;
		
		if(currentPage % pageBlock == 0) startPage -= pageBlock;
		System.out.println("startPage : " + startPage);
		
		// 마지막페이지
		// 3 = 1 + 3 - 1
		endPage = startPage + pageBlock - 1;
		if(endPage > pageCount) endPage = pageCount;
		System.out.println("endpage : " + endPage);
		
		System.out.println("========================");	 	
	 	
		req.setAttribute("pageSize", pageSize);
		req.setAttribute("cnt", cnt); // 글갯수
		req.setAttribute("mediumsrhCnt", mediumsrhCnt);
		req.setAttribute("bigsrhCnt", bigsrhCnt);
		req.setAttribute("brandsrhCnt", brandsrhCnt);
		req.setAttribute("srhCnt", srhCnt); // 검색한 글갯수
		req.setAttribute("number", number); // 출력용 글번호
		req.setAttribute("pageNum", pageNum); // 페이지번호
		
		if(cnt>0) {
			req.setAttribute("startPage", startPage); // 시작페이지
			req.setAttribute("endPage", endPage); // 마지막 페이지
			req.setAttribute("pageBlock", pageBlock); // 출력할 페이지 갯수
			req.setAttribute("pageCount", pageCount); // 페이지 갯수
			req.setAttribute("currentPage", currentPage); // 현재 페이지
		}
	}

	// 찜하기 삭제
	public void wishlistdeletePro(HttpServletRequest req, Model medel) {
		// 3단계. 입력받은 값을 받아오기
		
		// 5-1단계. 패스워드 인증
		int deleteCnt = 0;
		
		// 5-2단계. 맞으면 게시글 삭제
		deleteCnt = memberRepository.deletewish(Integer.parseInt(req.getParameter("num")));
		
		// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("dcnt", deleteCnt);
	}

	// 찜하기 모두 삭제
	public void wishlistalldeletePro(HttpServletRequest req, Model medel) {
		// 3단계. 입력받은 값을 받아오기
		
		// 5-1단계. 패스워드 인증
		int deleteCnt = 0;
		
		// 5-2단계. 맞으면 게시글 삭제
		deleteCnt = memberRepository.deleteallwish((String)req.getSession().getAttribute("memId"));
		
		// 6단계. request나 session에 처리결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("dcnt", deleteCnt);
	}

	// 검색 리스트 조회
	public void searchList(HttpServletRequest req, Model medel) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		// 페이징 처리 계산 처리
		int pageSize = 0;  // 한페이지당 출력할 글 갯수
		int pageBlock = 5; // 한 블럭당 페이지 갯수
		
		int srhCnt = 0;	   // 검색한 글 갯수
		int start = 0;	   // 현재페이지 시작 글번호
		int end = 0; 	   // 현재페이지 마지막 글번호
		int number = 0;	   // 출력용 글번호
		String pageNum = ""; // 페이지 번호
		int currentPage = 0; // 현재 페이지
		
		int pageCount = 0; // 페이지 갯수
		int startPage = 0; // 시작 페이지
		int endPage = 0;   // 마지막 페이지
		int searchType = 0;
		String searchText = "";
		
		// 검색하기 위한 조건들
		if(req.getParameter("searchType") != null) {
			searchType = Integer.parseInt(req.getParameter("searchType"));
			System.out.println("srchType" + searchType);
		}
		if(req.getParameter("srch") != null) {
			searchText = req.getParameter("srch");
			System.out.println("srchtext" + searchText);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchType", searchType);
		map.put("searchText", searchText);
		
		
		// 5-1단계. 글 갯수 구하기
		srhCnt = memberRepository.getSelectSearchCnt(map);
		
		// 5-2단계. 페이지 갯수 구하기
		pageNum = req.getParameter("pageNum");
		
		// 페이지 사이즈 구하기
		if(req.getParameter("pageSize") == null) {
			pageSize = 20;
		} else {
			pageSize = Integer.parseInt(req.getParameter("pageSize"));
		}
		
		if(pageNum == null) {
			pageNum = "1"; // 첫페이지를 1페이지로 지정
		}
		
		// 글 30건 기준
		
		// 현재 페이지 출력
		currentPage = Integer.parseInt(pageNum); // 현재페이지 : 1
		System.out.println(currentPage);
		
		// 페이지 갯수 6 = 30/5 + 0;
		pageCount = (srhCnt / pageSize) + (srhCnt % pageSize == 0 ? 0 : 1); // 페이지 갯수 + 나머지 있으면 1
		
		// 현재페이지 시작 글번호(페이지별)
		start = (currentPage - 1) * pageSize + 1;
		
		// 현재페이지 마지막 글번호
		end = start + pageSize - 1;
		
		System.out.println("start : " + start);
		System.out.println("end : " + end);
		map.put("start", start);
		map.put("end", end);
		
		if(end > srhCnt) end = srhCnt;
		
		// 출력용 글번호
		number = srhCnt - (currentPage - 1) * pageSize;
		
		System.out.println("number : " + number);
		System.out.println("pageSize : " + pageSize);
		
		if(srhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			List<clothDTO> list = memberRepository.getSearchList(map);
			req.setAttribute("list", list); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
		}
		
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		// 1 = (1/3)*3+1
		startPage = (currentPage / pageBlock) * pageBlock + 1;
		
		if(currentPage % pageBlock == 0) startPage -= pageBlock;
		System.out.println("startPage : " + startPage);
		
		// 마지막페이지
		// 3 = 1 + 3 - 1
		endPage = startPage + pageBlock - 1;
		if(endPage > pageCount) endPage = pageCount;
		System.out.println("endpage : " + endPage);
		
		System.out.println("========================");	 	
	 	
		req.setAttribute("pageSize", pageSize);
		req.setAttribute("srhCnt", srhCnt); // 검색한 글갯수
		req.setAttribute("number", number); // 출력용 글번호
		req.setAttribute("pageNum", pageNum); // 페이지번호
		req.setAttribute("searchtext", searchText);
		
		if(srhCnt>0) {
			req.setAttribute("startPage", startPage); // 시작페이지
			req.setAttribute("endPage", endPage); // 마지막 페이지
			req.setAttribute("pageBlock", pageBlock); // 출력할 페이지 갯수
			req.setAttribute("pageCount", pageCount); // 페이지 갯수
			req.setAttribute("currentPage", currentPage); // 현재 페이지
		}
	}

	// 아이디 찾기
	public void findid(HttpServletRequest req, Model medel) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		int type = Integer.parseInt(req.getParameter("typesel"));  // 출력용 글번호
		String name = req.getParameter("GNameN"); // 페이지 번호
		String email = req.getParameter("idName") + "@" +
				req.getParameter("urlcode");
		int idCnt = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("name", name);
		map.put("email", email);
		map.put("type", type);
		
		// 4단계. 다형성 적용, 싱글톤 방식으로 memberRepository 객체 생성
		List<MemberDTO> dto = memberRepository.findid(map);
		if(dto != null) {
			idCnt = 1;
		}
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("type", type);
		req.setAttribute("idCnt", idCnt);
		req.setAttribute("name", name);
		req.setAttribute("email", email);
		req.setAttribute("vo", dto);
	}
	
	// 아이디 찾기
	public void findpwd(HttpServletRequest req, Model medel) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		int type = Integer.parseInt(req.getParameter("typesel"));  // 출력용 글번호
		String strid = req.getParameter("useridN"); // 페이지 번호
		String email = req.getParameter("idName") + "@" +
				req.getParameter("urlcode");
		int idCnt = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("strId", strid);
		map.put("email", email);
		map.put("type", type);
		
		// 4단계. 다형성 적용, 싱글톤 방식으로 memberRepository 객체 생성
		MemberDTO dto = memberRepository.findpwd(map);
		if(dto != null) {
			idCnt = 1;
		}
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		req.setAttribute("type", type);
		req.setAttribute("idCnt", idCnt);
		req.setAttribute("id", strid);
		req.setAttribute("email", email);
		req.setAttribute("vo", dto);
	}
	
	// 메뉴 리스트 조회
	public void prdList(HttpServletRequest req, Model medel) {
		// 3단계. 화면으로 부터 입력받은 값을 받아온다.
		// 페이징 처리 계산 처리
		int pageSize = 0;  // 한페이지당 출력할 글 갯수
		int pageBlock = 5; // 한 블럭당 페이지 갯수
		
		int srhCnt = 0;	   // 검색한 글 갯수
		int start = 1;	   // 현재페이지 시작 글번호
		int end = 7; 	   // 현재페이지 마지막 글번호
		int number = 0;	   // 출력용 글번호
		String pageNum = ""; // 페이지 번호
		int currentPage = 0; // 현재 페이지
		
		int pageCount = 0; // 페이지 갯수
		int startPage = 0; // 시작 페이지
		int endPage = 0;   // 마지막 페이지
		
		// 5-1단계. 글 갯수 구하기
		srhCnt = memberRepository.getproductCnt();
		
		// 페이지 사이즈 구하기
		if(req.getParameter("pageSize") == null) {
			pageSize = 20;
		} else {
			pageSize = Integer.parseInt(req.getParameter("pageSize"));
		}
		
		// 글 30건 기준
		
		// 현재 페이지 출력
		System.out.println(currentPage);
		
		// 페이지 갯수 6 = 30/5 + 0;
		pageCount = (srhCnt / pageSize) + (srhCnt % pageSize == 0 ? 0 : 1); // 페이지 갯수 + 나머지 있으면 1
		/*
		 * if(cnt%5 == 0) { pageCount = cnt/pageSize; } else { pageCount =
		 * (cnt/pageSize) + 1; }
		 */
		
		System.out.println("start : " + start);
		System.out.println("end : " + end);
		
		if(end > srhCnt) end = srhCnt;
		
		// 출력용 글번호
		number = srhCnt - (currentPage - 1) * pageSize;
		
		System.out.println("number : " + number);
		System.out.println("pageSize : " + pageSize);
		
		if(srhCnt > 0) {
			// 5-2단계. 게시글 목록 조회
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("start", start);
			map.put("end", end);
			map.put("name", "outer");
			List<clothDTO> outerlist = memberRepository.getprdList(map);
			medel.addAttribute("outerlist", outerlist); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
			System.out.println("outerlistSize = " + outerlist.size());
			map.put("name", "top");
			List<clothDTO> toplist = memberRepository.getprdList(map);
			medel.addAttribute("toplist", toplist); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
			map.put("name", "shirt");
			List<clothDTO> shirtlist = memberRepository.getprdList(map);
			medel.addAttribute("shirtlist", shirtlist); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
			map.put("name", "knit");
			List<clothDTO> knitlist = memberRepository.getprdList(map);
			medel.addAttribute("knitlist", knitlist); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
			map.put("name", "bottom");
			List<clothDTO> bottomlist = memberRepository.getprdList(map);
			medel.addAttribute("bottomlist", bottomlist); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
			map.put("name", "suit");
			List<clothDTO> suitlist = memberRepository.getprdList(map);
			medel.addAttribute("suitlist", suitlist); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
			map.put("name", "acc");
			List<clothDTO> acclist = memberRepository.getprdList(map);
			medel.addAttribute("acclist", acclist); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
			List<clothDTO> list = memberRepository.productlist();
			medel.addAttribute("list", list); // 큰바구니 : 게시글 목록 cf) 작은 바구니 : 게시글 1건
			System.out.println("list" + list);
		}
		
		// 6단계. request나 session에 처리 결과를 저장(jsp에 전달하기 위함)
		// 1 = (1/3)*3+1
		startPage = (currentPage / pageBlock) * pageBlock + 1;
		
		if(currentPage % pageBlock == 0) startPage -= pageBlock;
		System.out.println("startPage : " + startPage);
		
		// 마지막페이지
		// 3 = 1 + 3 - 1
		endPage = startPage + pageBlock - 1;
		if(endPage > pageCount) endPage = pageCount;
		System.out.println("endpage : " + endPage);
		
		System.out.println("========================");	 	
	 	
		medel.addAttribute("pageSize", pageSize);
		medel.addAttribute("srhCnt", srhCnt); // 검색한 글갯수
		medel.addAttribute("number", number); // 출력용 글번호
		medel.addAttribute("pageNum", pageNum); // 페이지번호
		
		if(srhCnt>0) {
			medel.addAttribute("startPage", startPage); // 시작페이지
			medel.addAttribute("endPage", endPage); // 마지막 페이지
			medel.addAttribute("pageBlock", pageBlock); // 출력할 페이지 갯수
			medel.addAttribute("pageCount", pageCount); // 페이지 갯수
			medel.addAttribute("currentPage", currentPage); // 현재 페이지
		}
	}

}
