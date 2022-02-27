<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="vo.Card"%>
<%
	/*
	블랙잭 알고리즘
	
	int sum = 0;
	int oneCount = 0; // 1의 횟수가 아니고 1을 11로 치환한 횟수
	for(int i = 0; i < num.length; i = i + 1) { // i++;
		if(num[i] == 1) {
			oneCount = oneCount + 1; // oneCount++;
			sum = sum + 11;
		} else if(num[i] > 10) {
			sum = sum + 10; // 11, 12, 13인 경우는 10으로 합산한다.
		} else {
			sum = sum + num[i];
		}
		
		if(i == 1 && sum >= 21) { // 2번째 조건식
			if(oneCount > 0) {
				sum = sum - 10;
				oneCount = oneCount - 1; // oneCount--;
			}
		} else if(i == 2 && sum > 21) { // 3번째 조건식
			if(oneCount > 0) {
				sum = sum - 10;
				oneCount = oneCount - 1; // oneCount--;
			}
		}
		System.out.println(sum + " <-- for>sum");
	}
	
	System.out.println(sum + " <-- sum");
	
	*/
	

	// 1) 52장의 카드를 생성
	Card[] cards = null;
	cards = new Card[52];
	
	// 2) 52장의 카드값을 초기화 (1~13 4번 반복, spade를 13번, diamond를 13번...)
	// -num(0값)과 kind(null값)를 가진 카드 52개 생성(초기화)
	for(int i=0; i<cards.length; i=i+1) { 
		cards[i] = new Card(); 
		cards[i].num = (i % 13) + 1; // 0->1, 1->2, ... 12->13, 13->1
		if(i / 13 == 0) {
			cards[i].kind = "spade"; // 0 ~ 12는 13으로 나눴을 때 몫이 0
		} else if(i / 13 == 1) {
			cards[i].kind = "diamond"; // 13 ~ 25는 13으로 나눴을 때 몫이 1
		} else if(i / 13 == 2) {
			cards[i].kind = "heart"; // 26 ~ 38는 13으로 나눴을 때 몫이 2
		} else if(i / 13 == 3) {
			cards[i].kind = "clover"; // 39 ~ 52는 13으로 나눴을 때 몫이 3
		}
		
		/*
		if(i < 13) {
			cards[i].kind = "spade";
		} else if(i < 26) {
			cards[i].kind = "diamond";
		} else if(i < 39) {
			cards[i].kind = "heart";
		} else {
			cards[i].kind = "clover";
		}
		*/
	}
	
	// 디버깅
	System.out.println("-----------초기화 후-----------");
	for(Card c : cards) {
		System.out.printf("%d번 %s \n", c.num, c.kind);
	}
	
	// 3) 섞다. 로또 shuffle과 동일한 알고리즘
	for(int i=0; i<10000; i=i+1) {
		int r = (int)(Math.random() * 52);// 0 ~ 51
		Card temp = cards[0];
		cards[0] = cards[r];
		cards[r] = temp;
	}
	
	// 디버깅
	System.out.println("-----------shuffle 후-----------");
	for(Card c : cards) {
		System.out.printf("%d번 %s \n", c.num, c.kind);
	} 
	
	final int PLAYER_COUNT = 2;
	final int CARD_COUNT = 3;
	
	Card[] p1 = new Card[CARD_COUNT]; // -player1이 가져야 할 카드 수
	Card[] p2 = new Card[CARD_COUNT];
	
	for(int i=0; i<PLAYER_COUNT * CARD_COUNT; i=i+1) { // -PLAYER_COUNT * CARD_COUNT -> 나눠줄 카드 수
		if(i / CARD_COUNT == 0) { // 첫번째 player
			p1[i] = cards[i]; // p1[0] = cards[0], cards[1], cards[2]
 		} else if(i / CARD_COUNT == 1) { // 두번째 player
			p2[i % CARD_COUNT] = cards[i]; // p2[0], 1, 2 = cards[3], cards[4], cards[5]
		}
	}
	
	// 참가자들의 카드의 숫자값으로 순위 결정
	// 2 ~ 10 -> 숫자값대로
	// 11 ~ 13 -> 10
	// 1 -> 11 but 11인데 3장의 합이 21을 넘으면 1로 변경
	// 21을 넘지 않으면 21에 가까운 참가자가 승리
	
	int p1Sum = 0; 
	int p2Sum = 0;
	p1Sum = p1[0].num + p1[1].num + p1[2].num;
	p2Sum = p2[0].num + p2[1].num + p2[2].num;
	
	for(int i=0; i<CARD_COUNT; i=i+1) { // 나눠준 카드에서 11 ~ 13이 있을 경우 합의 숫자만 10으로 바꾸기
		if(p1[i].num == 11) {
			p1Sum = p1Sum - 1;
		} else if(p1[i].num == 12) {
			p1Sum = p1Sum - 2;
		} else if(p1[i].num == 13) {
			p1Sum = p1Sum - 3;
		}
		if(p2[i].num == 11) {
			p2Sum = p2Sum - 1;
		} else if(p2[i].num == 12) {
			p2Sum = p2Sum - 2;
		} else if(p2[i].num == 13) {
			p2Sum = p2Sum - 3;
		}
	}
	for(int i=0; i<CARD_COUNT; i=i+1) { // 1카드 11만들기
		if(p1Sum < 21) {
			if(p1[i].num == 1) {
				p1Sum = p1Sum + 10;
			}
		}
		if(p2Sum < 21) {
			if(p2[i].num == 1) {
				p2Sum = p2Sum + 10;
			}
		}
	}
	/*
	for(int i=0; i<CARD_COUNT; i=i+1) { // A카드가 11로 했을 때 21이상이면 1로 계산
		if(p1Sum >= 21) {
			if(p1[i].num == 1) {
				p1Sum = p1Sum - 10;
			}
		}
		if(p2Sum >= 21) {
			if(p2[i].num == 1) {
				p2Sum = p2Sum - 10;
			}
		}
	}
	*/

	String result = "";
	if(p1Sum <= 21) {
		if(p1Sum == p2Sum) {
			result = "비겼습니다.";
		} else if(p2Sum <= 21 && p1Sum < p2Sum) { // p2 합이 p1 합보다 클 때
			result = "player2가 이겼습니다.";
		} else if(p2Sum <= 21 && p1Sum > p2Sum) { // p2 합이 p1 합보다 작을 때
			result = "player1이 이겼습니다.";
		} else {
			result = "player1이 이겼습니다.";;
		}
	} else if(p2Sum <= 21){
		if(p1Sum == p2Sum) {
			result = "비겼습니다.";
		} else if(p1Sum <= 21 && p1Sum < p2Sum) { // p2 합이 p1 합보다 클 때
			result = "player2가 이겼습니다.";
		} else if(p1Sum <= 21 && p1Sum > p2Sum) { // p2 합이 p1 합보다 작을 때
			result = "player1이 이겼습니다.";
		} else {
			result = "player2가 이겼습니다.";
		}
	} else {
		result = "player1, player2 모두 21보다 크기 때문에 졌습니다.";
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>player1 카드</h2>
	<div>
		<%
			for(Card c : p1) {
		%>
			<span><img src="./img/<%= c.kind %><%= c.num %>.jpg"></span>
		<%
			}
		%>
		<div>
			p1 참가자의 카드 합 : <%= p1Sum %>
		</div>
	</div>
	
	<h2>player2 카드</h2>
	<div>
		<%
			for(Card c : p2) {
		%>
			<span><img src="./img/<%= c.kind %><%= c.num %>.jpg"></span>	
		<%
			}
		%>
		<div>
			p2 참가자의 카드 합 : <%= p2Sum %>
		</div>
	</div>
	<div>
		<%= result %>
	</div>
</body>
</html>