/**
  	김도은 / 멘토 프로필 정보 저장용 class
 */

package vo;

import java.util.Date;



/**
 * 
 */
public class MentorProfileVO {

	private int num;
	private String mentorId;
	private String lang;
	private String email;
	private String intro;
	private Date createdAt;
	private String name;
	private String phone;
	private double score;
	
	
	public MentorProfileVO() {}

	public MentorProfileVO(int num, String mentorId, String lang, String email, String intro, Date createdAt,
			String name, String phone) {
		super();
		this.num = num;
		this.mentorId = mentorId;
		this.lang = lang;
		this.email = email;
		this.intro = intro;
		this.createdAt = createdAt;
		this.name = name;
		this.phone = phone;
	}
	

	public MentorProfileVO(int num, String mentorId, String name, String lang, String email, String intro, Date createdAt) {
		super();
		this.num = num;
		this.mentorId = mentorId;
		this.name = name;
		this.lang = lang;
		this.email = email;
		this.intro = intro;
		this.createdAt = createdAt;
	}
	
	public MentorProfileVO(String phone) {
		super();
		this.phone = phone;
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

	public String getLang() {
		return lang;
	}

	public void setLang(String lang) {
		this.lang = lang;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public double getScore() {
		return score;
	}

	public void setScore(double score) {
		this.score = score;
	}

	@Override
	public String toString() {
		return "MentorProfileVO [num=" + num + ", mentorId=" + mentorId + ", lang=" + lang + ", email=" + email
				+ ", intro=" + intro + ", createdAt=" + createdAt + ", name=" + name + ", phone=" + phone + "]";
	}

	
	
} // end class
