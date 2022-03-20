<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.PhotoDao" %>
<%@ page import = "vo.Photo" %>
<%
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	PhotoDao photoDao = new PhotoDao();
	Photo photo = photoDao.selectPhotoOne(photoNo);
	
	// 디버깅
    System.out.println("[deletePhotoForm.jsp] photoNo : " + photo.photoNo);
    System.out.println("[deletePhotoForm.jsp] photoPw : " + photo.photoPw);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>deletePhotoForm</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class = "container">
	<div class="container p-3 my-3 bg-secondary text-white">
	<h1>photo delete</h1>
	</div>
	<!-- 이미지 삭제 -->
	<form method = "post" action = "<%= request.getContextPath() %>/photo/deletePhotoAction.jsp">
		<table class = "table table-active">
			<tr>
				<td>이미지 번호</td>
				<td><input type = "text" name = "photoNo" value = "<%= photo.photoNo %>"class="form-control" readonly></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type = "password" name = "photoPw" class="form-control"></td>
			</tr>
		</table>
		<button type = "submit" class = "btn btn-outline-dark">삭제</button>
		<a href="<%= request.getContextPath() %>/guestbook/guestbookList.jsp" class = "btn btn-outline-dark">이전 페이지</a>
	</form>
</div>
</body>
</html>