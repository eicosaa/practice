<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>insertPdfForm</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class = "container">
	<!-- 메인 메뉴 -->
	<div class="container p-3 my-3 bg-dark text-white">
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	</div>

	<div class="container p-3 my-3 bg-secondary text-white">
	<h1>PDF 등록</h1>
	</div>
	
<div>
	<form action="<%= request.getContextPath() %>/pdf/insertPdfAction.jsp" method="post" enctype="multipart/form-data">
		<table class = "table table-active">
			<tr>
				<td>PDF 파일</td>
				<td><input type="file" name="pdf"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="pdfPw"></td>
			</tr>
			<tr>
				<td>글쓴이</td>
				<td><input type="text" name="writer"></td>
			</tr>
		</table>
		<button type = "submit" class = "btn btn-outline-dark">PDF 등록</button>
		<a href="<%= request.getContextPath() %>/pdf/pdfList.jsp" class = "btn btn-outline-dark">이전 페이지</a>
	</form>
</div>
</body>
</html>