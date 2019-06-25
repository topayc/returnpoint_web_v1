package com.returnp_web.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.returnp_web.svc.FrontMainService;
import com.returnp_web.svc.MobileMainServiceImpl;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

//설명: FRONT PC Controller
@Controller
@RequestMapping
public class FrontController extends MallBaseController {

	@Autowired
	private FrontMainService fms;

	private static final Logger logger = LoggerFactory.getLogger(FrontController.class);
	
	// WEB 메인페이지
	@RequestMapping("/main/index")
	public String home(@RequestParam(required = false) String lang, @RequestParam HashMap<String, Object> params, HttpSession session, HttpServletRequest request, HttpServletResponse response, ModelMap map) throws Exception {
		return "/main/index";
	}
	
	// WEB 서비스안내
	@RequestMapping("/company/service_member")
	public String serviceInfo(@RequestParam(required = false) String lang, @RequestParam HashMap<String, Object> params, HttpSession session, HttpServletRequest request, HttpServletResponse response, ModelMap map) throws Exception {
		return "/company/service_member";
	}
	
	// WEB 회사소개
	@RequestMapping("/company/company_identity")
	public String companyInfo(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session) throws Exception {
		return "/company/company_identity";
	}
	
	// WEB 가맹점찾기
	@RequestMapping("/board/franchisee_info")
	public String franchiseeInfoSearch(@RequestParam HashMap<String, Object> params, HttpSession session, HttpServletRequest request, HttpServletResponse response, ModelMap map) throws Exception {
		
		/****Paging*******************/
		int page = 1; 		// 현재 선택된 페이지
		int upperPage= 1;	// 현재 선택된 상위페이지
		int recordCount = 0; //데이터 총 갯수
		int recordPerPage = 20; //페이지당 레코드수
		int pageCount = 1;	//페이지 총 갯수
		int upperPageCount = 1;	//상위페이지수
		int pagePerUpperPage = 5;	//한화면에 보여지는 페이지수
		int s_seq=0;
		int e_seq=0;
		/*****************************/
		
		try{
			if (params.get("city") != null) {
				String affiliateAddress = params.get("city").toString() +" "+ params.get("country").toString();
				params.put("affiliateAddress", affiliateAddress);
			}
	
			recordCount = fms.selectWebFranchiseeInfoListTotalCount(params);
			pageCount = (int) Math.ceil((double)recordCount/recordPerPage); //페이지 총 갯수
			
			if (params.get("page") != null) page = Integer.parseInt(params.get("page").toString());	//현재 페이지
			if (params.get("upperPage") != null) upperPage = Integer.parseInt(params.get("upperPage").toString());		//현재 선택된 상위페이지
			if (params.get("recordPerPage") != null) recordPerPage = Integer.parseInt(params.get("recordPerPage").toString());		//페이지당 레코드수
			
			s_seq = (page-1) * recordPerPage + 1;		//s_seq = 현재페이지 * 페이지당레코드
			e_seq = page * recordPerPage;
	
			upperPageCount =(int)Math.ceil((double)pageCount / pagePerUpperPage);		//올림(토탈페이지수 / 슈퍼페이지당 페이지)
			
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
		}catch(Exception e){
			e.printStackTrace();
		}	
			return "/board/franchisee_info";
		
	}
	
	
	// WEB FAQ(자주묻는질문)
	@RequestMapping("/board/faq")
	public String faq(@RequestParam HashMap<String, Object> params, HttpSession session, HttpServletRequest request, HttpServletResponse response, ModelMap map) throws Exception {
		
		/****Paging*******************/
		int page = 1; 		// 현재 선택된 페이지
		int upperPage= 1;	// 현재 선택된 상위페이지
		int recordCount = 0; //데이터 총 갯수
		int recordPerPage = 20; //페이지당 레코드수
		int pageCount = 1;	//페이지 총 갯수
		int upperPageCount = 1;	//상위페이지수
		int pagePerUpperPage = 5;	//한화면에 보여지는 페이지수
		int s_seq=0;
		int e_seq=0;
		/*****************************/
		/*************FAQ 세부 구분*******************/
		if(params.get("bbsType2") != null && params.get("bbsType2") != "0" ){
			params.put("bbsType2", params.get("bbsType2")); //faq는 bbsType1: 2번 으로 fix한 상태에서, bbsType2에  1:회원/가입/탈퇴, 2:포인트, 3:적립 및 출금, 10.기타
		}else {
			params.put("bbsType2", 0);
		}
		/*************FAQ 세부 구분*******************/
		
		try{
			recordCount = fms.selectWebFAQListTotalCount(params);
			pageCount = (int) Math.ceil((double)recordCount/recordPerPage); //페이지 총 갯수
			
			if (params.get("page") != null) page = Integer.parseInt(params.get("page").toString());	//현재 페이지
			if (params.get("upperPage") != null) upperPage = Integer.parseInt(params.get("upperPage").toString());		//현재 선택된 상위페이지
			if (params.get("recordPerPage") != null) recordPerPage = Integer.parseInt(params.get("recordPerPage").toString());		//페이지당 레코드수
			
			s_seq = (page-1) * recordPerPage + 1;		//s_seq = 현재페이지 * 페이지당레코드
			e_seq = page * recordPerPage;
	
			upperPageCount =(int)Math.ceil((double)pageCount / pagePerUpperPage);		//올림(토탈페이지수 / 슈퍼페이지당 페이지)
			
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
			
			ArrayList<HashMap<String, Object>> faqList = fms.selectWebFAQList(params);
			
			map.addAttribute("faqList", faqList);
			map.addAttribute("params", params);

		}catch(Exception e){
			e.printStackTrace();
		}
			return "/board/faq";
	}

	
	// WEB 공지사항 상세 페이지
	@RequestMapping("/board/faq_content")
	public String faqContent(@RequestParam HashMap<String, Object> params, HttpSession session, HttpServletRequest request, HttpServletResponse response, ModelMap map) throws Exception {
		
		int viewCount = 0; 
		
		params.put("mainBbsNo", params.get("mainBbsNo"));
		params.put("page", params.get("page"));
		params.put("upperPage", params.get("upperPage"));
		params.put("recordPerPage", params.get("recordPerPage"));
		
		try{
			HashMap<String, Object> faqContent = fms.selectWebFAQContent(params);
	
			if( faqContent.get("viewCount") != null) {
				viewCount = (int) faqContent.get("viewCount");
			}
			
			params.put("viewCount", viewCount);
			fms.updateMainBbsViewCount(params);
			
			map.addAttribute("faqContent", faqContent);
			map.addAttribute("params", params);
		}catch(Exception e){
			e.printStackTrace();
		}	
			return "/board/faq_content";
	}

	
	// WEB 공지사항
	@RequestMapping("/board/notice")
	public String notice(@RequestParam HashMap<String, Object> params, HttpSession session, HttpServletRequest request, HttpServletResponse response, ModelMap map) throws Exception {
		
		/****Paging***************/
		int page = 1; 		// 현재 선택된 페이지
		int upperPage= 1;	// 현재 선택된 상위페이지
		int recordCount = 0; //데이터 총 갯수
		int recordPerPage = 20; //페이지당 레코드수
		int pageCount = 1;	//페이지 총 갯수
		int upperPageCount = 1;	//상위페이지수
		int pagePerUpperPage = 5;	//한화면에 보여지는 페이지수
		int s_seq=0;
		int e_seq=0;
		/*****************************/
		try{
			recordCount = fms.selectWebNoticeListTotalCount(params);
			
			pageCount = (int) Math.ceil((double)recordCount/recordPerPage); //페이지 총 갯수
			
			if (params.get("page") != null) page = Integer.parseInt(params.get("page").toString());	//현재 페이지
			if (params.get("upperPage") != null) upperPage = Integer.parseInt(params.get("upperPage").toString());		//현재 선택된 상위페이지
			if (params.get("recordPerPage") != null) recordPerPage = Integer.parseInt(params.get("recordPerPage").toString());		//페이지당 레코드수
			
			s_seq = (page-1) * recordPerPage + 1;		//s_seq = 현재페이지 * 페이지당레코드
			e_seq = page * recordPerPage;
	
			upperPageCount =(int)Math.ceil((double)pageCount / pagePerUpperPage);		//올림(토탈페이지수 / 슈퍼페이지당 페이지)
			
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
			
			ArrayList<HashMap<String, Object>> noticeList = fms.selectWebNoticeList(params);
			
			map.addAttribute("noticeList", noticeList);
			map.addAttribute("params", params);
		}catch(Exception e){
			e.printStackTrace();
		}	
			return "/board/notice";
		
	}
	
	
	// WEB 공지사항 상세
	@RequestMapping("/board/notice_content")
	public String noticeContent(@RequestParam HashMap<String, Object> params, HttpSession session, HttpServletRequest request, HttpServletResponse response, ModelMap map) throws Exception {
		
		int viewCount = 0; 
		
		params.put("mainBbsNo", params.get("mainBbsNo"));
		params.put("page", params.get("page"));
		params.put("upperPage", params.get("upperPage"));
		params.put("recordPerPage", params.get("recordPerPage"));
		
		try{
			HashMap<String, Object> noticeContent = fms.selectWebNoticeContent(params);
			
			if( noticeContent.get("viewCount") != null) {
				viewCount = (int) noticeContent.get("viewCount");
			}
			
			params.put("viewCount", viewCount);
			fms.updateMainBbsViewCount(params);
			
			map.addAttribute("noticeContent", noticeContent);
			map.addAttribute("params", params);
		}catch(Exception e){
			e.printStackTrace();
		}
			return "/board/notice_content";
	}
	
	
	// WEB 제휴안내
	@RequestMapping("/board/partner_ask")
	public String partnerAsk(@RequestParam HashMap<String, Object> params, HttpSession session, HttpServletRequest request, HttpServletResponse response, ModelMap map) throws Exception {
		return "/board/partner_ask";
	}
	
