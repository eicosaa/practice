<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	System.out.println("[selectPhotoOne.jsp] photoNo : " + photoNo);
	
	PhotoDao photoDao = new PhotoDao();
	Photo photo = photoDao.selectPhotoOne(photoNo);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>selectPhotoOne</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class = "container">
	<div class="container p-3 my-3 bg-secondary text-white">
	<h1>selectPhotoOne</h1>
	</div>
	
	<table class = "table table-info">
		<tr>
			<td>photoNo</td>
			<td class="table-warning"><%= photo.photoNo %></td>
		</tr>
		<tr>
			<td>photo</td>
			<td class="table-warning"><img src="<%= request.getContextPath() %>/upload/<%= photo.photoOriginalName %>"></td>
		</tr>
		<tr>
			<td>writer</td>
			<td class="table-warning"><%= photo.writer %></td>
		</tr>
		<tr>
			<td>createDate</td>
			<td class="table-warning"><%= photo.createDate %></td>
		</tr>
	</table>
		<div>
			<a href="<%= request.getContextPath() %>/photo/deletePhotoForm.jsp?photoNo=<%= photo.photoNo %>" class = "btn btn-outline-info">삭제</a>
			<a href="<%= request.getContextPath() %>/photo/photoList.jsp" class = "btn btn-outline-info">이전 페이지</a>
		</div>

</div>		
</body>
</html>