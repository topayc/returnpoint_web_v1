package com.returnp_web.dao.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.returnp_web.utils.RPMap;

public interface MobileMapper {
		
	/**
	 * login user select.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : loginAct
	 * @Method 설명 : 로그인
	 */
	HashMap<String,Object> loginAct(HashMap<String, Object> params);
	
	
	/**
	 * login failure.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : updateLoginFailure
	 * @Method 설명 : 로그인 실패시 count 추가
	 */
	int updateLoginFailure(HashMap<String, Object> params);
	
	/**
	 * auth number update.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : updateLoginAuthNumber
	 * @Method 설명 : 로그인 5회 실패시 인증번호 업데이트
	 */
	int updateLoginAuthNumber(HashMap<String, Object> params);	
	
	/**
	 * auth number delete.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : loginAuthNumberDelete
	 * @Method 설명 : 인증 성공 후 인증번호 삭제
	 */
	int loginAuthNumberDelete(HashMap<String, Object> params);	
	
	/**
	 * login out.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : logOut
	 * @Method 설명 : 로그인 아웃
	 */
	HashMap<String,Object> logOut(HashMap<String, Object> params);
	
	/**
	 * select recommend.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : selectRecommend
	 * @Method 설명 : 추천인 조회
	 */
	int selectRecommend(HashMap<String,Object> params);

	/**
	 * select recommend.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : selectRecommendDetail
	 * @Method 설명 : 추천인 회원정보 조회
	 */
	HashMap<String,Object> selectRecommendDetail(HashMap<String,Object> params);	
	
	/**
	 * select member.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : selectAuthMember
	 * @Method 설명 : 회원 조회(ID 암호화)
	 */
	HashMap<String,Object> selectAuthMember(HashMap<String,Object> params);	
	

	
	/**
	 * select recommend.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : selectmemberEmailDup
	 * @Method 설명 : 회원 이메일 중복 조회
	 */
	int selectmemberEmailDup(HashMap<String,Object> params);
	
	/**
	 * select recommend.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : selectmemberNo
	 * @Method 설명 : 회원 번호 조회
	 */
	int selectmemberNo(HashMap<String,Object> params);
	
	/**
	 * insert member.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : insertJoinAct
	 * @Method 설명 : 회원 가입
	 */
	
	int insertJoinAct(HashMap<String, Object> params);

	/**
	 * insert member green point default.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : insertGreenAct
	 * @Method 설명 : 회원 가입
	 */
	
	int insertGreenAct(HashMap<String, Object> params);
	
	/**
	 * insert member red point default.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : insertRedAct
	 * @Method 설명 : 회원 가입
	 */
	
	int insertRedAct(HashMap<String, Object> params);

	/**
	 * select mypage myinfo.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : selectMypageMyinfo
	 * @Method 설명 : 마이페이지
	 */
	HashMap<String,Object> selectMypageMyinfo(HashMap<String, Object> params);
	
	/**
	 * select recommend.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : selectMypageMyinfo
	 * @Method 설명 : 회원탈퇴전 회원정보 확인
	 */
	HashMap<String,Object> selectMyinfoCheck(HashMap<String, Object> params);
	
	String recommenderNo(HashMap<String, Object> params);
	
	int updateUser(HashMap<String, Object> params);
	
	int updateUserMemberStatus(HashMap<String, Object> params);
	
	/**
	 * update emailSgn No.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : selectEmailSignSuccessCount
	 * @Method 설명 : 비밀번호 찾기 - 임시 비밀번호 업데이트
	 */
	int selectEmailSignSuccessCount(HashMap<String, Object> params);
	
	/**
	 * Select find email.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : selectCompanyBankAccount
	 * @Method 설명 : 회원 이메일 정보 찾기
	 */
	HashMap<String,Object> 	selectFindEmailAct(HashMap<String, Object> params);
	
	/**
	 * Select find user email.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : selectCompanyBankAccount
	 * @Method 설명 : 회원 이메일 정보 찾기(이름+휴대폰번호)
	 */
	HashMap<String,Object> 	selectFindUserEmailAct(HashMap<String, Object> params);
	
	/**
	 * update Auth No.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : updateTempPw
	 * @Method 설명 : 비밀번호 찾기 - 임시 비밀번호 업데이트
	 */
	int updateTempPw(HashMap<String, Object> params);
	
	/**
	 * select recommend overlap count.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : selectMemberJoinCount
	 * @Method 설명 : 회원 중복 가입 조회
	 */
	int selectMemberJoinCount(HashMap<String,Object> params);
	
	/**
	 * select member phone overlap count.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : selectMemberJoinCount
	 * @Method 설명 : 회원 중복 가입 조회
	 */
	int selectMemberPhoneOverlapCount(HashMap<String,Object> params);
	
