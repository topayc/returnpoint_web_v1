package com.returnp_web.dao;

import java.util.ArrayList;
import java.util.HashMap;

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
	 * select my red point Sum Info.
	 *
	 * @param params the params
	 * @return the hash map
	 */
	public int selectMemberTotal(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).selectMemberTotal(params);
	}

	/**
	 * select my red point Sum Info.
	 *
	 * @param params the params
	 * @return the hash map
	 */
	public HashMap<String,Object> selectMyRedPointSumInfo(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).selectMyRedPointSumInfo(params);
	}

	/**
	 * select my green point Sum Info.
	 *
	 * @param params the params
	 * @return the hash map
	 */
	public HashMap<String,Object> selectMyGreenPointSumInfo(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).selectMyGreenPointSumInfo(params);
	}

	/**
	 * select my Green point List Info.
	 *
	 * @param params the params
	 * @return the array list
	 */
	public ArrayList<HashMap<String,Object>> selectMyGreenPointList(HashMap<String, Object> params) {
		return sqlSession.getMapper(FrontMainMapper.class).selectMyGreenPointList(params);
	}

	/**
	 * insert point_convert_request.
	 *
	 * @param params the params
	 * @return int
	 */
	public int insertPointConvertRequestAct(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).insertPointConvertRequestAct(params);
	}

	/**
	 * Select duplicate Point Chcek count.
	 *
	 * @param params the params
	 * @return the int
	 */
	public int duplicatePointChcek(HashMap<String,Object> params) {
		return sqlSession.getMapper(FrontMainMapper.class).duplicatePointChcek(params);
	}

	/**
	 * update green point_use_sum.
	 *
	 * @param params the params
	 * @return int
	 */
	public int updateGreenPointUse(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).updateGreenPointUse(params);
	}

	/**
	 * insert point_conversion_transaction.
	 *
	 * @param params the params
	 * @return int
	 */
	public int insertPointConvertTransactionAct(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).insertPointConvertTransactionAct(params);
	}

	/**
	 * select payment_pointback_record List Info.
	 *
	 * @param params the params
	 * @return the array list
	 */
	//public ArrayList<HashMap<String, Object>> selectPaymentPointbackRecordList(HashMap<String,Object> params){
	//	return sqlSession.getMapper(FrontMainMapper.class).selectPaymentPointbackRecordList(params);
	//}

	/**
	 * select point_conversion_transaction List Info.
	 *
	 * @param params the params
	 * @return the array list
	 */
	//public ArrayList<HashMap<String, Object>> selectpointConversionTransactionList(HashMap<String,Object> params){
	//	return sqlSession.getMapper(FrontMainMapper.class).selectpointConversionTransactionList(params);
	//}

	/**
	 * update my red point.
	 *
	 * @param params the params
	 * @return int
	 */
	public int updateMyRedPointUse(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).updateMyRedPointUse(params);
	}


	/**
	 * update my green point.
	 *
	 * @param params the params
	 * @return int
	 */
	public int updateMyGreenPointUse(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).updateMyGreenPointUse(params);
	}

	/**
	 * insert point_transfer_transaction
	 *
	 * @param params the params
	 * @return int
	 */
	public int insertPointTransferTransactionAct(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).insertPointTransferTransactionAct(params);
	}

	/**
	 * select receiver red point Info.
	 *
	 * @param params the params
	 * @return the hash map
	 */
	public HashMap<String,Object> selectReceiverRedPointInfo(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).selectReceiverRedPointInfo(params);
	}

	/**
	 * update receiver red point.
	 *
	 * @param params the params
	 * @return int
	 */
	public int updateReceiveRedPoint(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).updateReceiveRedPoint(params);
	}

	/**
	 * update receiver green point.
	 *
	 * @param params the params
	 * @return int
	 */
	public int updateReceiveGreenPoint(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).updateReceiveGreenPoint(params);
	}

	/**
	 * select policy List Info.
	 *
	 * @param params the params
	 * @return the array list
	 */
	public ArrayList<HashMap<String, Object>> selectPolicyList(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).selectPolicyList(params);
	}

	/**
	 * select receiver green point Info.
	 *
	 * @param params the params
	 * @return the hash map
	 */
	public HashMap<String,Object> selectReceiverGreenPointInfo(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).selectReceiverGreenPointInfo(params);
	}

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

	/**
	 * select payment_pointback_record detail List Info.
	 *
	 * @param params the params
	 * @return the array list
	 */
	public ArrayList<HashMap<String, Object>> selectPaymentPointbackRecordDetailList(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).selectPaymentPointbackRecordDetailList(params);
	}

	/**
	 * select my Green point Sum List Info.
	 *
	 * @param params the params
	 * @return the array list
	 */
	public ArrayList<HashMap<String,Object>> selectMyGreenPointSumList(HashMap<String, Object> params) {
		return sqlSession.getMapper(FrontMainMapper.class).selectMyGreenPointSumList(params);
	}

	/**
	 * select point_conversion_transaction And point_transfer_transaction List Info.
	 *
	 * @param params the params
	 * @return the array list
	 */
	public ArrayList<HashMap<String, Object>> selectpointConTranAndPointTranList(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).selectpointConTranAndPointTranList(params);
	}

	/**
	 * select my Red point Sum List Info.
	 *
	 * @param params the params
	 * @return the array list
	 */
	public ArrayList<HashMap<String,Object>> selectMyRedPointSumList(HashMap<String, Object> params) {
		return sqlSession.getMapper(FrontMainMapper.class).selectMyRedPointSumList(params);
	}

	/**
	 * select conversion transaction red point detail List Info.
	 *
	 * @param params the params
	 * @return the array list
	 */
	public ArrayList<HashMap<String, Object>> selectPointConversionTransactionDetailList(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).selectPointConversionTransactionDetailList(params);
	}

	/**
	 * select faq List.
	 *
	 * @param params the params
	 * @return the array list
	 */
	public ArrayList<HashMap<String, Object>> selectFaqList(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).selectFaqList(params);
	}

	/**
	 * select notice List.
	 *
	 * @param params the params
	 * @return the array list
	 */
	public ArrayList<HashMap<String, Object>> selectNoticeList(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).selectNoticeList(params);
	}

	/**
	 * select conversion transaction red point detail List Info.
	 *
	 * @param params the params
	 * @return the array list
	 */
	public ArrayList<HashMap<String, Object>> selectRpmapLoadList(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).selectRpmapLoadList(params);
	}

	/**
	 * select faq board Total Cnt.
	 *
	 * @param params the params
	 * @return the hash map
	 */
	public HashMap<String,Object> faqTotalCnt(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).faqTotalCnt(params);
	}

	/**
	 * select board faq List Info.
	 *
	 * @param params the params
	 * @return the array list
	 */
	public ArrayList<HashMap<String, Object>> selectFaqMoreList(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).selectFaqMoreList(params);
	}

	/**
	 * select notice List Info.
	 *
	 * @param params the params
	 * @return the array list
	 */
	public ArrayList<HashMap<String, Object>> selectNoticeMoreList(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).selectNoticeMoreList(params);
	}

	/**
	 * select faq board Total Cnt.
	 *
	 * @param params the params
	 * @return the hash map
	 */
	public HashMap<String,Object> noticeTotalCnt(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).noticeTotalCnt(params);
	}

	/**
	 * select qna List.
	 *
	 * @param params the params
	 * @return the array list
	 */
	public ArrayList<HashMap<String, Object>> selectQnaList(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).selectQnaList(params);
	}

	/**
	 * select qna board Total Cnt.
	 *
	 * @param params the params
	 * @return the hash map
	 */
	public HashMap<String,Object> qnaTotalCnt(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).qnaTotalCnt(params);
	}

	/**
	 * select qnaNode List.
	 *
	 * @param params the params
	 * @return the array list
	 */
	public ArrayList<HashMap<String, Object>> selectQnaNodeList(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).selectQnaNodeList(params);
	}

	/**
	 * select qnaNode board Total Cnt.
	 *
	 * @param params the params
	 * @return the hash map
	 */
	public HashMap<String,Object> qnaNodeTotalCnt(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMainMapper.class).qnaNodeTotalCnt(params);
	}
}
