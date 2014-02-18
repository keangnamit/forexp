<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.mail.*"%>
<%@ page import="kr.co.keangnamit.mail.*"%>

<%
	String id, pw;
	String email;
	String name;
	int ps;

	/*
	if (session.getAttribute("id") == null
			|| session.getAttribute("id") == "") {
		id = "";
		pw = "";
	} */

	id = request.getParameter("id");

	//DB연결 쿼리
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@192.168.6.81:1521:ora9";

	//out.print(email);
	out.print(id);

	try {
		Class.forName(driver);
		conn = DriverManager.getConnection(url, "FOODSALE", "NJOY123");

		pstmt = conn
				.prepareStatement("select PASSWORD, EMAIL from MEMBERS WHERE USERID = ?");
		pstmt.setString(1, id);

		rs = pstmt.executeQuery();
		//rs.next();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	/*
	 function f_send(par0,par1) {
	 if (par0 == 0) {
	 var form = document.ajoin;
	 form.action = "./sendmail_ps.jsp";
	 form.submit();
	 } 
	 } */

	function goURL(url) {
		location.href = url
	}
</script>

<title>pw찾기결과</title>
</head>
<body>
	<%
		if (rs.next() == false) {
	%>
	해당 id로 가입자가 없습니다.
	<%
		} else {
	%>
	pw를 <%=rs.getString(2)%>로 전송했습니다.
	

	<%
		String tomail;
		String contents;
		String title;

		tomail = rs.getString(2);
		title = "요청하신 내용 입니다.";
		contents = rs.getString(1);

		
		MailTest ma = new MailTest();
		ma.sendEmail("onesum@kne.co.kr", tomail, "", title,	contents);
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