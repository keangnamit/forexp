package kr.co.keangnamit.sql;

import java.io.IOException;
import java.io.Reader;

import javax.annotation.Resource;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MyBatis {
	private final static String RESOURCE = "kr/co/keangnamit/config/mybatis-config.xml";
	private static SqlSessionFactory sqlMapper = null;
	
	public static SqlSessionFactory getSqlSessionFactory(){
		if(sqlMapper == null){
			Reader reader ;
			try{
				reader = Resources.getResourceAsReader(RESOURCE);
				sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			}catch(IOException e){
				e.printStackTrace();
			}
		}
		return sqlMapper;
				
	}
}
