package vo;

import java.util.Date;

public class BoardVO {

	private int rn;
	private int num;
	private String mentorId;
	private String menteeId;
	private String title;
	private String content;
	private String category;
	private Date createdAt;
	private String isCompleted;
	private String name;
	
	
	public BoardVO() {}

	

	public BoardVO(int rn, int num, String title, String content, Date createdAt) {
		// 관리자 게시글 저장용 생성자 (rn 포함)
		super();
		this.rn = rn;
		this.num = num;
		this.title = title;
		this.content = content;
		this.createdAt = createdAt;
	}

	public BoardVO(int num, String title, String content, Date createdAt) {
		// 관리자 게시글 저장용 생성자 (rn 미포함)
		super();
		this.num = num;
		this.title = title;
		this.content = content;
		this.createdAt = createdAt;
	}



	public BoardVO(int num, String mentorId, String menteeId, String title, String content, String category,
			Date createdAt, String isCompleted) {
		super();
		this.num = num;
		this.mentorId = mentorId;
		this.menteeId = menteeId;
		this.title = title;
		this.content = content;
		this.category = category;
		this.createdAt = createdAt;
		this.isCompleted = isCompleted;
	}
	
	public BoardVO(int rn, int num, String mentorId, String menteeId, String title, String content, String category,
			Date createdAt, String isCompleted) {
		super();
		this.rn = rn;
		this.num = num;
		this.mentorId = mentorId;
		this.menteeId = menteeId;
		this.title = title;
		this.content = content;
		this.category = category;
		this.createdAt = createdAt;
		this.isCompleted = isCompleted;
	}

	public int getRn() {
		return rn;
	}

	public void setRn(int rn) {
		this.rn = rn;
	}



	public int getNum() {
		return num;
	}



	public void setNum(int num) {
		this.num = num;
	}



	public String getMentorId() {
		return mentorId;
	}



	public void setMentorId(String mentorId) {
		this.mentorId = mentorId;
	}



	public String getMenteeId() {
		return menteeId;
	}



	public void setMenteeId(String menteeId) {
		this.menteeId = menteeId;
	}



	public String getTitle() {
		return title;
	}



	public void setTitle(String title) {
		this.title = title;
	}



	public String getContent() {
		return content;
	}



	public void setContent(String content) {
		this.content = content;
	}



	public String getCategory() {
		return category;
	}



	public void setCategory(String category) {
		this.category = category;
	}



	public Date getCreatedAt() {
		return createdAt;
	}



	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}



	public String getIsCompleted() {
		return isCompleted;
	}



	public void setIsCompleted(String isCompleted) {
		this.isCompleted = isCompleted;
	}

	

	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	@Override
	public String toString() {
		return "BoardVO [num=" + num + ", mentorId=" + mentorId + ", menteeId=" + menteeId + ", title=" + title
				+ ", content=" + content + ", category=" + category + ", createdAt=" + createdAt + ", isCompleted="
				+ isCompleted + "]";
	}

} // end class
