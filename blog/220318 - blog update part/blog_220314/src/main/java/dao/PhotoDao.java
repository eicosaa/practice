package dao;

import java.util.ArrayList;

import vo.Photo;

public class PhotoDao {
	
	// 이미지 입력
	public void insertPhoto(Photo photo) {
		// 구현
	}
	
	// 이미지 삭제
	public int deletePhoto(int photoNo, String photoPw) {
		int row = 0;
		return row;
	}
	
	// 이미지 목록
	public ArrayList<Photo> selectPhotoListByPage(int beginRow, int rowPerPage) {
		ArrayList<Photo> list = new ArrayList<Photo>();
		return list;
	}
	
	// 이미지 하나 상세보기
	public Photo selectPhotoOne(int photoNo) {
		Photo photo = null;
		return photo;
	}
	
	// 전체 행의 수
	public int selectPhotoTotalRow() {
		int total = 0;
		return total;
	}
	
	// 수정은 삭제 후 새로 입력
}