	/**
	 * login failure.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : deleteLoginFailure
	 * @Method 설명 : 로그인 실패시 count 추가
	 */
	int deleteLoginFailure(HashMap<String, Object> params);
	
	/**
	 * Select main review list.
	 *
	 * @param params the params
	 * @return the array list
	 * @Method Name : selectCompanyBankList
	 * @Method 설명 : 회사 은행 계좌 조회
	 */
	ArrayList<HashMap<String,Object>> selectCompanyBankList(HashMap<String, Object> params);
	
	ArrayList<HashMap<String,Object>> selectMyMemberList(HashMap<String, Object> params);

	int  selectMyMemberListCount(HashMap<String, Object> params);
	
	/**
	 * Select bank account list.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : selectCompanyBankAccount
	 * @Method 설명 : 회사 은행 계좌 조회2
	 */
	HashMap<String,Object> selectCompanyBankAccount(HashMap<String, Object> params);
	
	/**
	 * Select policy membershipTransLimit list.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : selectPolicyMembershipTransLimit
	 * @Method 설명 : policy 조회
	 */
	HashMap<String,Object> selectPolicyMembershipTransLimit(HashMap<String, Object> params);
	
	/**
	 * insert membership_request.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : insertMembershipRequest
	 * @Method 설명 : 정회원 신청
	 */
	
	int insertMembershipRequest(HashMap<String, Object> params);

	/**
	 * member out
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : memberOutAct
	 * @Method 설명 : 로그인 실패시 count 추가
	 */
	int memberOutAct(HashMap<String, Object> params);
	
	/**
	 * select recommend.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : selectMypageMyinfo
	 * @Method 설명 : 회원정보 확인
	 */
	HashMap<String,Object> selectMypageMyinfoValidity(HashMap<String, Object> params);
	
	
	/**
	 * select membership request count.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : selectMypageMyinfo
	 * @Method 설명 : 회원정보 확인
	 */
	int selectMemberShipReq(HashMap<String, Object> params);
	
	/**
	 * select select UserInfo UseEmail.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : selectUserInfoUseEmail
	 * @Method 설명 : 회원정보 확인(memberEmail use)
	 */
	HashMap<String,Object> selectUserInfoUseEmail(HashMap<String, Object> params);
	
	/**
	 * Select point_convert_request search.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : selectPolicyMembershipTransLimit
	 * @Method 설명 : point_convert_request 조회
	 */
	HashMap<String,Object> selectPointConversionTransaction(HashMap<String, Object> params);
	
	/**
	 * Select policy search.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : selectPolicyPointTranslimit
	 * @Method 설명 : policy ajax 조회
	 */
	HashMap<String,Object> selectPolicyPointTranslimit(HashMap<String, Object> params);
	
	/**
	 * select recommend overlap count.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : selectMemberInfo
	 * @Method 설명 : 회원 가입 여부 조회
	 */
	int selectMemberInfo(HashMap<String,Object> params);
	
	/**
	 * Select red point search.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : selectMyRedPointMapinfo
	 * @Method 설명 : red point 조회
	 */
	HashMap<String,Object> selectMyRedPointMapinfo(HashMap<String, Object> params);
	
	/**
	 * select RecipientMember info.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : selectRecipientMemberinfo
	 * @Method 설명 : 회원 조회(red point 선물받을 회원 조회)
	 */
	HashMap<String,Object> selectRecipientMemberinfo(HashMap<String,Object> params);	
	
	/**
	 * select nowYearMonth info.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : selectRecipientMemberinfo
	 * @Method 설명 : 회원 조회(red point 선물받을 회원 조회)
	 */
	HashMap<String,Object> selectYearMonth(HashMap<String, Object> params);
	
	/**
	 * Select Mygreen Point Info list.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : selectMygreenPointInfo
	 * @Method 설명 : my green point 조회
	 */
	HashMap<String,Object> selectMygreenPointInfo(HashMap<String, Object> params);
	
	/**
	 * select MemberAuthToken.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : selectMemberAuthToken
	 * @Method 설명 : member_auth_token(APP 자동로그인 유지)
	 */
	HashMap<String,Object> selectMemberAuthToken(HashMap<String, Object> params);

	
	HashMap<String,Object> getMemberAuthToken(HashMap<String, Object> params);
	
	/**
	 * insert member_auth_token.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : insertMemberAuthTokenAct
	 * @Method 설명 : member_auth_token 인증값 저장
	 */
	
	int insertMemberAuthTokenAct(HashMap<String, Object> params);

	
	/**
	 * delete member_auth_token.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : deleteMemberAuthToken
	 * @Method 설명 : member Auth Token 삭제
	 */
	int deleteMemberAuthToken(HashMap<String, Object> params);
	
	/**
	 * delete qr memberPhone.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : selectqrMemberPhone
	 * @Method 설명 : memberphone으로 회원가입 유무 조회
	 */
	int selectqrMemberPhone(HashMap<String, Object> params);
	
