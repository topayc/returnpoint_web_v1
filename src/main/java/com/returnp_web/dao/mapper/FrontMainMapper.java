package com.returnp_web.dao.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public interface FrontMainMapper {

	/**
	 * select company Info.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : select Company Info.
	 * @Method 설명 : 회사정보 조회
	 */
	HashMap<String,Object> selectCompanyInfo(HashMap<String, Object> params);

	/**
	 * select company Info.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : select ServerManage Status Info.
	 * @Method 설명 : 서버 상태(운영,점검) 조회
	 */
	HashMap<String,Object> selectServerManageStatusInfo(HashMap<String, Object> params);

	//공지사항 리스트 총갯수
	int selectWebNoticeListTotalCount(HashMap<String, Object> params);
	
	//공지사항 리스트
	ArrayList<HashMap<String,Object>> selectWebNoticeList(HashMap<String, Object> params);
	
	//공지사항 상세
	HashMap<String,Object> selectWebNoticeContent(HashMap<String, Object> params);
	
	//FAQ 리스트 총갯수
	int selectWebFAQListTotalCount(HashMap<String, Object> params);
	
	//FAQ 리스트
	ArrayList<HashMap<String,Object>> selectWebFAQList(HashMap<String, Object> params);
	
	//FAQ 상세
	HashMap<String,Object> selectWebFAQContent(HashMap<String, Object> params);
	
	//가맹점찾기 리스트 총갯수
	int selectWebFranchiseeInfoListTotalCount(HashMap<String, Object> params);
	
	//가맹점찾기 리스트
	ArrayList<HashMap<String,Object>> selectWebFranchiseeInfoSearchList(HashMap<String, Object> params);
	
	//CITY 리스트
	ArrayList<HashMap<String, Object>> selectWebCityList(HashMap<String, Object> params);
	
	//시군구 AJAX 리스트
	ArrayList<HashMap<String, Object>> selectWebCountryNameList(HashMap<String, Object> params);
	
	//게시글 카운팅 +1
	int updateMainBbsViewCount(HashMap<String, Object> params);
	
	//제휴문의 저장
	int insertMainBbsPartnerAskSave(HashMap<String, Object> params);
	
}
