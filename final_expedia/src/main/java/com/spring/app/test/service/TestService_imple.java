package com.spring.app.test.service;

import org.springframework.beans.factory.annotation.Autowired;

import com.spring.app.test.model.TestDAO;

public class TestService_imple implements TestService {
	
	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private TestDAO dao;
	
}
