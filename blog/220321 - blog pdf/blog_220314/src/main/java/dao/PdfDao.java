package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import vo.Pdf;

public class PdfDao {
	public PdfDao() { } // -생성자 메소드
	
	// 입력
	public void insertPdf(Pdf pdf) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3307/blog"; // 주소
		String dbuser = "root"; // 아이디
		String dbpw = "java1234"; // 패스워드
		String sql = "INSERT INTO pdf(pdf_name, pdf_original_name, pdf_type, pdf_pw, writer, create_date, update_date) VALUES(?, ?, ?, ?, ?, NOW(), NOW())";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		System.out.println("[insertPdf] conn : " + conn + " / 드라이버 로딩 성공");
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, pdf.pdfName);
		stmt.setString(2, pdf.pdfOriginalName);
		stmt.setString(3, pdf.pdfType);
		stmt.setString(4, pdf.pdfPw);
		stmt.setString(5, pdf.writer);
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("[insertPdf] 입력 성공");
		} else {
			System.out.println("[insertPdf] 입력 실패");
		}
		stmt.close();
		conn.close();
	}
	
	// 삭제
	public int deletePdf(int pdfNo, String pdfPw) throws Exception {
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3307/blog"; // 주소
		String dbuser = "root"; // 아이디
		String dbpw = "java1234"; // 패스워드
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		System.out.println("[deletePdf] conn : " + conn + " / 드라이버 로딩 성공");
		
		String sql = "DELETE FROM pdf WHERE pdf_no = ? AND pdf_pw = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, pdfNo);
		stmt.setString(2, pdfPw);
		
		System.out.println("[Dao.deletepdf] sql : " + stmt);
		row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		return row;
	}
	
	// 상세보기
	public Pdf selectPdfOne(int pdfNo) throws Exception {
		Pdf pdf = null;
		
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3307/blog"; // 주소
		String dbuser = "root"; // 아이디
		String dbpw = "java1234"; // 패스워드
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		System.out.println("[selectPdfOne] conn : " + conn + " / 드라이버 로딩 성공");
		
		String sql = "SELECT pdf_no pdfNo, pdf_original_name pdfOriginalName, writer, create_date createDate FROM pdf WHERE pdf_no = ? ORDER BY create_date DESC";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, pdfNo);
		System.out.println("[Dao.selectpdfOne] sql : " + stmt);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			pdf = new Pdf(); // 생성자메서드
			pdf.pdfNo = rs.getInt("pdfNo");
			pdf.pdfOriginalName = rs.getString("pdfOriginalName");
			pdf.writer = rs.getString("writer");
			pdf.createDate = rs.getString("createDate");
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return pdf;
	}
	
	// 목록 (n행씩 반환)
	public ArrayList<Pdf> selectPdfListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Pdf> list = new ArrayList<Pdf>();
		
		// 10행 반환되도록 구현
		Class.forName("org.mariadb.jdbc.Driver"); // -드라이버 로딩
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3307/blog"; // 주소
		String dbuser = "root"; // 아이디
		String dbpw = "java1234"; // 패스워드
		String sql = "SELECT pdf_no pdfNo, pdf_original_name pdfOriginalName, writer, create_date createDate FROM pdf ORDER BY create_date DESC LIMIT ?, ?";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		System.out.println("[selectPdfListByPage] conn : " + conn + " / 드라이버 로딩 성공");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		// 데이터베이스 로직 끝
		
		// 데이터 변환(가공)
		while(rs.next()) {
			Pdf p = new Pdf();
			p.pdfNo = rs.getInt("pdfNo");
			p.pdfOriginalName = rs.getString("pdfOriginalName");
			p.writer = rs.getString("writer");
			p.createDate = rs.getString("createDate");
			list.add(p);
		}
		
		// 데이터베이스 자원들 반환
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	// 전체 행의 수
	public int selectPdfTotalRow() throws Exception {
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3307/blog"; // 주소
		String dbuser = "root"; // 아이디
		String dbpw = "java1234"; // 패스워드
		
		String sql = "SELECT COUNT(*) cnt FROM pdf";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		System.out.println("[selectPdfTotalRow] conn : " + conn + " / 드라이버 로딩 성공");
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("cnt");
		}
		return row;
	}
	
}
