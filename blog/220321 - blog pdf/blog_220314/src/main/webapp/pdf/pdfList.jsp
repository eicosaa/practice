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

	PdfDao pdfDao = new PdfDao();
	ArrayList<Pdf> list = pdfDao.selectPdfListByPage(beginRow, rowPerPage);
	
	int lastPage = 0; // -마지막 페이지
	int totalCount = pdfDao.selectPdfTotalRow();
	lastPage = (int)(Math.ceil((double)totalCount / (double)rowPerPage)); 
%>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>pdfList</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class = "container">
	<!-- 메인 메뉴 -->
	<div class="container p-3 my-3 bg-dark text-white">
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	</div>
	
	<div class="container p-3 my-3 bg-secondary text-white">
	<h1>PDF 목록</h1>
	</div>
	
<div>
<%
	for(Pdf p : list) {
%>
		<table class = "table table-active">
			<tr>
				<td>
					<a href = "<%= request.getContextPath() %>/pdf/selectPdfOne.jsp?pdfNo=<%= p.pdfNo %>"> <%=p.pdfOriginalName%> </a>
				</td>
			</tr>
		</table>
<%
	}
%>
</div>

<div>
<%

	if(currentPage > 1) {
%>
		<a href = "<%= request.getContextPath() %>/pdf/pdfList.jsp?currentPage=<%= currentPage - 1 %>" class = "btn btn-outline-dark">이전</a>
<%
	}

	if(currentPage < lastPage) {
%>
		<a href = "<%= request.getContextPath() %>/pdf/pdfList.jsp?currentPage=<%= currentPage + 1 %>" class = "btn btn-outline-dark" >다음</a>
<%
	}
%>
		<a href="<%= request.getContextPath() %>/pdf/insertPdfForm.jsp" class = "btn btn-outline-dark">PDF 등록</a>
</div>
</body>
</html>