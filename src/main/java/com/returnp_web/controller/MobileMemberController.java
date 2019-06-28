package com.returnp_web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.returnp_web.svc.MobileMemberService;
import com.returnp_web.utils.Const;
import com.returnp_web.utils.RPMap;
import com.returnp_web.utils.Util;

@Controller
@RequestMapping("/m")
public class MobileMemberController extends MallBaseController{

	@Autowired
	private MobileMemberService mms;

	//로그인 view
	@RequestMapping("/member/login")
	public String memberLogin(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/member/login");
		return page(true, map, rmap);
	}

	//로그인 처리
	@RequestMapping("/member/login_act")
	public String memberLoginAct(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.loginAct(Util.toRPap(p), rmap, request, response);
		return act(map, rmap);
	}

	//로그인 성공 후 처리 
	@RequestMapping("/member/login_ok")
	public String memberLoginOk(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		RPMap rmap = Util.getRPRmap("/mobile/member/login_ok");
		return page(true, map, rmap);
	}

	//로그아웃
	@RequestMapping("/member/logout")
	public String memberLogOut(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.logOut(Util.toRPap(p), rmap, request, response);
		return act(map, rmap);
	}

	//회원가입 view
	@RequestMapping("/member/join")
	public String memberJoin(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/member/join");
		boolean bret = mms.selectCountries(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	// 회원가입
	@RequestMapping(value ="/member/join_act" )
	public String memberJoinAct(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.memberJoinAct(Util.toRPap(p), rmap, request, response);
		return act(map, rmap);
	}

	//추천인 조회
	@RequestMapping(value = "/member/selectRecommend", produces = "application/text; charset=utf8")
	@ResponseBody
	public String selectRecommend(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.selectRecommend(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}

	//인증번호 발급
	@RequestMapping(value = "/member/authNumberRequest", produces = "application/text; charset=utf8")
	@ResponseBody
	public String authNumberRequest(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.selectAuthNumberRequest(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}

	//회원조회( ID 암호화 )
	@RequestMapping(value = "/member/selectAuthMember", produces = "application/text; charset=utf8")
	@ResponseBody
	public String selectAuthMember(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.selectAuthMember(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}

	//마이페이지 view
	@RequestMapping("/mypage/mypage_myinfo")
	public String mypageMyinfo(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/mypage/mypage_myinfo");
		boolean bret = mms.mypageMyinfo(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	//정회원신청페이지
	@RequestMapping("/mypage/m_fullmember")
	public String mFullmember(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/mypage/m_fullmember");
		boolean bret = mms.mypageMyinfo(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}
	
	//나의 멤버 리스트 보기 
	@RequestMapping("/mypage/m_myMemberList")
	public String mMyMemberList(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("mMyMemberList");
		RPMap rmap = Util.getRPRmap("/mobile/mypage/m_my_member_list");
		boolean bret = mms.myMemberList(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}
	
	//등록 계좌 리스트 보기  
	@RequestMapping("/mypage/m_mybank_account_list")
	public String mMyBankAccountList(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/mypage/bank_account_list");
		boolean bret = mms.getMemberBankAccounts(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}	
	
	//계좌 등록 및 수정 폼 
	@RequestMapping("/mypage/m_mybank_account_form")
	public String mMyBankAccountForm(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/mypage/regist_bank_account");
		boolean bret = mms.prepareMemberBankAccountForm(Util.toRPap(p), rmap, request, response);
		return page(true, map, rmap);
	}	
	
	//계좌 등록 처리 
	@RequestMapping(value = "/mypage/m_regist_mybank_account",method = RequestMethod.GET)
	@ResponseBody
	public String mRegistBankAccount(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.registerMemberBankAccount(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}	
	
	//계좌 삭제
	@RequestMapping(value = "/mypage/m_delete_bank_account",method = RequestMethod.GET)
	@ResponseBody
	public String mDelBankAccount(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.deleteMemberBankAccount(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}	
	
	//멤버 설정 변경
	@RequestMapping(value = "/mypage/m_change_member_config",method = RequestMethod.GET)
	@ResponseBody
	public String mChangeMemberConfig(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.changeMemberConfig(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}	
		
	//출금 요청 리스트 화면  
	@RequestMapping("/mypage/m_rpay_withdrawal_list")
	public String mPointwithdrawalList(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/mypage/rpay_withdrawal_list");
		boolean bret = mms.preparePointwithdrawalList(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}	
	
	//포인트 출금 신청 폼  
	@RequestMapping(value = "/mypage/m_withdrawl_point_form", method = RequestMethod.GET )
	public String mMyWithdrawalPointForm(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/mypage/rpay_withdrawl_form");
		boolean bret = mms.preparePointwithdrawlForm(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}	
	
	//포인트 출금 신청 처리  
	@RequestMapping(value = "/mypage/m_withdrawal_point_regist", method = RequestMethod.POST )
	@ResponseBody
	public String mSubmitWithdrawl(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.insertPointWithdrawal(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}	
	
	//포인트 출금 신청 수정
	@RequestMapping(value = "/mypage/m_withdrawal_point_update", method = RequestMethod.POST )
	@ResponseBody
	public String mUpdatePointwithdrawal(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.updatePointwithdrawal(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}	
	
	//포인트 사용하기   
	@RequestMapping("/mypage/m_rpay_payment.do")
	public String mRPayPayment(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/mypage/point_use");
		boolean bret = mms.preparePointwithdrawalList(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}	
	
	//포인트 사용하기의 목록 화면 리스트 
	@RequestMapping("/mypage/m_rpay_use_manage.do")
	public String mRPayManageUse(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/mypage/manage_rpay_use");
		boolean bret = mms.preparePointwithdrawalList(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	//QR 코드 관련 기능 관리 페이지 표시
	@RequestMapping("/mypage/manage_qr.do")
	public String mManageQR(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/mypage/manage_qr");
		//boolean bret = mms.mypageMyinfo(Util.toRPap(p), rmap, request, response);
		boolean bret = true;
		return page(bret, map, rmap);
	}	

	//각종 QR 코드 생성 
	@RequestMapping("/mypage/m_gen_qr_code.do")
	public String mGenQrCode(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/mypage/gen_qr");
		boolean bret = mms.generateQR(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}	
	
	//각종 QR 코드 명령 처리 
	@RequestMapping("/mypage/m_qr_command_control.do")
	public String mQrCommandControl(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/error/common_error");
		boolean bret = mms.qrCommandControl(Util.toRPap(p), rmap, request, response);
		
		if (!((String)rmap.get("resultCode")).equals("100")) {
			return page(bret, map, rmap);
		}else {
			System.out.println("redirect");
			System.out.println((String)rmap.getDateStr("redirectUrl"));
			return "redirect:" + rmap.getStr("redirectUrl");
		}
	}	
	
	// 상품권 QR 요청 처리 
	@ResponseBody
	@RequestMapping(value = "/mypage/m_gift_card_command.do", method = RequestMethod.POST)
	public String qrAccProxy(@RequestParam HashMap<String, String> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		return mms.handleGiftCardQR(p, map, request, response);
	}
	
	//언어 선택 페이지 보기  
	@RequestMapping("/mypage/m_selectLanguage")
	public String selectLanguage(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/mypage/m_select_language");
		boolean bret = mms.selectLanguages(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}
	

	//회원정보확인페이지 view
	@RequestMapping("/mypage/mypage_myinfo_confirm")
	public String mypageMyinfoConfirm(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/mypage/mypage_myinfo_confirm");
		boolean bret = mms.myinfoConfirm(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	//회원정보수정페이지 view
	@RequestMapping("/mypage/mypage_myinfo_modify")
	public String mypageMyinfoModify(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/mypage/mypage_myinfo_modify");
		boolean bret = mms.myinfoConfirmModify(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	//회원정보 수정 비밀번호 입력 확인
	@RequestMapping("/mypage/mypage_myinfo_check")
	public String mypageMyinfoModifyCheck(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/mypage/mypage_myinfo_check");
		boolean bret = mms.myinfoConfirmModifyCheck(Util.toRPap(p), rmap, request, response);
		return act(map, rmap);
	}

	// 회원정보 수정 저장
	@RequestMapping(value ="/mypage/member_update_act" )
	public String memberUpdateAct(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.memberUpdateAct(Util.toRPap(p), rmap, request, response);
		return act(map, rmap);
	}

	// 이메일 인증(이메일 수신)
	@RequestMapping(value ="/member/email_sign_act" )
	public String emailSignSuccessAct(@RequestParam(required = false) String memberEmail, ModelMap map, HttpServletRequest request, HttpServletResponse response) throws Exception{
		RPMap rmap = Util.getRPRmap("/mobile/main/index");
		boolean bret = mms.emailSignAct(memberEmail, rmap, request, response);
		return act(map, rmap);
	}

	//EMAIL 찾기 화면 전환
	@RequestMapping("/member/find_email")
	public String memberFindEmail(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/member/find_email");
		return page(true, map, rmap);
	}

	//EMAIL 찾기 act
	@RequestMapping("/member/find_email_act")
	public String findEmail(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.findEmailAct(Util.toRPap(p), rmap, request, response);
		return act(map, rmap);
	}

	//PW 찾기 화면 전환
	@RequestMapping("/member/find_pw")
	public String memberFindPw(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/member/find_pw");
		return page(true, map, rmap);
	}

	//PW 찾기 act
	@RequestMapping("/member/find_pw_act")
	public String findPw(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.findPwAct(Util.toRPap(p), rmap, request, response);
		return act(map, rmap);
	}

	//회원 가입 중복 조회
	@RequestMapping(value = "/member/select_member_validity", produces = "application/text; charset=utf8")
	@ResponseBody
	public String selectMemberValidity(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.selectMemberValidity(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}

	//휴대폰번호 중복 가입 조회
	@RequestMapping(value = "/member/select_phone_overlap", produces = "application/text; charset=utf8")
	@ResponseBody
	public String selectPhoneOverlap(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.selectPhoneOverlap(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}

	//이메일 미인증 고객 이메일 재전송
	@RequestMapping(value ="/member/member_email_confirm_act" )
	@ResponseBody
	public String memberEmailConfirmAct(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.memberEmailConfirmAct(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}

	//정회원 신청
	@RequestMapping("/member/regular_member")
	public String regularMember(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.regularMemberAct(Util.toRPap(p), rmap, request, response);
		return act(map, rmap);
	}

	//회원탈퇴 view
	@RequestMapping("/mypage/mypage_out")
	public String mypageOut(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/mypage/mypage_out");
		boolean bret = mms.myinfoCheck(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	//회원탈퇴
	@RequestMapping(value ="/member/member_out_act" )
	public String memberOutAct(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.memberOutAct(Util.toRPap(p), rmap, request, response);
		return act(map, rmap);
	}


	//정책 - 최종 포인트 최대 적립 금액 조회
	@RequestMapping(value = "/member/policyPointTransLimit", produces = "application/text; charset=utf8")
	@ResponseBody
	public String policyPointTransLimit(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.selectPolicyPointTransLimit(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}

	//포인트선물하기-회원 이메일 조회
	@RequestMapping(value = "/member/select_view_member_information", produces = "application/text; charset=utf8")
	@ResponseBody
	public String selectMemberInfo(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.selectMemberEmailInfo(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}

	//회원가입 유무 조회
	@RequestMapping(value = "/member/qr_select_memberPhone", produces = "application/text; charset=utf8")
	@ResponseBody
	public String selectQrSelectMemberPhone(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.selectQrSelectMemberPhoneInfo(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}

	//휴대폰번호 중복 가입 조회(회원정보수정)
	@RequestMapping(value = "/member/select_phone_overlapModify", produces = "application/text; charset=utf8")
	@ResponseBody
	public String selectPhoneOverlapModify(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.selectPhoneOverlapModify(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}

	//정회원 신청 정보 변경(상태값)
	@RequestMapping(value = "/member/updatePaymentStatus")
	public String paymentStatus(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.updatePaymentStatus(Util.toRPap(p), rmap, request, response);
		return act(map, rmap);
	}
}