package mvc.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import mvc.database.DBConnection;

public class ReviewDAO {
	
	private static ReviewDAO instance;

	private ReviewDAO() {
		
	}


	public static ReviewDAO getInstance() {
		if (instance == null)
			instance = new ReviewDAO();
		return instance;
	}	
	
	

	//review 테이블의 레코드 개수
	public int getListCount(String items, String text) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		String sql;

		/*검색구분 x, 검색문자열x => 전체검색*/
		if (items == null && text == null)
			sql = "select  count(*) from review";
		else
			sql = "SELECT   count(*) FROM review where " + items + " like '%" + text + "%'";
		
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
	
	
	//review 테이블의 레코드 가져오기	
		//매개변수: 현재 페이지 번호, 한 페이지 당 행 개수, 검색 분류(작성자,제목,..), 검색할 문자열 
	public ArrayList<ReviewDTO> getReviewList(int page, int limit, String items, String text) {
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
			sql = "select * from review ORDER BY rv_no DESC";		//최신글부터
		else
			sql = "SELECT  * FROM review where " + items + " like '%" + text + "%' ORDER BY rv_no DESC ";

		/*리스트에 담기 */
		ArrayList<ReviewDTO> list = new ArrayList<ReviewDTO>();
	
		try {
			/*데이터베이스에 연결*/
			conn = DBConnection.getConnection();
			

			/*
			 * TYPE_SCROLL_INSESITIVE	:	ResultSet 커서를 원하는 행으로 이동 시 변경된 행의 값을 미반영 시킨다 (SENSITIVE = 반영)
			 * TYPE_SCROLL_SENSITIVE	:	ResultSet 커서를 원하는 행으로 이동 시 변경된 행의 값을 반영 시킨다
			 * CONCUR_UPDATABLE			:	현재 행의 값을 변경 가능하도록 하는 옵션	(READ_ONLY = 변경 불가능)
			 * CONCUR_READ_ONLY			:	현재 행의 값을 변경하지 못하게 하는 옵션 
			 * */
			pstmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = pstmt.executeQuery();
			/* */
			while (rs.absolute(index)) {
				ReviewDTO review = new ReviewDTO();
				review.setRv_no(rs.getInt("rv_no"));
				review.setUser_id(rs.getString("user_id"));
				review.setPd_no(rs.getInt("pd_no"));
				review.setRv_title(rs.getString("rv_title"));
				review.setRv_content(rs.getString("rv_content"));
				review.setRv_img(rs.getString("rv_img"));
				review.setHit(rs.getInt("hit"));
				review.setIp(rs.getString("ip"));
				review.setRv_createtime(rs.getTimestamp("rv_createtime"));				//날짜 가져오기는 .getTimestamp()
				review.setRv_updatetime(rs.getTimestamp("rv_updatetime"));
				review.setRating(rs.getInt("rating"));
				
				//ArrayList에 게시물을 추가
				list.add(review);
				
			
				/*조회된 총 건 수와 비교하여 index값을 증가시킨다 */
				if (index < (start + limit) && index <= total_record) {
					index++;
				}else {
					break;
				}
			}
			return list;
		} catch (Exception ex) {
			System.out.println("getReviewList() 예외발생 : " + ex);
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
	//user 테이블에서 인증된 user_id 의 사용자명 가져오기
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
			System.out.println("getReviewByNum() 예외발생 : " + ex);
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

	//review 테이블에 새로운 글 삽입하기
	public void insertReview(ReviewDTO review)  {

		
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBConnection.getConnection();		

			String sql = "insert into review values(null, ?, ?, ?, ?, ?, ?, ?, now(), now(), ?)";
		
			pstmt = conn.prepareStatement(sql);
			/* pstmt.setInt(1, review.getRv_no()); */
			pstmt.setString(1, review.getUser_id());
			pstmt.setInt(2, review.getPd_no());
			pstmt.setString(3, review.getRv_title());
			
			pstmt.setString(4, review.getRv_content());
			pstmt.setString(5, review.getRv_img()); 
			pstmt.setInt(6, review.getHit());
			pstmt.setString(7, review.getIp()); 
			pstmt.setInt(8, review.getRating());

			pstmt.executeUpdate();
		} catch (Exception ex) {
			System.out.println("insertReview() 예외발생 : " + ex);
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
	//선택된 글의 조회 수 증가시키기
	public void updateHit(int rv_no) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConnection.getConnection();

			String sql = "select hit from review where rv_no = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rv_no);
			rs = pstmt.executeQuery();
			int hit = 0;

			if (rs.next())
				hit = rs.getInt("hit") + 1;
		

			sql = "update review set hit=? where rv_no=?";
			pstmt = conn.prepareStatement(sql);		
			pstmt.setInt(1, hit);
			pstmt.setInt(2, rv_no);
			pstmt.executeUpdate();
		} catch (Exception ex) {
			System.out.println("updateHit() 예외발생 : " + ex);
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
	}
	//선택된 글 상세 내용 가져오기
	public ReviewDTO getReviewByNum(int rv_no, int page) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ReviewDTO review = null;

		updateHit(rv_no);
		String sql = "select * from review where rv_no = ? ";

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rv_no);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				review = new ReviewDTO();
				review.setRv_no(rs.getInt("rv_no"));
				review.setUser_id(rs.getString("user_id")); 
				review.setPd_no(rs.getInt("pd_no"));
				review.setRv_title(rs.getString("rv_title"));
				review.setRv_content(rs.getString("rv_content"));
				review.setRv_img(rs.getString("rv_img"));
				review.setHit(rs.getInt("hit"));
				review.setIp(rs.getString("ip"));
				review.setRating(rs.getInt("rating"));
			}
			
			return review;
		} catch (Exception ex) {
			System.out.println("getReviewByNum() 예외발생 : " + ex);
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
	public void updateReview(ReviewDTO review) {

		Connection conn = null;
		PreparedStatement pstmt = null;
	
		try {
			String sql = "update review "
					+ "set user_id=?, "
					+ "rv_title=?, "
					+ "rv_content=?, " 
					+ "rating=? " 
					+ "where rv_no=?";

			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			conn.setAutoCommit(false);

			pstmt.setString(1, review.getUser_id());
			pstmt.setString(2, review.getRv_title());
			pstmt.setString(3, review.getRv_content()); 
			pstmt.setInt(4, review.getRating());
			pstmt.setInt(5, review.getRv_no());

			pstmt.executeUpdate();			
			conn.commit();

		} catch (Exception ex) {
			System.out.println("updateReview() 예외발생 : " + ex);
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
	public void deleteReview(int rv_no) {
		Connection conn = null;
		PreparedStatement pstmt = null;		

		String sql = "delete from review "
				+ "where rv_no=?";	

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rv_no);
			pstmt.executeUpdate();

		} catch (Exception ex) {
			System.out.println("deleteReview() 예외발생 : " + ex);
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
