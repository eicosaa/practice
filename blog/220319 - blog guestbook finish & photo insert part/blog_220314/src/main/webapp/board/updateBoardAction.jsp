<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import="java.util.ArrayList"%>    
<%
	/*
	updateBoardAction 수정 쿼리문
	
	UPDATE board SET
		category_name = ?,
		board_title = ?,
		board_content = ?,
		update_Date = NOW()
	WHERE board_no = ? AND board_pw = ?
	*/
	
	// -인코딩
	request.setCharacterEncoding("utf-8");
	
	// ---------------------------updateBoardForm 페이지에서 보낸 파라미터 값 변수에 저장
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String categoryName = request.getParameter("categoryName");	
	String boardTitle = request.getParameter("boardTitle");	
	String boardContent = request.getParameter("boardContent");	
	String boardPw = request.getParameter("boardPw");	
	System.out.println("[updateBoardAction.jsp] boardNo : " + boardNo);
	System.out.println("[updateBoardAction.jsp] categoryName : " + categoryName);
	System.out.println("[updateBoardAction.jsp] boardTitle : " + boardTitle);
	System.out.println("[updateBoardAction.jsp] boardContent : " + boardContent);
	System.out.println("[updateBoardAction.jsp] boardPw : " + boardPw);
	
	// -요청에서 넘겨진 값들을 가공
	Board board = new Board();
	board.boardNo = boardNo;
	board.boardTitle = boardTitle;
	board.boardContent = boardContent;
	board.boardPw = boardPw;
	
	// -----------------------------------mariadb 드라이버 로딩 + mariadb RDBMS 접속
	Class.forName("org.mariadb.jdbc.Driver"); // 드라이버 로딩
	Connection conn = null;
	String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
	String dbuser = "root"; // DB 아이디
	String dbpw = "java1234"; // DB 패스워드
	conn = DriverManager.getConnection(dburl, dbuser, dbpw);
	System.out.println("[updateBoardAction.jsp] conn : " + conn + " / 드라이버 로딩 성공");
	
	// ---------------------------------------------------------------------쿼리
	// -쿼리 저장
	PreparedStatement stmt = conn.prepareStatement("UPDATE board SET category_name = ?, board_title = ?, board_content = ?, update_Date = NOW() WHERE board_no = ? AND board_pw = ?");
	// -사용자가 선택해서 넘어온 ?값
	stmt.setString(1, categoryName); 
	stmt.setString(2, boardTitle);
	stmt.setString(3, boardContent);
	stmt.setInt(4, boardNo); 
	stmt.setString(5, boardPw);
	
	// -수행결과 int 타입의 값 반환하는 executeUpdate를 사용하여 몇 행을 입력했는지 return
	int row = stmt.executeUpdate();
	// 디버깅
	if(row == 0) { // 행의 변화(쿼리의 수행 결과)가 없으면 수정 실패, form으로 돌아간다.
		System.out.println("update 실패");
		response.sendRedirect(request.getContextPath() + "/updateBoardForm.jsp?boardNo=" + board.boardNo);
	} else if(row == 1) { // 행의 변화(쿼리의 수행 결과)가 있으면 수정 성공
		System.out.println("update 성공");
		response.sendRedirect(request.getContextPath() + "/boardOne.jsp?boardNo=" + board.boardNo);
	} else { // 행의 변화(쿼리의 수행 결과)가 0이나 1이 아닌 수는 에러
		System.out.println("update 에러(updateBoardAction.jsp)");
	}
	
	conn.close();
%>
