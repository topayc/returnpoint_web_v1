package com.returnp_web.dao.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.returnp_web.utils.RPMap;

public interface MobileMainMapper {

	/**
	 * select my red point Sum Info.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : selectmemberTotal
	 * @Method 설명 : 포인트 조회
	 */
	int selectMemberTotal(HashMap<String, Object> params);

	/**
	 * select my red point Sum Info.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : selectMyRedPointSumInfo
	 * @Method 설명 : 포인트 조회
	 */
	HashMap<String,Object> selectMyRedPointSumInfo(HashMap<String, Object> params);

	/**
	 * select my Green point Sum Info.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : selectMyGreenPointSumInfo
	 * @Method 설명 : 포인트 조회
	 */
	HashMap<String,Object> selectMyGreenPointSumInfo(HashMap<String, Object> params);

	/**
	 * select my Green point List Info.
	 *
	 * @param params the params
	 * @return the array list
	 * @Method Name : selectmyGreenPointList
	 * @Method 설명 : 포인트 조회
	 */
	ArrayList<HashMap<String,Object>> selectMyGreenPointList(HashMap<String, Object> params);

	/**
	 * insert Point Convert RequestAct.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : selectmyGreenPointList
	 * @Method 설명 : 포인트 조회
	 */
	int insertPointConvertRequestAct(HashMap<String, Object> params);

	/**
	 * select duplicate Point Chcek .
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : selectRecommend
	 * @Method 설명 : 추천인 조회
	 */
	int duplicatePointChcek(HashMap<String,Object> params);

	/**
	 * update green point_use_sum.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : selectmyGreenPointList
	 * @Method 설명 : green point 차감
	 */
	int updateGreenPointUse(HashMap<String, Object> params);

	/**
	 * insert point conversion transaction Act.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : insertPointConvertTransactionAct
	 * @Method 설명 : point_conversion_transaction 저장
	 */
	int insertPointConvertTransactionAct(HashMap<String, Object> params);

	/**
	 * Select payment_pointback_record list.
	 *
	 * @param params the params
	 * @return the array list
	 * @Method Name : selectPaymentPointbackRecordList
	 * @Method 설명 : Green point 적립내역 조회
	 */
	//ArrayList<HashMap<String,Object>> selectPaymentPointbackRecordList(HashMap<String, Object> params);


	/**
	 * Select point_conversion_transaction list.
	 *
	 * @param params the params
	 * @return the array list
	 * @Method Name : selectPointConversionTransaction
	 * @Method 설명 : Red point 적립내역 조회
	 */
	//ArrayList<HashMap<String,Object>> selectpointConversionTransactionList(HashMap<String, Object> params);

	/**
	 * update red point update.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : updateMyRedPointUse
	 * @Method 설명 : my red point 차감(선물하기)
	 */
	int updateMyRedPointUse(HashMap<String, Object> params);

	/**
	 * update green point update.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : updateMyGreenPointUse
	 * @Method 설명 : my green point 차감(선물하기)
	 */
	int updateMyGreenPointUse(HashMap<String, Object> params);

	/**
	 * insert point_transfer_transaction Act.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : insertPointTransferTransactionAct
	 * @Method 설명 : point_transfer_transaction 저장(포인트선물하기)
	 */
	int insertPointTransferTransactionAct(HashMap<String, Object> params);

	/**
	 * select receiver red point Info.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : selectMyGreenPointSumInfo
	 * @Method 설명 : 포인트 조회
	 */
	HashMap<String,Object> selectReceiverRedPointInfo(HashMap<String, Object> params);

	/**
	 * update receive red point update.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : updateReceiveRedPoint
	 * @Method 설명 : receive red point 증가(선물하기)
	 */
	int updateReceiveRedPoint(HashMap<String, Object> params);

	/**
	 * update receive green point update.
	 *
	 * @param params the params
	 * @return the int
	 * @Method Name : updateReceiveGreenPoint
	 * @Method 설명 : receive green point 증가(선물하기)
	 */
	int updateReceiveGreenPoint(HashMap<String, Object> params);

	/**
	 * select policy List Info.
	 *
	 * @param params the params
	 * @return the array list
	 * @Method Name : selectmyGreenPointList
	 * @Method 설명 : 포인트 조회
	 */
	ArrayList<HashMap<String,Object>> selectPolicyList(HashMap<String, Object> params);

	/**
	 * select receiver green point Info.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : selectReceiverGreenPointInfo
	 * @Method 설명 : 포인트 조회
	 */
	HashMap<String,Object> selectReceiverGreenPointInfo(HashMap<String, Object> params);

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

	/**
	 * Select payment_pointback_record detail list.
	 *
	 * @param params the params
	 * @return the array list
	 * @Method Name : selectPaymentPointbackRecordDetailList
	 * @Method 설명 : Green point detail 적립내역 조회
	 */
	ArrayList<HashMap<String,Object>> selectPaymentPointbackRecordDetailList(HashMap<String, Object> params);

	/**
	 * select my Green point Sum List Info.
	 *
	 * @param params the params
	 * @return the array list
	 * @Method Name : selectmyGreenPointList
	 * @Method 설명 : 포인트 종류별 sum 조회
	 */
	ArrayList<HashMap<String,Object>> selectMyGreenPointSumList(HashMap<String, Object> params);

	/**
	 * Select point_conversion_transaction And point_transfer_transaction list.
	 *
	 * @param params the params
	 * @return the array list
	 * @Method Name : selectPointConversionTransaction
	 * @Method 설명 : Red point 적립내역 조회
	 */
	ArrayList<HashMap<String,Object>> selectpointConTranAndPointTranList(HashMap<String, Object> params);

