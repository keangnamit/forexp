<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="kr.co.keangnamit.board.service.*"%>
<%@ page import="kr.co.keangnamit.board.dao.*"%>
<%@ page import="kr.co.keangnamit.board.model.*"%>
<%
	String id;
	String pw;
	int reqPageNum;
	List<BoardDo> boardList;
	String reqPageNumber;
		
	request.setCharacterEncoding("UTF-8");
	
	String type = request.getParameter("srh_code");
	String words = request.getParameter("srh_name");
	
	// 파라미터 초기화
	if (words == null) {
		type = "";
		words = "";
	}
	if (words != null){
		words = new String(words.getBytes("ISO-8859-1"), "UTF-8");
	}

	int beginPage = 0, endPage = 0;
	
	if (session.getAttribute("id") == null
			|| session.getAttribute("id") == "") {
		id = "";
		pw = "";
		response.sendRedirect("index.jsp");
	} else {
		id = (String) session.getAttribute("id");
		
		reqPageNum = 1;
		reqPageNumber = request.getParameter("pageNum");
		
		
		if (reqPageNumber != null && reqPageNumber.length() > 0) {
			reqPageNum = Integer.parseInt(reqPageNumber);
		}

		ListBoardService listBoardService = new ListBoardService();
		
		BoardListModel boardListModel;
		if (type == "" || type.isEmpty()) { 
			boardListModel = listBoardService.getBoardList(reqPageNum);
		}else{
			boardListModel = listBoardService.getBoardList(reqPageNum, type, words); //검색
		}

		List<BoardDo> boardList1 = boardListModel.getArticleList();

		int totalBoardPage = boardListModel.getTotalPageCount();

		if (totalBoardPage > 0) {
			beginPage = (totalBoardPage - 1) / 10 * 10 + 1;
			endPage = beginPage + 9;
			if (endPage > totalBoardPage) {
				endPage = totalBoardPage;
			}
		}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>리스트</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="./css/style.css" />
<script>

	function goUrl(url){
		location.href = url; 
	}
	// 검색 폼 체크
	function searchCheck() {
		var form = document.searchForm;
		if (form.srh_name.value == '') {
			alert('검색어를 입력하세요.');
			form.srh_name.focus();
			return false;
		}
		return true;
	}
</script>
</head>
<body>

	<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td><%=id%> 님 환영합니다</td>
			<td>
				<button onfocus="this.blur()" class="button" onclick="goUrl('write.jsp')">작성하기</button>
				<button onfocus="this.blur()" class="button" onclick="goUrl('logout.jsp')">로그아웃</button></td>
		</tr>
		<tr>
			<td>총페이지수:<%=totalBoardPage%> 요청페이지:<%=reqPageNum%> 요청:<%=reqPageNumber%></td>
			
			<%if (boardListModel.isHasArticle() == false) {  %>
			<td>게시물없음</td>
			<% } else {%>
			<td>게시물 있음</td>
			<%} %>
			<td>시작페이지<%=beginPage%> 끝페이지<%=endPage%></td>
		</tr>
	</table>

	<br>
   <form name="searchForm" action="list.jsp" method="get" onsubmit="return searchCheck();" >
	<table border="0" cellpadding="0" cellspacing="0" class="tt"
		width="600px">
		<tr>
			<td class="list_sub01">검색조건</td>
			<td class="list_sub02">
				<select name="srh_code">
						<option value="A">제목</option>
						<option value="B">작성자</option>
						<option value="C">내용</option>
						<option value="D">모두</option>
				</select>
			</td>
			<td class="list_sub02">
				<input type="text" name="srh_name">
			</td>
			<td class="list_sub02">
				<button onfocus="this.blur()" 	class="button" onclick="">검색</button></td>
		</tr>
	</table>
	</form>

	<table border="0" cellpadding="0" cellspacing="0" class="tt"
		width="600px">
		<tr>
				<td colspan="5">
		<%=boardListModel.getStartRow()%>-<%=boardListModel.getEndRow()%>
		[<%=boardListModel.getRequestPage()%>/<%=boardListModel.getTotalPageCount()%>]
		</td>
		</tr>
		
		<tr>
			<td class="list_sub01">작성순번</td>
			<td class="list_sub01">제목</td>
			<td class="list_sub01">내용</td>
			<td class="list_sub01">작성자</td>
			<td class="list_sub01">작성일</td>
		</tr>
		<%
			for (BoardDo boardList2 : boardList1) {
		%>
		<tr>
			<td><%=boardList2.getSeqNo()%></td>
			<td><a href="view.jsp?pageNum=<%=reqPageNum%>&num=<%=boardList2.getSeqNo()%>"><%=boardList2.getTitle()%></a></td>
			<td><a href="view.jsp?num=<%=boardList2.getSeqNo()%>&amp;pageNum=<%=reqPageNum%>"><%=boardList2.getContents()%></a></td>
			<td><%=boardList2.getUserId()%></td>
			<td><%=boardList2.getInsertDt()%></td>
		</tr>
		<%
			}
		%>

	</table>
	
	<table border="0" cellpadding="0" cellspacing="0" class="tt"
		width="600px">
		<tr>
		<td class="list_sub02">
			<% 
				if (beginPage > 10){
			%>
				<a href="list.jsp?pageNum=<%=beginPage-1%>">이전</a>
			<%
				} 
			%>
			
			<%for (int i=beginPage ; i <= endPage ; i++ ) {%>
			<a href="list.jsp?pageNum=<%=i%>"><%=i%></a>
			<%} %>
			
			<%
				if(endPage < totalBoardPage){
			%>
			<a href="list.jsp?pageNum=<%=endPage+1%>">다음</a>
			<%
				}
			%>
		</td>
		</tr>
	</table>
</body>
</html>
<%
	}
%>
