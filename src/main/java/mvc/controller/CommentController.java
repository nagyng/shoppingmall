package mvc.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.model.CommentDAO;
import mvc.model.CommentDTO;

 
public class CommentController extends HttpServlet {
	private static final long serialVersionUID = 1L; 
	static final int LISTCOUNT = 30; 	

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);		 
	}
 
		//전달 방식이 post 일 때 실행한다
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		  
		
		String RequestURI = request.getRequestURI();					//  /BigMarket/join.jsp 
		String contextPath = request.getContextPath();					//  BigMarket  
		String command = RequestURI.substring(contextPath.length());	//  (프로젝트명) join.jsp 
		
		response.setContentType("text/html; charset=utf-8");
		request.setCharacterEncoding("utf-8");
	
		 
		if (command.equals("/CommentListAction.cdo")) {				// 댓글 목록 페이지 
			requestCommentList(request);
			RequestDispatcher rd = request.getRequestDispatcher("./comment/list.jsp");
			rd.forward(request, response);
		} else if (command.equals("/CommentWriteForm.cdo")) { 		// 댓글 등록 페이지  
				requestLoginName(request);
				RequestDispatcher rd = request.getRequestDispatcher("./comment/writeForm.jsp");
				rd.forward(request, response);				
		} else if (command.equals("/CommentWriteAction.cdo")) {		// 새로운 댓글 등록
				requestCommentWrite(request);						// 입력받은 댓글 내용을 insert 
				RequestDispatcher rd = request.getRequestDispatcher("/CommentListAction.cdo");
				rd.forward(request, response);						
		} else if (command.equals("/CommentUpdateAction.cdo")) { 	// 선택된 댓글 수정 
				requestCommentUpdate(request);
				RequestDispatcher rd = request.getRequestDispatcher("/CommentListAction.cdo");
				rd.forward(request, response);
		}else if (command.equals("/CommentDeleteAction.cdo")) { 	// 선택된 댓글 삭제 
				requestCommentDelete(request);
				RequestDispatcher rd = request.getRequestDispatcher("/CommentListAction.cdo");
				rd.forward(request, response);				
		} 
	}
 
	//등록된 댓글 목록 가져오기
	public void requestCommentList(HttpServletRequest request){ 
		CommentDAO dao = CommentDAO.getInstance(); 
		ArrayList<CommentDTO> commentlist = new ArrayList<CommentDTO>();
		
	  	int pageNum=1;		
		int limit=LISTCOUNT;
		
		if(request.getParameter("pageNum") != null) {
			pageNum=Integer.parseInt(request.getParameter("pageNum"));
		}

		if(request.getParameter("pageNum") != null) {
			pageNum=Integer.parseInt(request.getParameter("pageNum"));
		}
		
		 
		String items = request.getParameter("items"); 
		String text = request.getParameter("text");
 
		int total_record  =  dao.getListCount(items, text);
		commentlist  =  dao.getCommentList(pageNum,limit, items, text); 
		
		
		int total_page;
		
		if (total_record % limit == 0){      
	     	total_page = total_record/limit;	
	     	Math.floor(total_page);  		
		}
		else{	 
		   total_page = total_record/limit;
		   Math.floor(total_page); 
		   total_page =  total_page + 1; 
		}
     
   		request.setAttribute("pageNum", pageNum);		  																
   		request.setAttribute("total_page", total_page);		  								 
		request.setAttribute("total_record",total_record); 
		request.setAttribute("commentlist", commentlist);	
	}
	 
	// 인증된 사용자 이름을 가져온다 
	public void requestLoginName(HttpServletRequest request){
					
		String id = request.getParameter("id"); 
		CommentDAO  dao = CommentDAO.getInstance(); 
		String name = dao.getLoginNameById(id);		 
		request.setAttribute("name", name);									
	}
   
	// 새 댓글 등록 
	public void requestCommentWrite(HttpServletRequest request){
					
		CommentDAO dao = CommentDAO.getInstance();		
		
		CommentDTO comment = new CommentDTO();
		comment.setQna_no(Integer.parseInt(request.getParameter("qna_no")));
		comment.setUser_id(request.getParameter("user_id"));
		comment.setCm_content(request.getParameter("cm_content")); 
		
		System.out.println(request.getParameter("qna_no"));
		System.out.println(request.getParameter("user_id"));
		System.out.println(request.getParameter("cm_content"));  
		java.util.Date utilDate = new java.util.Date();								//DATETIME 
		java.sql.Timestamp regDate = new java.sql.Timestamp(utilDate.getTime());
		comment.setCm_createtime(regDate);
		comment.setCm_updatetime(regDate);
		
		dao.insertComment(comment);								
	}
	
	 //선택된 댓글 내용 수정하기
	public void requestCommentUpdate(HttpServletRequest request){
					
		int cm_no = Integer.parseInt(request.getParameter("cm_no")); 
		
		CommentDAO dao = CommentDAO.getInstance();
		
		CommentDTO comment = new CommentDTO();		
		comment.setCm_no(cm_no);
		comment.setUser_id(request.getParameter("user_id"));
		comment.setCm_content(request.getParameter("cm_content")); 
		
		dao.updateQna(comment);								
	}
	
	//선택된 댓글 삭제하기
	public void requestCommentDelete(HttpServletRequest request){
					
		int cm_no = Integer.parseInt(request.getParameter("cm_no")); 
		
		CommentDAO dao = CommentDAO.getInstance();
		dao.deleteComment(cm_no);							
	}	
}
