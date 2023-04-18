package com.spring.project.repository;

import com.spring.project.dto.*;

import java.util.List;
import java.util.Map;

public interface MemberRepository {
	// 중복확인 체크
	public int idCheck(Map<String, Object> map);
		
	// 회원가입 처리
	public int insertMember(Map<String, Object> map);
	
	// 로그인 처리, 회원정보탈퇴시 비밀번호 인증, 회원정보수정시 비밀번호 인증
	public int idPwdCheck(Map<String, Object> map);
	
	// 삭제처리
	public int deleteMember(String strid);
	
	// 회원정보 수정 상세페이지
	public MemberDTO getMemberInfo(String strid);
	
	// 회원정보 수정 처리
	public int updateMember(MemberDTO vo);
	
	// 게시글 갯수 구하기
	public int getArticleCnt(Map<String, Object> map);
	
	// 게시글 상세 조회, 게시글 수정을 위한 상세페이지
	public List<noticeDTO> getnoticeArticle(int num);
	
	public List<FAQDTO> getFAQArticle(int num);
	
	public List<QnADTO> getQnAArticle(int num);
	
	public List<reviewDTO> getreviewArticle(int num);
	
	
	// 조회수 증가
	public void addReadCnt(Map<String, Object> map);
	
	// 게시글 수정 - 비밀번호 인증
	public int numPwdCheck(int num, String pwd);

	// 글수정 처리
	public int updateBoard(Map<String, Object> map);

	// 글작성 처리 도우미들
	int maxnum(Map<String, Object> map);
	
	void updateReply(Map<String, Object> map);

	int QnAupdatestate(int num);

	int numSelect(Map<String, Object> map);

	int ifwupdate(Map<String, Object> map);
	
	int inextupdate(Map<String, Object> map);

	int replyfnupdate();
	
	// 글작성 처리
	public int insertBoard(Map<String, Object> map);

	// 공지 뿌려줄 때 사용하는 메소드
	public List<noticeDTO> getNoticeList(Map<String, Object> map);
	
	// 공지전용 글 삭제 처리
	public int deleteNoticeBoard(String[] checked);

	public int fwupdate(Map<String, Object> map);
	
	public int nextupdate(Map<String, Object> map);

	public noticeDTO getdeletenNotice(int num);

	// 공지전용 검색 처리
	public int getSelectNoticeCnt(Map<String, Object> map);

	// FAQ전용 검색 처리
	public int getSelectFAQCnt(Map<String, Object> map);

	// FAQ 목록 조회
	public List<FAQDTO> getFAQList(Map<String, Object> map);
	
	// FAQ 전용 글 삭제 처리
	public int deleteFAQBoard(String[] checked);
	
	public FAQDTO getdeleteFAQ(int num);
	
	// QnA 목록 조회
	public List<QnADTO> getQnAList(Map<String, Object> map);

	// QnA전용 검색 처리
	public int getSelectQnACnt(Map<String, Object> map);

	// QnA전용 삭제 처리
	public int deleteQnABoard(String[] checked);
	
	QnADTO getdeleteQnA(int num);

	int getReplyCnt(Map<String, Object> map);

	int getReplysecCnt(Map<String, Object> map);

	int getReplydelete(Map<String, Object> map);

	int getnotReplydelete(Map<String, Object> map);
	
	
	// review전용 검색 처리
	public int getSelectreviewCnt(Map<String, Object> map);

	// review 목록 조회
	public List<reviewDTO> getreviewList(Map<String, Object> map);
	
	// reply 검색 개수
	public int getSelectreplyCnt(int num);

	// reply 목록 조회
	public List<replyDTO> getreplyList(Map<String, Object> map);
	
	// reply 삭제
	public int deletereplyBoard(String[] checked);
	
	replyDTO getdeletereply(int num);

	// review 삭제
	public int deletereviewBoard(String[] checked);
	
	reviewDTO getdeletereview(int num);

	int refdelete(int num);
	
	// brand 검색 갯수
	public int getSelectbrandCnt(Map<String, Object> map);

	// brand 갯수
	public int getbrandCnt();

	public List<BrandDTO> getbrandList(Map<String, Object> map);

	public int getbrandMaxNum();

	// 브랜드 등록
	public int insertBrand(BrandDTO vo);

