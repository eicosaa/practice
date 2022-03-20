<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//-----------------------------------boardOne 페이지에서 보낸 파라미터 값 변수에 저장
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
%>   
 
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>deleteBoardForm</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class = "container">
	<div class="container p-3 my-3 bg-dark text-white">
	<h1>글 삭제</h1>
	</div>
	<form method="post" action="<%= request.getContextPath() %>/board/deleteBoardAction.jsp">
		<table class = "table table-primary">
			<tr>
				<td> 글 번호 </td>
				<td> <input type="text" name="boardNo" value="<%=boardNo%>" readonly="readonly" class="form-control"> </td>
			</tr>
			<tr>
				<td> 비밀번호 </td>
				<td> <input type="password" name="boardPw" class="form-control"> </td>
			</tr>
		</table>
		<div>
			<button type="submit" class="btn btn-outline-info">삭제</button>
			<a href="<%=request.getContextPath()%>/board/boardList.jsp" class = "btn btn-outline-info">이전 페이지</a>
		</div>
	</form>
</div>
</body>
</html>