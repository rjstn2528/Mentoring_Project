package vo;

/**
    회원 정보 저장용 class
 */
public class MemberVO {

	private int num;			// 회원 번호
	private String id;			// 사용자 아이디
	private String pw;			// 사용자 비밀번호
	private String name;		// 사용자 이름
	private String addr;		// 주소
	private String email;		// 이메일
	private String phone;		// 전화번호
	private String role;		// 역할(멘토/멘티)
	private String lang;		// 프로그래밍 언어

	public MemberVO() {}

	public MemberVO(String id) {
		this.id = id;
	}
	
	public MemberVO(String id, String name) {
		this.id = id;
		this.name = name;
	}
	
	public MemberVO(int num, String id, String pw, String name, String addr, String email, String phone, String role) {
		super();
		this.num = num;
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.addr = addr;
		this.email = email;
		this.phone = phone;
		this.role = role;
	}
	
	public MemberVO(int num, String id, String pw, String name, String addr, String email, String phone, String role, String lang) {
		super();
		this.num = num;
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.addr = addr;
		this.email = email;
		this.phone = phone;
		this.role = role;
		this.lang = lang;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}
	
	public String getLang() {
		return lang;
	}

	public void setLang(String lang) {
		this.lang = lang;
	}

	@Override
	public String toString() {
		return "MemberVO [num=" + num + ", id=" + id + ", pw=" + pw + ", name=" + name + ", addr=" + addr + ", email="
				+ email + ", phone=" + phone + ", role=" + role + "]";
	}

	
}
