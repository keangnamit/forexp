<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="kr.co.keangnamit.board.service.*"%>
<%@ page import="kr.co.keangnamit.board.dao.*"%>
<%@ page import="kr.co.keangnamit.board.model.*"%>
<%@ page import="kr.co.keangnamit.jdbc.*"%>
<%
	String id;
	String pw;
	String ipAddress;
	int reqPageNum = 0;
	int reqNum = 0;

	request.setCharacterEncoding("UTF-8");
	
	String num = request.getParameter("num");
	String pageNum = request.getParameter("pageNum");
	String title = request.getParameter("title");
	String contents = request.getParameter("contents");
	String saveFile = request.getParameter("saveFile");
	String realFile = request.getParameter("realFile");

	ipAddress = request.getRemoteAddr();

	if (session.getAttribute("id") == null
			|| session.getAttribute("id") == "") {
		id = "";
		pw = "";
		response.sendRedirect("index.jsp");
	} else {
		id = (String) session.getAttribute("id");

		if (pageNum != null && pageNum.length() > 0) {
			reqPageNum = Integer.parseInt(pageNum);
		}
		num = request.getParameter("num");
		if (num != null && num.length() > 0) {
			reqNum = Integer.parseInt(num);
		}
		BoardDo board = new BoardDo();
		BoardDao boardDao = new BoardDao();

		board.setSeqNo(reqNum);
		board.setIpAddress(ipAddress);
		board.setTitle(title);
		board.setContents(contents);
		board.setRealFile(realFile);
		board.setSaveFile(saveFile);
		board.setUserId(id);

		Connection conn = null;
		try {
			conn = SimpleConnection.getConnection();
			
			int i = boardDao.BoardEdit(conn, board);
			
			if (i > 0){
				response.sendRedirect("./list.jsp?pageNum="+pageNum);
			}
			else{
				%>
				<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
				<html>
				<head>
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
				<title>Insert title here</title>
				</head>
				<body>
					error!<%=title %>
				</body>
				</html>	
				<%			
			}
			
		} finally {
			JdbcUtil.close(conn);
		}
	}
%>

