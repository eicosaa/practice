<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "vo.Guestbook" %>
<%
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	GuestbookDao guestbookDao = new GuestbookDao();
	Guestbook guestbook = guestbookDao.selectGuestbookOne(guestbookNo);
	
	// 디버깅
    System.out.println("[deleteGuestbookForm.jsp] guestbookNo : " + guestbook.guestbookNo);
    System.out.println("[deleteGuestbookForm.jsp] guestbookPw : " + guestbook.guestbookPw);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	<title>deleteGuestbookForm</title>
</head>
<body>
<div class = "container">
	<div class="container p-3 my-3 bg-secondary text-white">
	<h1>guestbook delete</h1>
	</div>
	<!-- 방명록 삭제 -->
	<form method = "post" action = "<%= request.getContextPath() %>/guestbook/deleteGuestbookAction.jsp">
		<table class = "table table-active">
			<tr>
				<td>글 번호</td>
				<td><input type = "text" name = "guestbookNo" value = "<%= guestbook.guestbookNo %>"class="form-control" readonly></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type = "password" name = "guestbookPw" class="form-control"></td>
			</tr>
		</table>
		<button type = "submit" class = "btn btn-outline-dark">삭제</button>
		<a href="<%= request.getContextPath() %>/guestbook/guestbookList.jsp" class = "btn btn-outline-dark">이전 페이지</a>
	</form>
</div>
</body>
</html>