<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	String id, pw;
	String email;
	String name;
	int ps;

	if (session.getAttribute("id") == null
			|| session.getAttribute("id") == "") {
		id = "";
		pw = "";
	}
	request.setCharacterEncoding("UTF-8"); // 페이지해도 설정해야할듯
	id = request.getParameter("id");
	
	//DB연결 쿼리
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@192.168.6.81:1521:ora9";

	out.print(id);
	//out.print(pw);

	try {
		Class.forName(driver);
		conn = DriverManager.getConnection(url, "FOODSALE", "NJOY123");

		pstmt = conn.prepareStatement("select userid from MEMBERS WHERE USERID = ?");
		pstmt.setString(1, id);

		rs = pstmt.executeQuery();
		//rs.next();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	function goURL(url){
		location.href=url
	}

	function f_close(par0){
		//window.opener.f_getdata(par0); //부모쪽에서 
		window.opener.document.getElementsByName("id")[0].value = par0; //직접
		
		window.close();

	}	
	
</script>

<title>ID중복확인</title>
</head>
<body>
	<%
		if (rs.next() == false) {
	%>
	해당 id로 가입자가 없습니다.
	<%
		} else {
	%>
	id는 <%=rs.getString(1)%>는 사용가능합니다.
	<%
		}
	%>
	<br>
	
	<button class="button" onclick="f_close('<%=id%>')">사용</button>
	<button class="button" onclick="f_close('')">다른ID</button>
	

</body>

</html>

<%
	} catch (Exception e) {
		//out.print("fail");
		//response.sendRedirect("index.jsp");
		e.printStackTrace();
	} finally {
		if (rs != null)
			rs.close();
		if (pstmt != null)
			pstmt.close();
		if (conn != null)
			conn.close();

	}
%>