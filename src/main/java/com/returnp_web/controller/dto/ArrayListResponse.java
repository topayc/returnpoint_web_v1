package com.returnp_web.controller.dto;

import java.util.ArrayList;

public class ArrayListResponse<T> extends ReturnpBaseResponse{
	public int total;
	public ArrayList<T> rows;
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public ArrayList<T> getRows() {
		return rows;
	}
	public void setRows(ArrayList<T> rows) {
		this.rows = rows;
	}


	
}
