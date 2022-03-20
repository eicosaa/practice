<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.io.File" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%

	request.setCharacterEncoding("utf-8");
	// DefaultFileRenamePolicy rp = new DefaultFileRenamePolicy(); -동일한 이름이 존재할 때 알아서 바꿔줌
	String path = application.getRealPath("uploadPdf"); // application변수는 톰캣을 가르키는 변수
	
	MultipartRequest multiReq = new MultipartRequest(request, path, 1024*1024*100, "utf-8", new DefaultFileRenamePolicy());
	// 2^10 byte = 1 kbyte 1024byte = 1kbte
	// 2^10 kbyte = 1 mbyte
	// 100 mbyte = 1024*1024*100 byte = 104857600 byte 곱셈을 계산해서 코딩하면 가독성이 떨어진다. ex) 24*60*60 하루에 대한 초
	
	String pdfPw = multiReq.getParameter("pdfPw");
	String writer = multiReq.getParameter("writer");
	
	// input type="file" name="pdf"에 대한 처리
	String pdfOriginalName = multiReq.getOriginalFileName("pdf"); // 파일 업로드 시 원본의 이름
	String pdfName = multiReq.getOriginalFileName("pdf"); // new DefaultFileRenamePolicy()객체를 통해 변경된 이름
	String pdfType = multiReq.getContentType("pdf");
	
	System.out.println("[insertPdfAction.jsp] pdfPw : " + pdfPw);
	System.out.println("[insertPdfAction.jsp] writer : " + writer);
	System.out.println("[insertPdfAction.jsp] pdfOriginalName : " + pdfOriginalName);
	System.out.println("[insertPdfAction.jsp] pdfName : " + pdfName);
	System.out.println("[insertPdfAction.jsp] pdfType : " + pdfType);
	
	// 파일 업로드의 경우 100mbyte 이하의 image/gif, image/png, image/jpeg 3가지 이미지만 허용
	if(pdfType.equals("application/pdf")) {
		// db에 저장
		System.out.println("db에 저장되었습니다.");
		
		PdfDao pdfDao = new PdfDao();
		Pdf pdf = new Pdf();
		
		pdf.pdfName = pdfName;
		pdf.pdfOriginalName = pdfOriginalName;
		pdf.pdfType = pdfType;
		pdf.pdfPw = pdfPw;
		pdf.writer = writer;
		
		pdfDao.insertPdf(pdf); // 메서드 구현
		
		response.sendRedirect(request.getContextPath() + "/pdf/pdfList.jsp");
	} else {
		// 업로드 취소
		System.out.println("pdf 파일만 올려주세요.");
		// 잘못 들어온 파일이므로 업로드된 파일을 지우고 form으로 이동
		File file = new File(path + "\\" + pdfName); // java.io.File / 잘못된 파일을 불러온다.
		file.delete(); // 잘못 업로드된 파일을 삭제
		response.sendRedirect(request.getContextPath() + "/pdf/insertPdfForm.jsp");
	}
	
	// -c:\\test -> 2번의 역슬래시(\\)가 하나의 역슬래시(\)이다.  [\\] == [\]
%>