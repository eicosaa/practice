<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@page import="vo.*"%>
<%

	//--------------deleteBoardForm 페이지에서 보낸 파라미터(매개변수) 값 변수에 저장 및 가공
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String boardPw = request.getParameter("boardPw");
	System.out.println("[deleteBoardAction.jsp] boardNo : " + boardNo);
	System.out.println("[deleteBoardAction.jsp] boardPw : " + boardPw);
	
	// -요청에서 넘겨진 값들을 가공
	Board board = new Board();
	board.boardNo = boardNo;
	board.boardPw = boardPw;
	
	//------------------------------------mariadb 드라이버 로딩 + mariadb RDBMS 접속
	Class.forName("org.mariadb.jdbc.Driver"); // 드라이버 로딩
	Connection conn = null;
	String dburl = "jdbc:mariadb://localhost:3306/blog"; // 주소
	String dbuser = "root"; // 아이디
	String dbpw = "java1234"; // 패스워드
	conn = DriverManager.getConnection(dburl, dbuser, dbpw);
	System.out.println("[deleteBoardAction.jsp] conn : " + conn + " / 드라이버 로딩 성공");
	
	// ---------------------------------------------------------------------쿼리
	// -데이터베이스에 deleteBoardForm에서 넘어온 데이터를 저장하기 위한 쿼리
	PreparedStatement stmt = conn.prepareStatement("delete from board where board_no=? and board_pw=?");
	stmt.setInt(1, board.boardNo);
	stmt.setString(2, board.boardPw);
	
	// -쿼리수행결과 int 타입의 값 반환하는 executeUpdate를 사용하여 몇 행을 입력했는지 return
	int row = stmt.executeUpdate();

	if(row == 0) { // 삭제 실패
		System.out.println("삭제 실패");
		response.sendRedirect(request.getContextPath() + "/deleteBoardForm.jsp?boardNo=" + board.boardNo);
		// -deleteBoardForm.jsp로 가면 boardNo을 넘겨받기에 boardNo 추가
	} else if(row == 1) { // 삭제 성공
		System.out.println("[deleteBoardAction.jsp] 삭제 성공");
		response.sendRedirect("./boardList.jsp");
	} else { // 여러 행이 삭제되면 에러
		System.out.println("[deleteBoardAction.jsp] 삭제 에러");
	}
	
	conn.close(); // -사용이 끝난 Connection 객체 반납
%>