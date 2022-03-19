<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "vo.Guestbook" %>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");	

	// -메소드 호출
	GuestbookDao guestbookDao = new GuestbookDao();
	Guestbook guestbook = new Guestbook();
	
	// 요청값
	guestbook.guestbookContent = request.getParameter("guestbookContent");	
	guestbook.guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));	
	guestbook.guestbookPw = request.getParameter("guestbookPw");	
	
	guestbookDao.updateGuestbook(guestbook);
		
	// -디버깅 코드
	System.out.println("[updateGuestbookAction.jsp] guestbookContent : " + guestbook.guestbookContent);
	System.out.println("[updateGuestbookAction.jsp] guestbookNo : " + guestbook.guestbookNo);
	System.out.println("[updateGuestbookAction.jsp] guestbookPw : " + guestbook.guestbookPw);

	// -페이지 이동
	response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");
%>