package com.returnp_web.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
//import org.springframework.context.MessageSourceAware; 
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.returnp_web.svc.FrontMemberService;
import com.returnp_web.utils.RPMap;
import com.returnp_web.utils.SessionManager;
import com.returnp_web.utils.Util;

@Controller
@RequestMapping
public class FrontMemberController extends MallBaseController{

	@Autowired
	private FrontMemberService fms;
	
	/*@Autowired
	private MessageSourceAware messageSourceAware;

	public void setMessageSource(MessageSource messageSource) throws BeansException {
		this.messageSourceAware = messageSourceAware;
	}*/
	
	//로그인 view
	@RequestMapping("/member/login")
	public String memberLogin(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/member/login");
		return page(true, map, rmap);
	}	
	
	//로그인 처리
	@RequestMapping("/member/login_act")
	public String memberLoginAct(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = fms.loginAct(Util.toRPap(p), rmap, request, response);
		return act(map, rmap);
	}	
	
	//로그아웃
	@RequestMapping("/member/logout")
	public String memberLogOut(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = fms.logOut(Util.toRPap(p), rmap, request, response);
		return act(map, rmap);
	}	
	
	//회원가입 view
	@RequestMapping("/member/join")
	public String memberJoin(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/member/join");
		boolean bret = fms.selectCountries(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}
	
	// 회원가입
	@RequestMapping(value ="/member/join_act" )
	public String memberJoinAct(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = fms.memberJoinAct(Util.toRPap(p), rmap, request, response);
		return act(map, rmap);
	}
	
	//추천인 조회
	@RequestMapping(value = "/member/selectRecommend", produces = "application/text; charset=utf8")
	@ResponseBody
	public String selectRecommend(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = fms.selectRecommend(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}	
	
	//인증번호 발급
	@RequestMapping(value = "/member/authNumberRequest", produces = "application/text; charset=utf8")
	@ResponseBody
	public String authNumberRequest(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = fms.selectAuthNumberRequest(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}
	
	//회원조회( ID 암호화 )
	@RequestMapping(value = "/member/selectAuthMember", produces = "application/text; charset=utf8")
	@ResponseBody
	public String selectAuthMember(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = fms.selectAuthMember(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json"); 
	}		

	//마이페이지 view
	@RequestMapping("/mypage/mypage_myinfo")
	public String mypageMyinfo(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mypage/mypage_myinfo");
		boolean bret = fms.mypageMyinfo(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}
	
	//회원정보확인페이지 view
	@RequestMapping("/mypage/mypage_myinfo_confirm")
	public String mypageMyinfoConfirm(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mypage/mypage_myinfo_confirm");
		boolean bret = fms.myinfoConfirm(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}
	
	//회원정보수정페이지 view
	@RequestMapping("/mypage/mypage_myinfo_modify")
	public String mypageMyinfoModify(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mypage/mypage_myinfo_modify");
		boolean bret = fms.myinfoConfirmModify(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}
	
	//회원정보 수정 비밀번호 입력 확인
	@RequestMapping("/mypage/mypage_myinfo_check")
	public String mypageMyinfoModifyCheck(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mypage/mypage_myinfo_check");
		boolean bret = fms.myinfoConfirmModifyCheck(Util.toRPap(p), rmap, request, response);
		return act(map, rmap);
	}
	
	// 회원정보 수정 저장
	@RequestMapping(value ="/mypage/member_update_act" )
	public String memberUpdateAct(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = fms.memberUpdateAct(Util.toRPap(p), rmap, request, response);
		return act(map, rmap);
	}
	
	// 이메일 인증(이메일 수신)
	@RequestMapping(value ="/member/email_sign_act" )
	public String emailSignSuccessAct(@RequestParam(required = false) String memberEmail, ModelMap map, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/main/index");
		boolean bret = fms.emailSignAct(memberEmail, rmap, request, response);
		return act(map, rmap);
	}
	
	//EMAIL 찾기 화면 전환
	@RequestMapping("/member/find_email")
	public String memberFindEmail(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/member/find_email");
		return page(true, map, rmap);
	}

	//EMAIL 찾기 act
	@RequestMapping("/member/find_email_act")
	public String findEmail(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = fms.findEmailAct(Util.toRPap(p), rmap, request, response);
		return act(map, rmap);
	}
	
	//PW 찾기 화면 전환
	@RequestMapping("/member/find_pw")
	public String memberFindPw(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/member/find_pw");
		return page(true, map, rmap);
	}

	//PW 찾기 act
	@RequestMapping("/member/find_pw_act")
	public String findPw(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = fms.findPwAct(Util.toRPap(p), rmap, request, response);
		return act(map, rmap);
	}
	
	//회원 가입 중복 조회
	@RequestMapping(value = "/member/select_member_validity", produces = "application/text; charset=utf8")
	@ResponseBody
	public String selectMemberValidity(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = fms.selectMemberValidity(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}	
	
	//휴대폰번호 중복 가입 조회
	@RequestMapping(value = "/member/select_phone_overlap", produces = "application/text; charset=utf8")
	@ResponseBody
	public String selectPhoneOverlap(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = fms.selectPhoneOverlap(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}
	
	//이메일 미인증 고객 이메일 재전송
	@RequestMapping(value ="/member/member_email_confirm_act" )
	@ResponseBody
	public String memberEmailConfirmAct(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = fms.memberEmailConfirmAct(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}

	//정회원 신청
	@RequestMapping("/member/regular_member")
	public String regularMember(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = fms.regularMemberAct(Util.toRPap(p), rmap, request, response);
		return act(map, rmap);
	}
	
	//회원탈퇴 view
	@RequestMapping("/mypage/mypage_out")
	public String mypageOut(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mypage/mypage_out");
		boolean bret = fms.myinfoCheck(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}
	
	//회원탈퇴
	@RequestMapping(value ="/member/member_out_act" )
	public String memberOutAct(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = fms.memberOutAct(Util.toRPap(p), rmap, request, response);
		return act(map, rmap);
	}
	
	
	//정책 - 최종 포인트 최대 적립 금액 조회 
	@RequestMapping(value = "/member/policyPointTransLimit", produces = "application/text; charset=utf8")
	@ResponseBody
	public String policyPointTransLimit(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = fms.selectPolicyPointTransLimit(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}	
	
	//포인트선물하기-회원 이메일 조회
	@RequestMapping(value = "/member/select_view_member_information", produces = "application/text; charset=utf8")
	@ResponseBody
	public String selectMemberInfo(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = fms.selectMemberEmailInfo(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}	
	
	//회원가입 유무 조회
	@RequestMapping(value = "/member/qr_select_memberPhone", produces = "application/text; charset=utf8")
	@ResponseBody
	public String selectQrSelectMemberPhone(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = fms.selectQrSelectMemberPhoneInfo(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}
	
	//휴대폰번호 중복 가입 조회(회원정보수정)
	@RequestMapping(value = "/member/select_phone_overlapModify", produces = "application/text; charset=utf8")
	@ResponseBody
	public String selectPhoneOverlapModify(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = fms.selectPhoneOverlapModify(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}
	
	//정회원 신청 정보 변경(상태값)
	@RequestMapping(value = "/member/updatePaymentStatus")
	public String paymentStatus(@RequestParam Map<String,Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = fms.updatePaymentStatus(Util.toRPap(p), rmap, request, response);
		return act(map, rmap);
	}	
	
}