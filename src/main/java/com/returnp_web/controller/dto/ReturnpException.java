package com.returnp_web.controller.dto;

public class ReturnpException extends RuntimeException {
	private ReturnpBaseResponse data;
	public ReturnpException(ReturnpBaseResponse res) {
		this.data = res;
	} 
	public ReturnpBaseResponse getBaseResponse() {
		return data;
	}

	public void setBaseResponse(ReturnpBaseResponse data) {
		this.data = data;
	}
}
