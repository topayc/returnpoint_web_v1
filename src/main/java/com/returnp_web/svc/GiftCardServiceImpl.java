package com.returnp_web.svc;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.returnp_web.dao.GiftCardDao;
import com.returnp_web.utils.QRManager;
import com.returnp_web.utils.RPMap;
import com.returnp_web.utils.ResponseUtil;
import com.returnp_web.utils.SessionManager;

@Service
public class GiftCardServiceImpl implements GiftCardService {
	@Autowired private MessageSource messageSource;
	@Autowired private  GiftCardDao giftCardDao;
	@Override
	public boolean getMyGiftCards(RPMap paramMap, RPMap rpMap, HttpServletRequest request, HttpServletResponse response) {
		try {
			HashMap<String, Object> dbparams = new HashMap<String, Object>();
			SessionManager sm = new SessionManager(request, response);
			dbparams.put("memberNo", sm.getMemberNo());
			
			switch(paramMap.getStr("giftCardStatus")) {
			case "1": //결제 완료
				dbparams.put("payableStatus", "N");
				break;
			case "2": //적립 완료
				dbparams.put("accableStatus", "N");
				break;
			case "3": // 결제 가능
				dbparams.put("payableStatus", "Y");
				break;
			case "4": // 적립 가능
				dbparams.put("accableStatus", "Y");
				break;
			}
			ArrayList<HashMap<String, Object>> myGiftCards = this.giftCardDao.selectMyGiftCards(dbparams);
			rpMap.put("myGiftCards", myGiftCards);
			rpMap.put("giftCardStatus", paramMap.getStr("giftCardStatus"));
			return true;
		}catch(Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			throw e;
		}
	}
	@Override
	public boolean getMyGiftCardDetail(RPMap paramMap, RPMap rpMap, HttpServletRequest request, HttpServletResponse response) {
		try {
			HashMap<String, Object> dbparams = new HashMap<String, Object>();
			SessionManager sm = new SessionManager(request, response);
			dbparams.put("memberNo", sm.getMemberNo());
			dbparams.put("myGiftCardNo", paramMap.getStr("myGiftCardNo"));
			
			ArrayList<HashMap<String, Object>> myGiftCards = this.giftCardDao.selectMyGiftCards(dbparams);
			SimpleDateFormat df = new SimpleDateFormat("yyyy년 M월 dd일");
			myGiftCards.get(0).put("createTime", df.format(myGiftCards.get(0).get("createTime")));
			myGiftCards.get(0).put("expirationTime", df.format(myGiftCards.get(0).get("expirationTime")));
			rpMap.put("giftCard", myGiftCards.get(0));
			return true;
		}catch(Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			throw e;
		}
	}

	@Override
	public byte[] createQrCode(RPMap paramMap, HttpServletRequest request, HttpServletResponse response) {
		try {
			HashMap<String, Object> dbparams = new HashMap<String, Object>();
			SessionManager sm = new SessionManager(request, response);
			dbparams.put("giftCardIssueNo", paramMap.getStr("giftCardIssueNo"));

			ArrayList<HashMap<String, Object>> giftCardIssues = this.giftCardDao.selectGiftCardIssues(dbparams);
			if (giftCardIssues.size() != 1) {
				new Exception();
			}
			HashMap<String, Object> issues = giftCardIssues.get(0);
			String qrData = paramMap.getStr("type").equals("A") ? (String) issues.get("accQrData")
					: (String) issues.get("payQrData");
			byte[] qrCodeBytes = QRManager.genQRCode(qrData);
			return qrCodeBytes;
		} catch (Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return null;
		}
	}
	@Override
	public boolean viewFullQrCode(RPMap paramMap, RPMap rmap, HttpServletRequest request, HttpServletResponse response) {
		try {
			HashMap<String, Object> dbparams = new HashMap<String, Object>();
			SessionManager sm = new SessionManager(request, response);
			dbparams.put("memberNo", sm.getMemberNo());
			dbparams.put("giftCardIssueNo", paramMap.getStr("giftCardIssueNo"));
			
			ArrayList<HashMap<String, Object>> myGiftCards = this.giftCardDao.selectMyGiftCards(dbparams);
			rmap.put("giftCard", myGiftCards.get(0));
			rmap.put("type", paramMap.getStr("type"));
			rmap.put("giftCardIssueNo", paramMap.getStr("giftCardIssueNo"));
		/*	if (paramMap.getStr("type").equals("A")) {
				
			}
			
			if (paramMap.getStr("type").equals("A")) {
				
			}*/
			return true;
		}catch(Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			throw e;
		}
	}
}
	




