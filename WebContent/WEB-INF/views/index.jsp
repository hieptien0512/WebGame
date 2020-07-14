<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bảng Xếp Hạng</title>
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
h3 {
  font-size: 20px;
  background: -webkit-linear-gradient(black, white);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}
</style>
</head>
<body>
	<div align="center">
		<h1>Bảng Xếp Hạng</h1>
		<h3><a href="player_form">New Player</a></h3>
		<table border="1" cellpadding="5">
			<tr>
				<th>No</th>
				<th>Name</th>
				<th>Gender</th>
				<th>Score</th>
				<th>Action</th>
			</tr>
			<c:forEach items="${listPlayer}" var="player" varStatus="status">
				<tr>
					<td>${status.index + 1}</td>
					<td>${player.name}</td>
					<td>${player.gender}</td>
					<td>${player.score}</td>
					<td>
						<a href="edit?id=${player.id }">Edit</a>
						&nbsp;&nbsp;
						<a href="delete?id=${player.id }">Delete</a>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>