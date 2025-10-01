package vo;

import java.util.Date;

public class AnswerVO {

	private int num;
	private String mentorId;
	private String content;
	private int boardNum;
	private Date createdAt;
	
	public AnswerVO() {}

	public AnswerVO(int num, String mentorId, String content, int boardNum, Date createdAt) {
		super();
		this.num = num;
		this.mentorId = mentorId;
		this.content = content;
		this.boardNum = boardNum;
		this.createdAt = createdAt;
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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getBoardNum() {
		return boardNum;
	}

	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	@Override
	public String toString() {
		return "AnswerVO [num=" + num + ", mentorId=" + mentorId + ", content=" + content + ", boardNum=" + boardNum
				+ ", createdAt=" + createdAt + "]";
	}
	
	
}
