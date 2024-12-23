package com.returnp_web.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.returnp_web.dao.mapper.MobileMainMapper;
import com.returnp_web.dao.mapper.MobileMapper;
import com.returnp_web.utils.RPMap;


/**
 * The Class MobileMainDao.
 */
@Repository
public class MobileMainDao {

	/** The Constant logger. */
	private static final Logger logger = LoggerFactory.getLogger(MobileMainDao.class);

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
		return sqlSession.getMapper(MobileMainMapper.class).selectMemberTotal(params);
	}

	/**
	 * select my red point Sum Info.
	 *
	 * @param params the params
	 * @return the hash map
	 */
	public HashMap<String,Object> selectMyRedPointSumInfo(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMainMapper.class).selectMyRedPointSumInfo(params);
	}

	/**
	 * select my green point Sum Info.
	 *
	 * @param params the params
	 * @return the hash map
	 */
	public HashMap<String,Object> selectMyGreenPointSumInfo(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMainMapper.class).selectMyGreenPointSumInfo(params);
	}

	/**
	 * select my Green point List Info.
	 *
	 * @param params the params
	 * @return the array list
	 */
	public ArrayList<HashMap<String,Object>> selectMyGreenPointList(HashMap<String, Object> params) {
		return sqlSession.getMapper(MobileMainMapper.class).selectMyGreenPointList(params);
	}

	/**
	 * insert point_convert_request.
	 *
	 * @param params the params
	 * @return int
	 */
	public int insertPointConvertRequestAct(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMainMapper.class).insertPointConvertRequestAct(params);
	}

	/**
	 * Select duplicate Point Chcek count.
	 *
	 * @param params the params
	 * @return the int
	 */
	public int duplicatePointChcek(HashMap<String,Object> params) {
		return sqlSession.getMapper(MobileMainMapper.class).duplicatePointChcek(params);
	}

	/**
	 * update green point_use_sum.
	 *
	 * @param params the params
	 * @return int
	 */
	public int updateGreenPointUse(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMainMapper.class).updateGreenPointUse(params);
	}

	/**
	 * insert point_conversion_transaction.
	 *
	 * @param params the params
	 * @return int
	 */
	public int insertPointConvertTransactionAct(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMainMapper.class).insertPointConvertTransactionAct(params);
	}

	/**
	 * select payment_pointback_record List Info.
	 *
	 * @param params the params
	 * @return the array list
	 */
	//public ArrayList<HashMap<String, Object>> selectPaymentPointbackRecordList(HashMap<String,Object> params){
	//	return sqlSession.getMapper(MobileMainMapper.class).selectPaymentPointbackRecordList(params);
	//}

	/**
	 * select point_conversion_transaction List Info.
	 *
	 * @param params the params
	 * @return the array list
	 */
	//public ArrayList<HashMap<String, Object>> selectpointConversionTransactionList(HashMap<String,Object> params){
	//	return sqlSession.getMapper(MobileMainMapper.class).selectpointConversionTransactionList(params);
	//}

	/**
	 * update my red point.
	 *
	 * @param params the params
	 * @return int
	 */
	public int updateMyRedPointUse(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMainMapper.class).updateMyRedPointUse(params);
	}


	/**
	 * update my green point.
	 *
	 * @param params the params
	 * @return int
	 */
	public int updateMyGreenPointUse(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMainMapper.class).updateMyGreenPointUse(params);
	}

	/**
	 * insert point_transfer_transaction
	 *
	 * @param params the params
	 * @return int
	 */
	public int insertPointTransferTransactionAct(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMainMapper.class).insertPointTransferTransactionAct(params);
	}

	/**
	 * select receiver red point Info.
	 *
	 * @param params the params
	 * @return the hash map
	 */
	public HashMap<String,Object> selectReceiverRedPointInfo(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMainMapper.class).selectReceiverRedPointInfo(params);
	}

	/**
	 * update receiver red point.
	 *
	 * @param params the params
	 * @return int
	 */
	public int updateReceiveRedPoint(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMainMapper.class).updateReceiveRedPoint(params);
	}

	/**
	 * update receiver green point.
	 *
	 * @param params the params
	 * @return int
	 */
	public int updateReceiveGreenPoint(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMainMapper.class).updateReceiveGreenPoint(params);
	}

	/**
	 * select policy List Info.
	 *
	 * @param params the params
	 * @return the array list
	 */
	public ArrayList<HashMap<String, Object>> selectPolicyList(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMainMapper.class).selectPolicyList(params);
	}

	/**
	 * select receiver green point Info.
	 *
	 * @param params the params
	 * @return the hash map
	 */
	public HashMap<String,Object> selectReceiverGreenPointInfo(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMainMapper.class).selectReceiverGreenPointInfo(params);
	}

	/**
	 * select company Info.
	 *
	 * @param params the params
	 * @return the hash map
	 */
	public HashMap<String,Object> selectCompanyInfo(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMainMapper.class).selectCompanyInfo(params);
	}

	/**
	 * select ServerManageStatus Info.
	 *
	 * @param params the params
	 * @return the hash map
	 */
	public HashMap<String,Object> selectServerManageStatusInfo(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMainMapper.class).selectServerManageStatusInfo(params);
	}

	/**
	 * select payment_pointback_record detail List Info.
	 *
	 * @param params the params
	 * @return the array list
	 */
	public ArrayList<HashMap<String, Object>> selectPaymentPointbackRecordDetailList(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMainMapper.class).selectPaymentPointbackRecordDetailList(params);
	}

	/**
	 * select my Green point Sum List Info.
	 *
	 * @param params the params
	 * @return the array list
	 */
	public ArrayList<HashMap<String,Object>> selectMyGreenPointSumList(HashMap<String, Object> params) {
		return sqlSession.getMapper(MobileMainMapper.class).selectMyGreenPointSumList(params);
	}

	/**
	 * select point_conversion_transaction And point_transfer_transaction List Info.
	 *
	 * @param params the params
	 * @return the array list
	 */
	public ArrayList<HashMap<String, Object>> selectpointConTranAndPointTranList(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMainMapper.class).selectpointConTranAndPointTranList(params);
	}

	/**
	 * select my Red point Sum List Info.
	 *
	 * @param params the params
	 * @return the array list
	 */
	public ArrayList<HashMap<String,Object>> selectMyRedPointSumList(HashMap<String, Object> params) {
		return sqlSession.getMapper(MobileMainMapper.class).selectMyRedPointSumList(params);
	}

	/**
	 * select conversion transaction red point detail List Info.
	 *
	 * @param params the params
	 * @return the array list
	 */
	public ArrayList<HashMap<String, Object>> selectPointConversionTransactionDetailList(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMainMapper.class).selectPointConversionTransactionDetailList(params);
	}

	/**
	 * select faq List.
	 *
	 * @param params the params
	 * @return the array list
	 */
	public ArrayList<HashMap<String, Object>> selectFaqList(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMainMapper.class).selectFaqList(params);
	}

	/**
	 * select notice List.
	 *
	 * @param params the params
	 * @return the array list
	 */
	public ArrayList<HashMap<String, Object>> selectNoticeList(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMainMapper.class).selectNoticeList(params);
	}

	/**
	 * select conversion transaction red point detail List Info.
	 *
	 * @param params the params
	 * @return the array list
	 */
	public ArrayList<HashMap<String, Object>> selectRpmapLoadList(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMainMapper.class).selectRpmapLoadList(params);
	}

	/**
	 * select faq board Total Cnt.
	 *
	 * @param params the params
	 * @return the hash map
	 */
	public HashMap<String,Object> faqTotalCnt(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMainMapper.class).faqTotalCnt(params);
	}

	/**
	 * select board faq List Info.
	 *
	 * @param params the params
	 * @return the array list
	 */
	public ArrayList<HashMap<String, Object>> selectFaqMoreList(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMainMapper.class).selectFaqMoreList(params);
	}

	/**
	 * select notice List Info.
	 *
	 * @param params the params
	 * @return the array list
	 */
	public ArrayList<HashMap<String, Object>> selectNoticeMoreList(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMainMapper.class).selectNoticeMoreList(params);
	}

	/**
	 * select faq board Total Cnt.
	 *
	 * @param params the params
	 * @return the hash map
	 */
	public HashMap<String,Object> noticeTotalCnt(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMainMapper.class).noticeTotalCnt(params);
	}

	/**
	 * select qna List.
	 *
	 * @param params the params
	 * @return the array list
	 */
	public ArrayList<HashMap<String, Object>> selectQnaList(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMainMapper.class).selectQnaList(params);
	}

	/**
	 * select qna board Total Cnt.
	 *
	 * @param params the params
	 * @return the hash map
	 */
	public HashMap<String,Object> qnaTotalCnt(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMainMapper.class).qnaTotalCnt(params);
	}

	/**
	 * select qnaNode List.
	 *
	 * @param params the params
	 * @return the array list
	 */
	public ArrayList<HashMap<String, Object>> selectQnaNodeList(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMainMapper.class).selectQnaNodeList(params);
	}

	/**
	 * select qnaNode board Total Cnt.
	 *
	 * @param params the params
	 * @return the hash map
	 */
	public HashMap<String,Object> qnaNodeTotalCnt(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMainMapper.class).qnaNodeTotalCnt(params);
	}

	public ArrayList<HashMap<String, Object>> selectBoards(HashMap<String, Object> params) {
		return sqlSession.getMapper(MobileMainMapper.class).selectBoards(params);
	}

	public HashMap<String, Object> selectSubBbs(HashMap<String, Object> params) {
		return sqlSession.getMapper(MobileMainMapper.class).selectSubBbs(params);
	}
	
	public HashMap<String, Object> selectMemberAddress(HashMap<String, Object> params) {
		return sqlSession.getMapper(MobileMainMapper.class).selectMemberAddress(params);
	}
	
	public HashMap<String, Object> selectAffiliate(HashMap<String, Object> params) {
		return sqlSession.getMapper(MobileMainMapper.class).selectAffiliate(params);
	}
	
	public HashMap<String, Object> selectAffiliateDetail(HashMap<String, Object> params) {
		return sqlSession.getMapper(MobileMainMapper.class).selectAffiliateDetail(params);
	}

	public HashMap<String, Object> selectMember(HashMap<String, Object> params) {
		return sqlSession.getMapper(MobileMainMapper.class).selectMember(params);
	}
	
	public HashMap<String, Object> selectPointCoupon(HashMap<String, Object> dbparams) {
		return sqlSession.getMapper(MobileMainMapper.class).selectPointCoupon(dbparams);
	}

	public HashMap<String, Object> selectPointCodeIssue(HashMap<String, Object> dbparams) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(MobileMainMapper.class).selectPointCodeIssue(dbparams);
	}

	public HashMap<String, Object> selectAffiliateReceiptSummary(RPMap dbparams) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(MobileMainMapper.class).selectAffiliateReceiptSummary(dbparams);
	}

	public HashMap<String, Object> selectAffiliateQrSummary(RPMap dbparams) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(MobileMainMapper.class).selectAffiliateQrSummary(dbparams);
	}

	public ArrayList<HashMap<String, Object>> selectReceipts(HashMap<String, Object> dbparams) {
		return sqlSession.getMapper(MobileMainMapper.class).selectReceipts(dbparams);
	}

	public ArrayList<HashMap<String, Object>> selectCompletedReceipts(HashMap<String, Object> dbparams) {
		return sqlSession.getMapper(MobileMainMapper.class).selectCompletedReceipts(dbparams);
	}

	public ArrayList<HashMap<String, Object>> selectNotCompletedReceipts(HashMap<String, Object> dbparams) {
		return sqlSession.getMapper(MobileMainMapper.class).selectNotCompletedReceipts(dbparams);
	}

	public int createOrder(HashMap<String, Object> dbParams) {
		return sqlSession.getMapper(MobileMainMapper.class).createOrder(dbParams);
	}

	public ArrayList<HashMap<String, Object>> selectMaskOrders(HashMap<String, Object> dbparams) {
		return sqlSession.getMapper(MobileMainMapper.class).selectMaskOrders(dbparams);
	}

	public HashMap<String, Object> selectUserAddress(HashMap<String, Object> dbParams) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(MobileMainMapper.class).selectUserAddress(dbParams);
	}

	public int insertUserAddress(HashMap<String, Object> dbParams) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(MobileMainMapper.class).insertUserAddress(dbParams);
	}

	public int updateUserAddress(HashMap<String, Object> dbParams) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(MobileMainMapper.class).updateUserAddress(dbParams);
	}

}