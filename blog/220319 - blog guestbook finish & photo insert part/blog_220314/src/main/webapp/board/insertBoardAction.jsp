<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%
	/*
		INSERT INTO board(
				category_name,
				board_title,
				board_content,
				board_pw,
				create_date,
				update_date
		) VALUES (
			?, ?, ?, ?, NOW(), NOW()		
		)
	*/
	
	// -인코딩
	request.setCharacterEncoding("utf-8");
	
	// -------------------insertBoardForm 페이지에서 보낸 파라미터(매개변수) 값 변수에 저장
		String categoryName = request.getParameter("categoryName");	
		String boardTitle = request.getParameter("boardTitle");
		String boardContent = request.getParameter("boardContent");
		String boardPw = request.getParameter("boardPw");
		// -디버깅 코드
		System.out.println("[insertBoardAction.jsp] categoryName : " + categoryName);
		System.out.println("[insertBoardAction.jsp] boardTitle : " + boardTitle);
		System.out.println("[insertBoardAction.jsp] boardContent : " + boardContent);
		System.out.println("[insertBoardAction.jsp] boardPw : " + boardPw);
	
	//-----------------------------------mariadb 드라이버 로딩 + mariadb RDBMS 접속
		Class.forName("org.mariadb.jdbc.Driver"); // 드라이버 로딩
		Connection conn = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // 주소
		String dbuser = "root"; // 아이디
		String dbpw = "java1234"; // 패스워드
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // -드라이버 연결하여 conn 변수에 저장
		System.out.println("[insertBoardAction.jsp] conn : " + conn + " / 드라이버 로딩 성공");
		
	// ---------------------------------------------------------------------쿼리
	// -데이터베이스에 insertBoardForm에서 넘어온 데이터를 저장하기 위한 쿼리
	String sql = "INSERT INTO board(category_name, board_title,	board_content, board_pw, create_date, update_date) VALUES (?, ?, ?, ?, NOW(), NOW())";
	PreparedStatement stmt = conn.prepareStatement(sql); 
	stmt.setString(1, categoryName);
	stmt.setString(2, boardTitle);
	stmt.setString(3, boardContent);
	stmt.setString(4, boardPw);
	
	// -수행결과 int 타입의 값 반환하는 executeUpdate를 사용하여 몇 행을 입력했는지 return
	int row = stmt.executeUpdate();
	// 디버깅
	if(row == 1) {
		System.out.println(row + "행 입력 성공");
	} else {
		System.out.println("입력 실패");
	}
	
	conn.close(); // -Connection 객체는 사용이 끝나면 반납	
	
	response.sendRedirect(request.getContextPath() + "/boardList.jsp"); // 재요청 / 입력 실패하거나 성공 후 boardList.jsp로 이동
%>