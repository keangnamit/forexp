<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>회원 가입</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="./css/style.css" />
<script>
	function f_join(par0) {

		if (par0 == "c") {
			var form = document.join;
			form.action = "./index.jsp";
			form.submit();
		} else if (par0 == "j") {
			if (f_chk() == 1) {
				alert("id 넣으셈")
			} else if (f_chk() == 2) {
				alert("email 넣으셈");
			} else if (f_chk() == 3) {
				alert("name 넣으셈");
			} else if (f_chk() == 4) {
				alert("비번 넣으셈");
			} else if (f_chk() == 5) {
				alert("확인비번 넣으셈");
			} else {
				var form = document.join;
				form.action = "./join_pc.jsp";
				form.submit();
			}
		}
	}

	function f_chk() {

		t_id = document.getElementsByName("id")[0].value;
		t_email = document.getElementsByName("email")[0].value;
		t_name = document.getElementsByName("name")[0].value;
		t_pw = document.getElementsByName("password")[0].value;
		t_pw_chk = document.getElementsByName("password_check")[0].value;

		if (t_id == "" || t_id == null) {
			result = 1;
			return result
		} else if (t_email == "") {
			result = 2;
			return result
		} else if (t_name == "") {
			result = 3;
			return result
		} else if (t_pw == "") {
			result = 4;
			return result
		} else if (t_pw_chk == "") {
			result = 5;
			return result
		}
	}

	function f_open() {
		window.open("", "id_ck", "width=500,height=200,left=300,top=100");
		var form = document.join;
		form.target = "id_ck"
		form.action = "./dupid_pc.jsp"
		form.submit();
	}
	function f_getdata(par0) {
		//var form = document.join;
		//form.id = par0;
		//alert(par0);
		document.getElementsByName("id")[0].value = par0;
	}
	function f_keyup() {
		var code= event.keyCode;

		
		if ((code >= 65 && code <= 90) ||(code >= 48 && code <= 57) || code == 8 ) {
			var password = document.getElementsByName("password")[0].value;
			var password_chk = document.getElementsByName("password_check")[0].value;
			if (password != password_chk) {
				document.getElementsByName("password_check")[0].style.color = "red";
			} else {
				document.getElementsByName("password_check")[0].style.color = "black";
			}
		}
	}
	function goUrl(url){
		location.href=url
	}
</script>
</head>
<body>
	<form name="join" method="post">
		<!--<form name="join" method="post" onsubmit="return false">-->
		<table border="0" cellpadding="0" cellspacing="0" class="tt">
			<tr>
				<td class="list_sub01">아이디</td>
				<td class="list_sub02"><input type="text" name="id"></td>
				<td class="list_sub02"><button onfocus="this.blur()"
						class="button" onclick="f_open()">중복확인</button></td>
			</tr>
			<tr>
				<td class="list_sub01">이메일</td>
				<td colspan="2" class="list_sub02"><input type="text"
					name="email"></td>
			</tr>
			<tr>
				<td class="list_sub01">이름</td>
				<td colspan="2" class="list_sub02"><input type="text"
					name="name"></td>
			</tr>
			<tr>
				<td class="list_sub01">비밀번호</td>
				<td colspan="2" class="list_sub02"><input type="password"
					name="password"></td>
			</tr>
			<tr>
				<td class="list_sub01">비밀번호 확인</td>
				<td colspan="2" class="list_sub02"><input type="password"
					name="password_check" onkeyup="f_keyup()"></td>
			</tr>
			<tr>
				<td colspan="3" class="list_sub02">
					<button  class="button" onclick="f_join('j')">가입하기</button>

				</td>

			</tr>
		</table>
	</form>
	<button onfocus="this.blur()" class="button" onclick="goUrl('index.jsp')">취소</button>
</body>
</html>