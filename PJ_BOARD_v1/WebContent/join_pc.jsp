<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	String id, pw, pw_check, email, name;
	int ps;

	if (session.getAttribute("id") == null
			|| session.getAttribute("id") == "") {
		id = "";
		pw = "";
	}

	request.setCharacterEncoding("UTF-8");
	
	id = request.getParameter("id");
	pw = request.getParameter("password");
	pw_check = request.getParameter("password_check");
	email = request.getParameter("email");
	name = request.getParameter("name");

	//DB연결 쿼리
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@192.168.6.81:1521:ora9";

	try {
		Class.forName(driver);
		conn = DriverManager.getConnection(url, "FOODSALE", "NJOY123");

		pstmt = conn
				.prepareStatement("INSERT INTO MEMBERS (USERID, PASSWORD, NAME, EMAIL, INSERTDT) VALUES (?,?,?,?,sysdate)");
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		pstmt.setString(3, name);
		pstmt.setString(4, email);

		ps = pstmt.executeUpdate();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	function f_send(par0) {
		if (par0 == 0) {
			var form = document.ajoin;
			alert("가입실패했습니다~~ ㅜㅜ.");
			form.action = "./join.jsp";
			form.submit();
		} else {
			var form = document.ajoin;
			alert("가입완료되었습니다.");
			form.action = "./index.jsp";
			form.submit();
		}
	}
	function gourl(url){
		location.href = url;
	}
</script>

<title></title>
</head>

<body>

	<%
		if (ps == 0) {
	%>
	alert("가입실패되었습니다.");
	<a href="join.jsp">가입페이지</a>

	<%
	//	response.sendRedirect("./join.jsp");
			} else {
	%>
	alert("가입했습니다~~");
	<br>
	<a href="index.jsp">로그인</a>
	
	<%
	//	response.sendRedirect("./index.jsp");
			}
	%>


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