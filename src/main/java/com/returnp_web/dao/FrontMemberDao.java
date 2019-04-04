package com.returnp_web.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.returnp_web.dao.mapper.FrontMapper;
import com.returnp_web.utils.RPMap;


/**
 * The Class FrontMainDao.
 */
@Repository
public class FrontMemberDao {
	
	/** The Constant logger. */
	private static final Logger logger = LoggerFactory.getLogger(FrontMemberDao.class);
	
	/** The sql session. */
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	/**
	 * Select login user
	 *
	 * @param params the params
	 * @return HashMap
	 */
	public HashMap<String,Object> loginAct(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMapper.class).loginAct(params);
	}
	
	/**
	 * login failure.
	 *
	 * @param params the params
	 * @return void
	 */
	public int updateLoginFailure(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMapper.class).updateLoginFailure(params);
	}
	
	/**
	 * auth number update.
	 *
	 * @param params the params
	 * @return void
	 */
	public int updateLoginAuthNumber(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMapper.class).updateLoginAuthNumber(params);
	}
	
	/**
	 * auth number delete.
	 *
	 * @param params the params
	 * @return void
	 */
	public int loginAuthNumberDelete(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMapper.class).loginAuthNumberDelete(params);
	}
	
	/**
	 * log out
	 *
	 * @param params the params
	 * @return HashMap
	 */
	public HashMap<String,Object> logOut(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMapper.class).logOut(params);
	}
	
	/**
	 * Select Recommend count.
	 *
	 * @param params the params
	 * @return the int
	 */
	public int selectRecommend(HashMap<String,Object> params) {
		return sqlSession.getMapper(FrontMapper.class).selectRecommend(params);
	}
	
	public ArrayList<HashMap<String,Object>> selectMyMemberList(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMapper.class).selectMyMemberList(params);
	}

	public int  selectMyMemberListCount(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMapper.class).selectMyMemberListCount(params);
	}
	
	/**
	 * select member .
	 *
	 * @param params the params
	 * @return the int
	 */
	public HashMap<String,Object> selectAuthMember(HashMap<String,Object> params) {
		return sqlSession.getMapper(FrontMapper.class).selectAuthMember(params);
	}	
		
	/**
	 * Select Recommend info.
	 *
	 * @param params the params
	 * @return the int
	 */
	public HashMap<String,Object> selectRecommendDetail(HashMap<String,Object> params) {
		return sqlSession.getMapper(FrontMapper.class).selectRecommendDetail(params);
	}
	
	/**
	 * Select member Email Duplicate count.
	 *
	 * @param params the params
	 * @return the int
	 */
	public int selectMemberEmailDup(HashMap<String,Object> params) {
		return sqlSession.getMapper(FrontMapper.class).selectmemberEmailDup(params);
	}
	
	/**
	 * Select memberNo.
	 *
	 * @param params the params
	 * @return the int
	 */
	public int selectMemberNo(HashMap<String,Object> params) {
		return sqlSession.getMapper(FrontMapper.class).selectmemberNo(params);
	}
	
	/**
	 * insert member.
	 *
	 * @param params the params
	 * @return int
	 */
	public int insertJoinAct(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMapper.class).insertJoinAct(params);
	}

	/**
	 * insert member green point default.
	 *
	 * @param params the params
	 * @return int
	 */
	public int insertGreenAct(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMapper.class).insertGreenAct(params);
	}
	
	/**
	 * insert member red point default.
	 *
	 * @param params the params
	 * @return int
	 */
	public int insertRedAct(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMapper.class).insertRedAct(params);
	}
	
	/**
	 * Select myinfo.
	 *
	 * @param params the params
	 * @return the int
	 */
	public HashMap<String,Object> selectMypageMyinfo(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMapper.class).selectMypageMyinfo(params);
	}
	
	/**
	 * Select recommenderNo.
	 *
	 * @param params the params
	 * @return the int
	 */
	public String recommenderNo(HashMap<String,Object> params) {
		return sqlSession.getMapper(FrontMapper.class).recommenderNo(params);
	}
	
	/**
	 * Update user.
	 *
	 * @param params the params
	 * @return the int
	 */
	public int updateUser(HashMap<String,Object> params) {
		return sqlSession.getMapper(FrontMapper.class).updateUser(params);
	}
	
	/**
	 * Update member Status.
	 *
	 * @param params the params
	 * @return the int
	 */
	public int updateUserMemberStatus(HashMap<String,Object> params) {
		return sqlSession.getMapper(FrontMapper.class).updateUserMemberStatus(params);
	}
	
	/**
	 * Select email Sign count.
	 *
	 * @param params the params
	 * @return the int
	 */
	public int selectEmailSignSuccessCount(HashMap<String,Object> params) {
		return sqlSession.getMapper(FrontMapper.class).selectEmailSignSuccessCount(params);
	}	
	
	/**
	 * Select email find
	 *
	 * @param params the params
	 * @return HashMap
	 */
	public HashMap<String,Object> selectFindEmailAct(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMapper.class).selectFindEmailAct(params);
	}
	
	/**
	 * Select find user email
	 *
	 * @param params the params
	 * @return HashMap
	 */
	public HashMap<String,Object> selectFindUserEmailAct(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMapper.class).selectFindUserEmailAct(params);
	}
	
	/**
	 * Select user info. use memberEmail
	 *
	 * @param params the params
	 * @return HashMap
	 */
	public HashMap<String,Object> selectUserInfoUseEmail(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMapper.class).selectUserInfoUseEmail(params);
	}
	
	/**
	 * random  update.
	 *
	 * @param params the params
	 * @return void
	 */
	
	public int updateTempPw(HashMap<String,Object> params) {
		return sqlSession.getMapper(FrontMapper.class).updateTempPw(params);
	}
	
	/**
	 * Select member count.
	 *
	 * @param params the params
	 * @return the int
	 */
	public int selectMemberJoinCount(HashMap<String,Object> params) {
		return sqlSession.getMapper(FrontMapper.class).selectMemberJoinCount(params);
	}
	
	/**
	 * Select member phone overlap count.
	 *
	 * @param params the params
	 * @return the int
	 */
	public int selectMemberPhoneOverlapCount(HashMap<String,Object> params) {
		return sqlSession.getMapper(FrontMapper.class).selectMemberPhoneOverlapCount(params);
	}
	
	/**
	 * Select mypage myinfo.
	 *
	 * @param params the params
	 * @return the int
	 */
	public HashMap<String,Object> selectMyinfoCheck(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMapper.class).selectMyinfoCheck(params);
	}
	
	
	/**
	 * login failure.
	 *
	 * @param params the params
	 * @return void
	 */
	public int deleteLoginFailure(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMapper.class).deleteLoginFailure(params);
	}
	
	public ArrayList<HashMap<String, Object>> selectCompanyBankList(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMapper.class).selectCompanyBankList(params);
	}
	
	public HashMap<String,Object> selectCompanyBankAccount(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMapper.class).selectCompanyBankAccount(params);
	}
	
	public HashMap<String,Object> selectPolicyMembershipTransLimit(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMapper.class).selectPolicyMembershipTransLimit(params);
	}
	
	public HashMap<String,Object> selectPointConversionTransaction(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMapper.class).selectPointConversionTransaction(params);
	}
	
	/**
	 * insert membership_request.
	 *
	 * @param params the params
	 * @return void
	 */
	public int insertMembershipRequest(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMapper.class).insertMembershipRequest(params);
	}
	
	/**
	 * member out update.
	 *
	 * @param params the params
	 * @return void
	 */
	public int memberOutAct(HashMap<String,Object> params) {
		return sqlSession.getMapper(FrontMapper.class).memberOutAct(params);
	}
	
	/**
	 * select member Validity.
	 *
	 * @param params the params
	 * @return void
	 */
	public HashMap<String,Object> selectMypageMyinfoValidity(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMapper.class).selectMypageMyinfoValidity(params);
	}
	
	/**
	 * Select MemberShip Req count.
	 *
	 * @param params the params
	 * @return the int
	 */
	public int selectMemberShipReq(HashMap<String,Object> params) {
		return sqlSession.getMapper(FrontMapper.class).selectMemberShipReq(params);
	}
	
	/**
	 * Select policy.
	 *
	 * @param params the params
	 * @return the int
	 */
	public HashMap<String,Object> selectPolicyPointTranslimit(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMapper.class).selectPolicyPointTranslimit(params);
	}
	
	/**
	 * Select member email Info.
	 *
	 * @param params the params
	 * @return the int
	 */
	public int selectMemberInfo(HashMap<String,Object> params) {
		return sqlSession.getMapper(FrontMapper.class).selectMemberInfo(params);
	}
	
	/**
	 * Select RedPoint Map info.
	 *
	 * @param params the params
	 * @return HashMap
	 */
	public HashMap<String,Object> selectMyRedPointMapinfo(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMapper.class).selectMyRedPointMapinfo(params);
	}
	
	/**
	 * Select RecipientMember info.
	 *
	 * @param params the params
	 * @return HashMap
	 */
	public HashMap<String,Object> selectRecipientMemberinfo(HashMap<String,Object> params) {
		return sqlSession.getMapper(FrontMapper.class).selectRecipientMemberinfo(params);
	}
	
	/**
	 * Select selectYearMonth.
	 *
	 * @param params the params
	 * @return HashMap
	 */
	public HashMap<String,Object> selectYearMonth(HashMap<String,Object> params) {
		return sqlSession.getMapper(FrontMapper.class).selectYearMonth(params);
	}
	
	/**
	 * Select select Mygreen Point Info.
	 *
	 * @param params the params
	 * @return HashMap
	 */
	public HashMap<String,Object> selectMygreenPointInfo(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMapper.class).selectMygreenPointInfo(params);
	}
	
	/**
	 * Select member_auth_token.
	 *
	 * @param params the params
	 * @return HashMap
	 */
	public HashMap<String,Object> selectMemberAuthToken(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMapper.class).selectMemberAuthToken(params);
	}
	
	/**
	 * insert member_auth_token.
	 *
	 * @param params the params
	 * @return int
	 */
	public int insertMemberAuthTokenAct(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMapper.class).insertMemberAuthTokenAct(params);
	}
	
	
	/**
	 * delete member_auth_token.
	 *
	 * @param params the params
	 * @return int
	 */
	public int deleteMemberAuthToken(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMapper.class).deleteMemberAuthToken(params);
	}
	
	public HashMap<String,Object> getMemberAuthToken(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMapper.class).getMemberAuthToken(params);
	}
	
	/**
	 * Select qr memberPhone Info.
	 *
	 * @param params the params
	 * @return the int
	 */
	public int selectqrMemberPhone(HashMap<String,Object> params) {
		return sqlSession.getMapper(FrontMapper.class).selectqrMemberPhone(params);
	}
	
	/**
	 * Select auto login user
	 *
	 * @param params the params
	 * @return HashMap
	 */
	public HashMap<String,Object> loginAppAct(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMapper.class).loginAppAct(params);
	}
	
	/**
	 * Select AffiliateInfo.
	 *
	 * @param params the params
	 * @return HashMap
	 */
	public HashMap<String,Object> selectAffiliateInfo(HashMap<String,Object> params) {
		return sqlSession.getMapper(FrontMapper.class).selectAffiliateInfo(params);
	}
	
	/**
	 * Select member phone overlap myinfo modify count.
	 *
	 * @param params the params
	 * @return the int
	 */
	public int selectMemberPhoneOverlapModfiyCount(HashMap<String,Object> params) {
		return sqlSession.getMapper(FrontMapper.class).selectMemberPhoneOverlapModfiyCount(params);
	}
	
	/**
	 * Select MembershipRequest PaymentStatus.
	 *
	 * @param params the params
	 * @return the int
	 */
	public HashMap<String,Object> selectMembershipRequestPaymentStatus(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMapper.class).selectMembershipRequestPaymentStatus(params);
	}
	
	/**
	 * Update user paymentStatus.
	 *
	 * @param params the params
	 * @return the int
	 */
	public int updatePaymentStatusRequestCon(HashMap<String,Object> params) {
		return sqlSession.getMapper(FrontMapper.class).updatePaymentStatusRequestCon(params);
	}
	
	/**
	 * Select member Type info.
	 *
	 * @param params the params
	 * @return the HashMap
	 */
	public HashMap<String,Object> selectmemberTypeInfo(HashMap<String,Object> params){
		return sqlSession.getMapper(FrontMapper.class).selectmemberTypeInfo(params);
	}
	
	/**
	 * insert QnA.
	 *
	 * @param params the params
	 * @return int
	 */
	public int insertQnaWAct(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMapper.class).insertQnaWAct(params);
	}
	
	/**
	 * insert 제휴상담.
	 *
	 * @param params the params
	 * @return int
	 */
	public int insertQnaNodeWAct(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMapper.class).insertQnaNodeWAct(params);
	}

	public ArrayList<HashMap<String,Object>> selectCountries(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMapper.class).selectCountries(params);
	}

	public ArrayList<HashMap<String,Object>> selectLanguages(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMapper.class).selectLanguages(params);
	}
	
	public ArrayList<HashMap<String,Object>> selectBankAccounts(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMapper.class).selectBankAccounts(params);
	}
	public int deleteMemberBankAccount(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMapper.class).deleteMemberBankAccount(params);
	}

	public int insertMemberBankAccount(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMapper.class).insertMemberBankAccount(params);
	}
	
	public int insertPointWithdrawal(HashMap<String, Object> params) {
		return sqlSession.getMapper(FrontMapper.class).insertPointWithdrawal(params);
	}
	
	public int updatePointwithdrawal(HashMap<String, Object> params) {
		return sqlSession.getMapper(FrontMapper.class).updatePointwithdrawal(params);
	}
	public int updateRedPoint(HashMap<String, Object> params) {
		return sqlSession.getMapper(FrontMapper.class).updateRedPoint(params);
	}

	public int updateMemberBankAccount(HashMap<String, Object> params) {
		return sqlSession.getMapper(FrontMapper.class).updateMemberBankAccount(params);
	}
	
	public ArrayList<HashMap<String,Object>> selectPointwithdrawals(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMapper.class).selectPointwithdrawals(params);
	}

	public int selectWithdrawalSumPerDay(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMapper.class).selectWithdrawalSumPerDay(params);
	}
	public HashMap<String,Object> selectGiftCardIssue(HashMap<String, Object> params){
		return sqlSession.getMapper(FrontMapper.class).selectGiftCardIssue(params);
	}
}
