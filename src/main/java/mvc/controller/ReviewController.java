package mvc.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.model.ReviewDAO;
import mvc.model.ReviewDTO;

//HttpServlet 	:	부모클래스를 상속받아 선언 
public class ReviewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final int LISTCOUNT = 5; 	// <- 페이지 당 보여지는 게시물 행 수 (5행)

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);		//doGet
	}

	// jsp 에서 선언된 방식이 post 이면 처리
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
										//doPost
										/*
										 * 						/프로젝트명/실행페이지명
										 * http://localhost:8080/BigMarket/join.jsp
										 */		
		String RequestURI = request.getRequestURI();					// <- 주소값에서 /BigMarket/join.jsp 을 가져온다 
		String contextPath = request.getContextPath();					// <- BigMarket 만 가져온다
		String command = RequestURI.substring(contextPath.length());	// <- (프로젝트명 뒤부터 끝까지) join.jsp 을 가져온다
		
		response.setContentType("text/html; charset=utf-8");
		request.setCharacterEncoding("utf-8");
	
		
		//do -> rdo
		
		/* 게시물 조회를 실행하면 처리 */
		if (command.equals("/ReviewListAction.rdo")) {//등록된 글 목록 페이지 출력하기
			requestReviewList(request);
			RequestDispatcher rd = request.getRequestDispatcher("./review/list.jsp");
			rd.forward(request, response);
		} else if (command.equals("/ReviewWriteForm.rdo")) { //글 등록 페이지 출력
				requestLoginName(request);
				RequestDispatcher rd = request.getRequestDispatcher("./review/writeForm.jsp");
				rd.forward(request, response);				
		} else if (command.equals("/ReviewWrite.rdo")) {
			RequestDispatcher rd = request.getRequestDispatcher("/review/review_process.jsp");
			rd.forward(request, response);	
		} 
		
		else if (command.equals("/ReviewWriteAction.rdo")) {//새로운 글 등록
				requestReviewWrite(request);		//입력받은 게시물 내용을 insert 
				RequestDispatcher rd = request.getRequestDispatcher("/ReviewListAction.rdo");
				rd.forward(request, response);						
		} else if (command.equals("/ReviewViewAction.rdo")) {//선택된 글 상자 페이지 가져오기
				requestReviewView(request);
				RequestDispatcher rd = request.getRequestDispatcher("/ReviewView.rdo");
				rd.forward(request, response);						
		} else if (command.equals("/ReviewView.rdo")) {  //글 상세 페이지 출
				RequestDispatcher rd = request.getRequestDispatcher("./review/view.jsp");
				rd.forward(request, response);	
		} else if (command.equals("/ReviewUpdateAction.rdo")) { //선택된 글 수정하기
				requestReviewUpdate(request);
				RequestDispatcher rd = request.getRequestDispatcher("/ReviewListAction.rdo");
				rd.forward(request, response);
		}else if (command.equals("/ReviewDeleteAction.rdo")) { //선택된 글 삭제하기
				requestReviewDelete(request);
				RequestDispatcher rd = request.getRequestDispatcher("/ReviewListAction.rdo");
				rd.forward(request, response);				
		} 
	}
	//등록된 글 목록 가져오기
	public void requestReviewList(HttpServletRequest request){

		/* static으로 선언됨 
		 * 싱글톤 패턴으로 정의 */
		ReviewDAO dao = ReviewDAO.getInstance();

		/* 컬렉션(Collection)의 3개 중 리스트 구조 
		 * <> : 제네릭 */
		ArrayList<ReviewDTO> reviewlist = new ArrayList<ReviewDTO>();
		

		/*초기페이지 = 1*/
	  	int pageNum=1;		
		int limit=LISTCOUNT;
		
		if(request.getParameter("pageNum") != null) {
			pageNum=Integer.parseInt(request.getParameter("pageNum"));
		}
		

		/*검색구분 (예를 들어 작성자,제목,내용으로 검색)*/
		String items = request.getParameter("items");
		/*검색하려는 문자열 입력*/
		String text = request.getParameter("text");

		/*검색 조건에 따라서 게시물 총 건수를 변수에 대입*/
		int total_record  =  dao.getListCount(items, text);
		reviewlist  =  dao.getReviewList(pageNum,limit, items, text); //어레이리스트에 담기
		
		
		int total_page;
		
		if (total_record % limit == 0){     	//남는 페이지가 없으면 총-건-수/페이지당-행-수
	     	total_page = total_record/limit;	
	     	Math.floor(total_page);  		
		}
		else{	//남는 페이지가 생기면 다음 페이지로 넘어가도록 한 페이지를 더 추가한다
		   total_page = total_record/limit;
		   Math.floor(total_page); 
		   total_page =  total_page + 1; 
		}
    
		//다른 페이지에서 참조할 수 있도록 속성을 지정 
   		request.setAttribute("pageNum", pageNum);		  																
   		request.setAttribute("total_page", total_page);		  								 
		request.setAttribute("total_record",total_record); 								
		request.setAttribute("reviewlist", reviewlist);								
	}
	//인증된 사용자명 가져오기
	public void requestLoginName(HttpServletRequest request){
					
		String user_id = request.getParameter("user_id");
		
		ReviewDAO  dao = ReviewDAO.getInstance();
		
		String name = dao.getLoginNameById(user_id);		
		
		request.setAttribute("name", name);									
	}
   //새로운 글 등록하기
	public void requestReviewWrite(HttpServletRequest request){
					
		ReviewDAO dao = ReviewDAO.getInstance();		
		
		ReviewDTO review = new ReviewDTO();
		review.setUser_id(request.getParameter("user_id"));
		review.setPd_no(Integer.parseInt(request.getParameter("pd_no")));
		review.setRv_title(request.getParameter("rv_title"));
		review.setRv_content(request.getParameter("rv_content"));	 
		review.setRating(Integer.parseInt(request.getParameter("rating")));	
		
		System.out.println(request.getParameter("user_id"));
		System.out.println(request.getParameter("rv_title"));
		System.out.println(request.getParameter("rv_content")); 
		System.out.println(request.getParameter("rating")); 
		review.setHit(0);
		review.setIp(request.getRemoteAddr());	
		java.util.Date utilDate = new java.util.Date();								//DATETIME 
		java.sql.Timestamp createtime = new java.sql.Timestamp(utilDate.getTime());
		review.setRv_createtime(createtime);
		review.setRv_updatetime(createtime);
		
		dao.insertReview(review);								
	}
	//선택된 글 상세 페이지 가져오기
	public void requestReviewView(HttpServletRequest request){
					
		ReviewDAO dao = ReviewDAO.getInstance();
		int rv_no = Integer.parseInt(request.getParameter("rv_no"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));	 
		
		ReviewDTO review = new ReviewDTO();
		review = dao.getReviewByNum(rv_no, pageNum);		
		
		request.setAttribute("rv_no", rv_no);		 
   		request.setAttribute("page", pageNum); 
   		request.setAttribute("review", review);    							
	}
	 //선택된 글 내용 수정하기
	public void requestReviewUpdate(HttpServletRequest request){
					
		int rv_no = Integer.parseInt(request.getParameter("rv_no"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));	 
		
		ReviewDAO dao = ReviewDAO.getInstance();
		
		ReviewDTO review = new ReviewDTO();
		review.setRv_no(rv_no);
		review.setUser_id(request.getParameter("user_id"));
		review.setRv_title(request.getParameter("rv_title"));
		review.setRv_content(request.getParameter("rv_content")); 
		review.setRating(Integer.parseInt(request.getParameter("rating")));	
		review.setHit(0);
		review.setIp(request.getRemoteAddr());	 
		
		 dao.updateReview(review);								
	}
	//선택된 글 삭제하기
	public void requestReviewDelete(HttpServletRequest request){
					
		int rv_no = Integer.parseInt(request.getParameter("rv_no"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));	
		
		ReviewDAO dao = ReviewDAO.getInstance();
		dao.deleteReview(rv_no);							
	}	
}
