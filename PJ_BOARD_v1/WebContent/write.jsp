<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String id = "";

	if (session.getAttribute("id") == null
			|| session.getAttribute("id") == "") {
		id = "";

		response.sendRedirect("index.jsp");
	} else {
		id = (String) session.getAttribute("id");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>작성하기</title>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="./css/style.css" />
<script>
	function f_write(par0){
		var form = document.write;
		
		if (par0 == "s"){
		form.action = "./list.jsp";
		form.submit;
		} else if (par0 == "l"){
			form.action = "./list.jsp";
			form.submit;
		}
	}
	
	function boardWriteCheck() {
		var form = document.write;
		if (form.title.value == '') {
			alert('제목을 입력하세요.');
			form.title.focus();
			return false;
		}
		if (form.content.value == '') {
			alert('내용을 입력하세요');
			form.content.focus();
			return false;
		}	
		return true;
	}
	
	function goUrl(url){
		location.href = url;
	}
	

</script>
</head>
<body>
<form name="write" method="post" action="BoardWriteServlet" onsubmit="return boardWriteCheck()">

<table border="0" cellpadding="0" cellspacing="0" class="tt" width="600px">
	<tr>
	<td>
		<input type="hidden" name="userId" value="<%=id%>" />
	</td>
	</tr>
	<tr>
		<td class="list_sub01">제목</td>
		<td class="list_sub02"><input type="text" name="title"></td>
	</tr>
	<tr>
		<td class="list_sub01">내용</td>
		<td class="list_sub02"><textarea name="contents" rows="8"></textarea></td>
	</tr>
	<tr>
		<td colspan="2" class="list_sub02">
		<button onfocus="this.blur()" class= "button" onclick="f_edit('l')">리스트</button>
		
				<input class="button" type="submit" value="저장" />
		</td>
	</tr>
</table>
</form>
</body>
</html>
<% }%>