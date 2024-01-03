package com.spring.app.test.model;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class TestDAO_imple implements TestDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession;
	
}
