<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	int pdfNo = Integer.parseInt(request.getParameter("pdfNo"));
	System.out.println("[selectPdfOne.jsp] pdfNo : " + pdfNo);
	
	PdfDao pdfDao = new PdfDao();
	Pdf pdf = pdfDao.selectPdfOne(pdfNo);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>selectPdfOne</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class = "container">
	<div class="container p-3 my-3 bg-secondary text-white">
	<h1>selectPdfOne</h1>
	</div>
	
	<table class = "table table-info">
		<tr>
			<td>pdfNo</td>
			<td class="table-warning"><%= pdf.pdfNo %></td>
		</tr>
		<tr>
			<td>pdf</td>
			<td class="table-warning"><a href="<%=request.getContextPath()%>/uploadPdf/<%=pdf.pdfOriginalName%>"><%=pdf.pdfOriginalName%></a></td>
		</tr>
		<tr>
			<td>writer</td>
			<td class="table-warning"><%= pdf.writer %></td>
		</tr>
		<tr>
			<td>createDate</td>
			<td class="table-warning"><%= pdf.createDate %></td>
		</tr>
	</table>
		<div>
			<a href="<%= request.getContextPath() %>/pdf/deletePdfForm.jsp?pdfNo=<%= pdf.pdfNo %>" class = "btn btn-outline-info">삭제</a>
			<a href="<%= request.getContextPath() %>/pdf/pdfList.jsp" class = "btn btn-outline-info">이전 페이지</a>
		</div>

</div>		
</body>
</html>