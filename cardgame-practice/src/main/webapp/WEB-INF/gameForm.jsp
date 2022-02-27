<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>카드 게임(블랙잭)</h1>
	
	<form method="post" action="./gameAction.jsp">
		<div><img src="./img/cardback.png"></div>
		<div><button type="submit">게임 시작</button></div>
	</form>
	
	<hr> <!-- 수평선 -->
	
	<div>
		<h3>블랙잭 게임</h3>
		<div><img src="./img/rule.JPG"></div>
		<ul>
			<li>딜러와 플레이어 중 카드의 합이 21 또는 21에 가장 가까운 숫자를 가지는 쪽이 이기는 게임입니다.</li>
			<li>Ace는 1 또는 11로 계산합니다.</li>
			<li>King(13), Queen(12), Jack(11)은 각각 10으로 계산합니다.</li>
			<li>그 외의 카드는 카드에 표시된 숫자로 계산합니다.</li>
		</ul>
	</div>
</body>
</html>