	/**
	 * login auto user select.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : loginAppAct
	 * @Method 설명 : 로그인
	 */
	HashMap<String,Object> loginAppAct(HashMap<String, Object> params);
	
	/**
	 * select Affiliate Info.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : selectAffiliateInfo
	 * @Method 설명 : qr후 가맹점 이름 조회
	 */
	HashMap<String,Object> selectAffiliateInfo(HashMap<String, Object> params);
	
	/**
	 * select member phone overlap modify count.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : selectMemberJoinCount
	 * @Method 설명 : 회원 휴대폰 중복 가입 조회(회원정보수정)
	 */
	int selectMemberPhoneOverlapModfiyCount(HashMap<String,Object> params);
	
	
	/**
	 * select mypage myinfo.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : select MembershipRequest PaymentStatus
	 * @Method 설명 : 정회원신청여부 상태값 조회
	 */
	HashMap<String,Object> selectMembershipRequestPaymentStatus(HashMap<String, Object> params);
	
	/**
	 * update mypage myinfo.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : update MembershipRequest PaymentStatus
	 * @Method 설명 : 정회원신청여부 상태값 조회
	 */
	int updatePaymentStatusRequestCon(HashMap<String, Object> params);
	
	/**
	 * select memberType Info.
	 * @param params the params
	 * @return the hash map
	 * @Method Name : selectmemberTypeInfo
	 * @Method 설명 : 마이페이지-회원타입 조회
	 */
	HashMap<String,Object> selectmemberTypeInfo(HashMap<String, Object> params);
	
	/**
	 * insert QnA.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : insertQnaWAct
	 * @Method 설명 : 게시판-QnA 글쓰기
	 */
	
	int insertQnaWAct(HashMap<String, Object> params);
	
	/**
	 * insert 제휴상담.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : insertQnaNodeWAct
	 * @Method 설명 : 게시판-제휴상담 글쓰기
	 */
	
	int insertQnaNodeWAct(HashMap<String, Object> params);

	ArrayList<HashMap<String,Object>> selectCountries(HashMap<String, Object> params);

	ArrayList<HashMap<String,Object>> selectLanguages(HashMap<String, Object> params);

	ArrayList<HashMap<String,Object>> selectBankAccounts(HashMap<String, Object> params);

	int deleteMemberBankAccount(HashMap<String, Object> params);

	int insertMemberBankAccount(HashMap<String, Object> params);

	int insertPointWithdrawal(HashMap<String, Object> params);
	
	int updatePointwithdrawal(HashMap<String, Object> params);

	int updateRedPoint(HashMap<String, Object> params);

	int updateMemberBankAccount(HashMap<String, Object> params);

	ArrayList<HashMap<String,Object>> selectPointwithdrawals(HashMap<String, Object> params);

	int selectWithdrawalSumPerDay(HashMap<String, Object> params);
	
	HashMap<String,Object> selectGiftCardIssue(HashMap<String, Object> params);
	
	HashMap<String,Object> selectMemberConfig(HashMap<String, Object> params);

	int insertMemberConfigl(HashMap<String, Object> params);

	int  updateMemberConfig(HashMap<String, Object> dbparams);
	
	ArrayList<HashMap<String, Object>>  selectAffiliateTid(HashMap<String, Object> dbparams);

	HashMap<String, Object> selectAffiliateCommand(HashMap<String, Object> dbparams);


	ArrayList<HashMap<String, Object>> selectAffiliateCategories(HashMap<String, Object> dbparams);


	ArrayList<HashMap<String, Object>> findAffiliatesByCate(Map<String, Object> paramMap);


	HashMap<String, Object> selectPointCodeSummary(HashMap<String, Object> dbparams);


	ArrayList<HashMap<String, Object>> selectPointCodeIssueRequests(HashMap<String, Object> dbparams);


	ArrayList<HashMap<String, Object>> selectPointCodeIssues(HashMap<String, Object> dbparams);


	HashMap<String, Object> selectReceipt(HashMap<String, Object> dbparams);


	int checkDepositRequest(RPMap dbparams);
	
	int insertPointCodeIssueRequest(RPMap dbparams);


	int updatePointCodeIssueRequest(RPMap dbparams);


	HashMap<String, Object> selectPaymentRouter(HashMap<String, Object> dbparams2);


	ArrayList<HashMap<String, Object>> selectAffiliates(RPMap dbparams);


	int insertMemberNoti(HashMap<String, Object> notiMap);
	
	ArrayList<HashMap<String, Object>> selectMemberNotis(HashMap<String, Object> dbparams);


	HashMap<String, Object> selectMemberNotiCount(RPMap dbparams);


	int updateMemberNotiStatus(RPMap dbparams);

}
