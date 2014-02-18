package kr.co.keangnamit.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JdbaUtil {
	public static void close(ResultSet rs){
		if(rs != null){
			try{
				rs.close();
			}catch(SQLException ex){ex.printStackTrace();}
		}
	}
	public static void close(Statement stmt){
		if(stmt != null){
			try{
				stmt.close();
			}catch(SQLException ex){ex.printStackTrace();}
		}
	}
	public static void close(Connection conn){
		if(conn != null){
			try{
				conn.close();
			}catch(SQLException ex){ex.printStackTrace();}
		}
	}
	public static void close(Statement stmt, ResultSet rs){
		if(rs != null || stmt != null){
			try{
				stmt.close();
				rs.close();
			}catch(SQLException ex){ex.printStackTrace();}
		}
	}
	public static void close(Connection conn, Statement stmt, ResultSet rs){
		if(conn != null ||rs != null || stmt != null){
			try{
				conn.close();
				stmt.close();
				rs.close();
			}catch(SQLException ex){ex.printStackTrace();}
		}
	}
	public static void close(Connection conn, PreparedStatement ps, ResultSet rs){
		if(conn != null ||rs != null || ps != null){
			try{
				conn.close();
				ps.close();
				rs.close();
			}catch(SQLException ex){ex.printStackTrace();}
		}
	}	
	
}
