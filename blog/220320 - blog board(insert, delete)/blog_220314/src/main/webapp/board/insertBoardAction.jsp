<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// -인코딩
	request.setCharacterEncoding("utf-8");

	// -메소드 호출
	BoardDao boardDao = new BoardDao();
	Board board = new Board();
	
	// -요청값 / insertBoardForm 페이지에서 보낸 파라미터(매개변수) 값 변수에 저장
	board.categoryName = request.getParameter("categoryName");	
	board.boardTitle = request.getParameter("boardTitle");	
	board.boardContent = request.getParameter("boardContent");
	board.boardPw = request.getParameter("boardPw");
	
	boardDao.insertBoard(board);

	// -디버깅 코드
	System.out.println("[insertBoardAction.jsp] categoryName : " + board.categoryName);
	System.out.println("[insertBoardAction.jsp] boardTitle : " + board.boardTitle);
	System.out.println("[insertBoardAction.jsp] boardContent : " + board.boardContent);
	System.out.println("[insertBoardAction.jsp] boardPw : " + board.boardPw);
	
	response.sendRedirect(request.getContextPath() + "/board/boardList.jsp"); // 재요청 / 입력 실패하거나 성공 후 boardList.jsp로 이동
%>