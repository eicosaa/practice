package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import vo.Board;
import vo.Photo;

public class BoardDao {
	public BoardDao() { } // -생성자 메소드
	
	// 입력
	public void insertBoard(Board board) throws Exception {
		//-----------------------------------mariadb 드라이버 로딩 + mariadb RDBMS 접속
		Class.forName("org.mariadb.jdbc.Driver"); // 드라이버 로딩
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3307/blog"; // 주소
		String dbuser = "root"; // 아이디
		String dbpw = "java1234"; // 패스워드
		String sql = "INSERT INTO board(category_name, board_title,	board_content, board_pw, create_date, update_date) VALUES (?, ?, ?, ?, NOW(), NOW())";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // -드라이버 연결하여 conn 변수에 저장
		System.out.println("[insertBoard] conn : " + conn + " / 드라이버 로딩 성공");
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, board.categoryName);
		stmt.setString(2, board.boardTitle);
		stmt.setString(3, board.boardContent);
		stmt.setString(4, board.boardPw);
		
		// -수행결과 int 타입의 값 반환하는 executeUpdate를 사용하여 몇 행을 입력했는지 return
		int row = stmt.executeUpdate();
		// 디버깅
		if(row == 1) {
			System.out.println("[insertBoard] " + row + "행 입력 성공");
		} else {
			System.out.println("[insertBoard] 입력 실패");
		}
		
		stmt.close();
		conn.close(); // -Connection 객체는 사용이 끝나면 반납	
	}
	
	// 수정
	public int updateBoard(Board board) throws Exception {
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3307/blog"; // 주소
		String dbuser = "root"; // 아이디
		String dbpw = "java1234"; // 패스워드
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		System.out.println("[updateBoard] conn : " + conn + " / 드라이버 로딩 성공");
		
		String sql = "UPDATE board SET category_name = ?, board_title = ?, board_content = ?, update_Date = NOW() WHERE board_no = ? AND board_pw = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, board.categoryName); 
		stmt.setString(2, board.boardTitle);
		stmt.setString(3, board.boardContent);
		stmt.setInt(4, board.boardNo); 
		stmt.setString(5, board.boardPw);
		System.out.println("[Dao.insertBoard] sql : " + stmt);
		row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		
		return row;
	}
	
	// 삭제
	public int deleteBoard(int boardNo, String boardPw) throws Exception {
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3307/blog"; // 주소
		String dbuser = "root"; // 아이디
		String dbpw = "java1234"; // 패스워드
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		System.out.println("[deleteBoard] conn : " + conn + " / 드라이버 로딩 성공");
		
		String sql = "DELETE FROM board WHERE board_no = ? AND board_pw = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, boardNo);
		stmt.setString(2, boardPw);
		
		System.out.println("[Dao.deleteBoard] sql : " + stmt);
		row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		return row;
	}
	
	// 상세보기
	public Board selectBoardOne(int boardNo) throws Exception {
		Board board = null;
		
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3307/blog"; // 주소
		String dbuser = "root"; // 아이디
		String dbpw = "java1234"; // 패스워드
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		System.out.println("[selectBoardOne] conn : " + conn + " / 드라이버 로딩 성공");
		
		String sql = "SELECT board_no boardNo, category_name categoryName, board_content boardContent, board_title boardTitle, create_date createDate, update_date updateDate FROM board where board_no = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, boardNo);
		System.out.println("[Dao.selectBoardOne] sql : " + stmt);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			board = new Board(); // 생성자메서드
			board.boardNo = rs.getInt("photoNo");
			board.boardTitle = rs.getString("boardTitle");
			board.categoryName = rs.getString("categoryName");
			board.boardContent = rs.getString("boardContent");
			board.createDate = rs.getString("createDate");
			board.updateDate = rs.getString("updateDate");

		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return board;
	}
	
	// 목록 (n행씩 반환)
	public ArrayList<Board> selectBoardListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Board> list = new ArrayList<Board>();
		
		// 10행 반환되도록 구현
		Class.forName("org.mariadb.jdbc.Driver"); // -드라이버 로딩
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3307/blog"; // 주소
		String dbuser = "root"; // 아이디
		String dbpw = "java1234"; // 패스워드
		String sql = "SELECT  create_date createDate FROM board ORDER BY create_date DESC LIMIT ?, ?";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		System.out.println("[selectBoardListByPage] conn : " + conn + " / 드라이버 로딩 성공");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		// 데이터베이스 로직 끝
		
		// 데이터 변환(가공)
		while(rs.next()) {
			Board b = new Board();
			b.boardNo = rs.getInt("boardNo");
			b.createDate = rs.getString("createDate");
			list.add(b);
		}
		
		// 데이터베이스 자원들 반환
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	// 전체 행의 수
	public int selectBoardTotalRow() throws Exception {
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3307/blog"; // 주소
		String dbuser = "root"; // 아이디
		String dbpw = "java1234"; // 패스워드
		
		String sql = "SELECT COUNT(*) cnt FROM board";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		System.out.println("[selectBoardTotalRow] conn : " + conn + " / 드라이버 로딩 성공");
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("cnt");
		}
		return row;
	}
	
}
