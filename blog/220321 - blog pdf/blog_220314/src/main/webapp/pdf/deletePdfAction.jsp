<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.PdfDao" %>
<%@ page import = "vo.Pdf" %>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");	
	
	// 요청값
	int pdfNo = Integer.parseInt(request.getParameter("pdfNo"));		
	String pdfPw = request.getParameter("pdfPw");	
	
	// -메소드 호출
	PdfDao pdfDao = new PdfDao();
	Pdf pdf = new Pdf();
	
	int row = pdfDao.deletePdf(pdfNo, pdfPw);

	// 디버깅
	if(row == 1) { // 반환 값이 1일 때 삭제 성공, photoList 이동
		System.out.println("[deletePdfAction.jsp] 삭제 성공");
		response.sendRedirect(request.getContextPath()+"/pdf/pdfList.jsp");
	} else if(row == 0) { // 반환 값이 0일 때 삭제 실패, deletePhotoForm 이동
		System.out.println("[deletePdfAction.jsp] 삭제 실패");
		response.sendRedirect(request.getContextPath()+"/pdf/deletePdfForm.jsp?pdfNo=" + pdfNo);
	} else { // 반환 값이 0, 1이 아닐 떄 에러
		System.out.println("[deletePdfAction.jsp] 에러");
	}
		
	// -디버깅 코드
	System.out.println("[deletePdfAction.jsp] pdfNo : " + pdf.pdfNo);
	System.out.println("[deletePdfAction.jsp] pdfPw : " + pdf.pdfPw);
	System.out.println("[deletePdfAction.jsp] row : " + row);
%>