	// 브랜드 삭제
	public int deletebrand(String[] checked);

	// 브랜드 1개 가져오기
	public BrandDTO getbrand(int num);

	// 브랜드 수정 처리
	public int updateBrand(BrandDTO vo);

	// 대분류 검색 갯수
	public int getSelectbigpartCnt();

	// 중분류 검색 갯수
	public int getSelectmediumpartCnt(int num);

	// product 목록 조회
	public List<clothDTO> getproductList(Map<String, Object> map);

	// bigpart 목록 모두 조회
	public List<bigpartDTO> getbigpartallList();

	// mediumpart 목록 모두 조회
	public List<mediumpartDTO> getmediumallList(int num);

	// brand 목록 모두 조회
	public List<BrandDTO> getbrandallList();

	// product 검색 개수
	public int getSelectproductCnt(Map<String, Object> map);

	// product 개수
	public int getproductCnt();

	// color 개수
	public int getcolorCnt();

	// size 개수
	public int getsizeCnt();

	// color 목록 조회
	public List<colorDTO> getcolorList();

	// size 목록 조회
	public List<sizeDTO> getsizeList();

	// bigpart 등록
	public int insertBigpart(String name);

	// 중분류 등록
	public int insertmediumpart(Map<String, Object> map);

	// 컬러 등록
	public int insertcolorpart(String name);

	// 사이즈 등록
	public int insertsizepart(String name);

	// 대분류 삭제
	public int deletebigpart(int num);

	// 중분류 삭제
	public int deletemediumpart(int num);

	// 컬러 삭제
	public int deletecolorpart(int num);

	// 사이즈 삭제
	public int deletesizepart(int num);

	// product 등록 처리
	public int insertproduct(clothDTO vo);

	// product 수정 폼
	public clothDTO getproduct(int num);

	// product 수정 처리
	public int updateproduct(clothDTO vo);

	// product mainimage 수정
	public int updatemainfileproduct(clothDTO vo);

	// product files 수정
	public int updatefilesproduct(clothDTO vo);

	// product withitems 수정
	public int updatewithitemsproduct(clothDTO vo);

	// product 삭제
	public int deleteproduct(String[] checked);

	// menuproduct 리스트 갯수 조회
	public int getSelectprdCnt(String name);

	// menuproduct 리스트 조회
	public List<clothDTO> getprdList(Map<String, Object> map);

	// 상품상세 컬러 개수
	public int getSelectcolorCnt(int num);

	// 상품상세 사이즈 개수
	public int getSelectsizeCnt(Map<String, Object> map);

	// 상품상세 컬러 목록
	public List<colorDTO> getSelectcolorList(int num);

	// 상품상세 사이즈 목록
	public List<sizeDTO> getSelectsizeList(Map<String, Object> map);

	// 사이즈 컬러 추가 처리
	public int insertcs(stockDTO vo);

	// 재고 목록 불러오기
	public stockDTO getcs(Map<String, Object> map);

	// cs 수정 처리
	public int updatecs(stockDTO vo);

	// 주문 등록 처리
	public int insertorder(orderDTO vo);

	// ordercount 수정하기
	public int orderupdatecs(orderDTO vo);

	// count Check
	public int countChk(Map<String, Object> map);
	
	int getcountcs(Map<String, Object> map);

	// order 검색 갯수
	public int getSelectOrderCnt(Map<String, Object> map);

	// order 전체 갯수
	public int getorderCnt();

	// order 목록 구하기
	public List<orderDTO> getorderList(Map<String, Object> map);

	// cart 추가
	public int insertcart(cartDTO vo);

	// state 변경
	public int stockstate(Map<String, Object> map);
	
	public int updatestate(Map<String, Object> map);

	// cart 검색 갯수
	public int getSelectCartCnt(String string);

	// cart 갯수
	public int getcartCnt();

	// cart 리스트 목록
	public List<orderDTO> getcartList(Map<String, Object> map);

	// 이메일 보내기
	public void sendmail(String email, String key) throws Exception;

	// 주문시에 장바구니도 삭제
	public int deletecart(int parseInt);

	// 장바구니 모두 삭제 아이디 해당
	public int deleteallcart(String strid);

	// 적립금 plus
	public int updategplus(Map<String, Object> map);

	// plus들 가져오기
	public List<orderDTO> getplusList(Map<String, Object> map);

