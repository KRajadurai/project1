package com.logan.security.payload;

import java.util.Date;

import org.springframework.http.HttpStatus;

public class ErrorDetails {
	private Date timestamp;
	private int status;
	private String message;
	private String error;
	private String path;
	
	public ErrorDetails() {
		this.timestamp = new Date();
	}
	
	public ErrorDetails(HttpStatus staus, String message, String path) {
		this();
		this.error =staus.getReasonPhrase();
		this.status =staus.value();
		this.message = message;
		this.path = path;
	}

	public Date getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(Date timestamp) {
		this.timestamp = timestamp;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getError() {
		return error;
	}
	public void setError(String error) {
		this.error = error;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}

}
