package mvc.model;

import java.util.Date;

public class ReviewDTO {

	private int rv_no;				//게시물 번호
	private String user_id;			//게시물 작성자 아이디
	private int pd_no;				//품목 번호
	private String rv_title;		//게시물 제목
	private String rv_content;		//게시물 내용
	private String rv_img;			//게시물 첨부 이미지 파일 
	private Date rv_createtime;		//게시물 등록 일자
	private Date rv_updatetime;		//게시물 수정일자
	private int hit;				//조회수
	private String ip;				//게시물 작성 아이피 
	private int rating;				//별점 추가 
	
	  
	 
	
	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}
	
	

	public ReviewDTO() {
		super();
	}
	
	public int getRv_no() {
		return rv_no;
	}
	public void setRv_no(int rv_no) {
		this.rv_no = rv_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getPd_no() {
		return pd_no;
	}
	public void setPd_no(int pd_no) {
		this.pd_no = pd_no;
	}
	public String getRv_title() {
		return rv_title;
	}
	public void setRv_title(String rv_title) {
		this.rv_title = rv_title;
	}
	public String getRv_content() {
		return rv_content;
	}
	public void setRv_content(String rv_content) {
		this.rv_content = rv_content;
	}
	public String getRv_img() {
		return rv_img;
	}
	public void setRv_img(String rv_img) {
		this.rv_img = rv_img;
	}
	public Date getRv_createtime() {
		return rv_createtime;
	}
	public void setRv_createtime(Date rv_createtime) {
		this.rv_createtime = rv_createtime;
	}
	public Date getRv_updatetime() {
		return rv_updatetime;
	}
	public void setRv_updatetime(Date rv_updatetime) {
		this.rv_updatetime = rv_updatetime;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	
	
	
}
