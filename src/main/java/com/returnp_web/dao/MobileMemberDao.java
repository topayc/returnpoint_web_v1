package com.returnp_web.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import com.returnp_web.dao.mapper.MobileMapper;
import com.returnp_web.utils.RPMap;


/**
 * The Class MobileMainDao.
 */
@Repository
public class MobileMemberDao {
	
	/** The Constant logger. */
	private static final Logger logger = LoggerFactory.getLogger(MobileMemberDao.class);
	
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
		return sqlSession.getMapper(MobileMapper.class).loginAct(params);
	}
	
	/**
	 * login failure.
	 *
	 * @param params the params
	 * @return void
	 */
	public int updateLoginFailure(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMapper.class).updateLoginFailure(params);
	}
	
	/**
	 * auth number update.
	 *
	 * @param params the params
	 * @return void
	 */
	public int updateLoginAuthNumber(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMapper.class).updateLoginAuthNumber(params);
	}
	
	/**
	 * auth number delete.
	 *
	 * @param params the params
	 * @return void
	 */
	public int loginAuthNumberDelete(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMapper.class).loginAuthNumberDelete(params);
	}
	
	/**
	 * log out
	 *
	 * @param params the params
	 * @return HashMap
	 */
	public HashMap<String,Object> logOut(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMapper.class).logOut(params);
	}
	
	/**
	 * Select Recommend count.
	 *
	 * @param params the params
	 * @return the int
	 */
	public int selectRecommend(HashMap<String,Object> params) {
		return sqlSession.getMapper(MobileMapper.class).selectRecommend(params);
	}
	
	public ArrayList<HashMap<String,Object>> selectMyMemberList(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMapper.class).selectMyMemberList(params);
	}

	public int  selectMyMemberListCount(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMapper.class).selectMyMemberListCount(params);
	}
	
	/**
	 * select member .
	 *
	 * @param params the params
	 * @return the int
	 */
	public HashMap<String,Object> selectAuthMember(HashMap<String,Object> params) {
		return sqlSession.getMapper(MobileMapper.class).selectAuthMember(params);
	}	
		
	/**
	 * Select Recommend info.
	 *
	 * @param params the params
	 * @return the int
	 */
	public HashMap<String,Object> selectRecommendDetail(HashMap<String,Object> params) {
		return sqlSession.getMapper(MobileMapper.class).selectRecommendDetail(params);
	}
	
	/**
	 * Select member Email Duplicate count.
	 *
	 * @param params the params
	 * @return the int
	 */
	public int selectMemberEmailDup(HashMap<String,Object> params) {
		return sqlSession.getMapper(MobileMapper.class).selectmemberEmailDup(params);
	}
	
	/**
	 * Select memberNo.
	 *
	 * @param params the params
	 * @return the int
	 */
	public int selectMemberNo(HashMap<String,Object> params) {
		return sqlSession.getMapper(MobileMapper.class).selectmemberNo(params);
	}
	
	/**
	 * insert member.
	 *
	 * @param params the params
	 * @return int
	 */
	public int insertJoinAct(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMapper.class).insertJoinAct(params);
	}

	/**
	 * insert member green point default.
	 *
	 * @param params the params
	 * @return int
	 */
	public int insertGreenAct(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMapper.class).insertGreenAct(params);
	}
	
	/**
	 * insert member red point default.
	 *
	 * @param params the params
	 * @return int
	 */
	public int insertRedAct(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMapper.class).insertRedAct(params);
	}
	
	/**
	 * Select myinfo.
	 *
	 * @param params the params
	 * @return the int
	 */
	public HashMap<String,Object> selectMypageMyinfo(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMapper.class).selectMypageMyinfo(params);
	}
	
	/**
	 * Select recommenderNo.
	 *
	 * @param params the params
	 * @return the int
	 */
	public String recommenderNo(HashMap<String,Object> params) {
		return sqlSession.getMapper(MobileMapper.class).recommenderNo(params);
	}
	
	/**
	 * Update user.
	 *
	 * @param params the params
	 * @return the int
	 */
	public int updateUser(HashMap<String,Object> params) {
		return sqlSession.getMapper(MobileMapper.class).updateUser(params);
	}
	
	/**
	 * Update member Status.
	 *
	 * @param params the params
	 * @return the int
	 */
	public int updateUserMemberStatus(HashMap<String,Object> params) {
		return sqlSession.getMapper(MobileMapper.class).updateUserMemberStatus(params);
	}
	
	/**
	 * Select email Sign count.
	 *
	 * @param params the params
	 * @return the int
	 */
	public int selectEmailSignSuccessCount(HashMap<String,Object> params) {
		return sqlSession.getMapper(MobileMapper.class).selectEmailSignSuccessCount(params);
	}	
	
	/**
	 * Select email find
	 *
	 * @param params the params
	 * @return HashMap
	 */
	public HashMap<String,Object> selectFindEmailAct(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMapper.class).selectFindEmailAct(params);
	}
	
	/**
	 * Select find user email
	 *
	 * @param params the params
	 * @return HashMap
	 */
	public HashMap<String,Object> selectFindUserEmailAct(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMapper.class).selectFindUserEmailAct(params);
	}
	
	/**
	 * Select user info. use memberEmail
	 *
	 * @param params the params
	 * @return HashMap
	 */
	public HashMap<String,Object> selectUserInfoUseEmail(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMapper.class).selectUserInfoUseEmail(params);
	}
	
	/**
	 * random  update.
	 *
	 * @param params the params
	 * @return void
	 */
	
	public int updateTempPw(HashMap<String,Object> params) {
		return sqlSession.getMapper(MobileMapper.class).updateTempPw(params);
	}
	
	/**
	 * Select member count.
	 *
	 * @param params the params
	 * @return the int
	 */
	public int selectMemberJoinCount(HashMap<String,Object> params) {
		return sqlSession.getMapper(MobileMapper.class).selectMemberJoinCount(params);
	}
	
	/**
	 * Select member phone overlap count.
	 *
	 * @param params the params
	 * @return the int
	 */
	public int selectMemberPhoneOverlapCount(HashMap<String,Object> params) {
		return sqlSession.getMapper(MobileMapper.class).selectMemberPhoneOverlapCount(params);
	}
	
	/**
	 * Select mypage myinfo.
	 *
	 * @param params the params
	 * @return the int
	 */
	public HashMap<String,Object> selectMyinfoCheck(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMapper.class).selectMyinfoCheck(params);
	}
	
	
	/**
	 * login failure.
	 *
	 * @param params the params
	 * @return void
	 */
	public int deleteLoginFailure(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMapper.class).deleteLoginFailure(params);
	}
	
	public ArrayList<HashMap<String, Object>> selectCompanyBankList(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMapper.class).selectCompanyBankList(params);
	}
	
	public HashMap<String,Object> selectCompanyBankAccount(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMapper.class).selectCompanyBankAccount(params);
	}
	
	public HashMap<String,Object> selectPolicyMembershipTransLimit(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMapper.class).selectPolicyMembershipTransLimit(params);
	}
	
	public HashMap<String,Object> selectPointConversionTransaction(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMapper.class).selectPointConversionTransaction(params);
	}
	
	/**
	 * insert membership_request.
	 *
	 * @param params the params
	 * @return void
	 */
	public int insertMembershipRequest(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMapper.class).insertMembershipRequest(params);
	}
	
	/**
	 * member out update.
	 *
	 * @param params the params
	 * @return void
	 */
	public int memberOutAct(HashMap<String,Object> params) {
		return sqlSession.getMapper(MobileMapper.class).memberOutAct(params);
	}
	
	/**
	 * select member Validity.
	 *
	 * @param params the params
	 * @return void
	 */
	public HashMap<String,Object> selectMypageMyinfoValidity(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMapper.class).selectMypageMyinfoValidity(params);
	}
	
	/**
	 * Select MemberShip Req count.
	 *
	 * @param params the params
	 * @return the int
	 */
	public int selectMemberShipReq(HashMap<String,Object> params) {
		return sqlSession.getMapper(MobileMapper.class).selectMemberShipReq(params);
	}
	
	/**
	 * Select policy.
	 *
	 * @param params the params
	 * @return the int
	 */
	public HashMap<String,Object> selectPolicyPointTranslimit(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMapper.class).selectPolicyPointTranslimit(params);
	}
	
	/**
	 * Select member email Info.
	 *
	 * @param params the params
	 * @return the int
	 */
	public int selectMemberInfo(HashMap<String,Object> params) {
		return sqlSession.getMapper(MobileMapper.class).selectMemberInfo(params);
	}
	
	/**
	 * Select RedPoint Map info.
	 *
	 * @param params the params
	 * @return HashMap
	 */
	public HashMap<String,Object> selectMyRedPointMapinfo(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMapper.class).selectMyRedPointMapinfo(params);
	}
	
	/**
	 * Select RecipientMember info.
	 *
	 * @param params the params
	 * @return HashMap
	 */
	public HashMap<String,Object> selectRecipientMemberinfo(HashMap<String,Object> params) {
		return sqlSession.getMapper(MobileMapper.class).selectRecipientMemberinfo(params);
	}
	
	/**
	 * Select selectYearMonth.
	 *
	 * @param params the params
	 * @return HashMap
	 */
	public HashMap<String,Object> selectYearMonth(HashMap<String,Object> params) {
		return sqlSession.getMapper(MobileMapper.class).selectYearMonth(params);
	}
	
	/**
	 * Select select Mygreen Point Info.
	 *
	 * @param params the params
	 * @return HashMap
	 */
	public HashMap<String,Object> selectMygreenPointInfo(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMapper.class).selectMygreenPointInfo(params);
	}
	
	/**
	 * Select member_auth_token.
	 *
	 * @param params the params
	 * @return HashMap
	 */
	public HashMap<String,Object> selectMemberAuthToken(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMapper.class).selectMemberAuthToken(params);
	}
	
	/**
	 * insert member_auth_token.
	 *
	 * @param params the params
	 * @return int
	 */
	public int insertMemberAuthTokenAct(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMapper.class).insertMemberAuthTokenAct(params);
	}
	
	
	/**
	 * delete member_auth_token.
	 *
	 * @param params the params
	 * @return int
	 */
	public int deleteMemberAuthToken(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMapper.class).deleteMemberAuthToken(params);
	}
	
	public HashMap<String,Object> getMemberAuthToken(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMapper.class).getMemberAuthToken(params);
	}
	
	/**
	 * Select qr memberPhone Info.
	 *
	 * @param params the params
	 * @return the int
	 */
	public int selectqrMemberPhone(HashMap<String,Object> params) {
		return sqlSession.getMapper(MobileMapper.class).selectqrMemberPhone(params);
	}
	
	/**
	 * Select auto login user
	 *
	 * @param params the params
	 * @return HashMap
	 */
	public HashMap<String,Object> loginAppAct(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMapper.class).loginAppAct(params);
	}
	
	/**
	 * Select AffiliateInfo.
	 *
	 * @param params the params
	 * @return HashMap
	 */
	public HashMap<String,Object> selectAffiliateInfo(HashMap<String,Object> params) {
		return sqlSession.getMapper(MobileMapper.class).selectAffiliateInfo(params);
	}
	
	/**
	 * Select member phone overlap myinfo modify count.
	 *
	 * @param params the params
	 * @return the int
	 */
	public int selectMemberPhoneOverlapModfiyCount(HashMap<String,Object> params) {
		return sqlSession.getMapper(MobileMapper.class).selectMemberPhoneOverlapModfiyCount(params);
	}
	
	/**
	 * Select MembershipRequest PaymentStatus.
	 *
	 * @param params the params
	 * @return the int
	 */
	public HashMap<String,Object> selectMembershipRequestPaymentStatus(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMapper.class).selectMembershipRequestPaymentStatus(params);
	}
	
	/**
	 * Update user paymentStatus.
	 *
	 * @param params the params
	 * @return the int
	 */
	public int updatePaymentStatusRequestCon(HashMap<String,Object> params) {
		return sqlSession.getMapper(MobileMapper.class).updatePaymentStatusRequestCon(params);
	}
	
	/**
	 * Select member Type info.
	 *
	 * @param params the params
	 * @return the HashMap
	 */
	public HashMap<String,Object> selectmemberTypeInfo(HashMap<String,Object> params){
		return sqlSession.getMapper(MobileMapper.class).selectmemberTypeInfo(params);
	}
	
	/**
	 * insert QnA.
	 *
	 * @param params the params
	 * @return int
	 */
	public int insertQnaWAct(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMapper.class).insertQnaWAct(params);
	}
	
	/**
	 * insert 제휴상담.
	 *
	 * @param params the params
	 * @return int
	 */
	public int insertQnaNodeWAct(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMapper.class).insertQnaNodeWAct(params);
	}

	public ArrayList<HashMap<String,Object>> selectCountries(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMapper.class).selectCountries(params);
	}

	public ArrayList<HashMap<String,Object>> selectLanguages(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMapper.class).selectLanguages(params);
	}
	
	public ArrayList<HashMap<String,Object>> selectBankAccounts(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMapper.class).selectBankAccounts(params);
	}
	public int deleteMemberBankAccount(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMapper.class).deleteMemberBankAccount(params);
	}

	public int insertMemberBankAccount(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMapper.class).insertMemberBankAccount(params);
	}
	
	public int insertPointWithdrawal(HashMap<String, Object> params) {
		return sqlSession.getMapper(MobileMapper.class).insertPointWithdrawal(params);
	}
	
	public int updatePointwithdrawal(HashMap<String, Object> params) {
		return sqlSession.getMapper(MobileMapper.class).updatePointwithdrawal(params);
	}
	public int updateRedPoint(HashMap<String, Object> params) {
		return sqlSession.getMapper(MobileMapper.class).updateRedPoint(params);
	}

	public int updateMemberBankAccount(HashMap<String, Object> params) {
		return sqlSession.getMapper(MobileMapper.class).updateMemberBankAccount(params);
	}
	
	public ArrayList<HashMap<String,Object>> selectPointwithdrawals(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMapper.class).selectPointwithdrawals(params);
	}

	public int selectWithdrawalSumPerDay(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMapper.class).selectWithdrawalSumPerDay(params);
	}
	public HashMap<String,Object> selectGiftCardIssue(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMapper.class).selectGiftCardIssue(params);
	}
	
	public HashMap<String,Object> selectMemberConfig(HashMap<String, Object> params){
		return sqlSession.getMapper(MobileMapper.class).selectMemberConfig(params);
	}
	
	public int insertMemberConfigl(HashMap<String, Object> params) {
		return sqlSession.getMapper(MobileMapper.class).insertMemberConfigl(params);
	}

	public int updateMemberConfig(HashMap<String, Object> dbparams) {
		return sqlSession.getMapper(MobileMapper.class).updateMemberConfig(dbparams);
		
	}
	
	public ArrayList<HashMap<String, Object>>  selectAffiliateTid(HashMap<String, Object> dbparams){
		return sqlSession.getMapper(MobileMapper.class).selectAffiliateTid(dbparams);
	}

	public HashMap<String, Object> selectAffiliateCommand(HashMap<String, Object> dbparams) {
		return sqlSession.getMapper(MobileMapper.class).selectAffiliateCommand(dbparams);
	}

	public ArrayList<HashMap<String, Object>> selectAffiliateCategories(HashMap<String, Object> dbparams) {
		return sqlSession.getMapper(MobileMapper.class).selectAffiliateCategories(dbparams);
	}

	public ArrayList<HashMap<String, Object>> findAffiliatesByCate(Map<String, Object> paramMap) {
		return sqlSession.getMapper(MobileMapper.class).findAffiliatesByCate(paramMap);
	}
}
