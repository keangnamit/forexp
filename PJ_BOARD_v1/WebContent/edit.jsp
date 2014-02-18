<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="kr.co.keangnamit.board.dao.*"%>
<%@ page import="kr.co.keangnamit.board.model.*"%>
<%@ page import="kr.co.keangnamit.jdbc.*"%>
<%
	String id;
	String pw;
	String ipAddress;
	int reqPageNum = 0;
	int reqNum = 0;

	String num = request.getParameter("num");
	String pageNum = request.getParameter("pageNum");
	Connection conn = null;
	
	ipAddress = request.getRemoteAddr();

	if (session.getAttribute("id") == null
			|| session.getAttribute("id") == "") {
		id = "";
		pw = "";
		response.sendRedirect("index.jsp");
	} else {
		id = (String) session.getAttribute("id");
		

		if (num != null && num.length() > 0) {
			reqNum = Integer.parseInt(num);
		}
		
		try{
		conn = SimpleConnection.getConnection();
		BoardDao boardDao = new BoardDao();
		BoardDo board = boardDao.boardView(conn, reqNum);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>수정 페이지</title>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="./css/style.css" />
<script>
	function f_edit(par0){
		var form = document.edit;
		
		if (par0 == "s"){
		form.action = "./edit_ps.jsp";
		form.submit;
		} else if (par0 == "d"){
			form.action = "BoardDeleteServlet";
			form.submit;
		}
	}
	
	function goUrl(url){
		location.href = url;
	}


</script>
</head>
<body>
<form name="edit" method="post" action="BoardDeleteServlet">
<table border="0" cellpadding="0" cellspacing="0" class="tt" width="600px">
	<tr><td>
	<input type="hidden" name="pageNum" value="<%=pageNum%>" />
	<input type="hidden" name="num" value="<%=num%>" />
	<input type="hidden" name="ipAddress" value="<%=ipAddress%>" />	
	<input type="hidden" name="pageNum" value="<%=pageNum %>" />
	<input type="hidden" name="userId" value="<%=board.getUserId()%>" />
	<input type="hidden" name="saveFile" value="<%=board.getSaveFile()%>" />
	<input type="hidden" name="realFile" value="<%=board.getRealFile()%>" />
	</td>
	</tr>
	<tr>
		<td class="list_sub01">제목</td>
		<td class="list_sub02"><input type="text" name="title" value="<%=board.getTitle()%>"></td>
	</tr>
	<tr>
		<td class="list_sub01">내용</td>
		<td class="list_sub02"><textarea name="contents" rows="8" ><%=board.getContents()%></textarea></td>
	</tr>
	<tr>
		<td colspan="2" class="list_sub02">
		<button onfocus="this.blur()" class= "button" onclick="goUrl('list.jsp?pageNum=<%=pageNum%>')">리스트</button>
		<button onfocus="this.blur()" class= "button" onclick="f_edit('s')">저장</button>
		<button onfocus="this.blur()" class= "button" onclick="f_edit('d')">삭제</button>
		<input class="button" type="submit"  value="삭제!" />
		</td>
	</tr>
</table>
</form>
</body>
</html>
<%
		} finally{
			JdbcUtil.close(conn);
		}
	}
%>
