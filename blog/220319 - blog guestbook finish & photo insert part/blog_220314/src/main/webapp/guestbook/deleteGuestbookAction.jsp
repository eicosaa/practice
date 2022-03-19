<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "vo.Guestbook" %>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");	
	
	// 요청값
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));		
	String guestbookPw = request.getParameter("guestbookPw");	
	
	// -메소드 호출
	GuestbookDao guestbookDao = new GuestbookDao();
	Guestbook guestbook = new Guestbook();
	
	int row = guestbookDao.deleteGuestbook(guestbookNo, guestbookPw);

	// 디버깅
	if(row == 1) { // 반환 값이 1일 때 삭제 성공, guestbookList 이동
		System.out.println("삭제 성공");
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");
	} else if(row == 0) { // 반환 값이 0일 때 삭제 실패, deleteGuestbookForm 이동
		System.out.println("삭제 실패");
		response.sendRedirect(request.getContextPath()+"/guestbook/deleteGuestbookForm.jsp?guestbookNo=" + guestbookNo);
	} else { // 반환 값이 0, 1이 아닐 떄 에러
		System.out.println("에러");
	}
		
	// -디버깅 코드
	System.out.println("[deleteGuestbookAction.jsp] guestbookNo : " + guestbook.guestbookNo);
	System.out.println("[deleteGuestbookAction.jsp] guestbookPw : " + guestbook.guestbookPw);
	System.out.println("[deleteGuestbookAction.jsp] row : " + row);
%>