package com.returnp_web.svc;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;

import com.returnp_web.utils.RPMap;

@Transactional
public interface GiftCardService {
	public boolean getMyGiftCards(RPMap paramMap, RPMap rpMap, HttpServletRequest request, HttpServletResponse response);
	public boolean getMyGiftCardDetail(RPMap paramMap, RPMap rpMap, HttpServletRequest request, HttpServletResponse response);
	public byte[] createQrCode(RPMap rPap, HttpServletRequest request, HttpServletResponse response);
	public boolean viewFullQrCode(RPMap rPap, RPMap rmap, HttpServletRequest request, HttpServletResponse response);
}
