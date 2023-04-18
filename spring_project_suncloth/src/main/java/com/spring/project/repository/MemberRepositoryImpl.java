package com.spring.project.repository;

import com.spring.project.dto.*;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Repository;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.*;

@Repository
@RequiredArgsConstructor
public class MemberRepositoryImpl implements MemberRepository {

	private final SqlSessionTemplate sqlSession;
	
	private final JavaMailSender mailSender;
	
	// 중복확인 
	@Override
	public int idCheck(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.idCheck(map);
	}
	
	// 회원가입 처리
	@Override
	public int insertMember(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.insertMember(map);
	}
	
	// 로그인 처리
	@Override
	public int idPwdCheck(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.idPwdCheck(map);
	}
	
	// 삭제처리
	@Override
	public int deleteMember(String strid) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.deleteMember(strid);
	}
	
	@Override
	public MemberDTO getMemberInfo(String strid) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getMemberInfo(strid);
	}
	
	@Override
	public int updateMember(MemberDTO vo) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.updateMember(vo);
	}
	
	// 게시물
	// 게시글 갯수
	@Override
	public int getArticleCnt(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getArticleCnt(map);
	}

	// 공지글 상세 조회, 공지글 수정을 위한 상세페이지
	@Override
	public List<noticeDTO> getnoticeArticle(int num) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getnoticeArticle(num);
	}
	
	// 공지글 상세 조회, 공지글 수정을 위한 상세페이지
	@Override
	public List<FAQDTO> getFAQArticle(int num) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getFAQArticle(num);
	}
	
	// 공지글 상세 조회, 공지글 수정을 위한 상세페이지
	@Override
	public List<QnADTO> getQnAArticle(int num) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getQnAArticle(num);
	}
	
	// 공지글 상세 조회, 공지글 수정을 위한 상세페이지
	@Override
	public List<reviewDTO> getreviewArticle(int num) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getreviewArticle(num);
	}
	
	@Override
	public void addReadCnt(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		dao.addReadCnt(map);
	}

	// 게시글 수정 - 비밀번호 인증
	@Override
	public int numPwdCheck(int num, String pwd) {
		String sql = "select pwd from mvc_QnA_tbl where num = ?";
		return 0;
	}

	// 글 수정 처리
	@Override
	public int updateBoard(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.updateBoard(map);
	}

	// max num
	@Override
	public int maxnum(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.maxnum(map);
	}
	
	// 답변글인 경우
	@Override
	public void updateReply(Map<String, Object> map) {
		// return sqlSession.selectOne("spring.mvc.board_mybatis.persistence.MemberRepository.updateReply", map);
		// 2번째 방법
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		dao.updateReply(map);
	}
	
	// QnA state 변경
	@Override
	public int QnAupdatestate(int num) {
		// return sqlSession.selectOne("spring.mvc.board_mybatis.persistence.MemberRepository.updateReply", map);
		// 2번째 방법
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.QnAupdatestate(num);
	}
	
	// num 찾기
	@Override
	public int numSelect(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.numSelect(map);
	}
	
	// 처리 이전글 수정
	@Override
	public int ifwupdate(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.ifwupdate(map);
	}
	
	// 처리 다음글 수정
	@Override
	public int inextupdate(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.inextupdate(map);
	}
	
	// 답글 이전글 다음글 수정
	@Override
	public int replyfnupdate() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.replyfnupdate();
	}
		
	// 글작성 처리
	@Override
	public int insertBoard (Map<String, Object> map) {
		int num = 0;
		int ref = 0;
		int ref_step = 0;
		int ref_level = 0;
		
		if((int)map.get("choose") == 3) {
			num = ((QnADTO) map.get("vo")).getNum();
			ref = ((QnADTO) map.get("vo")).getRef();
			ref_step = ((QnADTO) map.get("vo")).getRef_step();
			ref_level = ((QnADTO) map.get("vo")).getRef_level();
		}
		
		// 답변글이 아닌경우(제목글인 경우)
		if(num == 0) {
			int cnt = maxnum(map);

			// 첫글이 아닌 경우
			if(cnt != 0) {
				ref = cnt + 1;
				System.out.println("첫글이 아닌 경우");
			// 첫글인 경우	
			} else {
				ref = 1;
			}
			
		// 답변글인 경우
		// 삽입할 글보다 아래쪽 글들이 한줄씩 밀려내려간다. 즉 ref_step(=행)이 1씩 증가한다... ref_step을 update시켜라
		} else {
			Map<String, Object> map1 = new HashMap<String, Object>();
			map1.put("ref_step", ref_step);
			map1.put("ref", ref);
			updateReply(map1);
			
			ref_step += 1; ref_level += 1; 
			
			QnAupdatestate(((QnADTO) map.get("vo")).getNum());
		}
		// 공통부분
		if((int)map.get("choose") == 3) {
			map.put("ref", ref);
			map.put("ref_step", ref_step);
			map.put("ref_level", ref_level);
		}	
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		int insertCnt = dao.insertBoard(map);
		int updateCnt = 1;
		if((int)map.get("choose") != 5 && maxnum(map) > 1) {
			map.put("num", numSelect(map));
			if(ref_level == 0) {
				updateCnt = ifwupdate(map);
				updateCnt = inextupdate(map);
			} else {
				updateCnt = replyfnupdate();
			}
		}
		if(updateCnt == 1) {
			return insertCnt;
		} else {
			return 0;
		}
	}

	// 공지 검색 리스트 조회
	@Override
	public List<noticeDTO> getNoticeList(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getNoticeList(map);
	}

	// 삭제할 글이 있는지 여부 판단
	@Override
	public noticeDTO getdeletenNotice(int num) {
		// return sqlSession.selectOne("spring.mvc.board_mybatis.persistence.MemberRepository.updateReply", map);
		// 2번째 방법
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getdeletenNotice(num);
	}
	
	@Override
	public int fwupdate(Map<String, Object> map) {
		// return sqlSession.selectOne("spring.mvc.board_mybatis.persistence.MemberRepository.updateReply", map);
		// 2번째 방법
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.fwupdate(map);
	}
	
	@Override
	public int nextupdate(Map<String, Object> map) {
		// return sqlSession.selectOne("spring.mvc.board_mybatis.persistence.MemberRepository.updateReply", map);
		// 2번째 방법
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.nextupdate(map);
	}
	
	// 공지 삭제
	@Override
	public int deleteNoticeBoard(String[] checked) {
		int deleteCnt = 0;
		noticeDTO vo = null;
		
			for(int i = 0; i < checked.length; i++) {
				vo = getdeletenNotice(Integer.parseInt(checked[i]));
				if(vo != null) {
					deleteCnt++;
				}
			}
			
			if(deleteCnt == checked.length) {
				MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
				for(int i = 0; i < checked.length; i++) {
					vo = getdeletenNotice(Integer.parseInt(checked[i]));
					
					if(vo != null) {
						Map<String, Object> map = new HashMap<String, Object>();
						map.put("nextnum", vo.getNextnum());
						map.put("fwnum", vo.getFwnum());
						map.put("table", "mvc_notice_tbl");
						if(vo.getFwnum() != 0) {
							fwupdate(map);
						}
						if(vo.getNextnum() != 0) {
							nextupdate(map);
						}
						
					}
					deleteCnt = dao.deleteNoticeBoard(new String[]{checked[i]});
				}
			} else {
				deleteCnt = 0;
			}
		
		return deleteCnt;
	}

	// 공지 검색 갯수
	@Override
	public int getSelectNoticeCnt(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getSelectNoticeCnt(map);
	}
	
	// FAQ 검색 갯수
	@Override
	public int getSelectFAQCnt(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getSelectFAQCnt(map);
	}

	// FAQ 검색 리스트 조회
	@Override
	public List<FAQDTO> getFAQList(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getFAQList(map);
	}
	
	// 삭제할 글이 있는지 여부 판단
	@Override
	public FAQDTO getdeleteFAQ(int num) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getdeleteFAQ(num);
	}
		
	// FAQ 삭제
	@Override
	public int deleteFAQBoard(String[] checked) {
		int deleteCnt = 0;
		FAQDTO vo = null;
		
		for(int i = 0; i < checked.length; i++) {
			vo = getdeleteFAQ(Integer.parseInt(checked[i]));
			if(vo != null) {
				deleteCnt++;
			}
		}
		
		if(deleteCnt == checked.length) {
			MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
			for(int i = 0; i < checked.length; i++) {
				vo = getdeleteFAQ(Integer.parseInt(checked[i]));
				
				if(vo != null) {
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("nextnum", vo.getNextnum());
					map.put("fwnum", vo.getFwnum());
					map.put("table", "mvc_FAQ_tbl");
					if(vo.getFwnum() != 0) {
						fwupdate(map);
					}
					if(vo.getNextnum() != 0) {
						nextupdate(map);
					}
					
				}
				deleteCnt = dao.deleteFAQBoard(new String[]{checked[i]});
			}
		} else {
			deleteCnt = 0;
		}
		
		return deleteCnt;
	}

	
	// QnA 검색 리스트 조회
	@Override
	public List getQnAList(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getQnAList(map);
	}
	
	// QnA 검색 갯수
	@Override
	public int getSelectQnACnt(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getSelectQnACnt(map);
	}

	// 삭제할 글이 있는지 여부 판단
	@Override
	public QnADTO getdeleteQnA(int num) {
		// return sqlSession.selectOne("spring.mvc.board_mybatis.persistence.MemberRepository.updateReply", map);
		// 2번째 방법
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getdeleteQnA(num);
	}
	
	// 답글이 있는지 여부 판단
	@Override
	public int getReplyCnt(Map<String, Object> map) {
		// return sqlSession.selectOne("spring.mvc.board_mybatis.persistence.MemberRepository.updateReply", map);
		// 2번째 방법
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getReplyCnt(map);
	}
	
	// 답글의 답글이 있는지 여부판단
	@Override
	public int getReplysecCnt(Map<String, Object> map) {
		// return sqlSession.selectOne("spring.mvc.board_mybatis.persistence.MemberRepository.updateReply", map);
		// 2번째 방법
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getReplysecCnt(map);
	}
	
	// 답글의 답글 전까지 삭제
	@Override
	public int getReplydelete(Map<String, Object> map) {
		// return sqlSession.selectOne("spring.mvc.board_mybatis.persistence.MemberRepository.updateReply", map);
		// 2번째 방법
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getReplydelete(map);
	}
	
	// 답글들만 삭제
	@Override
	public int getnotReplydelete(Map<String, Object> map) {
		// return sqlSession.selectOne("spring.mvc.board_mybatis.persistence.MemberRepository.updateReply", map);
		// 2번째 방법
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getnotReplydelete(map);
	}

	// QnA 삭제 처리
	@Override
	public int deleteQnABoard(String[] checked) {
		int deleteCnt = 0;
		QnADTO vo = null;
		
		for(int i = 0; i < checked.length; i++) {
			vo = getdeleteQnA(Integer.parseInt(checked[i]));
			if(vo != null) {
				deleteCnt++;
			}
		}
		
		if(deleteCnt == checked.length) {
			MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
			for(int i = 0; i < checked.length; i++) {
			vo = getdeleteQnA(Integer.parseInt(checked[i]));
			
			if(vo != null) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("nextnum", vo.getNextnum());
				map.put("fwnum", vo.getFwnum());
				map.put("table", "QnA");
				if(vo.getFwnum() != 0) {
					fwupdate(map);
				}
				if(vo.getNextnum() != 0) {
					nextupdate(map);
				}
				
			}
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("ref", vo.getRef());
			map.put("ref_step", vo.getRef_step());
			map.put("ref_level", vo.getRef_level());
			map.put("num", Integer.parseInt(checked[i]));
			
			int cnt = getReplyCnt(map);
				// 답글이 존재하는 경우
				if(cnt > 0) {
					int mi = getReplysecCnt(map);
					map.put("num", map.get("num"));
					System.out.println("답글이 존재하는 경우");
					if(mi > 0) {
						deleteCnt = getReplydelete(map);
					} else {
						deleteCnt = getnotReplydelete(map);
					}
				} else {
					// 답글이 존재하지 않은 경우
					deleteCnt = dao.deleteQnABoard(new String[]{checked[i]});
					System.out.println("답글이 존재하지 않은 경우");
				}
			}
		} else {
			deleteCnt = 0;
		}
	
		return deleteCnt;
	}
	
	// review 검색 갯수
	@Override
	public int getSelectreviewCnt(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getSelectreviewCnt(map);
	}

	// review 검색 리스트 조회
	@Override
	public List getreviewList(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getreviewList(map);
	}
	
	// reply 검색 갯수
	@Override
	public int getSelectreplyCnt(int num) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getSelectreplyCnt(num);
	}
	
	// reply 검색 리스트 조회
	@Override
	public List getreplyList(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getreplyList(map);
	}

	// 삭제할 글이 있는지 여부 판단
	@Override
	public replyDTO getdeletereply(int num) {
		// return sqlSession.selectOne("spring.mvc.board_mybatis.persistence.MemberRepository.updateReply", map);
		// 2번째 방법
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getdeletereply(num);
	}
		
	// reply 삭제
	@Override
	public int deletereplyBoard(String[] checked) {
		int deleteCnt = 0;
		replyDTO vo = null;
		
		for(int i = 0; i < checked.length; i++) {
			vo = getdeletereply(Integer.parseInt(checked[i]));
			if(vo != null) {
				deleteCnt++;
			}
		}
		
		if(deleteCnt == checked.length) {
			MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
			for(int i = 0; i < checked.length; i++) {
				deleteCnt = dao.deletereplyBoard(new String[]{checked[i]});
			}
		} else {
			deleteCnt = 0;
		}
		
		return deleteCnt;
	}

	// 삭제할 글이 있는지 여부 판단
	@Override
	public reviewDTO getdeletereview(int num) {
		// return sqlSession.selectOne("spring.mvc.board_mybatis.persistence.MemberRepository.updateReply", map);
		// 2번째 방법
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getdeletereview(num);
	}
	
	@Override
	public int refdelete(int num) {
		// return sqlSession.selectOne("spring.mvc.board_mybatis.persistence.MemberRepository.updateReply", map);
		// 2번째 방법
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.refdelete(num);
	}
		
	// review 삭제
	@Override
	public int deletereviewBoard(String[] checked) {
		int deleteCnt = 0;
		int r_deleteCnt = 0;
		reviewDTO vo = null;
		
		for(int i = 0; i < checked.length; i++) {
			vo = getdeletereview(Integer.parseInt(checked[i]));
			if(vo != null) {
				deleteCnt++;
			}
		}
		
		if(deleteCnt == checked.length) {
			MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
			for(int i = 0; i < checked.length; i++) {
				vo = getdeletereview(Integer.parseInt(checked[i]));
				
				if(vo != null) {
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("nextnum", vo.getNextnum());
					map.put("fwnum", vo.getFwnum());
					map.put("table", "mvc_review_tbl");
					if(vo.getFwnum() != 0) {
						fwupdate(map);
					}
					if(vo.getNextnum() != 0) {
						nextupdate(map);
					}
					
				}
				r_deleteCnt = refdelete(Integer.parseInt(checked[i]));
				deleteCnt = dao.deletereviewBoard(new String[]{checked[i]});
			}
		} else {
			deleteCnt = 0;
		}

		return deleteCnt;
	}

	
	// brand 검색 갯수
	@Override
	public int getSelectbrandCnt(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getSelectbrandCnt(map);
	}

	// brand 갯수
	@Override
	public int getbrandCnt() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getbrandCnt();
	}

	// brand 검색 리스트
	@Override
	public List getbrandList(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getbrandList(map);
	}

	// brand Max Num 가져오기
	@Override
	public int getbrandMaxNum() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getbrandMaxNum();
	}

	// 브랜드 등록 처리
	@Override
	public int insertBrand(BrandDTO vo) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.insertBrand(vo);
	}
	
	// brand 삭제
	@Override
	public int deletebrand(String[] checked) {
		int deleteCnt = 0;
		BrandDTO vo = null;
		
		for(int i = 0; i < checked.length; i++) {
			vo = getbrand(Integer.parseInt(checked[i]));
			if(vo != null) {
				deleteCnt++;
			}
		}
			
		if(deleteCnt == checked.length) {
			MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
			for(int i = 0; i < checked.length; i++) {
				deleteCnt = dao.deletebrand(new String[]{checked[i]});
			}
		} else {
			deleteCnt = 0;
		}
		
		return deleteCnt;
	}

	// brand 1개 상세 가져오기
	@Override
	public BrandDTO getbrand(int num) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getbrand(num);
	}


	// brand 수정 처리
	@Override
	public int updateBrand(BrandDTO vo) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.updateBrand(vo);
	}

	// 브랜드 리스트 모두 조회	
	@Override
	public List getbrandallList() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getbrandallList();
	}
	
	// product 검색 갯수
	@Override
	public int getSelectproductCnt(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getSelectproductCnt(map);
	}

	// product 갯수
	@Override
	public int getproductCnt() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getproductCnt();
	}

	// 상품 리스트 조회
	@Override
	public List getproductList(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getproductList(map);
	}

	// 대분류 검색 갯수
	@Override
	public int getSelectbigpartCnt() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getSelectbigpartCnt();
	}

	// 대분류 리스트 모두 조회
	@Override
	public List getbigpartallList() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getbigpartallList();
	}

	// 중분류 검색 갯수
	@Override
	public int getSelectmediumpartCnt(int num) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getSelectmediumpartCnt(num);
	}

	// 중분류 리스트 모두 조회	
	@Override
	public List getmediumallList(int num) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getmediumallList(num);
	}

	// color 개수
	@Override
	public int getcolorCnt() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getcolorCnt();
	}

	// color 목록 조회
	@Override
	public List getcolorList() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getcolorList();
	}

	// size 개수	
	@Override
	public int getsizeCnt() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getsizeCnt();
	}

	// size 목록 조회
	@Override
	public List getsizeList() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getsizeList();
	}

	// 대분류 등록
	@Override
	public int insertBigpart(String name) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.insertBigpart(name);
	}

	// 중분류 등록
	@Override
	public int insertmediumpart(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.insertmediumpart(map);
	}

	// 컬러등록
	@Override
	public int insertcolorpart(String name) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.insertcolorpart(name);
	}

	// 사이즈 등록
	@Override
	public int insertsizepart(String name) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.insertsizepart(name);
	}

	// 대분류 삭제
	@Override
	public int deletebigpart(int num) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.deletebigpart(num);
	}

	// 중분류 삭제
	@Override
	public int deletemediumpart(int num) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.deletemediumpart(num);
	}

	// 컬러 삭제
	@Override
	public int deletecolorpart(int num) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.deletecolorpart(num);
	}

	// 사이즈 삭제
	@Override
	public int deletesizepart(int num) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.deletesizepart(num);
	}

	// product 등록 처리
	@Override
	public int insertproduct(clothDTO vo) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.insertproduct(vo);
	}

	// product 수정 폼
	@Override
	public clothDTO getproduct(int num) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getproduct(num);
	}

	// 상품 수정처리
	@Override
	public int updateproduct(clothDTO vo) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.updateproduct(vo);
	}

	// 상품 메인처리
	@Override
	public int updatemainfileproduct(clothDTO vo) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.updatemainfileproduct(vo);
	}

	// 상품 파일 처리
	@Override
	public int updatefilesproduct(clothDTO vo) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.updatefilesproduct(vo);
	}

	// 상품 with 처리
	@Override
	public int updatewithitemsproduct(clothDTO vo) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.updatewithitemsproduct(vo);
	}

	// 상품 삭제
	@Override
	public int deleteproduct(String[] checked) {
		int deleteCnt = 0;
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		for(int i = 0; i < checked.length; i++) {
			deleteCnt = dao.deleteproduct(new String[]{checked[i]});
		}
		return deleteCnt;
	}

	// 분류에 따른 리스트 개수
	@Override
	public int getSelectprdCnt(String name) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getSelectprdCnt(name);
	}
	
	// 분류에 따른 리스트 조회
	@Override
	public List<clothDTO> getprdList(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getprdList(map);
	}

	// 상품상세 컬러 개수
	@Override
	public int getSelectcolorCnt(int num) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getSelectcolorCnt(num);
	}

	// 상품상세 사이즈 개수
	@Override
	public int getSelectsizeCnt(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getSelectsizeCnt(map);
	}

	// 상품상세 컬러 목록
	@Override
	public List getSelectcolorList(int num) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getSelectcolorList(num);
	}

	// 상품 상세 사이즈 목록
	@Override
	public List getSelectsizeList(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getSelectsizeList(map);
	}

	// 사이즈 컬러 추가 처리
	@Override
	public int insertcs(stockDTO vo) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.insertcs(vo);
	}

	// 사이즈 컬러 목록 불러오기
	@Override
	public stockDTO getcs(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getcs(map);
	}

	// cs 수정 처리 
	@Override
	public int updatecs(stockDTO vo) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.updatecs(vo);
	}

	// order 등록 처리
	@Override
	public int insertorder(orderDTO vo) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.insertorder(vo);
	}

	// cs count update
	@Override
	public int orderupdatecs(orderDTO vo) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.orderupdatecs(vo);
	}

	// stock 목록 불러오기
	@Override
	public int getcountcs(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getcountcs(map);
	}
	
	// count check
	@Override
	public int countChk(Map<String, Object> map) {
		int updateCnt = 0;
		
		updateCnt = getcountcs(map);
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		if(updateCnt == 0) {
			return dao.countChk(map);
		}
		
		return updateCnt;
	}

	// order 검색 개수
	@Override
	public int getSelectOrderCnt(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getSelectOrderCnt(map);
	}

	// order 전체 개수
	@Override
	public int getorderCnt() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getorderCnt();
	}

	// order 자기꺼 목록 조회
	@Override
	public List getorderList(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getorderList(map);
	}

	// cart 추가
	@Override
	public int insertcart(cartDTO vo) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.insertcart(vo);
	}

	// stock state 변경
	public int stockstate(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.stockstate(map);
	}
	
	// state 변경
	@Override
	public int updatestate(Map<String, Object> map) {
		int updateCnt = stockstate(map);
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		if((int)map.get("state") == 1) {
			return dao.updatestate(map);
		}
		return updateCnt;
	}

	// cart 검색 갯수
	@Override
	public int getSelectCartCnt(String string) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getSelectCartCnt(string);
	}
	
	// cart 갯수
	@Override
	public int getcartCnt() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getcartCnt();
	}
	
	// cart 목록 리스트
	@Override
	public List getcartList(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getcartList(map);
	}

	// 메일 보내기
	@Override
	public void sendmail(String sendemail, String key) throws Exception{
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("emailBean.xml");
		JavaMailSenderImpl mailSender = (JavaMailSenderImpl)ctx.getBean("mailSender");

		// 메일 내용
		String subject = "인증번호가 발송되었습니다. 인증번호를 확인해주세요";
		String content = "suncloth에서 이메일 인증을 위한 인증번호를 보냅니다! 인증번호는 " + key + "입니다. 감사합니다.";

		// 보내는 사람
		String from = "k-sunwo@naver.com";

		// 받는 사람
		String[] to = new String[1];
		to[0] = sendemail;

		try {
			// 메일 내용 넣을 객체와, 이를 도와주는 Helper 객체 생성
			MimeMessage mail = mailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, "UTF-8");

			// 메일 내용을 채워줌
			mailHelper.setFrom(from);	// 보내는 사람 셋팅
			mailHelper.setTo(to);		// 받는 사람 셋팅
			mailHelper.setSubject(subject);	// 제목 셋팅
			mailHelper.setText(content);	// 내용 셋팅

			// 메일 전송
			mailSender.send(mail);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	// 장바구니 삭제
	@Override
	public int deletecart(int checked) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.deletecart(checked);
	}

	// 장바구니 모두 삭제
	@Override
	public int deleteallcart(String strid) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.deleteallcart(strid);
	}

	// 적립금 추가
	@Override
	public int updategplus(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.updategplus(map);
	}

	// 적립금 리스트 가져오기
	@Override
	public List getplusList(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getplusList(map);
	}

	// 환불 적립금 가져오기
	@Override
	public int getrefundplus(String attribute) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getrefundplus(attribute);
	}

	// 주문 상태별 갯수 가져오기
	@Override
	public int selectstateCnt(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.selectstateCnt(map);
	}
	
	// plus 가져오기
	@Override
	public int h_plusgetting(int prdnum) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.h_plusgetting(prdnum);
	}
	
	// plus 더하기
	@Override
	public int h_plusplus(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.h_plusplus(map);
	}
	
	// plus 빼기
	@Override
	public int h_plusminus(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.h_plusminus(map);
	}

	// 관리자 전용 주문 상태 변경
	@Override
	public int h_updatestate(Map<String, Object> map) {
		int updateCnt = 0;
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		updateCnt = dao.h_updatestate(map);

		// 상품에 적혀진 적립금 금액 가져오기
		int plus = h_plusgetting((int)map.get("prdnum"));
		Map<String, Object> smap = new HashMap<String, Object>();
		smap.put("plus", plus);
		smap.put("strid", (String)map.get("gid"));
		System.out.println("smap = " + smap);
		
		if(((String)map.get("orderstate")).equals("배송완료")) {
			h_plusplus(smap);
		} else if(((String)map.get("orderstate")).equals("환불확인")) {
			h_plusminus(smap);
		}
		return updateCnt;
	}
	
	// 방문횟수 증가
	@Override
	public int visit(String strid) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.visit(strid);
	}

	// 회원 목록 리스트
	@Override
	public List getMemberlist(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getMemberlist(map);
	}

	// 회원갯수
	@Override
	public int getmemberCnt() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getmemberCnt();
	}

	// 회원검색 갯수
	@Override
	public int getSelectmemberCnt(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getSelectmemberCnt(map);
	}

	// 회원 관리자 메모 수정
	@Override
	public int updatehostmemoMember(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.updatehostmemoMember(map);
	}


	// 방문자 토탈
	@Override
	public int[] getclicktotal(Map<String, Object> map) {
		int[] list = new int[12]; 
		
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		for(int i = 0; i < 12; i++) {
			if(i < 10) {
				map.put("i", "0" + String.valueOf(i+1));
			} else {
				map.put("i", String.valueOf(i+1));
			}
			
			list[i] = dao.getclicktotal(map)[0];
		}
		
		return list;
	}

	// 신규 멤버 토탈
	@Override
	public int[] getnewmembertotal(Map<String, Object> map) {
		int[] list = new int[12]; 
		
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		for(int i = 0; i < 12; i++) {
			if(i < 10) {
				map.put("i", "0" + String.valueOf(i+1));
			} else {
				map.put("i", String.valueOf(i+1));
			}
			
			list[i] = dao.getnewmembertotal(map)[0];
		}
		
		return list;
	}

	// 주문 자 토탈
	// 회원 관리자 메모 수정
	@Override
	public int getordermemberalltotal() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getordermemberalltotal();
	}
	
	@Override
	public int[] getordermembertotal(Map<String, Object> map) {
		int[] list = new int[13]; 

		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		for(int i = 0; i < 12; i++) {
			if(i < 10) {
				map.put("i", "0" + String.valueOf(i+1));
			} else {
				map.put("i", String.valueOf(i+1));
			}
			
			list[i] = dao.getordermembertotal(map)[0];
		}
		list[12] = getordermemberalltotal();
		return list;
	}

	// 주문 건수 토탈
	@Override
	public int getorderCntalltotal() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getorderCntalltotal();
	}
	
	@Override
	public int[] getorderCnttotal(Map<String, Object> map) {
		int[] list = new int[13]; 

		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		for(int i = 0; i < 12; i++) {
			if(i < 10) {
				map.put("i", "0" + String.valueOf(i+1));
			} else {
				map.put("i", String.valueOf(i+1));
			}
			
			list[i] = dao.getorderCnttotal(map)[0];
		}
		list[12] = getorderCntalltotal();
		return list;
	}

	// 주문 금액 토탈
	@Override
	public int getorderpricealltotal() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getorderpricealltotal();
	}
	
	@Override
	public int[] getorderpricetotal(Map<String, Object> map) {
		int[] list = new int[13]; 

		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		for(int i = 0; i < 12; i++) {
			if(i < 10) {
				map.put("i", "0" + String.valueOf(i+1));
			} else {
				map.put("i", String.valueOf(i+1));
			}
			
			list[i] = dao.getorderpricetotal(map)[0];
		}
		list[12] = getorderpricealltotal();
		return list;
	}


	// 주문 환불 토탈
	@Override
	public int getorderrefundalltotal() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getorderrefundalltotal();
	}
	
	@Override
	public int[] getorderrefundtotal(Map<String, Object> map) {
		int[] list = new int[13]; 

		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		for(int i = 0; i < 12; i++) {
			if(i < 10) {
				map.put("i", "0" + String.valueOf(i+1));
			} else {
				map.put("i", String.valueOf(i+1));
			}
			
			list[i] = dao.getorderrefundtotal(map)[0];
		}
		list[12] = getorderrefundalltotal();
		return list;
	}


	// 주문 실금액 토탈
	@Override
	public int getorderrealpricealltotal() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getorderrealpricealltotal();
	}
	
	@Override
	public int[] getorderrealpricetotal(Map<String, Object> map) {
		int[] list = new int[13]; 

		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		for(int i = 0; i < 12; i++) {
			if(i < 10) {
				map.put("i", "0" + String.valueOf(i+1));
			} else {
				map.put("i", String.valueOf(i+1));
			}
			
			list[i] = dao.getorderrealpricetotal(map)[0];
		}
		list[12] = getorderrealpricealltotal();
		return list;
	}


	// 카테고리 별 순위
	@Override
	public List getCategoryrank(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getCategoryrank(map);
	}

	// 판매순위
	@Override
	public List getSalerank(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getSalerank(map);
	}

	// 적립금 순위
	@Override
	public List getPluspay() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getPluspay();
	}

	// 방문하면 토탈 올라가기
	@Override
	public void visitplus(String strid) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		dao.visitplus(strid);
	}

	// 이번달 주문 건수
	@Override
	public int getmonthorderCnttotal() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getmonthorderCnttotal();
	}

	// 이번달 매출액
	@Override
	public int getmonthorderrealpricetotal() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getmonthorderrealpricetotal();
	}

	// 오늘 통계 리스트
	@Override
	public int getdayorderrealpricetotal() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getdayorderrealpricetotal();
	}


	@Override
	public int getdayorderCnttotal() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getdayorderCnttotal();
	}


	@Override
	public int getdayclicktotal() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getdayclicktotal();
	}

	@Override
	public int selectQnACnt() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.selectQnACnt();
	}

	@Override
	public int selectnewmember() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.selectnewmember();
	}

	@Override
	public int getdaycancelCnttotal() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getdaycancelCnttotal();
	}

	// 7일간 통계
	@Override
	public int selectMaxPayendCnt() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.selectMaxPayendCnt();
	}
	
	@Override
	public int selectPayendCnt(int i) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.selectPayendCnt(i);
	}

	@Override
	public int selectMaxDeliStartCnt() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.selectMaxDeliStartCnt();
	}
	
	@Override
	public int selectDeliStartCnt(int i) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.selectDeliStartCnt(i);
	}

	@Override
	public int selectMaxDeliingCnt() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.selectMaxDeliingCnt();
	}

	@Override
	public int selectDeliingCnt(int i) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.selectDeliingCnt(i);
	}

	@Override
	public int selectMaxDeliEndCnt() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.selectMaxDeliEndCnt();
	}

	@Override
	public int selectDeliEndCnt(int i) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.selectDeliEndCnt(i);
	}

	@Override
	public int selectMaxCancelCnt() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.selectMaxCancelCnt();
	}

	@Override
	public int selectCancelCnt(int i) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.selectCancelCnt(i);
	}

	@Override
	public int selectMaxReviewCnt() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.selectMaxReviewCnt();
	}

	@Override
	public int selectReviewCnt(int i) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.selectReviewCnt(i);
	}

	@Override
	public int getweekpricetotalMax() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getweekpricetotalMax();
	}
	
	@Override
	public int getweekpricetotal(int i) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getweekpricetotal(i);
	}

	// 내 게시물 리스트
	@Override
	public List myboard(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.myboard(map);
	}

	// 게시물 검색 갯수
	@Override
	public int getSelectMyBoardCnt(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getSelectMyBoardCnt(map);
	}

	// 게시물 갯수
	@Override
	public int getMyBoardCnt(String strid) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getMyBoardCnt(strid);
	}

	// wish 추가
	@Override
	public int insertwish(wishDTO vo) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.insertwish(vo);
	}

	// wish 검색 갯수
	@Override
	public int getSelectWishCnt(String string) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getSelectWishCnt(string);
	}
	
	// wish 갯수
	@Override
	public int getWishCnt() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getWishCnt();
	}
	
	// wish 목록 리스트
	@Override
	public List getwishList(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getwishList(map);
	}

	// 찜하기 삭제
	@Override
	public int deletewish(int checked) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.deletewish(checked);
	}

	// 찜하기 모두 삭제
	@Override
	public int deleteallwish(String strid) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.deleteallwish(strid);
	}

	// 검색 리스트 개수
	@Override
	public int getSelectSearchCnt(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getSelectSearchCnt(map);
	}

	// 검색 리스트 조회
	@Override
	public List getSearchList(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.getSearchList(map);
	}


	// 아이디 찾기
	@Override
	public List<MemberDTO> findid(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.findid(map);
	}

	// 비밀번호 찾기
	@Override
	public MemberDTO findpwd(Map<String, Object> map) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.findpwd(map);
	}

	// 상품 리스트
	@Override
	public List<clothDTO> productlist() {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.productlist();
	}
	
	@Override
	public Map<String, Object> selectUser(String userid) {
		MemberRepository dao = sqlSession.getMapper(MemberRepository.class);
		return dao.selectUser(userid);
	}




}