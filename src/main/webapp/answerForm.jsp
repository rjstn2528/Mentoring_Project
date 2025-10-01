<!-- 김도은 / 멘토 답변 작성 폼 페이지 -->
<%@ include file="common/header.jsp"%>

<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="utils.DBCPUtil"%>
<%@page import="vo.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	
	//url로 넘겨 받은 멘토 ID & 게시글 NUM & rn
	String mentorId = request.getParameter("mentorId");
	String rn = request.getParameter("rn");
	String strNum = request.getParameter("num");
	int num = 0;
	if(strNum != null){
		num = Integer.parseInt(strNum);
	}

	if(mentorId == null || num == 0 || rn == null ||
	   loginMember == null || !loginMember.getId().equals(mentorId)){
		// 파라미터가 하나라도 넘어오지 않은 경우 & 로그인 멤버가 null이거나 답변을 달 수 있는 멘토 본인이 아닌 경우 접근 제한
		response.sendError(403);
		return;
	}
	
	// url로 넘겨받은 게시글 num으로 답변 달고 있는 게시글 제목 가져오기
	BoardVO board = null;
			
	Connection conn = DBCPUtil.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
		String sql = "SELECT * FROM board_table WHERE num = ?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, num);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			
			board = new BoardVO();
			
			board.setNum(rs.getInt(1));
			board.setMentorId(rs.getString(2));
			board.setMenteeId(rs.getString(3));
			board.setTitle(rs.getString(4));
			board.setContent(rs.getString(5));
			board.setCategory(rs.getString(6));
			board.setCreatedAt(rs.getDate(7));
			board.setIsCompleted(rs.getString(8));
			
		}
		
	}catch(Exception e){
		e.getStackTrace();
	}finally{
		DBCPUtil.close(rs, pstmt, conn);
	}

	
	// 이 게시글에 달린 답변 검색 (이전에 멘토 본인이 달았던 답변 출력용)
	conn = DBCPUtil.getConnection();
	pstmt = null;
	rs = null;
	
	// 답변 저장할 객체
	AnswerVO answer = null;
	
	// 답변이 여러 개일 때 리스트에 저장 후 모두 출력
	List<AnswerVO> list = new ArrayList<>();

	String sql = "SELECT * FROM answer_table WHERE board_num = ?";
			
	try{
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, board.getNum());
		
		rs = pstmt.executeQuery();
		
		while(rs.next()){
			answer = new AnswerVO();
			
			answer.setNum(rs.getInt(1));
			answer.setMentorId(rs.getString(2));
			answer.setContent(rs.getString(3));
			answer.setBoardNum(rs.getInt(4));
			answer.setCreatedAt(rs.getDate(5));
			
			list.add(answer);
		}
		
	}catch(Exception e){
		e.getStackTrace();
	}finally{
		DBCPUtil.close(rs, pstmt, conn);
	}
	
	// 멘티 이름 가져오기
	MemberVO mentee = null;
	conn = DBCPUtil.getConnection();
	
	sql = "SELECT * FROM member_table WHERE id = ?";
	
	try{
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, board.getMenteeId());
		
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			mentee = new MemberVO();
			
			mentee.setId(rs.getString("id"));
			mentee.setName(rs.getString("name"));
		}

	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBCPUtil.close(rs, pstmt, conn);
	}
%>    
    
    
    
<section id="main">
	<h3>멘티에게 답변하기</h3>
	<!-- 기존 게시글 출력 -->
	<table border="1" id="board">
		<tr>
			<th colspan="6">멘티 질문</th>
		</tr>
		<tr>
			<th>no.<%=rn%></th>
			<td colspan="5">
				<!-- 멘토링 완료된 글은 제목 앞에 완료 표시 -->
				<%= board.getIsCompleted().equals("Y") ? "[완료]   " : "" %>
				<%=board.getTitle()%>
			</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><%=mentee.getName()%></td>
			<th>프로그래밍 언어</th>
			<td><%=board.getCategory()%></td>
			<th>작성일</th>
			<td><%=board.getCreatedAt()%></td>
		</tr>
		<tr>
			<td colspan="6" id="cont">
				<pre><%=board.getContent()%></pre>
			</td>
		</tr>
	</table>
	<hr>
	
	<!-- 이 게시글에 기존에 작성한 답변이 있다면 답변 추가 시 참고할 수 있도록 출력 -->
		<% if(!list.isEmpty()){// 답변이 있을 때 %>
			
		<table border="1" id="answer">
			<% for(AnswerVO a : list){ %>
			<tr>
				<th colspan="2">작성일</th>
				<td colspan="2"><%=a.getCreatedAt()%></td>
			</tr>
			<tr rowspan="5">
				<td colspan="4" id="aContent">내 답변 : <br><pre><%=a.getContent()%></pre></td>
			</tr>
			<% } %>
		</table>
			
		<% } %>
		
	<!-- 답변 작성 폼 -->
	<form action="anwerSubmit.jsp" method="post">
		<input type="hidden" name="boardNum" value="<%=board.getNum()%>">
		<input type="hidden" name="mentorId" value="<%=board.getMentorId()%>">
		<input type="hidden" name="rn" value="<%=rn%>">
		<table border="1" id="aForm">
			<tr>
				<th>
					답변 작성
				</th>
			</tr>
			<tr>
				<td colspan="4">
					<textarea name="content" rows="20" cols="66" placeholder="멘티에게 답변해 주세요."></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<button type="submit">답변하기</button>
				</td>
			</tr>	
		</table>
	</form>

</section>

<%@ include file="common/footer.jsp"%>