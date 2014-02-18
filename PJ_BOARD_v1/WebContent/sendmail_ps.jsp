<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="kr.co.keangnamit.mail.*"%>
<%

try {
	MailTest ma = new MailTest();
    ma.sendEmail("onesum@kne.co.kr", "lyy80@kne.co.kr", "", "씨발", "씨발");
    

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
function goURL(url){
	location.href = url;
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div class = "list_sub01"> <button onfocus="this.blur()"	class="button" onclick="goURL('index.jsp')">로그인</button></div>

</body>
</html>
<%
   }
   catch(Exception e) {
    System.out.println("메일 전송에 실패하였습니다.		");
    System.out.println("실패 이유 : " + e.getMessage());
   }
   %>