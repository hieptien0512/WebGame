<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>New/Edit Player</title>
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

</style>
</head>
<body>
	<div align="center">
		<h1>New/Edit Player</h1>
		<form:form action="save" method="post" modelAttribute="player">
			<table cellpadding="5">
				<form:hidden path="id" />
				<tr>
					<td>Name:</td>
					<td><form:input path="name" /></td>
				</tr>

				<tr>
					<td>Gender:</td>
					<td><form:input path="gender" /></td>
				</tr>

				<tr>
					<td>Score:</td>
					<td><form:input path="score" /></td>
				</tr>

				<tr>
					<td>Password:</td>
					<td><form:input path="pass" type="password" /></td>
				</tr>

				<tr>
					<td align="center" colspan="2"><input type="submit"
						value="Save"></td>
				</tr>
			</table>
		</form:form>
	</div>
</body>
</html>