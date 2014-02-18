<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>ID/PW찾기</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="./css/style.css" />
<script>
	function f_join(par0) {
		t_i = document.getElementsByName("id")[0].value
		t_e = document.getElementsByName("email")[0].value
		t_n = document.getElementsByName("name")[0].value

		if (par0 == "f_id_name") {
			if (t_n == "" || t_n == null) {
				alert("name이 비었습니다.")
			} else {
				var form = document.findidpw;
				form.action = "./findid_pc.jsp";
				form.submit();
			}
		} else if (par0 == 'f_id_email') {
			if (t_e == "" || t_e == null) {
				alert("email이 비었습니다.")
			} else {
				var form = document.findidpw;
				form.action = "./findid_pc.jsp";
				form.submit();
			}
		} else if (par0 == 'f_pw') {
			if (t_i == "" || t_i == null) {
				alert("ID가 비었습니다.")
			} else {
				var form = document.findidpw;
				form.action = "./findpw_pc.jsp";
				form.submit();
			}
		}
	}

	function goURL(url) {
		location.href = url
	}
</script>
</head>
<body>
	<form name="findidpw" method="post">
		<table border="0" cellpadding="0" cellspacing="0" class="tt">
			<tr>
				<td class="list_sub01">아이디</td>
				<td class="list_sub02"><input type="text" name="id"></td>
				<td class="list_sub02"><button onfocus="this.blur()"
						class="button" onclick="f_join('f_pw')">PW찾기</button></td>
			</tr>
			<tr>
				<td class="list_sub01">이메일</td>
				<td class="list_sub02"><input type="text" name="email"></td>
				<td class="list_sub02"><button onfocus="this.blur()"
						class="button" onclick="f_join('f_id_email')">ID찾기</button></td>
			</tr>
			<tr>
				<td class="list_sub01">이름</td>
				<td class="list_sub02"><input type="text" name="name"></td>
				<td class="list_sub02"><button onfocus="this.blur()"
						class="button" onclick="f_join('f_id_name')">ID찾기</button></td>
			</tr>

		</table>

	</form>
	<div class="list_sub01">
		<button onfocus="this.blur()" class="button"
			onclick="goURL('index.jsp')">취소</button>
	</div>

</body>
</html>