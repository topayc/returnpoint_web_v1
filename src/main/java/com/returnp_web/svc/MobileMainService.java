package com.returnp_web.svc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import com.returnp_web.utils.RPMap;

/**
 * The Interface FrontMainService.
 */
@Service
public interface MobileMainService {

	/**
	 * 회원수현황
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean memberTotal(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	/**
	 * 사용자->포인트 조회
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean myPointInfo(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	/**
	 * 사용자->포인트 전환
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean pointConvertRequest(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	/**
	 * 사용자->red point 선물하기
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean redPointConvertRequest(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	/**
	 * 사용자->green point 선물하기
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean greenPointConvertRequest(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	/**
	 * kicc 전용 QR 이미지 생성
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean kiccQrImgView(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	boolean commonQrImgView(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	public String kiccQrAccProxy(HashMap<String, String> p, ModelMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception;

	public String commonQrAccProxy(HashMap<String, String> p, ModelMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception;

	/**
	 * 사용자->하단영역 정보
	 *
	 * @return the footer
	 * @throws Exception the exception
	 */
	HashMap<String, Object> getFooter(RPMap rmap) throws Exception;

	/**
	 * 사용자->서버 상태(운영,점검) 조회
	 *
	 * @return the footer
	 * @throws Exception the exception
	 */
	HashMap<String, Object> getServerManageStatus() throws Exception;

	/**
	 * 포인트조회->그린 포인트 상세내역 조회
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean paymentPointbackRecordDetail(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	/**
	 * 포인트조회->레드 포인트 상세내역 조회
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean pointConversionTransactionDetail(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	/**
	 * 게시판->faq 게시판
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean faq(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	/**
	 * 게시판->notice 게시판
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean notice(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	/**
	 * 내주변 상가 조회
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean rpmapLoadAct(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;


	/**
	 * faq 더보기 조회
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean faqMoreAct(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	/**
	 * notice(공지사항) 더보기 조회
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean noticeMoreAct(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	/**
	 * 사용자-> 회원정보
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean myinfo(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	/**
	 * 게시판->qna 게시판
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean qna(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	/**
	 * 게시판->qna 게시판 글쓰기
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean saveQnaWAct(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	/**
	 * 게시판->제휴상담 게시판
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean qnaNode(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	/**
	 * 게시판->제휴상담 게시판 글쓰기
	 *
	 * @param p the p
	 * @param rmap the rmap
	 * @param request the request
	 * @param response the response
	 * @return true, if successful
	 * @throws Exception the exception
	 */
	boolean saveQnaNodeWAct(RPMap p, RPMap rmap, HttpServletRequest request, HttpServletResponse response) throws Exception ;

	boolean giftCardQrImgView(RPMap rPap, RPMap rmap, HttpServletRequest request, HttpServletResponse response);

	boolean prepareIntro(RPMap paramMap, RPMap dataMap, HttpServletRequest request, HttpServletResponse response);

	boolean initMain(RPMap rPap, RPMap rmap, HttpServletRequest request, HttpServletResponse response);

	boolean getBoardList(RPMap rPap, RPMap rmap, HttpServletRequest request, HttpServletResponse response);

	boolean getBoardReply(RPMap rPap, RPMap rmap, HttpServletRequest request, HttpServletResponse response);

	boolean viewAffiliateDetail(RPMap rPap, RPMap rmap, HttpServletRequest request, HttpServletResponse response);

	boolean pointDetailAccInfo(RPMap rPap, RPMap rmap, HttpServletRequest request, HttpServletResponse response);


	boolean showPointCouponInfo(RPMap rPap, RPMap rmap, HttpServletRequest request, HttpServletResponse response);

	String accPointCoupon(HashMap<String, String> paramMap, ModelMap modelMap, HttpServletRequest request,
			HttpServletResponse response);

	boolean prepareNewAffiliateSearch(RPMap rPap, RPMap rmap, HttpServletRequest request, HttpServletResponse response);

	ArrayList<HashMap<String, Object>> findAffiliatesByCate(Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response);


}

