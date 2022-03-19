<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList" %>    
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	int beginRow = 0;
	int rowPerPage = 10;

	PhotoDao photoDao = new PhotoDao();
	ArrayList<Photo> list = photoDao.selectPhotoListByPage(beginRow, rowPerPage);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>photoList</title>
</head>
<body>
	<!-- 메인 메뉴 시작 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- include 시 -->
	<!-- 메인 메뉴 끝 -->
	
	<h1>이미지 목록</h1>
	<table border="1">
		<%
			for(Photo p : list) {
		%>
				<tr>
					<td>
						<a href = "<%= request.getContextPath() %>/photo/selectPhotoOne.jsp=photoNo=<%= p.photoNo %>">
							<img src="<%= request.getContextPath() %>/upload/<%= p.photoName %>" width = "200" height = "200">
							<!-- 상세보기에서는 원본 이미지 크기로 -->
						</a>
					</td>
				</tr>
		<%
			}
		%>
	</table>
</body>
</html>