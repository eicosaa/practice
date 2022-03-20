<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.PdfDao" %>
<%@ page import = "vo.Pdf" %>
<%
	int pdfNo = Integer.parseInt(request.getParameter("pdfNo"));
	PdfDao photoDao = new PdfDao();
	Pdf pdf = photoDao.selectPdfOne(pdfNo);
	
	// 디버깅
    System.out.println("[deletePdfForm.jsp] pdfNo : " + pdf.pdfNo);
    System.out.println("[deletePdfForm.jsp] pdfPw : " + pdf.pdfPw);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>deletePdfForm</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class = "container">
	<div class="container p-3 my-3 bg-secondary text-white">
	<h1>pdf delete</h1>
	</div>
	<!-- 이미지 삭제 -->
	<form method = "post" action = "<%= request.getContextPath() %>/pdf/deletePdfAction.jsp">
		<table class = "table table-active">
			<tr>
				<td>PDF 번호</td>
				<td><input type = "text" name = "pdfNo" value = "<%= pdf.pdfNo %>"class="form-control" readonly></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type = "password" name = "pdfPw" class="form-control"></td>
			</tr>
		</table>
		<button type = "submit" class = "btn btn-outline-dark">삭제</button>
		<a href="<%= request.getContextPath() %>/pdf/pdfList.jsp" class = "btn btn-outline-dark">이전 페이지</a>
	</form>
</div>
</body>
</html>