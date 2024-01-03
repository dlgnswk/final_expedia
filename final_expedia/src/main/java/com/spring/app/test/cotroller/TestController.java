package com.spring.app.test.cotroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.spring.app.test.service.TestService;

@Controller
public class TestController {
	
	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private TestService service;
	
}
