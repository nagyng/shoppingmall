package mvc.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import mvc.database.DBConnection;

public class QnaDAO {

	private static QnaDAO instance;
	
	private QnaDAO() {
		
	}

	public static QnaDAO getInstance() {
		if (instance == null)
			instance = new QnaDAO();
		return instance;
	}	
	//  테이블의 레코드 개수
	public int getListCount(String items, String text) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		String sql;

		/*검색구분 x, 검색문자열x => 전체검색*/
		if (items == null && text == null)
			sql = "select  count(*) from qna";
		else
			sql = "SELECT   count(*) FROM qna where " + items + " like '%" + text + "%'";
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) 
				x = rs.getInt(1);
			
		} catch (Exception ex) {
			System.out.println("getListCount() 예외발생: " + ex);
		} finally {			
			try {				
				if (rs != null) 
					rs.close();							
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();												
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}		
		return x;
	}
	//  테이블의 레코드 가져오기	
		//매개변수: 현재 페이지 번호, 한 페이지 당 행 개수, 검색 분류(작성자,제목,..), 검색할 문자열 
	public ArrayList<QnaDTO> getQnaList(int page, int limit, String items, String text) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		/*검색 조건에 따른 총 건수 계산*/
		int total_record = getListCount(items, text );
		/*시작페이지*/
		int start = (page - 1) * limit;
		int index = start + 1;

		String sql;

		/*(검색 내용 없음) 게시물 전체 검색*/
		if (items == null && text == null)
			sql = "select * from qna ORDER BY qna_no DESC";		//최신글부터
		else
			sql = "SELECT  * FROM qna where " + items + " like '%" + text + "%' ORDER BY qna_no DESC ";

		/*리스트에 담기 */
		ArrayList<QnaDTO> list = new ArrayList<QnaDTO>();
	
		try { 
			conn = DBConnection.getConnection();
			
 			pstmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = pstmt.executeQuery(); 
			while (rs.absolute(index)) {
				QnaDTO qna = new QnaDTO();
				qna.setQna_no(rs.getInt("qna_no"));
				qna.setUser_id(rs.getString("user_id"));
				qna.setQna_title(rs.getString("qna_title"));
				qna.setQna_content(rs.getString("qna_content")); 
				qna.setCreatetime(rs.getTimestamp("createtime"));				//날짜 가져오기는 .getTimestamp()
				qna.setUpdatetime(rs.getTimestamp("updatetime")); 
				 
				list.add(qna); 
				
				/*조회된 총 건 수와 비교하여 index값을 증가시킨다 */
				if (index < (start + limit) && index <= total_record) {
					index++;
				}else {
					break;
				}
			}
			return list;
		} catch (Exception ex) {
			System.out.println("getQnaList() 예외발생 : " + ex);
		} finally {
			try {
				if (rs != null) 
					rs.close();							
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}			
		}
		return null;
	}
	//  테이블에서 인증된 id 의 사용자명 가져오기
	public String getLoginNameById(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;	

		String name=null;
		String sql = "select * from user where user_id = ? ";

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) 
				name = rs.getString("username");	
			
			return name;
		} catch (Exception ex) {
			System.out.println("getQnaByNum() 예외발생 : " + ex);
		} finally {
			try {				
				if (rs != null) 
					rs.close();							
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}
		return null;
	}

	//board 테이블에 새로운 글 삽입하기
	public void insertQna(QnaDTO qna)  {

		
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBConnection.getConnection();		

			String sql = "insert into qna values(null, ?, ?, ?, now(), now())";
		
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, qna.getUser_id());
			pstmt.setString(2, qna.getQna_title());
			pstmt.setString(3, qna.getQna_content()); 

			pstmt.executeUpdate();
		} catch (Exception ex) {
			System.out.println("insertQna() 예외발생 : " + ex);
		} finally {
			try {									
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}		
	}  
	
	//선택된 글 상세 내용 가져오기
	public QnaDTO getQnaByNum(int qna_no, int page) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		QnaDTO qna = null;
 
		String sql = "select * from qna where qna_no = ? ";

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qna_no);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				qna = new QnaDTO();
				qna.setQna_no(rs.getInt("qna_no"));
				qna.setUser_id(rs.getString("user_id"));
				qna.setQna_title(rs.getString("qna_title"));
				qna.setQna_content(rs.getString("qna_content")); 
			}
			
			return qna;
		} catch (Exception ex) {
			System.out.println("getQnaByNum() 예외발생 : " + ex);
		} finally {
			try {
				if (rs != null) 
					rs.close();							
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}
		return null;
	}
	//선택된 글 내용 수정하기
	public void updateQna(QnaDTO qna) {

		Connection conn = null;
		PreparedStatement pstmt = null;
	
		try {
			String sql = "update qna "
					+ "set user_id=?, "
					+ "qna_title=?, "
					+ "qna_content=? "
					+ "where qna_no=?";

			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			conn.setAutoCommit(false);

			pstmt.setString(1, qna.getUser_id());
			pstmt.setString(2, qna.getQna_title());
			pstmt.setString(3, qna.getQna_content());
			pstmt.setInt(4, qna.getQna_no());

			pstmt.executeUpdate();			
			conn.commit();

		} catch (Exception ex) {
			System.out.println("updateQna() 예외발생 : " + ex);
		} finally {
			try {										
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}
	} 
	//선택된 글 삭제하기
	public void deleteQna(int qna_no) {
		Connection conn = null;
		PreparedStatement pstmt = null;		

		String sql = "delete from qna "
				+ "where qna_no=?";	

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qna_no);
			pstmt.executeUpdate();

		} catch (Exception ex) {
			System.out.println("deleteQna() 예외발생 : " + ex);
		} finally {
			try {										
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}
	}	
}

