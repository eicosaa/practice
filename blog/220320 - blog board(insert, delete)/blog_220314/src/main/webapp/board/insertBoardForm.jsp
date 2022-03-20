<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
	
	//-----------------------------------mariadb 드라이버 로딩 + mariadb RDBMS 접속
	Class.forName("org.mariadb.jdbc.Driver"); // 드라이버 로딩
	Connection conn = null;
	String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
	String dbuser = "root"; // DB 아이디
	String dbpw = "java1234"; // DB 패스워드
	conn = DriverManager.getConnection(dburl, dbuser, dbpw);
	System.out.println("[insertBoardForm.jsp] conn : " + conn + " / 드라이버 로딩 성공");
	
	// ---------------------------------------------------------------------쿼리
	// -데이터베이스에 있는 카테고리 데이터를 선택하기 위한 쿼리
	String sql = "select category_name categoryName from category order by category_name asc";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	ArrayList<String> list = new ArrayList<String>();
	while(rs.next()) {
		list.add(rs.getString("categoryName"));
	}
	
	conn.close();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>insertBoardForm</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</style>
</head>
<body>
<div class = "container">
	<div class="container p-3 my-3 bg-dark text-white">
	<h1>글 입력</h1>
	</div>
	<form method="post" action="<%= request.getContextPath() %>/board/insertBoardAction.jsp">
		<table class = "table table-primary">
			<tr>
				<td>categoryName</td>
				<td>
					<select name="categoryName" class = "form-select">
						<%
							for(String s : list) {
						%>
								<option value="<%=s%>"><%=s%></option>
						<%
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td>boardTitle</td>
				<td>
					<input name="boardTitle" type="text" class="form-control">
				</td>
			</tr>
			<tr>
				<td>boardContent</td>
				<td>
					<textarea name="boardContent" rows="5" cols="80" class="form-control"></textarea>
				</td>
			</tr>
			<tr>
				<td>boardPw</td>
				<td>
					<input name="boardPw" type="password" class="form-control">
				</td>
			</tr>
		</table>
		<div>
					<button type="submit" class="btn btn-outline-info">입력</button>
					<a href="<%=request.getContextPath()%>/board/boardList.jsp" class = "btn btn-outline-info">이전 페이지</a>
		</div>
	</form>
</div>
</body>
</html>