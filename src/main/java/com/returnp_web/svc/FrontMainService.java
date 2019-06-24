package com.returnp_web.svc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import com.returnp_web.utils.RPMap;

/**
 * The Interface FrontMainService.
 */
@Service
public interface FrontMainService {

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
	
	///////////////////////////////////////////////////////////2019.05.20 신규////////////////////////////////////////////////////////////////
	/**
	 * 공지사항 총 갯수
	 */
	public int selectWebNoticeListTotalCount(HashMap<String, Object> params) throws Exception;

	/**
	 * 공지사항 리스트
	 */
	public ArrayList<HashMap<String,Object>> selectWebNoticeList(HashMap<String, Object> params) throws Exception;
	
	/**
	 * 공지사항 상세
	 */
	public HashMap<String,Object> selectWebNoticeContent(HashMap<String, Object> params) throws Exception;

	/**
	 * FAQ 총 갯수
	 */
	public int selectWebFAQListTotalCount(HashMap<String, Object> params) throws Exception;

	/**
	 * FAQ 리스트
	 */
	public ArrayList<HashMap<String,Object>> selectWebFAQList(HashMap<String, Object> params) throws Exception;
	
	/**
	 * FAQ 상세
	 */
	public HashMap<String,Object> selectWebFAQContent(HashMap<String, Object> params) throws Exception;
	
	/**
	 * 가맹점찾기 총 갯수
	 */
	public int selectWebFranchiseeInfoListTotalCount(HashMap<String, Object> params) throws Exception;

	/**
	 * 가맹점찾기 리스트
	 */
	public ArrayList<HashMap<String,Object>> selectWebFranchiseeInfoSearchList(HashMap<String, Object> params) throws Exception;
	
	/**
	 * CITY 리스트
	 */
	public ArrayList<HashMap<String, Object>> selectWebCityList(HashMap<String, Object> params) throws Exception;
	
	/**
	 * 시군구 AJAX 리스트
	 */
	public ArrayList<HashMap<String, Object>> selectWebCountryNameList(HashMap<String, Object> params) throws Exception;

	/**
	 * 게시글 카운팅 +1
	 */
	public int updateMainBbsViewCount(HashMap<String, Object> params) throws Exception;

	/**
	 * 제휴문의 저장
	 */
	public int insertMainBbsPartnerAskSave(HashMap<String, Object> params) throws Exception;
}