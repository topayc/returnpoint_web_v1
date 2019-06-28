package com.returnp_web.controller.dto;

/**
 * @author user01
 *
 * @param <T>
 */
public class ObjectResponse <T> extends ReturnpBaseResponse {
	T data;

	public T getData() {
		return data;
	}

	public void setData(T data) {
		this.data = data;
	}
	
}
