<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 다른 페이지의 부분으로 사용되는 페이지 -->
<div>
	<a href="<%= request.getContextPath() %>/index.jsp">홈으로</a>
	<a href="<%= request.getContextPath() %>/board/boardList.jsp">게시판</a>
	<a href="<%= request.getContextPath() %>/photo/photoList.jsp">사진</a>
	<a href="<%= request.getContextPath() %>/guestbook/guestbookList.jsp">방명록</a>
	<a href="<%= request.getContextPath() %>/pdf/pdfList.jsp">PDF</a>
</div>