	// 환불 plus들 가져오기
	public int getrefundplus(String attribute);

	// 주문 상태별 갯수 가져오기
	public int selectstateCnt(Map<String, Object> map);

	// 관리자 전용 주문 상태 변경
	int h_plusgetting(int prdnum);
	
	public int h_updatestate(Map<String, Object> map);
	
	// 방문횟수 증가
	public int visit(String strid);

	// 회원목록 리스트
	public List<MemberDTO> getMemberlist(Map<String, Object> map);

	// 회원 갯수
	public int getmemberCnt();

	// 회원검색 갯수
	public int getSelectmemberCnt(Map<String, Object> map);

	// 회원 관리자메모 수정
	public int updatehostmemoMember(Map<String, Object> map);

	// 방문자 토탈
	public int[] getclicktotal(Map<String, Object> map);

	// 신규멤버
	public int[] getnewmembertotal(Map<String, Object> map);

	// 주문 자 토탈
	public int[] getordermembertotal(Map<String, Object> map);

	int getordermemberalltotal();
	
	// 주문 건수 토탈
	public int[] getorderCnttotal(Map<String, Object> map);

	int getorderCntalltotal();

	// 주문 금액 토탈
	public int[] getorderpricetotal(Map<String, Object> map);

	int getorderpricealltotal();

	// 주문 환불 토탈
	public int[] getorderrefundtotal(Map<String, Object> map);

	int getorderrefundalltotal();

	// 주문 실금액 토탈
	public int[] getorderrealpricetotal(Map<String, Object> map);

	int getorderrealpricealltotal();
	// 카테고리별 순위
	public List<CategoryDTO> getCategoryrank(Map<String, Object> map);

	// 판매순위
	public List<SalerankDTO> getSalerank(Map<String, Object> map);

	// 적립금 순위
	public List<PluspayDTO> getPluspay();

	// 방문 수 올라가기
	public void visitplus(String strid);
	
	// 달별 갯수
	public int getmonthorderCnttotal();

	// 달별 구매액
	public int getmonthorderrealpricetotal();

	// 오늘날 메인 리스트
	public int getdayorderrealpricetotal();

	public int getdayclicktotal();

	public int selectQnACnt();

	public int selectnewmember();

	public int getdayorderCnttotal();

	public int getdaycancelCnttotal();

	// 7일간 개수
	public int selectPayendCnt(int i);

	public int selectDeliStartCnt(int i);

	public int selectDeliingCnt(int i);

	public int selectDeliEndCnt(int i);

	public int selectCancelCnt(int i);

	public int selectReviewCnt(int i);

	public int getweekpricetotal(int i);
	
	// max 7일간
	public int selectMaxPayendCnt();

	public int selectMaxDeliStartCnt();

	public int selectMaxDeliingCnt();

	public int selectMaxDeliEndCnt();

	public int selectMaxCancelCnt();

	public int selectMaxReviewCnt();

	public int getweekpricetotalMax();

	// 내 게시물 목록
	public List<MyBoardDTO> myboard(Map<String, Object> map);

	// 게시물 검색 갯수
	public int getSelectMyBoardCnt(Map<String, Object> map);

	// 게시물 갯수
	public int getMyBoardCnt(String strid);

	// cart 추가
	public int insertwish(wishDTO vo);

	// cart 검색 갯수
	public int getSelectWishCnt(String strid);

	// cart 갯수
	public int getWishCnt();

	// cart 리스트 목록
	public List<orderDTO> getwishList(Map<String, Object> map);

	// 주문시에 장바구니도 삭제
	public int deletewish(int parseInt);

	// 장바구니 모두 삭제 아이디 해당
	public int deleteallwish(String attribute);

	// 검색 갯수
	public int getSelectSearchCnt(Map<String, Object> map);

	// 검색 목록 리스트
	public List<clothDTO> getSearchList(Map<String, Object> map);

	// 아이디 찾기
	public List<MemberDTO> findid(Map<String, Object> map);

	// 비밀번호 찾기
	public MemberDTO findpwd(Map<String, Object> map);

	// main lists
	public List<clothDTO> productlist();

	// 시큐리티 등록
	public Map<String, Object> selectUser(String userid);

	int h_plusplus(Map<String, Object> map);

	int h_plusminus(Map<String, Object> map);


}
