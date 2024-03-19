package mvc.model;

import java.util.Date;

public class BoardDTO {
	private int num;			//게시물 번호
	private String id;			//게시물 작성자 아이디
	private String name;		//게시물 작성자 이름
	private String subject;		//게시물 제목
	private String content;		//게시물 내용
	private Date regdate;		//게시물 등록일자
	private Date updatedate;	//게시물 수정일자
	private int hit;			//조회수
	private String ip;			//게시물작성 아이피
	
	public BoardDTO() {
		super();
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public Date getUpdatedate() {
		return updatedate;
	}

	public void setUpdatedate(Date updatedate) {
		this.updatedate = updatedate;
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
