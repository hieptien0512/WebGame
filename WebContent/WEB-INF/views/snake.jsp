<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html>
<head>
<title>Super Snake Game</title>
<style>
html, body {
	height: 100%;
	margin: 0;
}

body {
	background-image: linear-gradient(to right, red, yellow, green);
	display: flex;
	align-items: center;
	justify-content: center;
}

canvas {
	border: 4px solid white;
}

#p1 {
	color: lime;
	position: absolute;
	left: 100px;
	top: 70px;
	font-family: sans-serif;
}

#p2 {
	color: lime;
	position: absolute;
	left: 100px;
	top: 90px;
	font-family: sans-serif;
}

#p3 {
	color: lime;
	position: absolute;
	align-items: center;
	top: 0px;
	font-size: 50px;
	font-family: sans-serif;
}

#p4 {
	color: lime;
	position: absolute;
	left: 100px;
	top: 50px;
	font-family: sans-serif;
}

#score {
	color: lime;
	position: absolute;
	left: 170px;
	top: 70px;
	font-weight: 900;
}

#high {
	color: lime;
	position: absolute;
	left: 210px;
	top: 90px;
	font-weight: 900;
}

.button {
	background-color: lime; /* Green */
	border: none;
	color: white;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	transition-duration: 0.4s;
	cursor: pointer;
	position: absolute;
	left: 100px;
	top: 300px;
}

.button1 {
	background-color: white;
	color: black;
	border: 2px solid #4CAF50;
}

.button1:hover {
	background-color: #4CAF50;
	color: white;
}
</style>
</head>
<body>
	<p id="p3">
		<b><strong>SNAKE GAME</strong></b>
	</p>
	<%
		if (session.getAttribute("username") != null) {
	%>
	<p id="p4">
		Username :<strong><%=session.getAttribute("username")%></strong>
	</p>
	<%
		}
	%>
	<p id="p1">SCORE:</p>
	<p id="p2">HIGHSCORE:</p>
	<p id="score"></p>
	<p id="high" name="high"></p>
	<button class="button button1">
		<a href="index">Lưu High Score Và Xem Bảng Xếp Hạng</a>
	</button>



	<canvas width="400" height="400" id="game"></canvas>
	<script>
		var canvas = document.getElementById('game');
		var context = canvas.getContext('2d');
		var grid = 16;
		var count = 0;
		var score = 0;
		var max = 0;
		var my_gradient1 = context.createLinearGradient(220, 180, 130, 220);
		my_gradient1.addColorStop(0, "purple");
		my_gradient1.addColorStop(1, "#00FA9A");
		
		var my_gradient2 = context.createLinearGradient(0, 0, 0, 600);
		my_gradient2.addColorStop(0, "red");
		my_gradient2.addColorStop(1, "yellow");
		
		var snake = {
			x : 160,
			y : 160,

			// snake velocity. moves one grid length every frame in either the x or y direction
			dx : grid,
			dy : 0,

			// keep track of all grids the snake body occupies
			cells : [],

			// length of the snake. grows when eating an apple
			maxCells : 4
		};
		var apple = {
			x : 320,
			y : 320
		};

		// get random whole numbers in a specific range
		// @see https://stackoverflow.com/a/1527820/2124254

		function getRandomInt(min, max) {
			return Math.floor(Math.random() * (max - min)) + min;
		}
		// game loop
		function loop(color) {
			requestAnimationFrame(loop);
			// slow game loop to 15 fps instead of 60 (60/15 = 4)
			if (++count < 6) {
				return;
			}
			count = 0;
			context.clearRect(0, 0, canvas.width, canvas.height);
			// move snake by it's velocity
			snake.x += snake.dx;
			snake.y += snake.dy;
			// wrap snake position horizontally on edge of screen
			if (snake.x < 0) {
				snake.x = canvas.width - grid;
			} else if (snake.x >= canvas.width) {
				snake.x = 0;
			}

			// wrap snake position vertically on edge of screen
			if (snake.y < 0) {
				snake.y = canvas.height - grid;
			} else if (snake.y >= canvas.height) {
				snake.y = 0;
			}
			// keep track of where snake has been. front of the array is always the head
			snake.cells.unshift({
				x : snake.x,
				y : snake.y
			});
			// remove cells as we move away from them
			if (snake.cells.length > snake.maxCells) {
				snake.cells.pop();
			}
			// draw apple
			
			
			
			context.fillStyle = my_gradient2;
			context.fillRect(apple.x, apple.y, grid - 1, grid - 1);
			// draw snake one cell at a time
			context.fillStyle = my_gradient1;
			snake.cells.forEach(function(cell, index) {

				// drawing 1 px smaller than the grid creates a grid effect in the snake body so you can see how long it is
				context.fillRect(cell.x, cell.y, grid - 1, grid - 1);
				// snake ate apple
				if (cell.x === apple.x && cell.y === apple.y) {
					snake.maxCells++;
					score += 10;
					//max=score;
					document.getElementById('score').innerHTML = score;

					// canvas is 400x400 which is 25x25 grids 
					apple.x = getRandomInt(0, 25) * grid;
					apple.y = getRandomInt(0, 25) * grid;
				}
				// check collision with all cells after this one (modified bubble sort)
				for (var i = index + 1; i < snake.cells.length; i++) {

					// snake occupies same space as a body part. reset game
					if (cell.x === snake.cells[i].x
							&& cell.y === snake.cells[i].y) {

						if (score > max) {
							max = score;
						}
						snake.x = 160;
						snake.y = 160;
						snake.cells = [];
						snake.maxCells = 4;
						snake.dx = grid;
						snake.dy = 0;
						score = 0;
						apple.x = getRandomInt(0, 25) * grid;
						apple.y = getRandomInt(0, 25) * grid;
						document.getElementById('high').innerHTML = max;
					}
				}
			}

			);

		}
		// listen to keyboard events to move the snake
		document.addEventListener('keydown', function(e) {
			// prevent snake from backtracking on itself by checking that it's 
			// not already moving on the same axis (pressing left while moving
			// left won't do anything, and pressing right while moving left
			// shouldn't let you collide with your own body)

			// left arrow key
			if (e.which === 37 && snake.dx === 0) {
				snake.dx = -grid;
				snake.dy = 0;
			}
			// up arrow key
			else if (e.which === 38 && snake.dy === 0) {
				snake.dy = -grid;
				snake.dx = 0;
			}
			// right arrow key
			else if (e.which === 39 && snake.dx === 0) {
				snake.dx = grid;
				snake.dy = 0;
			}
			// down arrow key
			else if (e.which === 40 && snake.dy === 0) {
				snake.dy = grid;
				snake.dx = 0;
			}
		});
		// start the game
		requestAnimationFrame(loop);
	</script>
</body>
</html>