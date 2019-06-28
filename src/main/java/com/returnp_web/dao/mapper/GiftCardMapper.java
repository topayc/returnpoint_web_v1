package com.returnp_web.dao.mapper;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * The Interface GoodsReviewMapper.
 */
public interface GiftCardMapper {
	ArrayList<HashMap<String, Object>> selectMyGiftCards(HashMap<String, Object> paramMap);
	ArrayList<HashMap<String, Object>> selectGiftCardIssues(HashMap<String, Object> paramMap);
}
