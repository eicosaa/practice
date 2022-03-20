<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@page import="vo.*"%>
<%@page import="dao.*"%>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");	
	
	// 요청값 / deleteBoardForm 페이지에서 보낸 파라미터(매개변수) 값 변수에 저장 및 가공
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));		
	String boardPw = request.getParameter("boardPw");	
	
	// -메소드 호출
	BoardDao boardDao = new BoardDao();
	Board board = new Board();
	
	// -쿼리수행결과 int 타입의 값 반환하는 executeUpdate를 사용하여 몇 행을 입력했는지 return
	int row = boardDao.deleteBoard(boardNo, boardPw);

	// 디버깅
	if(row == 1) { // 반환 값이 1일 때 삭제 성공, guestbookList 이동
		System.out.println("[deleteBoardkAction.jsp] 삭제 성공");
		response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
	} else if(row == 0) { // 반환 값이 0일 때 삭제 실패, deleteGuestbookForm 이동
		System.out.println("[deleteBoardAction.jsp] 삭제 실패");
		response.sendRedirect(request.getContextPath()+"/board/deleteBoardForm.jsp?boardNo=" + boardNo);
	} else { // 반환 값이 0, 1이 아닐 떄 에러
		System.out.println("[deleteBoardAction.jsp] 삭제 에러");
	}
		
	// -디버깅 코드
	System.out.println("[deleteBoardAction.jsp] boardNo : " + boardNo);
	System.out.println("[deleteBoardAction.jsp] boardPw : " + boardPw);
	System.out.println("[deleteBoardAction.jsp] row : " + row);
%>