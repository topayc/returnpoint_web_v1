package com.returnp_web.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.returnp_web.svc.GiftCardService;
import com.returnp_web.utils.RPMap;
import com.returnp_web.utils.Util;

@Controller
@RequestMapping("/m")
public class GiftCardController  extends MallBaseController{
	
	@Autowired private GiftCardService giftCardService;
	
	
	/*
	 * 나의 상품권 리스트 페이지
	*/
	@RequestMapping(value = "/giftCard/giftCardList.do", method = RequestMethod.GET)
	public String mGiftCardList(@RequestParam Map<String, Object> paramMap, ModelMap modelMap, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/giftcard/m_gift_card_list");
		if (!paramMap.containsKey("giftCardStatus")) {
			paramMap.put("giftCardStatus", "3" ); /* 결제 완료된 상품권*/
		}
		boolean bret = giftCardService.getMyGiftCards(Util.toRPap(paramMap), rmap, request, response);
		return page(bret, modelMap, rmap);
	}

	/*
	 * 나의 상품권 상세 보기 페이지
	 */
	@RequestMapping(value = "/giftCard/giftCardDetail.do", method = RequestMethod.GET)
	public  String getMyGiftCards( @RequestParam Map<String, Object> paramMap, ModelMap modelMap, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/giftcard/m_gift_card_detail");
		boolean bret = giftCardService.getMyGiftCardDetail(Util.toRPap(paramMap), rmap, request, response);
		return page(bret, modelMap, rmap);
	}
	
	/*
	 * 상품권 QR 이미지 다운로드
	 */
	@RequestMapping(value = "/giftCard/downQrCode.do", method = RequestMethod.GET)
	public  void downQrCodeImg( @RequestParam Map<String, Object> paramMap, ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("image/png");
		response.getOutputStream().write(this.giftCardService.createQrCode(Util.toRPap(paramMap), request, response));;
	}

	/*
	 * 상품권 QR 이미지 풀 화면으로 보기
	 */
	@RequestMapping(value = "/giftCard/viewFullQrCode.do", method = RequestMethod.GET)
	public  String  viewFullQrCode( @RequestParam Map<String, Object> paramMap, ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RPMap rmap = Util.getRPRmap("/mobile/giftcard/m_gift_card_qr_view");
		boolean bret = giftCardService.viewFullQrCode(Util.toRPap(paramMap), rmap, request, response);
		return page(bret, modelMap, rmap);
	}
}
