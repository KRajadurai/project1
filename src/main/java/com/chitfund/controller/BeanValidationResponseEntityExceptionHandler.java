package com.chitfund.controller;

import java.util.Date;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import com.chitfund.security.payload.ErrorDetails;

@ControllerAdvice
@RestController
public class BeanValidationResponseEntityExceptionHandler extends ResponseEntityExceptionHandler {

	  @Override
	  protected ResponseEntity<Object> handleMethodArgumentNotValid(MethodArgumentNotValidException ex,
	      HttpHeaders headers, HttpStatus status, WebRequest request) {
	    ErrorDetails errorDetails = new ErrorDetails(HttpStatus.BAD_REQUEST, ex.getBindingResult().toString(),
	        null);
	    return new ResponseEntity<>(errorDetails, headers, HttpStatus.BAD_REQUEST);
	  } 
}
