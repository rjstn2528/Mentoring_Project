<!-- 김진주 / 김도은 -->
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ include file="common/header.jsp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="utils.*, vo.*, java.sql.*"%>

<%

	/* 김도은 / 멘토일 경우 프로필 등록한 멘토인지 검색 */
	boolean isProfile = false;
	MentorProfileVO mentor = null;
	
	if(loginMember.getRole().equals("멘토")){
		
		Connection conn = DBCPUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT * FROM mentor_profile WHERE mentor_id = ?";
		
		try{
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, loginMember.getId());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				// 프로필이 있는 경우
				isProfile = true;
				
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
			e.printStackTrace();
			response.sendError(500);
		}finally{
			DBCPUtil.close(rs, pstmt, conn);
		}
	} // end if
	
	
	/* 김도은 / 멘티일 경우 작성한 게시글이 있는지 검색, 있다면 내 정보 아래에 목록 출력 */
	boolean isBoard = false;
	List<BoardVO> list = new ArrayList<>();
	BoardVO b = null;
	PageMaker pm = null;
	int totalCount = 0;
	// 요청 페이지 번호 기본 값 1로 설정
	int pageNum = 1;
	
	if(loginMember.getRole().equals("멘티")){
		
			
		
		String strPage = request.getParameter("page");
		if(strPage != null){
			pageNum = Integer.parseInt(strPage);
		}
		
		// 한 페이지에 게시물 5개씩 출력
		int perPageNum = 5;
		
		Criteria cri = new Criteria(pageNum, perPageNum);
		int startRow = cri.getStartRow();
		
		
		Connection conn = DBCPUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		 
		
		
		String sql = "SELECT ROWNUM AS rn, t.* FROM ";
		       sql+= "(SELECT * FROM board_table WHERE mentee_id = ? ORDER BY num ASC) t ORDER BY rn DESC";
		       sql+= " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
		       
		try{
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, loginMember.getId());
			pstmt.setInt(2, cri.getStartRow());
			pstmt.setInt(3, cri.getPerPageNum());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				// 게시글이 있는 경우
				isBoard = true;
				
				b = new BoardVO();
				
				b.setRn(rs.getInt(1));
				b.setNum(rs.getInt(2));
				b.setMentorId(rs.getString(3));
				b.setMenteeId(rs.getString(4));
				b.setTitle(rs.getString(5));
				b.setContent(rs.getString(6));
				b.setCategory(rs.getString(7));
				b.setCreatedAt(rs.getDate(8));
				b.setIsCompleted(rs.getString(9));
				b.setName(loginMember.getName());
				
				list.add(b);
			}
			
		}catch(Exception e){
			e.printStackTrace();
			response.sendError(500);
		}finally{
			DBCPUtil.close(rs, pstmt, conn);
		}
		
		
	
		
		try{
			conn = DBCPUtil.getConnection();
			sql = "SELECT count(*) FROM board_table WHERE mentee_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, loginMember.getId());
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				totalCount = rs.getInt(1); // 로그인한 멘티가 작성한 모든 게시글 수
			}
			
			// 한 페이지에 게시글 5개씩, 페이지 번호 5개씩 출력
			pm = new PageMaker(cri, totalCount, 5);
			
		}catch(Exception e){
			e.printStackTrace();
			response.sendError(500);
			return;
		}finally{
			DBCPUtil.close(rs, pstmt, conn);
		}
	} // end if

%>
	
	
	
<!-- 현재 로그인된 사용자의 정보 출력 -->

<%
	if(loginMember == null){
		
%>
	<script>
		alert('잘못된 접근입니다.');
		location.replace('login.jsp');
	</script>

<% 
		return; 
	} 
