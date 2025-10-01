<!-- 김도은 / 멘티 게시글 상세 페이지 -->
<%@ include file="common/header.jsp"%>

<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*, utils.*, java.sql.*, vo.*"%>    

<%	
	//url로 넘겨 받은 멘토 ID & 게시글 NUM & RN
	String mentorId = request.getParameter("mentorId");
	String rn = request.getParameter("rnum");
	String strNum = request.getParameter("num");
	int num = 0;
	if(strNum != null){
		num = Integer.parseInt(strNum);
	}
	
	if(mentorId == null || num == 0 || rn == null){
		// 파라미터를 읽어 오지 못한 경우 접근 제한
		response.sendError(403);
		return;
	}
	
	// 게시글 정보 읽어와서 BoardVO 타입 객체에 저장
	BoardVO board = null;
			
	Connection conn = DBCPUtil.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "SELECT * FROM board_table WHERE mentor_id = ? AND num = ?";
	
	try{
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, mentorId);
		pstmt.setInt(2, num);
		
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
		// 예외 발생할 경우 에러 페이지 출력
		response.sendError(500);
		return;
	}finally{
		DBCPUtil.close(rs, pstmt, conn);
	}
	
	// 데이터베이스에서 조회되지 않아서 board에 데이터 저장이 되지 않은 경우
	if(board == null){
		// 잘못된 게시글 번호로 접근 : 없는 페이지 > 에러 페이지 출력
		response.sendError(404);
		return;
	}
	
	// 이 게시글에 달린 답변 검색
	conn = DBCPUtil.getConnection();
	pstmt = null;
	rs = null;
	
	// 답변 저장할 객체
	AnswerVO answer = null;
	
	// 답변이 여러 개일 때 리스트에 저장 후 모두 출력
	List<AnswerVO> list = new ArrayList<>();

	sql = "SELECT * FROM answer_table WHERE board_num = ?";
			
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
		response.sendError(500);
		return;
	}finally{
		DBCPUtil.close(rs, pstmt, conn);
	}
	
	// 멘토 답변에는 작성일+시간까지 출력되도록 구현
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd (HH:mm)");
	String date = null;
	if(answer != null){
		date = sdf.format(answer.getCreatedAt());
	}
	
	// 멘토 이름 가져오기
	conn = DBCPUtil.getConnection();
	
	// 멘토 이름 저장할 객체
	MemberVO mentor = null;
	String mName = null;
	
	sql = "SELECT * FROM member_table WHERE id = ?";
			
	try{
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, mentorId);
		
		rs = pstmt.executeQuery();
		
		while(rs.next()){
			mentor = new MemberVO();
			
			mentor.setId(rs.getString("id"));
			mentor.setName(rs.getString("name"));
			
			mName = mentor.getName();
		}
		
	}catch(Exception e){
		e.getStackTrace();
		response.sendError(500);
		return;
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

<script>
	function boardDelete(e){
		let isChecked = confirm('이 게시글을 삭제하시겠습니까?');
		if(isChecked){
			location.href="boardDelete.jsp";
		}else{
			e.preventDefault();
		}
	}
	
	function answerDelete(e){
		let isChecked = confirm('이 답변을 삭제하시겠습니까?');
		if(isChecked){
			location.href="answerDelete.jsp";
		}else{
			e.preventDefault();
		}
	}
</script>

<section id="main">
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
	
	<!-- 로그인 멤버가 현재 게시글 작성자일 때 수정/삭제 버튼 노출 -->
	<% if(loginMember != null && loginMember.getId().equals(board.getMenteeId())){ %>
		
			<div class="btnBox">
			<!-- 완료된 게시글은 수정할 수 없게 -->
			<% if(!board.getIsCompleted().equals("Y")){ %>
					<a href="boardUpdateForm.jsp?menteeId=<%=board.getMenteeId()%>&num=<%=board.getNum()%>&rn=<%=rn%>" >
						<button>수정</button>
					</a>
			<% } %>
				 <!-- 완료된 게시글이어도 삭제는 가능하도록 작성자에게 항상 노출 -->
					<form action="boardDelete.jsp" method="post">
						<input type="hidden" name="mentorId" value="<%=mentorId%>">
						<input type="hidden" name="menteeId" value="<%=board.getMenteeId()%>">
						<input type="hidden" name="num" value="<%=board.getNum()%>">
						<input type="hidden" name="rnum" value="<%=rn%>">
						<button type="submit" onclick="boardDelete(event)">삭제</button>
					</form>
			</div>	
			
	<% } %>
	<br>
	<hr>
	<br>
	
	<!-- 로그인 멤버가 게시글을 받은 멘토일 때 && 완료되지 않은 글일 때 답변하기 버튼 노출-->
	<% if(loginMember != null && loginMember.getId().equals(mentorId) && board.getIsCompleted().equals("N")){ %>
		<a href="answerForm.jsp?mentorId=<%=mentorId%>&num=<%=board.getNum()%>&rn=<%=rn%>">
			<button>멘티에게 답변하기</button>
		</a>
	<% } %>
	
	<table border="1" id="answer">
			<tr>
				<th colspan="2">멘토 답변</th>
			</tr>
		<!-- 이 게시글에 달린 답변이 있다면 출력 -->
		<% if(list.isEmpty()){ // 답변이 없을 때 %>
			<tr>
				<td>- 아직 등록된 답변이 없습니다. -</td>
			</tr>
		<% }else{ // 답변이 있을 때 %>
			
			<% for(AnswerVO a : list){ %>
			<tr>
				<th>작성일</th>
				<td><%=date%></td>
			</tr>
			<tr>
				<td colspan="2" id="aContent">
					<!-- 로그인 사용자가 멘토 본인이면 답변에 '내 답변 : ' , 그 외에는 'ㅇㅇㅇ 멘토 : ' 출력 -->
					<% if(loginMember != null && loginMember.getId().equals(mentorId)){ %>    
						내 답변 :
					<% }else{ %>
						<span class="mName"><%=mName%></span> 멘토 : <br>
					<% } %>
					<pre id="answer"><%=a.getContent()%></pre>
				</td>
			</tr>
			
			<!-- 로그인 사용자가 답변을 작성한 멘토 본인이고 해당 멘토링이 완료되지 않았을 경우 답변 삭제 버튼 노출 -->
			<% if(loginMember != null && loginMember.getId().equals(mentorId) && board.getIsCompleted().equals("N")) {%>
			<tr>
				<td colspan="4" class="deleteBtn">
					<form action="answerDelete.jsp" method="post">
						<input type="hidden" name="aNum" value="<%=a.getNum()%>">
						<input type="hidden" name="mentorId" value="<%=mentorId%>">
						<input type="hidden" name="num" value="<%=board.getNum()%>">
						<input type="hidden" name="rnum" value="<%=rn%>">
						<button type="submit" onclick="answerDelete(event)">삭제</button> 
					</form>
				</td>
			</tr>
			<% } // 답변 삭제 버튼 if %>
			
			<% } // end answer list 순회 for %>
			
		<% } // end if else %>
	</table>
	
	<%-- 답변 테이블에 이 게시글 번호와 일치하는 답변이 있고, 로그인 멤버가 게시글 작성자이고, 완료되지 않은 글일 때(별점은 게시글 하나당 한 번만 작성) --%>
	<% if(!list.isEmpty() && loginMember != null && loginMember.getId().equals(board.getMenteeId()) && board.getIsCompleted().equals("N")){ %>
		<form action="ratingForm.jsp">
			<input type="hidden" name="mName" value="<%=mName%>">
			<input type="hidden" name="mentorId" value="<%=board.getMentorId()%>">
			<input type="hidden" name="num" value="<%=board.getNum()%>">
			<button type="submit" >멘토링 완료</button>
		</form>
	<% } %>
	
	<!-- 멘토링 완료 버튼을 누른 게시글에 출력 -->
	<% if(board.getIsCompleted().equals("Y")){ %>
		<p> 💙 멘토링이 완료된 게시물입니다. 💙 </p>
	<% } %>

</section>

<%@ include file="common/footer.jsp"%>