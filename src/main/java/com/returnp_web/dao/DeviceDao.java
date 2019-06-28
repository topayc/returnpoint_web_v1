package com.returnp_web.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.returnp_web.dao.mapper.DeviceMapper;


/**
 * The Class DeviceDao.
 */
@Repository
public class DeviceDao {

	/** The Constant logger. */
	private static final Logger logger = LoggerFactory.getLogger(DeviceDao.class);

	/** The sql session. */
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int  registPushToken(HashMap<String,Object> params){
		return sqlSession.getMapper(DeviceMapper.class).registPushToken(params);
	}

	public int updateDeviceInfo(HashMap<String,Object> params){
		return sqlSession.getMapper(DeviceMapper.class).updateDeviceInfo(params);
	}
	
	public HashMap<String,Object>  selectDeviceInfo(HashMap<String, Object> params){
		return sqlSession.getMapper(DeviceMapper.class).selectDeviceInfo(params);
	}
	
	public HashMap<String, Object> selectLastVersion(HashMap<String, Object> params) {
		return sqlSession.getMapper(DeviceMapper.class).selectLastVersion(params);
	}
	
}