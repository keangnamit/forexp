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

	email = request.getParameter("email");
	name = request.getParameter("name");
	
	//DB연결 쿼리
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@192.168.6.81:1521:ora9";

	//out.print(email);
	//out.print(pw);

	try {
		Class.forName(driver);
		conn = DriverManager.getConnection(url, "FOODSALE", "NJOY123");

		pstmt = conn.prepareStatement("select USERID from MEMBERS WHERE EMAIL = ?");
		pstmt.setString(1, email);

		rs = pstmt.executeQuery();
		//rs.next();
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
	
	function goURL(url){
		location.href=url
	}
</script>

<title></title>
</head>
<body>
	<%
		if (rs.next() == false) {
	%>
	해당 이멜일로 가입된 ID는 없습니다.
	<%
		} else {
	%>
	ID는 <%=rs.getString(1)%>
	
	<%
		}
	%>
	<br>
	
	<button class="button" onclick="goURL('index.jsp')">로그인</button>
	<button class="button" onclick="goURL('findidpw.jsp')">다시찾기</button>

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