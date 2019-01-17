package com.returnp_web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.context.MessageSourceAware;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.returnp_web.svc.FrontMainService;
import com.returnp_web.utils.RPMap;
import com.returnp_web.utils.Util;

@Controller
@RequestMapping
public class FrontController extends MallBaseController {

	@Autowired
	private FrontMainService fms;

	/*
	 * @Autowired private MessageSourceAware messageSourceAware;
	 *
	 * public void setMessageSource(MessageSource messageSource) throws
	 * BeansException { this.messageSourceAware = messageSourceAware; }
	 */

	// 프론트 메인페이지
	@RequestMapping("/main/index.do")
	public String home(@RequestParam(required = false) String lang, @RequestParam Map<String, Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/main/index");
		return page(true, map, rmap);
	}

	// 서비스 안내
	@RequestMapping("/company/service_member")
	public String serviceInfo(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session) throws Exception {
		RPMap rmap = Util.getRPRmap("/company/service_member");
		return page(true, map, rmap);
	}

	// 회사소개
	@RequestMapping("/company/company_identity")
	public String companyInfo(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session) throws Exception {
		RPMap rmap = Util.getRPRmap("/company/company_identity");
		return page(true, map, rmap);
	}

	// 포인트 조회
	@RequestMapping("/mypage/point")
	public String myPoint(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mypage/point");
		boolean bret = fms.myPointInfo(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	// 포인트 전환 실행
	@RequestMapping("/mypage/pointTransactionAct")
	@ResponseBody
	public String pointConvert(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = fms.pointConvertRequest(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}

	// 포인트 전환 화면
	@RequestMapping("/mypage/point_transfer")
	public String pointTransfer(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mypage/point_transfer");
		boolean bret = fms.myPointInfo(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	// 포인트 조회
	@RequestMapping("/mypage/newpoint")
	public String myNewPoint(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mypage/newpoint");
		boolean bret = fms.myPointInfo(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	// 페이 조회
	@RequestMapping("/mypage/newpay")
	public String myNewPay(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mypage/newpay");
		boolean bret = fms.myPointInfo(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	// 포인트 조회
	@RequestMapping("/mypage/point_gift")
	public String myPointGift(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mypage/point_gift");
		boolean bret = fms.myPointInfo(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	// 페이 조회
	@RequestMapping("/mypage/pay_gift")
	public String myPayGift(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mypage/pay_gift");
		boolean bret = fms.myPointInfo(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	// red point 선물하기
	@RequestMapping("/mypage/redPointTransactionAct")
	@ResponseBody
	public String redPointConvert(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = fms.redPointConvertRequest(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}

	// green point 선물하기
	@RequestMapping("/mypage/greenPointTransactionAct")
	@ResponseBody
	public String greenPointConvert(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = fms.greenPointConvertRequest(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}

	// sms 로 추천하기
	@RequestMapping("/mypage/recommend_sms")
	public String recommendSms(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mypage/recommend_sms");
		boolean bret = fms.myinfo(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	// QR 코드 정보 생성
	@RequestMapping("/qr/qrinfo")
	public String qrInfo(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/qr/qrinfo");
		boolean bret = fms.qrImgView(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	// QR 코드 적립 요청 Procy
	@ResponseBody
	@RequestMapping(value = "/qr/qrAcc", method = RequestMethod.POST)
	public String qrAccProxy(@RequestParam HashMap<String, String> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		return fms.qrAccProxy(p, map, request, response);
	}

	// 내주변 상가 찾기
	@RequestMapping("/map/rpmap")
	public String map(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/map/rpmap");
		return page(true, map, rmap);
	}

	// 내주변 상가 상세
	@RequestMapping("/map/rp_shop")
	public String shop(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/map/rp_shop");
		return page(true, map, rmap);
	}

	// 자주하는 질문
	@RequestMapping("/board/faq")
	public String bFaq(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/board/faq");
		boolean bret = fms.faq(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	// 일반상담
	@RequestMapping("/board/qna")
	public String bQna(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/board/qna");
		return page(true, map, rmap);
	}

	// 일반상담
	@RequestMapping("/board/qna_w")
	public String bQna_w(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/board/qna_w");
		return page(true, map, rmap);
	}

	// 등급상담
	@RequestMapping("/board/qna_node")
	public String bQna_node(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/board/qna_node");
		return page(true, map, rmap);
	}

	// 등급상담
	@RequestMapping("/board/qna_node_w")
	public String bQna_node_w(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/board/qna_node_w");
		return page(true, map, rmap);
	}

	// 게시판메인
	@RequestMapping("/board/notice")
	public String bNotice(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/board/notice");
		boolean bret = fms.notice(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	// 게시판메인
	@RequestMapping("/board/board")
	public String bBoard(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/board/board");
		return page(true, map, rmap);
	}

	/*
	 * @RequestMapping("경로") public String 함수명(@RequestParam Map<String,Object> p,
	 * ModelMap map, HttpSession session, HttpServletRequest request,
	 * HttpServletResponse response) throws Exception{ RPMap rmap =
	 * Util.getRPRmap("경로"); return page(true, map, rmap); }
	 */

	// 그린포인트 상세 조회
	@RequestMapping(value = "/mypage/paymentPointbackRecordDetail", produces = "application/text; charset=utf8")
	@ResponseBody
	public String paymentPointbackRecordDetail(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = fms.paymentPointbackRecordDetail(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}

	// 레드포인트 상세 조회
	@RequestMapping(value = "/mypage/pointConversionTransactionDetail", produces = "application/text; charset=utf8")
	@ResponseBody
	public String pointConversionTransactionDetail(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = fms.pointConversionTransactionDetail(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}

	// 내주변 상가 찾기 -> 로딩시에 호출하여 사용
	@RequestMapping(value = "/map/rpmapLoadAct", produces = "application/json; charset=utf8")
	@ResponseBody
	public Object rpmapLoadAct(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = fms.rpmapLoadAct(Util.toRPap(p), rmap, request, response);
		return rmap.get("json");
	}

	// FAQ더보기
	@RequestMapping(value = "/board/faqMoreAct", produces = "application/text; charset=utf8")
	@ResponseBody
	public String faqMoreAct(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = fms.faqMoreAct(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}

	// 공지사항 더보기
	@RequestMapping(value = "/board/noticeMoreAct", produces = "application/text; charset=utf8")
	@ResponseBody
	public String MoreAct(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = fms.noticeMoreAct(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}

}