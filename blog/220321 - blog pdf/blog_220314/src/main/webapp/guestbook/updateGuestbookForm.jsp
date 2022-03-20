<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "vo.Guestbook" %>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");
	
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	System.out.println("[updateGuestbookForm.jsp] guestbookNo : " + guestbookNo);
	
	GuestbookDao guestbookDao = new GuestbookDao();
	Guestbook guestbook = guestbookDao.selectGuestbookOne(guestbookNo);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	<title>updateGuestbookForm</title>
</head>
<body>
<div class = "container">
	<div class="container p-3 my-3 bg-secondary text-white">
	<h1>guestbook update</h1>
	</div>
	<!-- 방명록 수정 -->
	<form method = "post" action = "<%= request.getContextPath() %>/guestbook/updateGuestbookAction.jsp">
		<table class = "table table-active">
			<tr>
				<td>글 번호</td>
				<td><input type = "text" name = "guestbookNo" value = "<%= guestbook.guestbookNo %>" class="form-control" readonly></td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea name="guestbookContent" rows="5" cols="80" class="form-control"></textarea>
				</td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type = "password" name = "guestbookPw" class="form-control"></td>
			</tr>
		</table>
		<button type = "submit" class = "btn btn-outline-dark">수정</button>
		<a href="<%= request.getContextPath() %>/guestbook/guestbookList.jsp" class = "btn btn-outline-dark">이전 페이지</a>
	</form>
</div>
</body>
</html>