	// WEB 제휴안내 저장
	@ResponseBody
	@RequestMapping(value = "/board/partnerAskSave", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public Map<String, Object> partnerAskSave(@RequestParam HashMap<String, Object> params, HttpSession session, HttpServletRequest request, HttpServletResponse response, ModelMap map) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try{
			fms.insertMainBbsPartnerAskSave(params);
			resultMap.put("code", "1");
		}catch(Exception e) {
			//resultMap.put("message", e.getMessage());
			return resultMap;
		}
			return resultMap;
	}
	
	
	//WEB CITY SEARCH
	@ResponseBody
	@RequestMapping(value = "/board/searchCity", method = RequestMethod.POST , produces = "application/json; charset=utf8")
	public String searchCity(@RequestParam HashMap<String, Object> params, HttpServletRequest request, HttpServletResponse response, ModelMap map) throws Exception {
		
		ArrayList<HashMap<String, Object>> cityList = fms.selectWebCityList(params);
		JSONObject json = new JSONObject();
		if (cityList.size() != '0') {
			JSONArray json_arr = new JSONArray();
			JSONObject obj = new JSONObject();
			for (int i = 0; i < cityList.size(); i++) {
				obj.put("cityList", cityList);
				json_arr.add(obj);
			}
			json.put("json_arr", json_arr);
		}
		return json.toString() ;
	}
	
