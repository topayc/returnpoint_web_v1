package com.returnp_web.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.returnp_web.dao.mapper.FrontMainMapper;


/**
 * The Class FrontMainDao.
 */
@Repository
public class FrontMainDao {

	/** The Constant logger. */
	private static final Logger logger = LoggerFactory.getLogger(FrontMainDao.class);

	/** The sql session. */
	@Autowired
	private SqlSessionTemplate sqlSession;

	/**
	 * select company Info.
	 *
	 * @param params the params
	 * @return the hash map
	 */
	public HashMap<String,Object> selectCompanyInfo(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).selectCompanyInfo(params);
	}

	/**
	 * select ServerManageStatus Info.
	 *
	 * @param params the params
	 * @return the hash map
	 */
	public HashMap<String,Object> selectServerManageStatusInfo(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).selectServerManageStatusInfo(params);
	}

	//공지사항 리스트 총 갯수
	public int selectWebNoticeListTotalCount(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).selectWebNoticeListTotalCount(params);
	}
	
	//공지사항 리스트
	public ArrayList<HashMap<String, Object>> selectWebNoticeList(HashMap<String, Object> params) {
		return sqlSession.getMapper(FrontMainMapper.class).selectWebNoticeList(params);
	}
	
	//공지사항 상세
	public HashMap<String,Object> selectWebNoticeContent(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).selectWebNoticeContent(params);
	}
	
	//FAQ 리스트 총 갯수
	public int selectWebFAQListTotalCount(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).selectWebFAQListTotalCount(params);
	}
	
	//공지사항 리스트
	public ArrayList<HashMap<String, Object>> selectWebFAQList(HashMap<String, Object> params) {
		return sqlSession.getMapper(FrontMainMapper.class).selectWebFAQList(params);
	}
	
	//공지사항 상세
	public HashMap<String,Object> selectWebFAQContent(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).selectWebFAQContent(params);
	}	
	
	//가맹점찾기 리스트 총 갯수
	public int selectWebFranchiseeInfoListTotalCount(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).selectWebFranchiseeInfoListTotalCount(params);
	}
	
	//가맹점찾기 리스트
	public ArrayList<HashMap<String, Object>> selectWebFranchiseeInfoSearchList(HashMap<String, Object> params) {
		return sqlSession.getMapper(FrontMainMapper.class).selectWebFranchiseeInfoSearchList(params);
	}
	
	//시군구 AJAX 리스트
	public ArrayList<HashMap<String, Object>> selectWebCityList(HashMap<String, Object> params) {
		return sqlSession.getMapper(FrontMainMapper.class).selectWebCityList(params);
	}
	
	//시군구 AJAX 리스트
	public ArrayList<HashMap<String, Object>> selectWebCountryNameList(HashMap<String, Object> params) {
		return sqlSession.getMapper(FrontMainMapper.class).selectWebCountryNameList(params);
	}
	
	//게시글 카운팅 +1
	public int updateMainBbsViewCount(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).updateMainBbsViewCount(params);
	}
	
	//제휴문의 저장
	public int insertMainBbsPartnerAskSave(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).insertMainBbsPartnerAskSave(params);
	}
}