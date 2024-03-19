package mvc.model;

import java.util.Date;

public class CommentDTO {
	private int cm_no;				//댓글 번호
	private int qna_no;				//게시물 번호
	private String user_id;			//댓글 작성자 아이디 
	private String cm_content;		//댓글 내용
	private Date cm_createtime;		//댓글 등록일자
	private Date cm_updatetime;		//댓글 수정일자 
	
	public CommentDTO() {
		super();
	}

	public int getCm_no() {
		return cm_no;
	}

	public void setCm_no(int cm_no) {
		this.cm_no = cm_no;
	}

	public int getQna_no() {
		return qna_no;
	}

	public void setQna_no(int qna_no) {
		this.qna_no = qna_no;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getCm_content() {
		return cm_content;
	}

	public void setCm_content(String cm_content) {
		this.cm_content = cm_content;
	}

	public Date getCm_createtime() {
		return cm_createtime;
	}

	public void setCm_createtime(Date cm_createtime) {
		this.cm_createtime = cm_createtime;
	}

	public Date getCm_updatetime() {
		return cm_updatetime;
	}

	public void setCm_updatetime(Date cm_updatetime) {
		this.cm_updatetime = cm_updatetime;
	}

	
}