	/**
	 * select my Red point Sum List Info.
	 *
	 * @param params the params
	 * @return the array list
	 * @Method Name : selectmyRedPointList
	 * @Method 설명 : 포인트 Red sum 조회
	 */
	ArrayList<HashMap<String,Object>> selectMyRedPointSumList(HashMap<String, Object> params);

	/**
	 * Select red point conversion transaction detail list.
	 *
	 * @param params the params
	 * @return the array list
	 * @Method Name : selectPointConversionTransactionDetailList
	 * @Method 설명 : red point detail 조회
	 */
	ArrayList<HashMap<String,Object>> selectPointConversionTransactionDetailList(HashMap<String, Object> params);

	/**
	 * Select faq list.
	 *
	 * @param params the params
	 * @return the array list
	 * @Method Name : selectFaqList
	 * @Method 설명 : FAQ 초기화면
	 */
	ArrayList<HashMap<String,Object>> selectFaqList(HashMap<String, Object> params);

	/**
	 * Select notice list.
	 *
	 * @param params the params
	 * @return the array list
	 * @Method Name : selectNoticeList
	 * @Method 설명 : NOTICE 초기화면
	 */
	ArrayList<HashMap<String,Object>> selectNoticeList(HashMap<String, Object> params);

	/**
	 * Select red point conversion transaction detail list.
	 *
	 * @param params the params
	 * @return the array list
	 * @Method Name : selectRpmapLoadList
	 * @Method 설명 : 내주변 가맹점 조회
	 */
	ArrayList<HashMap<String,Object>> selectRpmapLoadList(HashMap<String, Object> params);


	/**
	 * Select board faq list.
	 *
	 * @param params the params
	 * @return the array list
	 * @Method Name : selectFaqMoreList
	 * @Method 설명 : faq 더보기 조회
	 */
	ArrayList<HashMap<String,Object>> selectFaqMoreList(HashMap<String, Object> params);

	/**
	 * Select board notice list.
	 *
	 * @param params the params
	 * @return the array list
	 * @Method Name : selectNoticeMoreList
	 * @Method 설명 : notice 더보기 조회
	 */
	ArrayList<HashMap<String,Object>> selectNoticeMoreList(HashMap<String, Object> params);

	/**
	 * select faq board Total cnt.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : faqTotalCnt
	 * @Method 설명 : faq 게시판 게시글 수 조회
	 */
	HashMap<String,Object> faqTotalCnt(HashMap<String, Object> params);

	/**
	 * select notice board Total cnt.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : noticeTotalCnt
	 * @Method 설명 : notice 게시판 게시글 수 조회
	 */
	HashMap<String,Object> noticeTotalCnt(HashMap<String, Object> params);

	/**
	 * Select qna list.
	 *
	 * @param params the params
	 * @return the array list
	 * @Method Name : selectQnaList
	 * @Method 설명 : QNA 초기화면
	 */
	ArrayList<HashMap<String,Object>> selectQnaList(HashMap<String, Object> params);

	/**
	 * select qna board Total cnt.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : qnaTotalCntfaqTotalCnt
	 * @Method 설명 : QNA 게시판 게시글 수 조회
	 */
	HashMap<String,Object> qnaTotalCnt(HashMap<String, Object> params);

	/**
	 * Select qnaNode list.
	 *
	 * @param params the params
	 * @return the array list
	 * @Method Name : selectQnaNodeList
	 * @Method 설명 : 제휴상담 초기화면
	 */
	ArrayList<HashMap<String,Object>> selectQnaNodeList(HashMap<String, Object> params);

	/**
	 * select qna board Total cnt.
	 *
	 * @param params the params
	 * @return the hash map
	 * @Method Name : qnaNodeTotalCnt
	 * @Method 설명 : 제휴상담 게시판 게시글 수 조회
	 */
	HashMap<String,Object> qnaNodeTotalCnt(HashMap<String, Object> params);

	int  registPushToken(HashMap<String, Object> params);

	int  updateDeviceInfo(HashMap<String, Object> params);

	HashMap<String,Object>  selectDeviceInfo(HashMap<String, Object> params);
	
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

	ArrayList<HashMap<String, Object>> selectBoards(HashMap<String, Object> params);

	HashMap<String, Object> selectSubBbs(HashMap<String, Object> params);

	HashMap<String, Object> selectMemberAddress(HashMap<String, Object> params);

	HashMap<String, Object> selectAffiliate(HashMap<String, Object> params);

	HashMap<String, Object> selectAffiliateDetail(HashMap<String, Object> params);
	HashMap<String, Object> selectMember(HashMap<String, Object> params);
	HashMap<String, Object> selectPointCoupon(HashMap<String, Object> dbparams);

	HashMap<String, Object> selectPointCodeIssue(HashMap<String, Object> dbparams);

	HashMap<String, Object> selectAffiliateReceiptSummary(RPMap dbparams);

	HashMap<String, Object> selectAffiliateQrSummary(RPMap dbparams);

	ArrayList<HashMap<String, Object>> selectReceipts(HashMap<String, Object> dbparams);

	ArrayList<HashMap<String, Object>> selectCompletedReceipts(HashMap<String, Object> dbparams);

	ArrayList<HashMap<String, Object>> selectNotCompletedReceipts(HashMap<String, Object> dbparams);

	int createOrder(HashMap<String, Object> dbParams);

	ArrayList<HashMap<String, Object>> selectMaskOrders(HashMap<String, Object> dbparams);

	HashMap<String, Object> selectUserAddress(HashMap<String, Object> dbParams);

	int insertUserAddress(HashMap<String, Object> dbParams);

	int updateUserAddress(HashMap<String, Object> dbParams);
}