	//WEB COUNTRY SEARCH
	@ResponseBody
	@RequestMapping(value = "/board/searchCountry", method = RequestMethod.POST , produces = "application/json; charset=utf8")
	public String selectAjax(@RequestParam HashMap<String, Object> params, HttpServletRequest request, HttpServletResponse response, ModelMap map) throws Exception {
		ArrayList<HashMap<String, Object>> countryNameList = fms.selectWebCountryNameList(params);
		JSONObject json = new JSONObject();
		if (countryNameList.size() != '0') {
			JSONArray json_arr = new JSONArray();
			JSONObject obj = new JSONObject();
			for (int i = 0; i < countryNameList.size(); i++) {
				obj.put("countryNameList", countryNameList);
				json_arr.add(obj);
			}
			json.put("json_arr", json_arr);
		}
		return json.toString();
	}

	// 개인정보취급및처리방침
	@RequestMapping("/company/privacy")
	public String privacyInfo(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session) throws Exception {
		return "/company/privacy";
	}

	// 이용약관
	@RequestMapping("/company/customerInfo")
	public String customerInfo(@RequestParam Map<String, Object> p, ModelMap map, HttpSession session) throws Exception {
		return "/company/customerInfo";
	}
	
	// WEB 가맹점찾기 상세 Google Map
	@RequestMapping("/board/franchiseeInfoGoogleMap")
	public String franchiseeInfoGoogleMap(@RequestParam HashMap<String, Object> params, HttpSession session, HttpServletRequest request, HttpServletResponse response, ModelMap map) throws Exception {
		
		try{
			//Google Map Api Key
			String key = "AIzaSyB-bv2uR929DOUO8vqMTkjLI_E6QCDofb4";
			params.put("key", key);
			HashMap<String, Object> affiliateGoogleMapView = fms.selectAffiliateIfo(params);
			
			if (affiliateGoogleMapView.get("lat") == null || affiliateGoogleMapView.get("lng") == null || affiliateGoogleMapView.get("affiliateName") == null) { //위도, 경도, 가맹점명 중 하나라도 NULL일 경우
				params.put("code", "error");
			}else {
				params.put("code", "success");
			}
			map.addAttribute("affiliateGoogleMapView", affiliateGoogleMapView);
			map.addAttribute("params", params);
		}catch(Exception e){
			e.printStackTrace();
		}	
			return "/board/franchiseeInfoGoogleMap";
	}
	
}