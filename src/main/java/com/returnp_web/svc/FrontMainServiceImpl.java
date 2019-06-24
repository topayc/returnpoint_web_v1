package com.returnp_web.svc;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.ui.ModelMap;

import com.returnp_web.dao.FrontMainDao;
import com.returnp_web.utils.BASE64Util;
import com.returnp_web.utils.Const;
import com.returnp_web.utils.Converter;
import com.returnp_web.utils.QRManager;
import com.returnp_web.utils.RPMap;
import com.returnp_web.utils.SessionManager;
import com.returnp_web.utils.Util;
import net.sf.json.JSONObject;

/**
 * The Class FrontMainServiceImpl.
 */
@PropertySource("classpath:/config.properties")
@Service
public class FrontMainServiceImpl implements FrontMainService {

	private static final Logger logger = LoggerFactory.getLogger(FrontMainServiceImpl.class);

	/** The front main dao. */
	@Autowired
	private FrontMainDao frontMainDao;

	@Autowired
	private MessageSource messageSource;

	@Autowired
	Environment environment;

	//footer 정보
	@Override
	public HashMap<String, Object> getFooter(RPMap rmap) throws Exception {
		
		RPMap dbparams = new RPMap();
		HashMap<String, Object> map = new HashMap<String, Object>();
		String langLocale = rmap.getStr("langLocale");
		dbparams.put("langLocale", langLocale);
		HashMap<String, Object> company = frontMainDao.selectCompanyInfo(dbparams);
		map.put("company", company);
		
		return map;
	}

	//긴급 서버 점검 팝업
	@Override
	public HashMap<String, Object> getServerManageStatus() throws Exception {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		RPMap dbparams = new RPMap();
		HashMap<String, Object> servermanagestatus = frontMainDao.selectServerManageStatusInfo(dbparams);
		map.put("status", servermanagestatus);
		return map;
	}
	
	//공지사항 리스트 총 갯수
	public int selectWebNoticeListTotalCount(HashMap<String, Object> params) throws Exception {
		return frontMainDao.selectWebNoticeListTotalCount(params);
	}
	
	//공지사항 리스트
	public ArrayList<HashMap<String, Object>> selectWebNoticeList(HashMap<String, Object> params) throws Exception {
		return frontMainDao.selectWebNoticeList(params);
	}
	
	//공지사항 상세
	public HashMap<String, Object> selectWebNoticeContent(HashMap<String, Object> params) throws Exception{
		return frontMainDao.selectWebNoticeContent(params);
	}

	//FAQ 리스트 총 갯수
	public int selectWebFAQListTotalCount(HashMap<String, Object> params) throws Exception {
		return frontMainDao.selectWebFAQListTotalCount(params);
	}

	//FAQ 리스트
	public ArrayList<HashMap<String, Object>> selectWebFAQList(HashMap<String, Object> params) throws Exception {
		return frontMainDao.selectWebFAQList(params);
	}

	//FAQ 상세
	public HashMap<String, Object> selectWebFAQContent(HashMap<String, Object> params) throws Exception {
		return frontMainDao.selectWebFAQContent(params);
	}
	
	//가맹점찾기 리스트 총 갯수
	public int selectWebFranchiseeInfoListTotalCount(HashMap<String, Object> params) throws Exception {
		return frontMainDao.selectWebFranchiseeInfoListTotalCount(params);
	}

	//가맹점찾기 리스트
	public ArrayList<HashMap<String, Object>> selectWebFranchiseeInfoSearchList(HashMap<String, Object> params) throws Exception {
		return frontMainDao.selectWebFranchiseeInfoSearchList(params);
	}
	
	//CITY 리스트
	public ArrayList<HashMap<String, Object>> selectWebCityList(HashMap<String, Object> params) throws Exception {
		return frontMainDao.selectWebCityList(params);
	}
	
	//시군구 AJAX 리스트
	public ArrayList<HashMap<String, Object>> selectWebCountryNameList(HashMap<String, Object> params) throws Exception {
		return frontMainDao.selectWebCountryNameList(params);
	}
	
	//게시글 카운팅 +1
	public int updateMainBbsViewCount(HashMap<String, Object> params) throws Exception {
		return frontMainDao.updateMainBbsViewCount(params);
	}
	
	//제휴문의 글쓰기
	public int insertMainBbsPartnerAskSave(HashMap<String, Object> params) throws Exception {
		return frontMainDao.insertMainBbsPartnerAskSave(params);
	}
}