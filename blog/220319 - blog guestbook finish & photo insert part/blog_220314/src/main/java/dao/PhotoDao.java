package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.ArrayList;

import vo.Photo;

public class PhotoDao {
	
	// 이미지 입력
	public void insertPhoto(Photo photo) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3307/blog"; // 주소
		String dbuser = "root"; // 아이디
		String dbpw = "java1234"; // 패스워드
		String sql = "INSERT INTO photo(photo_name, photo_original_name, photo_type, photo_pw, writer, create_date, update_date) VALUES(?, ?, ?, ?, ?, NOW(), NOW())";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		System.out.println("[insertPhoto] conn : " + conn + " / 드라이버 로딩 성공");
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, photo.photoName);
		stmt.setString(2, photo.photoOriginalName);
		stmt.setString(3, photo.photoType);
		stmt.setString(4, photo.photoPw);
		stmt.setString(5, photo.writer);
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("[insertPhoto] 입력 성공");
		} else {
			System.out.println("[insertPhoto] 입력 실패");
		}
		stmt.close();
		conn.close();
	}
	
	// 이미지 삭제
	public int deletePhoto(int photoNo, String photoPw) throws Exception {
		int row = 0;
		return row;
	}
	
	// 이미지 목록
	public ArrayList<Photo> selectPhotoListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Photo> list = new ArrayList<Photo>();
		return list;
	}
	
	// 이미지 하나 상세보기
	public Photo selectPhotoOne(int photoNo) throws Exception {
		Photo photo = null;
		return photo;
	}
	
	// 전체 행의 수
	public int selectPhotoTotalRow() throws Exception {
		int total = 0;
		return total;
	}
	
	// 수정은 삭제 후 새로 입력
}
