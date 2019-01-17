/**
 * 
 */
package com.returnp_web.svc;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

/**
 * 페이지를 추적하기 위한 클래스
 */
@Service
@Scope("request")
public class CommonTrackerServiceImpl implements CommonTrackerService {
	
	/** The Constant logger. */
	private static final Logger logger = LoggerFactory.getLogger(CommonTrackerServiceImpl.class);
	
	/** The m_ctime. */
	private long m_ctime = 0;
	
	/** The m_admin_no. */
	private int m_admin_no = 0;
	
	/** The m_member_no. */
	private int m_member_no = 0;
	
	/** The m_page. */
	private String m_page = "-";
	
	/** The m_ip. */
	private String m_ip = "-";
	
	/** The m_history. */
	private List<Entry> m_history = new ArrayList<Entry>();
	
	/**
	 * The Class Entry.
	 */
	class Entry {
		
		/** The m_ctime. */
		public long m_ctime = 0;
		
		/** The m_key. */
		public String m_key = "";
		
		/** The m_value. */
		public String m_value = "";		
		
		/**
		 * Instantiates a new entry.
		 *
		 * @param k the k
		 * @param v the v
		 */
		public Entry(String k, String v) {
			m_ctime = System.currentTimeMillis();
			m_key = k;
			m_value = v;
		}
	}
	
	/**
	 * Instantiates a new common tracker service impl.
	 *
	 * @throws Exception the exception
	 */
	public CommonTrackerServiceImpl() throws Exception {
		m_ctime = System.currentTimeMillis();
	}

	@Override
	public void add(String k, String v) throws Exception {
		Entry entry = new Entry(k, v);
		m_history.add(entry);
	}

	@Override
	public String toStr() throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(String.format("%d %d %s %s", m_admin_no, m_member_no, m_ip, m_page));

		long start = this.m_ctime;

		for (Entry entry : m_history) {
			long diff = entry.m_ctime - start;
			sb.append(String.format(" [%d:%s:%s]", diff, entry.m_key, entry.m_value));
			start = entry.m_ctime;
		}

		return sb.toString();
	}

}
