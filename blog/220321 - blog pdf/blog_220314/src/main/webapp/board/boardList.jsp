<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("[boardList.jsp] currentPage : " + currentPage);
	
	// 이전, 다음 링크에서 null 값을 넘기는 것이 불가능해서 null -> 공백으로 치환해서 코드를 처리
	String categoryName = "";
	if(request.getParameter("categoryName") != null) {
		categoryName = request.getParameter("categoryName");
	}
	
	int rowPerPage = 10; // rowPerPage은 한 페이지에 내가 보고 싶은 글 수 (한 행에 10개씩 보고 싶다.)
	int beginRow = (currentPage - 1) * rowPerPage; // 현재 페이지가 변경되면 beginRow도 변경된다. -> 가져오는 데이터 변경된다.
	
	//String categoryName = request.getParameter("categoryName");	

	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	String dburl = "jdbc:mariadb://localhost:3307/blog";
	String dbuser = "root";
	String dbpw = "java1234";
	conn = DriverManager.getConnection(dburl, dbuser, dbpw);
	System.out.println(conn + " <-- conn");

	String categorySql = "SELECT category_name categoryName, COUNT(*) cnt FROM board GROUP BY category_name";
	PreparedStatement categoryStmt = conn.prepareStatement(categorySql);
	ResultSet categoryRs = categoryStmt.executeQuery();
	
	// 쿼리에 결과를 Category, Board VO로 저장할 수 없다. -> HashMap을 사용해서 저장하자!
	ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
	while(categoryRs.next()) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("categoryName", categoryRs.getString("categoryName"));
		map.put("cnt", categoryRs.getInt("cnt"));
		categoryList.add(map);
	}
	
	// boardList
	String boardSql = null;
	PreparedStatement boardStmt = null;
	if(categoryName.equals("")) {
		boardSql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board ORDER BY create_date DESC LIMIT ?, ?";
		boardStmt = conn.prepareStatement(boardSql);
		boardStmt.setInt(1, beginRow);
		boardStmt.setInt(2, rowPerPage);
	} else {
		boardSql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board WHERE category_name =? ORDER BY create_date DESC LIMIT ?, ?";
		boardStmt = conn.prepareStatement(boardSql);
		boardStmt.setString(1, categoryName);
		boardStmt.setInt(2, beginRow);
		boardStmt.setInt(3, rowPerPage);
	}
	ResultSet boardRs = boardStmt.executeQuery();
	ArrayList<Board> boardList = new ArrayList<Board>();
	while(boardRs.next()) {
		Board b = new Board();
		b.boardNo = boardRs.getInt("boardNo");
		b.categoryName = boardRs.getString("categoryName");
		b.boardTitle = boardRs.getString("boardTitle");
		b.createDate = boardRs.getString("createDate");
		boardList.add(b);
	}
	
	int totalRow = 0; // select count(*) from board; -> 전체 행의 개수
	String totalRowSql = "SELECT COUNT(*) cnt FROM board";
	PreparedStatement totalRowStmt = conn.prepareStatement(totalRowSql);
	ResultSet totalRowRs = totalRowStmt.executeQuery();
	if(totalRowRs.next()) {
		totalRow = totalRowRs.getInt("cnt");
		System.out.println(totalRow + " <-- totalRow");
	}
	
	int lastPage = 0;
	if(totalRow % rowPerPage == 0) {
		lastPage = totalRow / rowPerPage;
	} else {
		lastPage = (totalRow / rowPerPage) + 1;
	}
	
	conn.close();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>boardList</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class = "container">
	<!-- 메인 메뉴 -->
	<div class="container p-3 my-3 bg-dark text-white">
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	</div>
	
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
							<a href="<%=request.getContextPath()%>/board/boardList.jsp?categoryName=<%=m.get("categoryName")%>" ><%=m.get("categoryName")%> <span class = "badge bg-warning"><%=m.get("cnt")%></span> </a>
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
			<h1>게시글 목록</h1>
			<p>total : <%= totalRow %></p>
			</div>
		
				<!-- 게시글 리스트 -->
				<div>
					<a href="<%= request.getContextPath() %>/board/insertBoardForm.jsp" class = "btn btn-outline-info">게시글 입력</a>
				</div>
				<br>
				<div>
					<table class = "table table-info">
						<thead class = "table table-dark">
							<tr>
								<th>categoryName</th>
								<th>boardTitle</th>
								<th>createDate</th>
							</tr>
						</thead>
						<tbody>
							<%
								for(Board b : boardList) {
							%>
									<tr>
										<td><%=b.categoryName%></td>
										<td><a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=b.boardNo%>"><%=b.boardTitle%></a></td>
										<td><%=b.createDate%></td>
									</tr>
							<%		
								}
							%>
						</tbody>
					</table>
				</div>
				<!-- 페이징 -->		
				<div>
						<!-- 페이지가 만약 10페이지였다면 이전을 누르면 9페이지, 다음을 누르면 11페이지 -->
						<%
							if(currentPage > 1) { // 현재 페이지가 1이면 이전 페이지가 존재해서는 안된다.
						%>
								<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%= currentPage - 1 %>&categoryName=<%= categoryName%>" class = "btn btn-info">이전</a>
						<%
							}
						%>
						
						<!-- 
							전체 행   			마지막 페이지 ? 
							10개					1
							11,12,13 ~ 20		2
							21 ~ 30				3
							31 ~ 40				4
							
							마지막 페이지 = 전체 행 / rowPerPage
						-->
						<%
							if(currentPage < lastPage) {
						%>
								<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%= currentPage + 1 %>&categoryName=<%= categoryName%>" class = "btn btn-info">다음</a>
						<%
							}
						%>
					</div>
					<br>
			</div>
</div>
</div>
</body>
</html>