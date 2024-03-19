package mvc.model;

import java.util.Date;

public class QnaDTO {
	private int qna_no;			//게시물 번호
	private String user_id;			//게시물 작성자 아이디 
	private String qna_title;		//게시물 제목
	private String qna_content;		//게시물 내용
	private Date createtime;		//게시물 등록일자
	private Date updatetime;	//게시물 수정일자 
	
	public QnaDTO() {
		super();
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

	public String getQna_title() {
		return qna_title;
	}

	public void setQna_title(String qna_title) {
		this.qna_title = qna_title;
	}

	public String getQna_content() {
		return qna_content;
	}

	public void setQna_content(String qna_content) {
		this.qna_content = qna_content;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}
 
	
	
}
