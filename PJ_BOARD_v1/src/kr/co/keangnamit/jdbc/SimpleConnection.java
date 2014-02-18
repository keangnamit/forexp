package kr.co.keangnamit.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;

public class SimpleConnection {
	public static Connection getConnection() {
		Connection conn = null;
		try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.6.81:1521:ora9","FOODSALE","NJOY123");
		return conn;
		}catch(Exception e){
			e.printStackTrace();
			return conn;
		}
		
	}
}
