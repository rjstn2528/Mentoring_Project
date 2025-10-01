<!-- 김도은 / 게시글 작성 폼-->
<%@ include file="common/header.jsp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="vo.*, utils.*, java.sql.*"%>
<%

	// 파라미터로 전달 받은 정보
	String mentorId = request.getParameter("mentorId");
	
	if(loginMember == null){
		// 비로그인 상태인 경우
		session.setAttribute("msg", "로그인 후 이용 가능한 기능입니다.");
		response.sendRedirect("login.jsp");
	}

	if(mentorId == null ){
		// 파라미터가 넘어오지 않은 경우
		response.sendError(403);
		return;
	}
	
	// 멘토 프로필 보면서 게시글 작성할 수 있도록 멘토 프로필 가져오기
	MentorProfileVO mentor = null;
	
	Connection conn = DBCPUtil.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	

	String sql = "SELECT * FROM mentor_profile WHERE mentor_id = ?";
	
	try{
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, mentorId);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			
			mentor = new MentorProfileVO();
			
			mentor.setNum(rs.getInt(1));
			mentor.setMentorId(rs.getString(2));
			mentor.setName(rs.getString(3));
			mentor.setLang(rs.getString(4));
			mentor.setEmail(rs.getString(5));
			mentor.setIntro(rs.getString(6));
			mentor.setCreatedAt(rs.getDate(7));
			
		}
		
	}catch(Exception e){
		e.getStackTrace();
		response.sendError(500);
	}finally{
		DBCPUtil.close(rs, pstmt, conn);
	} 
	
	if(mentor == null){
		response.sendError(404);
		return;
	}
	
	// 멘토 아이디로 회원 정보 테이블에서 멘토 이름/전화번호 가져오기
	
	conn = DBCPUtil.getConnection();
	pstmt = null;
	rs = null;
	
	sql = "SELECT * FROM member_table WHERE id = ?";
	
	try{
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, mentorId);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			mentor.setPhone(rs.getString("phone"));
		}
		
	}catch(Exception e){
		e.getStackTrace();
	}finally{
		DBCPUtil.close(rs, pstmt, conn);
	}
	
%>
<section id="main">
	<table border="1" id="mentorT">
		
		<tr>
			<th colspan="4">멘토 소개</th>
		</tr>
		<tr>
			<th>이름</th>
			<td><%=mentor.getName()%></td>
			<th>프로그래밍 언어</th>
			<td><%=mentor.getLang()%></td>
		</tr>
		<tr>
			<th>연락처</th>
			<td><%=mentor.getPhone()%></td>
			<th>이메일</th>
			<td><%=mentor.getEmail()%></td>
		</tr>
		<tr>
			<td colspan="4" id="intro">
				<%=mentor.getIntro()%>
			</td>
		</tr>
	</table>
	
	<!-- 멘토 프로필 보면서 질문글 작성 -->
	<form action="boardWriteSubmit.jsp" method="POST">
		<input type="hidden" name="mentorId" value="<%=mentorId%>">
		<table border="1" id="write">
			<tr>
				<th colspan="2">멘토에게 질문 작성</th>
			</tr>
			<tr>
				<td>제목</td>
				<td>
					<input type="text" name="title" placeholder="제목을 입력하세요." class="title"/>
				</td>
			</tr>
			<tr>
				<td>프로그래밍 언어</td>
				<td>
					<label> <input type="radio" name="category" value="JAVA" />JAVA &nbsp;</label> 
					<label> <input type="radio" name="category" value="JAVASCRIPT" />JAVASCRIPT &nbsp;</label> 
					<label> <input type="radio" name="category" value="C" />C &nbsp;</label> 
					<label> <input type="radio" name="category" value="PYTHON" />PYTHON &nbsp;</label> 
					<label> <input type="radio" name="category" value="기타" />기타 &nbsp;</label> 
				</td>
			</tr>
			<tr>
				<td colspan="2" class="btnTop">
					<textarea name="content" rows="30" cols="66" placeholder="멘토에게 남길 질문을 작성해 주세요."></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="btn">
					<button type="submit">작성 완료</button>
				</td>
			</tr>
		</table>
	</form>
</section>
<%@ include file="common/footer.jsp"%>