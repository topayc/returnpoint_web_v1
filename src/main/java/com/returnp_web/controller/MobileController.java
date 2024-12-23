package com.returnp_web.controller;

import java.util.ArrayList;
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
import com.returnp_web.svc.MobileMainService;
import com.returnp_web.utils.RPMap;
import com.returnp_web.utils.SessionManager;
import com.returnp_web.utils.Util;

@Controller
@RequestMapping("/m")
public class MobileController extends MallBaseController {

	@Autowired
	private MobileMainService mms;
	@Autowired
	private FrontMainService fms;

	// intro 페이지
	@RequestMapping("/intro/intro.do")
	public String intro(@RequestParam(required = false) String lang, @RequestParam Map<String, Object> p,
			ModelMap modelMap, HttpSession session, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		RPMap dataMap = Util.getRPRmap("/mobile/intro/intro");
		boolean bret = true;
		/*
		 * v : 밴사 이름 tid : 해당 밴사에서 설치한 포스의 tid
		 */
		if (p.containsKey("v") && p.get("v") != null && p.containsKey("tid") && p.get("tid") != null) {
			bret = mms.prepareIntro(Util.toRPap(p), dataMap, request, response);
		}
		return page(bret, modelMap, dataMap);
	}

	// 모바일 메인페이지
	@RequestMapping("/main/index.do")
	public String home(@RequestParam(required = false) String lang, @RequestParam Map<String, Object> p, ModelMap map,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/main/index");
		boolean bret = mms.initMain(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}
	
	// 포인트 쿠폰 메인 페이지 
	@RequestMapping("/pointCoupon/index.do")
	public String pointCouponMain(@RequestParam(required = false) String lang, @RequestParam Map<String, Object> p, ModelMap map,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/pointCoupon/index");
		boolean bret =  mms.initPointCodeMain(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	// 포인트 쿠폰 입금 확인 요청 
	@RequestMapping(value = "/pointCoupon/checkDepositRequest.do", produces = "application/text; charset=utf8")
	@ResponseBody
	public String checkDepositRequest(@RequestParam(required = false) String lang, @RequestParam Map<String, Object> p, ModelMap map,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.checkDepositRequest(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}
	
	// 포인트 코드 사용 설명 페이지  
		@RequestMapping("/pointCoupon/help.do")
		public String pointCodeHelp(@RequestParam(required = false) String lang, @RequestParam Map<String, Object> p, ModelMap map,
				HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
			RPMap rmap = Util.getRPRmap("/mobile/pointCoupon/help");
			return page(true, map, rmap);
		}
		
		// 포인트 쿠폰 메인 페이지 
		@RequestMapping("/pointCoupon/help2.do")
		public String pointCodeHelp2(@RequestParam(required = false) String lang, @RequestParam Map<String, Object> p, ModelMap map,
				HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
			RPMap rmap = Util.getRPRmap("/mobile/pointCoupon/help2");
			return page(true, map, rmap);
		}
	
	// 영수증 업로드 폼 
	@RequestMapping(value = "/pointCoupon/uploadReceipt.do",  method = RequestMethod.GET)
	public String uploadReceiptForm(@RequestParam(required = false) String lang, @RequestParam Map<String, Object> p, ModelMap map,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = null;
		if (((String)p.get("receiptType")).equals("1")) {
			rmap = Util.getRPRmap("/mobile/pointCoupon/uploadAffilaiteReceipt");
		}else if (((String)p.get("receiptType")).equals("2")) {
			rmap = Util.getRPRmap("/mobile/pointCoupon/uploadCommonReceipt");
		}
		boolean bret = mms.uploadReceiptForm(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}
	
	// 영수증 업로드 액션
	@ResponseBody
	@RequestMapping(value = "/pointCoupon/uploadReceipt.do", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String uploadReceipt(@RequestParam(required = false) String lang, @RequestParam Map<String, Object> p, ModelMap map,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.uploadReceipt(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}
	
	//포인트 코드 세부 정보 
	@RequestMapping(value = "/pointCoupon/pointCodeInfo.do", method = RequestMethod.GET)
	public String pointCodeDetail(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/pointCoupon/pointCodeInfo");
		boolean bret = mms.showPointCodeInfo(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}
	
	// 영수증 업로드 내역 세부 페이지 
	@RequestMapping("/pointCoupon/receiptDetail.do")
	public String receiptCommonDetail(@RequestParam(required = false) String lang, @RequestParam Map<String, Object> p, ModelMap map,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewPage = ((String)p.get("issueType")).equals("1") ? "/mobile/pointCoupon/affiliateReceiptDetail" : "/mobile/pointCoupon/commonReceiptDetail";
		RPMap rmap = Util.getRPRmap(viewPage);
		boolean bret =  mms.selectReceiptDetailInfo(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}
	
	// 영수증 적립 코드 적립 프로세스
	@ResponseBody
	@RequestMapping(value = "/pointCode/accPointCode", method = RequestMethod.POST)
	public String accPointCode(@RequestParam HashMap<String, String> paramMap, ModelMap modelMap, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		return mms.accPointCode(paramMap, modelMap, request, response);
	}
	
	// WEB 가맹점찾기
	@RequestMapping("/affiliate/affiliateSearchList")
	public String franchiseeInfoSearch(@RequestParam HashMap<String, Object> params, HttpSession session,
			HttpServletRequest request, HttpServletResponse response, ModelMap map) throws Exception {

		/**** Paging *******************/
		int page = 1; // 현재 선택된 페이지
		int upperPage = 1; // 현재 선택된 상위페이지
		int recordCount = 0; // 데이터 총 갯수
		int recordPerPage = 20; // 페이지당 레코드수
		int pageCount = 1; // 페이지 총 갯수
		int upperPageCount = 1; // 상위페이지수
		int pagePerUpperPage = 5; // 한화면에 보여지는 페이지수
		int s_seq = 0;
		int e_seq = 0;
		/*****************************/

		try {
			if (params.get("city") != null) {
				String affiliateAddress = params.get("city").toString() + " " + params.get("country").toString();
				params.put("affiliateAddress", affiliateAddress);
			}

			recordCount = fms.selectWebFranchiseeInfoListTotalCount(params);
			pageCount = (int) Math.ceil((double) recordCount / recordPerPage); // 페이지 총 갯수

			if (params.get("page") != null)
				page = Integer.parseInt(params.get("page").toString()); // 현재 페이지
			if (params.get("upperPage") != null)
				upperPage = Integer.parseInt(params.get("upperPage").toString()); // 현재 선택된 상위페이지
			if (params.get("recordPerPage") != null)
				recordPerPage = Integer.parseInt(params.get("recordPerPage").toString()); // 페이지당 레코드수

			s_seq = (page - 1) * recordPerPage + 1; // s_seq = 현재페이지 * 페이지당레코드
			e_seq = page * recordPerPage;

			upperPageCount = (int) Math.ceil((double) pageCount / pagePerUpperPage); // 올림(토탈페이지수 / 슈퍼페이지당 페이지)

			params.put("page", page);
			params.put("upperPage", upperPage);
			params.put("recordCount", recordCount);
			params.put("recordPerPage", recordPerPage);
			params.put("pageCount", pageCount);
			params.put("upperPageCount", upperPageCount);
			params.put("pagePerUpperPage", pagePerUpperPage);
			params.put("S_SEQ", s_seq);
			params.put("E_SEQ", e_seq);
			params.put("breakValue", "N");

			ArrayList<HashMap<String, Object>> franchiseeInfoList = fms.selectWebFranchiseeInfoSearchList(params);

			map.addAttribute("franchiseeInfoList", franchiseeInfoList);
			map.addAttribute("params", params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/mobile/affiliate/affiliateSearchList";
	}

	/*
	 * 가맹점 구성을 위한 페이지 및 가맹점 카테고리 정보 가져오기
	 */
	@RequestMapping("/affiliate/newAffiliateSearch")
	public String searchAffilaite(@RequestParam Map<String, Object> paramMap, ModelMap modelMap,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/affiliate/newAffiliateSearch");
		boolean bret = mms.prepareNewAffiliateSearch(Util.toRPap(paramMap), rmap, request, response);
		return page(bret, modelMap, rmap);
	}

	/*
	 * 카테고리별 가맹점 리스트 찾기
	 */
	@RequestMapping(value = "/affiliate/findAffiliateByCate", method = RequestMethod.GET)
	@ResponseBody
	public ArrayList<HashMap<String, Object>> searchAffilaiteByCategory(@RequestParam Map<String, Object> paramMap,
			ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
		return mms.findAffiliatesByCate(paramMap, request, response);
	}

	// WEB 제휴안내 저장
	@ResponseBody
	@RequestMapping(value = "/board/partnerAskSave", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public Map<String, Object> partnerAskSave(@RequestParam HashMap<String, Object> params, HttpSession session,
			HttpServletRequest request, HttpServletResponse response, ModelMap map) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		SessionManager sm = new SessionManager(request, response);
		try {
			params.put("writerNo", sm.getMemberNo());
			fms.insertMainBbsPartnerAskSave(params);
			resultMap.put("code", "1");
		} catch (Exception e) {
			// resultMap.put("message", e.getMessage());
			return resultMap;
		}
		return resultMap;
	}

	// 프론트 메인페이지
	@RequestMapping("/affiliate/affiliateSearch.do")
	public String affiliateSearch(@RequestParam(required = false) String lang, @RequestParam Map<String, Object> p,
			ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/affiliate/affiliateSearch");
		// mms.memberTotal(Util.toRPap(p), rmap, request, response);
		// boolean bret = mms.myPointInfo(Util.toRPap(p), rmap, request, response);
		boolean bret = true;
		return page(bret, map, rmap);
	}

	@RequestMapping("/point/pointInfo.do")
	public String pointInfo(@RequestParam(required = false) String lang, @RequestParam Map<String, Object> p,
			ModelMap map, HttpSession session, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/point/point_info");
		boolean bret = mms.initMain(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	// 서비스 안내
	@RequestMapping("/company/service_member")
	public String serviceInfo(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/company/service_member");
		return page(true, map, rmap);
	}

	// 회사소개
	@RequestMapping("/company/company_identity")
	public String companyInfo(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/company/company_identity");
		return page(true, map, rmap);
	}

	// 포인트 조회
	@RequestMapping("/mypage/point")
	public String myPoint(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/mypage/point");
		boolean bret = mms.myPointInfo(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	// 포인트 전환 실행
	@RequestMapping("/mypage/pointTransactionAct")
	@ResponseBody
	public String pointConvert(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.pointConvertRequest(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}

	// 포인트 전환 화면
	@RequestMapping("/mypage/point_transfer")
	public String pointTransfer(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/mypage/point_transfer");
		boolean bret = mms.myPointInfo(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	// 포인트 조회
	@RequestMapping("/mypage/newpoint")
	public String myNewPoint(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/mypage/newpoint");
		boolean bret = mms.myPointInfo(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	// 포인트 쿠폰 세부 적립 정보 조회
	/*
	 * @RequestMapping("/mypage/point_coupon_info") public String
	 * pointDetailAccInfo(@RequestParam Map<String, Object> p, ModelMap map,
	 * HttpSession session, HttpServletRequest request, HttpServletResponse
	 * response) throws Exception { RPMap rmap =
	 * Util.getRPRmap("/mobile/mypage/point_coupon_info"); boolean bret =
	 * mms.pointDetailAccInfo(Util.toRPap(p), rmap, request, response); return
	 * page(bret, map, rmap); }
	 */

	// 포인트 적립 코드 소개
	@RequestMapping(value = "/coupon/point_coupon", method = RequestMethod.GET)
	public String pointCoupon(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/coupon/point_coupon");
		return page(true, map, rmap);
	}

	// G 포인트 적립권 등록 폼
	@RequestMapping(value = "/coupon/point_coupon_reg", method = RequestMethod.GET)
	public String regGpointCouponForm(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/coupon/point_coupon_reg");
		return page(true, map, rmap);
	}

	// G 포인트 적립권 세부 정도
	@RequestMapping(value = "/coupon/detail_point_coupon_info", method = RequestMethod.GET)
	public String showPointCouponInfo(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/coupon/point_coupon_info");
		boolean bret = mms.showPointCouponInfo(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	// G 포인트 적립권 등록 프로세스
	@ResponseBody
	@RequestMapping(value = "/coupon/acc_point_coupon", method = RequestMethod.POST)
	public String accPointCoupon(@RequestParam HashMap<String, String> paramMap, ModelMap modelMap, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		return mms.accPointCoupon(paramMap, modelMap, request, response);
	}

	// 페이 조회
	@RequestMapping("/mypage/newpay")
	public String myNewPay(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/mypage/newpay");
		boolean bret = mms.myPointInfo(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	// G 포인트 선물
	/*
	 * @RequestMapping("/mypage/point_gift") public String myPointGift(@RequestParam
	 * Map<String, Object> p, ModelMap map, HttpSession session, HttpServletRequest
	 * request, HttpServletResponse response) throws Exception { RPMap rmap =
	 * Util.getRPRmap("/mobile/mypage/point_gift"); boolean bret =
	 * mms.myPointInfo(Util.toRPap(p), rmap, request, response); return page(bret,
	 * map, rmap); }
	 */

	// 페이 조회
	@RequestMapping("/mypage/pay_gift")
	public String myPayGift(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/mypage/pay_gift");
		boolean bret = mms.myPointInfo(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	// red point 선물하기
	@RequestMapping("/mypage/redPointTransactionAct")
	@ResponseBody
	public String redPointConvert(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.redPointConvertRequest(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}

	// green point 선물하기
	@RequestMapping("/mypage/greenPointTransactionAct")
	@ResponseBody
	public String greenPointConvert(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.greenPointConvertRequest(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}

	// sms 로 친구 추천
	@RequestMapping("/mypage/recommend_sms")
	public String recommender_sms(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/mypage/recommend_sms");
		boolean bret = mms.myPointInfo(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	/*
	 * KICC 전용 QR 포맷 QR 코드 정보 생성
	 */
	@RequestMapping("/qr/kiccQrinfo")
	public String kiccQrinfo(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/qr/qrinfo");
		boolean bret = mms.kiccQrImgView(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	/*
	 * KICC 외의 표준 QR 포맷 QR 코드 정보 생성
	 */
	@RequestMapping("/qr/commonQrinfo")
	public String qrInfo(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/qr/qrinfo");
		boolean bret = mms.commonQrImgView(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	@RequestMapping("/qr/giftcard_qrinfo")
	public String giftCardQrInfo(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/qr/giftCardQrInfo");
		boolean bret = mms.giftCardQrImgView(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	// KICC QR 코드 적립 요청 Procy
	@ResponseBody
	@RequestMapping(value = "/qr/kiccQrAcc", method = RequestMethod.POST)
	public String kiccQrAcc(@RequestParam HashMap<String, String> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		return mms.kiccQrAccProxy(p, map, request, response);
	}

	// KICC QR 외의 일반 QR 적립 요청 Procy
	@ResponseBody
	@RequestMapping(value = "/qr/commonQrAcc", method = RequestMethod.POST)
	public String commonQrAcc(@RequestParam HashMap<String, String> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		return mms.commonQrAccProxy(p, map, request, response);
	}

	// 내주변 상가 찾기
	@RequestMapping("/map/rpmap")
	public String map(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/map/rpmap");
		return page(true, map, rmap);
	}

	// 내주변 상가 상세
	@RequestMapping("/map/rp_shop")
	public String shop(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/map/rp_shop");
		return page(true, map, rmap);
	}

	// 자주하는 질문
	@RequestMapping("/board/faq")
	public String bFaq(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/board/faq");
		boolean bret = mms.faq(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	// 일반상담
	@RequestMapping("/board/qna")
	public String bQna(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/board/qna");
		boolean bret = mms.qna(Util.toRPap(p), rmap, request, response);
		return page(true, map, rmap);
	}

	// 일반상담
	@RequestMapping("/board/qna_w")
	public String bQna_w(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/board/qna_w");
		return page(true, map, rmap);
	}

	// 일반상담 글쓰기
	@RequestMapping(value = "/member/saveQnaW_act")
	public String saveQnaWAct(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.saveQnaWAct(Util.toRPap(p), rmap, request, response);
		return act(map, rmap);
	}

	// 등급상담
	@RequestMapping("/board/qna_node")
	public String bQna_node(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/board/qna_node");
		boolean bret = mms.qnaNode(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	// 등급상담
	@RequestMapping("/board/qna_node_w")
	public String bQna_node_w(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/board/qna_node_w");
		SessionManager sm = new SessionManager(request, response);
		rmap.put("memberEmail", sm.getMemberEmail());
		return page(true, map, rmap);
	}

	// 등급상담 글쓰기
	@RequestMapping(value = "/member/saveQnaNodeW_act")
	public String saveQnaNodeWAct(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.saveQnaNodeWAct(Util.toRPap(p), rmap, request, response);
		return act(map, rmap);
	}

	// 게시판메인
	@RequestMapping("/board/notice")
	public String bNotice(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/board/notice");
		boolean bret = mms.notice(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	// 고객 센터 메인
	@RequestMapping("/customer/customerCenter")
	public String bBoard(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/customer/customerCenter");
		return page(true, map, rmap);
	}

	// 이벤트상세(임시)
	@RequestMapping("/board/event")
	public String bEvent(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/board/event");
		return page(true, map, rmap);
	}

	// 그린포인트 상세 조회
	@RequestMapping(value = "/mypage/paymentPointbackRecordDetail", produces = "application/text; charset=utf8")
	@ResponseBody
	public String paymentPointbackRecordDetail(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.paymentPointbackRecordDetail(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}

	// 레드포인트 상세 조회
	@RequestMapping(value = "/mypage/pointConversionTransactionDetail", produces = "application/text; charset=utf8")
	@ResponseBody
	public String pointConversionTransactionDetail(@RequestParam Map<String, Object> p, ModelMap map,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.pointConversionTransactionDetail(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}

	// 내주변 상가 찾기 -> 로딩시에 호출하여 사용
	@RequestMapping(value = "/map/rpmapLoadAct", produces = "application/json; charset=utf8")
	@ResponseBody
	public Object rpmapLoadAct(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.rpmapLoadAct(Util.toRPap(p), rmap, request, response);
		return rmap.get("json");
	}

	// 업체 세부 정보 보기
	@RequestMapping(value = "/affiliate/affiliateDetail")
	public Object viewAffilaiteDetail(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/affiliate/affiliateDetail");
		boolean bret = mms.viewAffiliateDetail(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	// 리뷰 폼
	@RequestMapping(value = "/affiliate/reviewForm")
	public Object reviewForm(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/affiliate/reviewForm");
		boolean bret = mms.viewAffiliateDetail(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}

	// FAQ더보기
	@RequestMapping(value = "/board/faqMoreAct", produces = "application/text; charset=utf8")
	@ResponseBody
	public String faqMoreAct(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.faqMoreAct(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}

	// 공지사항 더보기
	@RequestMapping(value = "/board/noticeMoreAct", produces = "application/text; charset=utf8")
	@ResponseBody
	public String MoreAct(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.noticeMoreAct(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}

	// 모바일 회원가입-이용약관
	@RequestMapping("/company/m_termsofuse")
	public String mtermsofuse(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/company/m_termsofuse");
		return page(true, map, rmap);
	}

	// 모바일 회원가입-개인정보 수집 및 이용
	@RequestMapping("/company/m_privacypolicy")
	public String mprivacypolicy(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/company/m_privacypolicy");
		return page(true, map, rmap);
	}

	// 로그인->이메일미인증고객->이메일인증 발송 페이지로 이동
	@RequestMapping("/member/m_emailconfirm")
	public String memailconfirm(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/member/m_emailconfirm");
		return page(true, map, rmap);
	}

	// 회원가입 완료 페이지
	@RequestMapping("/member/m_joincomplete")
	public String mjoincomplete(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/member/m_joincomplete");
		return page(true, map, rmap);
	}

	// 탈퇴완료 페이지
	@RequestMapping("/mypage/m_memberout")
	public String mmemberout(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/mypage/m_memberout");
		return page(true, map, rmap);
	}

	// G포인트 선물하기 모달(회원)
	/*
	 * @RequestMapping("/mypage/m_gpoint_gift") public String
	 * mGpointGift(@RequestParam Map<String, Object> p, ModelMap map, HttpSession
	 * session, HttpServletRequest request, HttpServletResponse response) throws
	 * Exception { RPMap rmap = Util.getRPRmap("/mobile/mypage/m_gpoint_gift");
	 * boolean bret = mms.myPointInfo(Util.toRPap(p), rmap, request, response);
	 * return page(bret, map, rmap); }
	 */

	// G포인트 선물하기 모달(정직원)
	/*
	 * @RequestMapping("/mypage/m_gpoint_gift1") public String
	 * mGpointGift1(@RequestParam Map<String, Object> p, ModelMap map, HttpSession
	 * session, HttpServletRequest request, HttpServletResponse response) throws
	 * Exception { RPMap rmap = Util.getRPRmap("/mobile/mypage/m_gpoint_gift1");
	 * boolean bret = mms.myPointInfo(Util.toRPap(p), rmap, request, response);
	 * return page(bret, map, rmap); }
	 */

	// G포인트 선물하기 모달(2)
	/*
	 * @RequestMapping("/mypage/m_gpoint_gift2") public String
	 * mGpointGift2(@RequestParam Map<String, Object> p, ModelMap map, HttpSession
	 * session, HttpServletRequest request, HttpServletResponse response) throws
	 * Exception { RPMap rmap = Util.getRPRmap("/mobile/mypage/m_gpoint_gift2");
	 * boolean bret = mms.myPointInfo(Util.toRPap(p), rmap, request, response);
	 * return page(bret, map, rmap); }
	 */

	// G포인트 선물하기 모달(3)
	/*
	 * @RequestMapping("/mypage/m_gpoint_gift3") public String
	 * mGpointGift3(@RequestParam Map<String, Object> p, ModelMap map, HttpSession
	 * session, HttpServletRequest request, HttpServletResponse response) throws
	 * Exception { RPMap rmap = Util.getRPRmap("/mobile/mypage/m_gpoint_gift3");
	 * boolean bret = mms.myPointInfo(Util.toRPap(p), rmap, request, response);
	 * return page(bret, map, rmap); }
	 */

	// G포인트 선물하기 모달(4)
	/*
	 * @RequestMapping("/mypage/m_gpoint_gift4") public String
	 * mGpointGift4(@RequestParam Map<String, Object> p, ModelMap map, HttpSession
	 * session, HttpServletRequest request, HttpServletResponse response) throws
	 * Exception { RPMap rmap = Util.getRPRmap("/mobile/mypage/m_gpoint_gift4");
	 * boolean bret = mms.myPointInfo(Util.toRPap(p), rmap, request, response);
	 * return page(bret, map, rmap); }
	 */

	// G포인트 선물하기 모달(지사)
	/*
	 * @RequestMapping("/mypage/m_gpoint_gift5") public String
	 * mGpointGift5(@RequestParam Map<String, Object> p, ModelMap map, HttpSession
	 * session, HttpServletRequest request, HttpServletResponse response) throws
	 * Exception { RPMap rmap = Util.getRPRmap("/mobile/mypage/m_gpoint_gift5");
	 * boolean bret = mms.myPointInfo(Util.toRPap(p), rmap, request, response);
	 * return page(bret, map, rmap); }
	 */

	// G포인트 선물하기 모달(6)
	/*
	 * @RequestMapping("/mypage/m_gpoint_gift6") public String
	 * mGpointGift6(@RequestParam Map<String, Object> p, ModelMap map, HttpSession
	 * session, HttpServletRequest request, HttpServletResponse response) throws
	 * Exception { RPMap rmap = Util.getRPRmap("/mobile/mypage/m_gpoint_gift6");
	 * boolean bret = mms.myPointInfo(Util.toRPap(p), rmap, request, response);
	 * return page(bret, map, rmap); }
	 */

	// R포인트 선물하기 모달
	/*
	 * @RequestMapping("/mypage/m_rpoint_gift") public String
	 * mRpointGift(@RequestParam Map<String, Object> p, ModelMap map, HttpSession
	 * session, HttpServletRequest request, HttpServletResponse response) throws
	 * Exception { RPMap rmap = Util.getRPRmap("/mobile/mypage/m_rpoint_gift");
	 * boolean bret = mms.myPointInfo(Util.toRPap(p), rmap, request, response);
	 * return page(bret, map, rmap); }
	 */

	/*
	 * 게시글 가져오기
	 */
	@RequestMapping("/board/boardList")
	public String getBoardList(@RequestParam Map<String, Object> paramMap, ModelMap modelMap, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/board/boardList");
		boolean bret = mms.getBoardList(Util.toRPap(paramMap), rmap, request, response);
		return page(bret, modelMap, rmap);
	}

	/*
	 * 게시글 가져오기
	 */
	@RequestMapping("/board/boardDetail")
	public String getBoardDetail(@RequestParam Map<String, Object> paramMap, ModelMap modelMap, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/board/board_detail");
		boolean bret = mms.getBoardReply(Util.toRPap(paramMap), rmap, request, response);
		return page(bret, modelMap, rmap);
	}
	
	/*
	 * 나의 알림 가져오기
	 */
	@RequestMapping("/board/memberNotiList")
	public String getMemberNotiList(@RequestParam Map<String, Object> paramMap, ModelMap modelMap, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/board/memberNotiList");
		boolean bret = mms.getMemberNotis(Util.toRPap(paramMap), rmap, request, response);
		return page(bret, modelMap, rmap);
	}
	
	/*
	 * 알림 보기 
	 */
	@RequestMapping("/board/memberNotiDetail")
	public String getMemberNotiDetail(@RequestParam Map<String, Object> paramMap, ModelMap modelMap, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/board/memberNotiDetail");
		boolean bret = mms.getMemberNotiDetail(Util.toRPap(paramMap), rmap, request, response);
		return page(bret, modelMap, rmap);
	}

	/*
	 * 알립 읽음 상태 변경
	 */
	@RequestMapping(value = "/board/memberNoti/changeStatus.do", produces = "application/text; charset=utf8")
	@ResponseBody
	public String changeMemberNotiStatus(@RequestParam Map<String, Object> paramMap, ModelMap modelMap, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.changeMemberNotiStatus(Util.toRPap(paramMap), rmap, request, response);
		return rmap.getStr("json");
	}
	
	
	
	/*****************************************************************************************************************************************************************
	 * 가맹점 개인화 메인 컨트롤러 메서드 
	 *****************************************************************************************************************************************************************/
	/*
	 * 가맹점 개인화 페이지 메인
	 */
	@RequestMapping("/affiliate/affiliateMain.do")
	public String affiliateMain(@RequestParam(required = false) String lang, @RequestParam Map<String, Object> p, ModelMap map,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/affiliate/affiliateMain");
		boolean bret =  mms.prepareAffiliateMain(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}
	
	
	/*
	 * 가맹점 영수증 매출 리스트
	 */
	@RequestMapping("/affiliate/affiliateReceiptList.do")
	public String listRecipt(@RequestParam(required = false) String lang, @RequestParam Map<String, Object> p, ModelMap map,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/affiliate/affiliateReceiptList");
		boolean bret =  mms.affiliateReceiptList(Util.toRPap(p), rmap, request, response);
		return page(true, map, rmap);
	}
	
	// 회원이 가맹점주에게 입금 확인 요청하기 
	@RequestMapping(value = "/pointCoupon/reqeustAffiliateDeposit.do", produces = "application/text; charset=utf8")
	@ResponseBody
	public String reqeustAffiliateDeposit(@RequestParam(required = false) String lang, @RequestParam Map<String, Object> p, ModelMap map,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.reqeustAffiliateDeposit(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}
	
	/*****************************************************************************************************************************************************************
	 * 마스크 판매 
	 *****************************************************************************************************************************************************************/
	
	@RequestMapping("/mypage/maskOrderList.do")
	public String maskOrderList(@RequestParam(required = false) String lang, @RequestParam Map<String, Object> p, ModelMap map,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/shop/mask_order_list");
		boolean bret =  mms.maskOrderList(Util.toRPap(p), rmap, request, response);
		return page(true, map, rmap);
	}

	@RequestMapping("/shop/maskProductDetail.do")
	public String productDetail(@RequestParam(required = false) String lang, @RequestParam Map<String, Object> p, ModelMap map,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/shop/mask_product_detail");
		//boolean bret =  mms.prepareAffiliateMain(Util.toRPap(p), rmap, request, response);
		return page(true, map, rmap);
	}
	
	@RequestMapping("/shop/maskOrder.do")
	public String productOrder(@RequestParam(required = false) String lang, @RequestParam Map<String, Object> p, ModelMap map,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/shop/mask_order");
		boolean bret =  mms.maskOrder(Util.toRPap(p), rmap, request, response);
		return page(true, map, rmap);
	}
	
	
	@RequestMapping(value = "/shop/processOrder.do",produces = "application/text; charset=utf8")
	@ResponseBody
	public String processOrder(@RequestParam(required = false) String lang, @RequestParam Map<String, Object> p, ModelMap map,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap();
		boolean bret = mms.processOrder(Util.toRPap(p), rmap, request, response);
		return rmap.getStr("json");
	}
	
	@RequestMapping("/shop/orderComplete.do")
	public String orderComplete(@RequestParam(required = false) String lang, @RequestParam Map<String, Object> p, ModelMap map,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/shop/order_complete");
		boolean bret =  mms.orderComplete(Util.toRPap(p), rmap, request, response);
		return page(bret, map, rmap);
	}
	
}