%>
<section id="main">
	<table class="login">
		<tr>
			<th colspan="2"><h1>회원정보</h1></th>
		</tr>
		<tr>
			<td>아이디</td>
			<td>
				<%= loginMember.getId() %>
			</td>
		</tr>

		<tr>
			<td>이름</td>
			<td>
				<%= loginMember.getName() %>
			</td>
		</tr>
		<tr>
			<td>주소</td>
			<td>
				<%= loginMember.getAddr() %>
			</td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td>
				<%= loginMember.getPhone() %>
			</td>
		</tr>
		<tr>
			<td>이메일</td>
			<td>
				<%= loginMember.getEmail() %>
			</td>
		</tr>
		<% if("멘토".equals(loginMember.getRole())) { %>
			<tr>
				<td>ROLE</td>
				<td><%= loginMember.getRole() %> ( <%= loginMember.getLang() %> )</td>
				</tr>
				<% } else { %>
				<tr>
				<td>ROLE</td>
				<td><%= loginMember.getRole() %></td>
			</tr>
		<% } %>
		<tr>
			<th colspan="2">
				<button type="button" onclick="location.href='index.jsp';">메인으로</button>
				<button type="button" onclick="location.href='infoUpdate.jsp';">회원정보 수정</button>
				<button type="button" onclick="location.href='memberDeleteForm.jsp';">회원 탈퇴</button>
			</th>
		</tr>
	</table>
	
	
	<!-- 김도은 / 로그인 멤버가 멘토일 경우 내 프로필 출력 -->
	
	<% if(loginMember.getRole().equals("멘토") && !isProfile) {%>
		<!-- 로그인 멤버가 멘토이고 등록된 프로필이 없는 경우 -->
		<button onclick="location.href='profileWrite.jsp';">프로필 등록</button>
		<table border="1" id="mentorP">
			<tr>
				<td class="none"> 아직 등록된 프로필이 없습니다. </td>
			</tr>
		</table>
	<% } %>
	
	<% if(loginMember.getRole().equals("멘토") && isProfile) {%>
		<!-- 로그인 멤버가 멘토이고 등록된 프로필이 있는 경우 -->
	<form action="profileUpdateForm.jsp" method="POST">
	<input type="hidden" name="intro" value="<%=mentor.getIntro()%>" />
	<table border="1" id="mentorP">
		<tr>
			<th colspan="4">내 프로필</th>
		</tr>
		<tr>
			<th>이름</th>
			<td><%=mentor.getName()%></td>
			<th class="lang">프로그래밍 언어</th>
			<td><%=mentor.getLang()%></td>
		</tr>
		<tr>
			<th>연락처</th>
			<td><%=loginMember.getPhone()%></td>
			<th>이메일</th>
			<td><%=mentor.getEmail()%></td>
		</tr>
		<tr>
			<td colspan="4" class="intro">
				<%=mentor.getIntro()%>
			</td>
		</tr>
		<tr>
			<td colspan="4" class="btn">
				<button type="submit">프로필 수정</button>
			</td>
		</tr>
	</table>
	</form>
	<% } %>
	
	<!-- 김도은 / 로그인 멤버가 멘티인 경우 -->
	<% if(loginMember.getRole().equals("멘티")) {%>
	<br>
	<hr>
	<br>
	<h3>- 내가 쓴 게시글 -</h3>
	<table border="1" id="boardT">
		<tr>
			<th>no.</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>
		<% if(list.isEmpty()){ // 게시글이 없을 때%>
		<tr>
			<td colspan="4">등록된 게시글이 없습니다.</td>
		</tr>
		<% }else{ // 게시글 있을 때 %>
		
				<% if(b != null) {%>
					<% for(BoardVO board : list){ %>
						<tr>
							<td><%=board.getRn()%></td>
							<td class="title">
								<a href="boardDetail.jsp?mentorId=<%=board.getMentorId()%>&num=<%=board.getNum()%>&rnum=<%=board.getRn()%>">
									<span id="complete"><%= board.getIsCompleted().equals("Y") ? "[완료] " : "" %></span><%=board.getTitle()%>
								</a>
							</td>
							<td><%=board.getName()%></td>
							<td><%=board.getCreatedAt()%></td>
						</tr>
					<% } %> <!-- 게시글 목록 출력 완료 -->
					
					<!-- 페이지 번호 출력 -->
					<tr>
						<td colspan="4" class="pageNum">
						<% if(pm.isFirst()){ %>
							<a href="?page=1">[처음]</a>
						<% } %>
						
						<% if(pm.isPrev()){ %>
							<a href="?page=<%=pm.getStartPage()-1%>">[이전]</a>
							 ... 
						<% } %>
						
						<% for(int i = pm.getStartPage(); i <= pm.getEndPage(); i++){ 
							String selected = (pageNum == i) ? "selected" : "";
						%>
							<a href="?page=<%=i%>" class="<%=selected%>">[<%=i%>]</a>								
						<% } %>
						
						<% if(pm.isNext()){ %>
							 ... 
							<a href="?page=<%=pm.getEndPage()+1%>">[다음]</a>
						<% } %>
						
						<% if(pm.isLast()){ %>
							<a href="?page=<%=pm.getMaxPage()%>">[마지막]</a>
						<% } %>
						</td>	
					</tr>
				<% } // end list null check %>
		<% } // end if else %>
	<% } // end if mentee %>
		
	</table>
</section>

<%@ include file="common/footer.jsp"%>