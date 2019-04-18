package com.returnp_web.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.returnp_web.dao.mapper.SmsMapper;
import com.returnp_web.utils.RPMap;


/**
 * The Class FrontMainDao.
 */
@Repository
public class SmsDao {
	
	/** The Constant logger. */
	private static final Logger logger = LoggerFactory.getLogger(SmsDao.class);
	
	/** The sql session. */
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	//이곳에 입력해주세요.
	
	
}
