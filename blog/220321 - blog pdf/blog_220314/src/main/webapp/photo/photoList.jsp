<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList" %>    
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	int currentPage = 1; // -현재 페이지
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5; // -페이지 당 보여줄 글의 수
	int beginRow = (currentPage - 1) * rowPerPage; // -시작 행 / beginRow는 currentPage에 따라 달라짐

	PhotoDao photoDao = new PhotoDao();
	ArrayList<Photo> list = photoDao.selectPhotoListByPage(beginRow, rowPerPage);
	
	int lastPage = 0; // -마지막 페이지
	int totalCount = photoDao.selectPhotoTotalRow();
	lastPage = (int)(Math.ceil((double)totalCount / (double)rowPerPage)); 
%>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>photoList</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class = "container">
	<!-- 메인 메뉴 -->
	<div class="container p-3 my-3 bg-dark text-white">
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	</div>
	<!-- include 시 컨텍스명(프로젝트이름)을 명시하지 않는다. -->
	<!-- 메인 메뉴 끝 -->
	<!-- -include는 내부 호출이기에 request.getContextPath() 사용 불가 -->
	<div class="container p-3 my-3 bg-secondary text-white">
	<h1>이미지 목록</h1>
	</div>
<div>
<%
	for(Photo p : list) {
%>
		<table class = "table table-active">
			<tr>
				<td>
					<a href = "<%= request.getContextPath() %>/photo/selectPhotoOne.jsp?photoNo=<%= p.photoNo %>">
						<img src="<%= request.getContextPath() %>/upload/<%= p.photoOriginalName %>" width = "200" height = "200">
						<!-- 상세보기에서는 원본 이미지 크기로 -->
					</a>
				</td>
			</tr>
		</table>
<%
	}
%>
<div>
<%

	if(currentPage > 1) {
%>
		<a href = "<%= request.getContextPath() %>/photo/photoList.jsp?currentPage=<%= currentPage - 1 %>" class = "btn btn-outline-dark">이전</a>
<%
	}

	if(currentPage < lastPage) {
%>
		<a href = "<%= request.getContextPath() %>/photo/photoList.jsp?currentPage=<%= currentPage + 1 %>" class = "btn btn-outline-dark" >다음</a>
<%
	}
%>
		<a href="<%= request.getContextPath() %>/photo/insertPhotoForm.jsp" class = "btn btn-outline-dark">이미지 등록</a>
</div>
</body>
</html>