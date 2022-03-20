<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.PhotoDao" %>
<%@ page import = "vo.Photo" %>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");	
	
	// 요청값
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));		
	String photoPw = request.getParameter("photoPw");	
	
	// -메소드 호출
	PhotoDao photoDao = new PhotoDao();
	Photo photo = new Photo();
	
	int row = photoDao.deletePhoto(photoNo, photoPw);

	// 디버깅
	if(row == 1) { // 반환 값이 1일 때 삭제 성공, photoList 이동
		System.out.println("[deletePhotoAction.jsp] 삭제 성공");
		response.sendRedirect(request.getContextPath()+"/photo/photoList.jsp");
	} else if(row == 0) { // 반환 값이 0일 때 삭제 실패, deletePhotoForm 이동
		System.out.println("[deletePhotoAction.jsp] 삭제 실패");
		response.sendRedirect(request.getContextPath()+"/photo/deletePhotoForm.jsp?photoNo=" + photoNo);
	} else { // 반환 값이 0, 1이 아닐 떄 에러
		System.out.println("[deletePhotoAction.jsp] 에러");
	}
		
	// -디버깅 코드
	System.out.println("[deletePhotoAction.jsp] photoNo : " + photo.photoNo);
	System.out.println("[deletePhotoAction.jsp] photoPw : " + photo.photoPw);
	System.out.println("[deletePhotoAction.jsp] row : " + row);
%>