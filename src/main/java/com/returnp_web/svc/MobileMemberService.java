package com.returnp_web.svc;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;

import com.returnp_web.utils.RPMap;

/**
 * 사용자 회원 service
 */
@Transactional
public interface MobileMemberService {
	
	
	/**
	 * 사용자->로그인
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean loginAct(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;
	
	/**
	 * 사용자->로그아웃
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean logOut(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	/**
	 * 사용자->추천인 조회
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean selectRecommend(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	/**
	 * 사용자->인증번호 발급
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean selectAuthNumberRequest(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	/**
	 * 사용자->사용자 조회(암호화)
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean selectAuthMember(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;
	
	/**
	 * 사용자->회원가입 처리
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean memberJoinAct(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	/**
	 * 사용자->마이페이지 회원정보
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean mypageMyinfo(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	/**
	 * 사용자->마이페이지 회원정보 확인
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean myinfoConfirm(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;
	
	/**
	 * 사용자->마이페이지 회원정보 수정
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean memberUpdateAct(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;
	
	/**
	 * 사용자->마이페이지 회원이동
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean myinfoConfirmModify(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	boolean myMemberList(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;
	
	/**
	 * 사용자->마이페이지 회원정보수정 페이지 접근 유효성 체크
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean myinfoConfirmModifyCheck(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;
	
	
	/**
	 * 사용자->이메일 인증
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean emailSignAct(String memberEmail, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;
	
	/**
	 * 사용자->이메일찾기
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean findEmailAct(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	/**
	 * 사용자->비밀번호찾기
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean findPwAct(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	/**
	 * 사용자->중복가입 조회
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean selectMemberValidity(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	/**
	 * 사용자->휴대폰 중복 가입 조회
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean selectPhoneOverlap(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;
	
	/**
	 * 사용자->이메일 미인증 고객시 이메일 전송
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean memberEmailConfirmAct(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;
	
	/**
	 * 사용자->정회원신청
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean regularMemberAct(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	/**
	 * 사용자->회원탈퇴
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean memberOutAct(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	/**
	 * 사용자->마이페이지 회원탈퇴 정보확인
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean myinfoCheck(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;
	
	/**
	 * 사용자->정책(policy) 조회
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean selectPolicyPointTransLimit(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;
	
	/**
	 * 사용자->포인트선물하기-회원 이메일정보 조회
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean selectMemberEmailInfo(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;
	
	/**
	 * 사용자->qr코드-회원가입페이지로 이동
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean selectQrSelectMemberPhoneInfo(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	/**
	 * 사용자->휴대폰 중복 가입 조회(회원정보수정)
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean selectPhoneOverlapModify(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	/**
	 * 사용자->정회원신청 정보 상태값 변경
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean updatePaymentStatus(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	boolean selectCountries(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	boolean selectLanguages(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	boolean getMemberBankAccounts(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	boolean deleteMemberBankAccount(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	boolean registerMemberBankAccount(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	boolean preparePointwithdrawlForm(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	boolean insertPointWithdrawal(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;
	
	boolean updatePointwithdrawal(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	boolean preparePointwithdrawalList(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	boolean generateQR(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	boolean qrCommandControl(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	boolean prepareMemberBankAccountForm(RPMap rPap, RPMap rmap, HttpServletRequest request,HttpServletResponse response) throws Exception ;

	public String handleGiftCardQR(HashMap<String, String> p, ModelMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception;

	public boolean changeMemberConfig(RPMap rPap, RPMap rMap, HttpServletRequest request, HttpServletResponse response);

	boolean prepareJoinProcess(RPMap rPap, RPMap rmap, HttpServletRequest request, HttpServletResponse response);

	boolean sendPhoneAuthSms(RPMap rPap, RPMap rmap, HttpServletRequest request, HttpServletResponse response);

	boolean requestPhoneNumberAuth(RPMap rPap, RPMap rmap, HttpServletRequest request, HttpServletResponse response);

	boolean checkRecommender(RPMap rPap, RPMap rmap, HttpServletRequest request, HttpServletResponse response);

	boolean newJoin(RPMap rPap, RPMap rmap, HttpServletRequest request, HttpServletResponse response);

	boolean sendPasswordAuthSms(RPMap rPap, RPMap rmap, HttpServletRequest request, HttpServletResponse response);

	boolean newLogin(RPMap rPap, RPMap rmap, HttpServletRequest request, HttpServletResponse response);

	
}
