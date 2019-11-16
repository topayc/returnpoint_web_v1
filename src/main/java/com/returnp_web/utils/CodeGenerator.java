package com.returnp_web.utils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Locale;
import java.util.SplittableRandom;

import org.json.simple.JSONObject;
import org.springframework.transaction.interceptor.TransactionAspectSupport;



public class CodeGenerator {
	public static String createTempKey(int length) {
		char[] PIN_CHARACTERS  = "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ".toCharArray();
		Collections.shuffle(Arrays.asList(PIN_CHARACTERS));
		char[] pinCharArrs = new char[length];
		SplittableRandom splittableRandom = null;

		for (int i = 0 ; i < length; i++) {
			splittableRandom = new SplittableRandom();
			for (int k = 0; k < pinCharArrs.length; k++) {
				int elementIndex = splittableRandom.nextInt(PIN_CHARACTERS.length);
				pinCharArrs[k] = PIN_CHARACTERS[elementIndex];
			}
		}
		return String.valueOf(pinCharArrs);
	}
}