<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="./css/style.css" />
<script>
	function f_index(par0) {
		var form = document.index;
		
		if (par0 == "j") {
			form.action = "./join.jsp";
			form.submit();
		} else if (par0 == "l") {
			if(f_val() == false ){
				alert("need ID or PW");
			}else{
				form.action = "./login.jsp";
				form.submit();	
			}
		} else if (par0 == "f") {
			form.action = "./findidpw.jsp";
			form.submit();
		}
	}
	function f_val(){
		var id = document.getElementsByName("id")[0].value;
		var pw = document.getElementsByName("password")[0].value;
		
		if (id==null || id=="" || pw == null || pw == ""){
			return false;			
		}
	}
</script>
<title>로그인</title>
</head>
<body>
	<form name="index" method="post">
		<table border="0" cellpadding="0" cellspacing="0" class="tt">
			<tr>
				<td class="list_sub01">아이디</td>
				<td class="list_sub02"><input type="text" name="id"></td>
			</tr>
			<tr>
				<td class="list_sub01">비밀번호</td>
				<td class="list_sub02"><input type="password" name="password"></td>
			</tr>
			<tr>
				<td colspan="2" class="list_sub02">
					<button onfocus="this.blur()" class="button" onclick="f_index('l')">로그인</button>
					<button onfocus="this.blur()" class="button" onclick="f_index('j')">회원가입</button>
					<button onfocus="this.blur()" class="button" onclick="f_index('f')">아이디/비밀번호찾기</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>