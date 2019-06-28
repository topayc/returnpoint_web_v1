package com.returnp_web.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.returnp_web.dao.mapper.GiftCardMapper;


/**
 * The Class FrontMainDao.
 */
@Repository
public class GiftCardDao {
	
	/** The Constant logger. */
	private static final Logger logger = LoggerFactory.getLogger(GiftCardDao.class);
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public ArrayList<HashMap<String,Object>> selectMyGiftCards(HashMap<String, Object> params){
		return sqlSession.getMapper(GiftCardMapper.class).selectMyGiftCards(params);
	}

	public ArrayList<HashMap<String,Object>> selectGiftCardIssues(HashMap<String, Object> params){
		return sqlSession.getMapper(GiftCardMapper.class).selectGiftCardIssues(params);
	}
}
