<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%
	// ----------------------------------------------전 페이지에서 넘어온 값 변수에 저장
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String categoryName = request.getParameter("categoryName");	
	System.out.println("[boardOne.jsp] boardNo : " + boardNo);
	System.out.println("[boardOne.jsp] categoryName : " + categoryName);
	
	// -----------------------------------mariadb 드라이버 로딩 + mariadb RDBMS 접속
	Class.forName("org.mariadb.jdbc.Driver"); // 드라이버 로딩
	Connection conn = null;
	String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
	String dbuser = "root"; // DB 아이디
	String dbpw = "java1234"; // DB 패스워드
	conn = DriverManager.getConnection(dburl, dbuser, dbpw);
	System.out.println("[boardOne.jsp] conn : " + conn + " / 드라이버 로딩 성공");
	
	// ---------------------------------------------------------------------쿼리
	// -쿼리 저장
	PreparedStatement stmt = conn.prepareStatement("SELECT board_no boardNo, category_name categoryName, board_content boardContent, board_title boardTitle, create_date createDate, update_date updateDate FROM board where board_no = ?");
	stmt.setInt(1, boardNo); // 사용자가 선택해서 넘어온 ?값
			
	// -쿼리를 실행 후 결과값(테이블 모양의 ResultSet타입)을 리턴
	// -한 행의 데이터값을 가져오기에 ArrayList 대신 Board board 사용
	ResultSet rs = stmt.executeQuery();
	Board board = null;
	if(rs.next()) { // -next()메소드 : 문자 혹은 문자열을 공백 기준으로 한 단어 또는 한 문자씩 입력받음, 다음 줄로 커서를 이동해서 읽을 값들이 존재하면 true, 존재하지 않으면 false 
		board = new Board();
		board.boardNo = rs.getInt("boardNo");
		board.boardTitle = rs.getString("boardTitle");
		board.categoryName = rs.getString("categoryName");
		board.boardContent = rs.getString("boardContent");
		board.createDate = rs.getString("createDate");
		board.updateDate = rs.getString("updateDate");
	}
	
	// -카테고리 메뉴 쿼리
	String categorySql = "SELECT category_name categoryName, COUNT(*) cnt FROM board GROUP BY category_name";
	PreparedStatement categoryStmt = conn.prepareStatement(categorySql);
	ResultSet categoryRs = categoryStmt.executeQuery();
	
	// -쿼리의 결과를 Category, Board VO로 저장할 수 없기에 HashMap 사용
	// -Resultset을 ArrayList<HashMap...> 변경, HashMap을 변수가 categoryList인 ArrayList에 담기
	ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
	while(categoryRs.next()) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("categoryName", categoryRs.getString("categoryName"));
		map.put("cnt", categoryRs.getInt("cnt"));
		categoryList.add(map);
	}
	
	conn.close(); // -Connection 객체는 사용이 끝나면 반납
	
	// -request.getContextPath() : 프로젝트 명이 바뀔 수 있기 때문에 사용 
	//	(프로젝트 명이 바뀌면 a href를 수정해야 하기 때문에 번거롭지 않기 위해 사용)
	// -request.getContextPath()는 프로젝트 명을 갖고 옴 (/blog라는 글이 들어갈거임)

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>boardOne</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class = "container">
	<br>
	<div class = "row">
		<!-- 좌측 메뉴, category별 게시글 링크 메뉴 -->
		<div class = "col-sm-2 bg-warning">
			<br>
			<ul class="list-group">
				<li class="list-group-item">= CATEGORY =</li>
				<%
					for(HashMap<String, Object> m : categoryList) {
				%>
						<li class = "list-group-item">
							<a href="<%= request.getContextPath() %>/board/boardList.jsp?categoryName=<%=m.get("categoryName")%>" ><%=m.get("categoryName")%> <span class = "badge bg-warning"><%=m.get("cnt")%></span> </a>
						</li>
				<%		
					}
				%>
			</ul> 
			<br>				
		</div>
			
	<!-- 메인 -->
	<div class = "col-sm-8 bg-light">
		<div class="container p-3 my-3 bg-dark text-white">
		<h1>board 게시글</h1>
	</div>
	<!-- 게시글 리스트 -->
	<table class = "table table-info">
		<tr>
			<td>boardNo</td>
			<td class="table-warning"><%= board.boardNo %></td>
		</tr>
		<tr>
			<td>categoryName</td>
			<td class="table-warning"><%= board.categoryName %></td>
		</tr>
		<tr>
			<td>boardTitle</td>
			<td class="table-warning"><%= board.boardTitle %></td>
		</tr>
		<tr>
			<td>boardContent</td>
			<td class="table-warning"><%= board.boardContent %></td>
		</tr>
		<tr>
			<td>createDate</td>
			<td class="table-warning"><%= board.createDate %></td>
		</tr>
		<tr>
			<td>updateDate</td>
			<td class="table-warning"><%= board.updateDate %></td>
		</tr>
	</table>
		<div>
			<a href="<%= request.getContextPath() %>/board/updateBoardForm.jsp?boardNo=<%= board.boardNo %>" class = "btn btn-outline-info">수정</a>
			<a href="<%= request.getContextPath() %>/board/deleteBoardForm.jsp?boardNo=<%= board.boardNo %>" class = "btn btn-outline-info">삭제</a>
			<a href="<%= request.getContextPath() %>/board/boardList.jsp" class = "btn btn-outline-info">이전 페이지</a>
		</div>
	</div>
</div>
</body>
</html>