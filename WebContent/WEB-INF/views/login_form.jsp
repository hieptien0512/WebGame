<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>Đăng nhập</title>
<style>
body {
	background-image: linear-gradient(to right, red, yellow, green);
	display: flex;
	align-items: center;
	justify-content: center;
}
h1 {
  font-size: 32px;
  background: -webkit-linear-gradient(black, white);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}
h2 {
  font-size: 25px;
  background: -webkit-linear-gradient(black, white);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}
label {
  font-size: 20px;
  background: -webkit-linear-gradient(black, white);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}
div1 {
  font-size: 17px;
  background: -webkit-linear-gradient(black, white);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  font-weight: bold;
}

</style>
</head>
<body >
	<div style="width: 700px; margin: 30px auto;">
		<h1 style="font-family: sans-serif;">
			<b>Chào Mừng Đến Với Trò Chơi Rắn Săn Mồi</b>
		</h1>
		<h2 style="font-family: sans-serif;">
			<b>Đăng nhập</b>
		</h2>
		<%
			if (session.getAttribute("loginStatus") != null) {
			out.print("<p style='color:red'><b>Sai tên đăng nhập hoặc mật khẩu</b> </p>");
		}
		%>
		<form action="login" method="post">
			<div>
				<label><b>Tên đăng nhập: </b></label> <input class="w3-input" type="text"
					name="username" value="" />
			</div>
			<br />
			<div>
				<label><b>Mật khẩu:</b></label> <input class="w3-input" type="password"
					name="password" value="" />
			</div>
			<br />
			<div1>
				<input class="w3-btn" type="submit" name="submit" value="Đăng nhập" /> <input class="w3-btn"
					type="reset" name="reset" value="Nhập lại" />
			</div1>
		</form>
	</div>
</body>
</html>