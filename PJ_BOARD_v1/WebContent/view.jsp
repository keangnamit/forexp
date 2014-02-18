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
	int reqPageNum = 0;
	int reqNum = 0;
	
	//request.setCharacterEncoding("UTF-8");
	
	String num = request.getParameter("num");
	String pageNum = request.getParameter("pageNum");
	//Connection conn = null;


	if (session.getAttribute("id") == null
			|| session.getAttribute("id") == "") {
		id = "";
		pw = "";
		response.sendRedirect("index.jsp");
	} else {
		id = (String) session.getAttribute("id");
		
		
		num = request.getParameter("num");
		if (num != null && num.length() > 0) {
			reqNum = Integer.parseInt(num);
		}
		
		try{
			
		//conn = SimpleConnection.getConnection();

		//BoardDao boardDao = new BoardDao();
		//BoardDo board = boardDao.boardView(conn, reqNum);
		
		BoardDaoImpl boardDao = new BoardMyBatisDao();
		BoardDo board = boardDao.boardView(reqNum);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>뷰 페이지</title>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="./css/style.css" />
<script>
	function f_view(par0) {
		var form = document.view;

		if (par0 == "l") {
			form.action = "./list.jsp";
			form.submit;
		} else if (par0 == "e") {
			form.action = "./edit.jsp";
			form.submit;
		}
	}
	
	function goUrl(url){
		location.href = url; 
	}
	
	function loadXMLdoc(){
		var xmlhttp;
		if (window.XMLHttpRequest)
			{
			xmlhttp = new XMLHttpRequest();
			}
		else
			{
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");	
			}
		
		xmlhttp.open("GET", "BoardRcmdServlet", true);
		xmlhttp.send("seqNum=<%=num%>");
		
		xmlhttp.onreadystatechange=function()
		  {
		  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    {
		    document.getElementById("myDiv").innerHTML=xmlhttp.responseText;
		    }
		  else
		    {
			  alert('Something went wrong...');
			  }
		  }	
	}
	/////////////////////////////////////////////////////////////////////////
	function createXMLHttpRequest(){
		  // See http://en.wikipedia.org/wiki/XMLHttpRequest
		  // Provide the XMLHttpRequest class for IE 5.x-6.x:
		  if( typeof XMLHttpRequest == "undefined" ) XMLHttpRequest = function() {
		    try { return new ActiveXObject("Msxml2.XMLHTTP.6.0") } catch(e) {}
		    try { return new ActiveXObject("Msxml2.XMLHTTP.3.0") } catch(e) {}
		    try { return new ActiveXObject("Msxml2.XMLHTTP") } catch(e) {}
		    try { return new ActiveXObject("Microsoft.XMLHTTP") } catch(e) {}
		    throw new Error( "This browser does not support XMLHttpRequest." )
		  };
		  return new XMLHttpRequest();
		}

		var AJAX = createXMLHttpRequest(); 

		function handler() {
		  if(AJAX.readyState == 4 && AJAX.status == 200) {
		      //var json = eval('(' + AJAX.responseText +')');
		      //or
		      var json = JSON.parse(AJAX.responseText);
		      //or
		      var hdrs = AJAX.getAllResponseHeaders();
		      //document.getElementById("myDiv").innerHTML=AJAX.responseText;
		      //document.getElementById("myDiv2").innerHTML=hdrs;
		      
		      //document.getElementById("recomcnt").innerHTML=AJAX.responseText;
		      document.getElementById("recomcnt").innerHTML=json.recomm;
		      //alert('name => ' + json.name + ';;;' + 'balance => ' + json.balance);
		      //alert("본문" + AJAX.responseText);
		  }else if (AJAX.readyState == 4 && AJAX.status != 200) {
		    alert('Something went wrong...');
		  }
		}

		function show(){
		  AJAX.onreadystatechange = handler;
		  AJAX.open("GET", "BoardRcmdServlet?seqNum=<%=num%>",true);
		  AJAX.send();
		};	
</script>
</head>
<body>

		<table border="0" cellpadding="0" cellspacing="0" class="tt"
			width="600px">
			<tr>
			<td class="list_sub01">로그인</td>
			<td class="list_sub2"><%=id%></td></tr>
			<tr>			
			<tr>
			<td class="list_sub01">요청페이지</td>
			<td class="list_sub2"><%=pageNum %></td></tr>
			<tr>
				<td class="list_sub01">작성순번</td>
				<td class="list_sub02"><%=board.getSeqNo()%></td>
			</tr>
			<tr>
				<td class="list_sub01">제목</td>
				<td class="list_sub02"><%=board.getTitle()%></td>
			</tr>
			<tr>
				<td class="list_sub01">내용</td>
				<td class="list_sub02"><%=board.getContents()%></td>
			</tr>
			<tr>
				<td class="list_sub01">작성자</td>
				<td class="list_sub02"><%=board.getUserId()%></td>
			</tr>
			<tr>
				<td class="list_sub01">작성일</td>
				<td class="list_sub02"><%=board.getInsertDt()%></td>
			</tr>
			<tr>
				<td class="list_sub01">추천수</td>
				<td class="list_sub02" id="recomcnt"><%=board.getRecommendNo()%></td>
			</tr>			
			<tr>
				<td colspan="2" class="list_sub02">
					<button onfocus="this.blur()" class="button" onclick="goUrl('list.jsp?pageNum=<%=pageNum%>')">리스트</button>

					<button onfocus="this.blur()" class="button" onclick="goUrl('edit.jsp?num=<%=num%>&pageNum=<%=pageNum%>')">수정</button>
					
					<button type="button" onclick = "loadXMLdoc()">추천load</button>
					<button type="button" onclick = "show()">추천show</button>

				</td>
			</tr>
		</table>
		<div id="myDiv"><h2>Let AJAX change this text</h2></div>
		<div id="myDiv2"><h2>Let AJAX HEADER</h2></div>

</body>
</html>
<%
		} finally{
			//JdbcUtil.close(conn);
		}
	}
%>

