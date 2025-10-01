<!-- 김도은 / 멘토 프로필 출력 -->
<%@ include file="common/header.jsp"%>

<%@ page import="java.util.*, vo.MentorProfileVO, utils.*, java.sql.*, vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    
    
<%
	
	String mentorId = request.getParameter("mentorId");
	if(mentorId == null){
		response.sendError(403);
		return;
	}
	
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
		return;
	}finally{
		DBCPUtil.close(rs, pstmt, conn);
	} 
	
		
	// 멘토 아이디로 회원 정보 테이블에서 멘토 전화번호 가져오기
	
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

	<% if(mentor == null){ %>
	<table border="1" id="mentorT">
		<tr>
			<th> 아직 등록된 프로필이 없습니다. </th>
		</tr>
	</table>
	<hr>
	<% }else{ %>
	
	<p id="title"><span id="mName"><%=mentor.getName()%></span> 멘토에게 멘토링 받아 보세요!</p>
	<hr>
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
	
		<!-- loginMember가 null이거나 loginMember가 멘토 본인이 아닌 경우, loginMember가 멘토가 아닌 경우 -->
		<%if(loginMember == null || !loginMember.getRole().equals("멘토")){ %>
				<!-- 게시글 작성 페이지에서 로그인 상태 체크해야 함 (비로그인 상태면 접근 제한) -->
				<a href="boardWrite.jsp?mentorId=<%=mentor.getMentorId()%>">
					<button>멘토에게 질문하기</button>
				</a>
		<% } %>
	<% } %>

</section>
<!-- 아래에 출력될 게시글 리스트에서 footer 출력 -->