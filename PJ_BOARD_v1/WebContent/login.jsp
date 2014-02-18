<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%

	String id;
	String pw;

	if (session.getAttribute("id") == null || session.getAttribute("id") == "") {
		id = "";
		pw = "";
	//	response.sendRedirect("index.jsp");
	}
	
	id = request.getParameter("id");
	pw = request.getParameter("password");
	
	//DB연결 쿼리
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@192.168.6.81:1521:ora9";
	
	try{
		Class.forName(driver);
		conn = DriverManager.getConnection(url,"FOODSALE","NJOY123");
		
		pstmt = conn.prepareStatement("select USERID, PASSWORD from MEMBERS WHERE USERID = ?");
		pstmt.setString(1,id);
							
		rs = pstmt.executeQuery();
		rs.next();
		
		String userId = rs.getString("USERID");
		String password = rs.getString("PASSWORD"); 
		

		if (id.equals(userId) && pw.equals(password)) {
			session.setAttribute("id", userId);//세션 id 저장
			response.sendRedirect("./list.jsp");
		} else if ((id.equals(userId) == false ) || (id.equals(password) == false )) {
			response.sendRedirect("./index.jsp");
		}
		
	
	} catch(Exception e){
		//out.print("fail");
		response.sendRedirect("index.jsp");
		e.printStackTrace();
	}finally{
		if(rs != null) rs.close();
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();

	}	
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>