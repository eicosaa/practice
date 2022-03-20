<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>index</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<h1>
			<div class="text-center">HOME</div>
		</h1>
		<table class="table table-bordered text-center table-striped">
				<tr>
					<td><a href="<%= request.getContextPath() %>/board/boardList.jsp">게시판</a></td>
				</tr>
				<tr>
					<td><a href="<%= request.getContextPath() %>/guestbook/guestbookList.jsp">방명록</a></td>
				</tr>
				<tr>
					<td><a href="<%= request.getContextPath() %>/photo/photoList.jsp">사진</a></td>
				</tr>
				<tr>
					<td><a href="<%= request.getContextPath() %>/pdf/pdfList.jsp">PDF자료실</a></td>
				</tr>
		</table>
	</div>
</body>
</html>