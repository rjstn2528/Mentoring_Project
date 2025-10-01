<!-- 김도은 / 멘토 프로필 & 멘티 작성 게시글 목록 -->
<%@ include file="mentorProfile.jsp"%> <!-- 멘토링 프로필 페이지에 헤더 인클루드 -->   

<%@page import="java.util.*, vo.BoardVO, utils.*, java.sql.*, vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	// 페이징 ----------------------------------------------
	
	// 요청 페이지 번호 기본 값 1로 설정
	int pageNum = 1;	
	
	String strPage = request.getParameter("page");
	if(strPage != null){
		pageNum = Integer.parseInt(strPage);
	}
	
	// 한 페이지에 게시물 10개씩 출력
	int perPageNum = 10;
	
	Criteria cri = new Criteria(pageNum, perPageNum);
	int startRow = cri.getStartRow();
	
	
	// 페이징 ----------------------------------------------


	// 게시글 목록 저장할 list
	List<BoardVO> list = new ArrayList<>();

	conn = DBCPUtil.getConnection();
	pstmt = null;
	rs = null;
		
	sql = "SELECT ROWNUM AS rn, t.* FROM ";
	sql+= "(SELECT * FROM board_table WHERE mentor_id = ? ORDER BY num ASC) t ORDER BY rn DESC";
	sql+= " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
	
	BoardVO board = null;
	
	try{
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, mentorId);
		pstmt.setInt(2, cri.getStartRow());
		pstmt.setInt(3, cri.getPerPageNum());
		
		
		rs = pstmt.executeQuery();
		
		while(rs.next()){ // 검색된 게시글이 있다면
			
			board = new BoardVO();
			
			board.setRn(rs.getInt(1));
			board.setNum(rs.getInt(2));
			board.setMentorId(rs.getString(3));
			board.setMenteeId(rs.getString(4));
			board.setTitle(rs.getString(5));
			board.setContent(rs.getString(6));
			board.setCategory(rs.getString(7));
			board.setCreatedAt(rs.getDate(8));
			board.setIsCompleted(rs.getString(9));
			
			list.add(board);
		} // 검색된 게시글 없을 때까지 반복
			
	}catch(Exception e){
		e.getStackTrace();
		response.sendError(500);
		return;
	}finally{
		DBCPUtil.close(rs, pstmt, conn);
	}
	
	

	// 페이징 ----------------------------------------------
	
	PageMaker pm = null;
	int totalCount = 0;
	
	try{
		conn = DBCPUtil.getConnection();
		sql = "SELECT count(*) FROM board_table WHERE mentor_id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, mentorId); // mentorId == 멘토 목록에서 클릭한 멘토의 아이디 url로 넘겨받음
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			totalCount = rs.getInt(1); // 해당 멘토에게 달린 전체 게시글 수
		}
		
		// 한 페이지에 게시글 10개씩, 페이지 번호 10개씩 출력
		pm = new PageMaker(cri, totalCount, 10);
		
	}catch(Exception e){
		e.printStackTrace();
		response.sendError(500);
		return;
	}finally{
		DBCPUtil.close(rs, pstmt, conn);
	}
	
	for(BoardVO b : list){
		
			// 멘티 이름 가져오기
			conn = DBCPUtil.getConnection();
			
			sql = "SELECT name FROM member_table WHERE id = ?";
			
			try{
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, b.getMenteeId());
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					String name= rs.getString(1);
					b.setName(rs.getString(1));
				}
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				DBCPUtil.close(rs, pstmt, conn);
			}
	}
%>
    
<section id="main">
	<table border="1" id="boardT">
		<tr class="none">
			<th>no.</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>
		<% if(list.isEmpty()){ // 게시글이 없을 때%>
		<tr>
			<td colspan="4">등록된 멘토링 요청이 없습니다.</td>
		</tr>
		<% }else{ // 게시글 있을 때 %>
		
				<% if(board != null) {%>
					<% for(BoardVO b : list){ %>
						<tr>
							<td><%=b.getRn()%></td>
							<td class="title">
								<a href="boardDetail.jsp?mentorId=<%=b.getMentorId()%>&num=<%=b.getNum()%>&rnum=<%=b.getRn()%>">
									<span id="complete"><%= b.getIsCompleted().equals("Y") ? "[완료] " : "" %></span><%=b.getTitle()%>
								</a>
							</td>
							<td><%=b.getName()%></td>
							<td><%=b.getCreatedAt()%></td>
						</tr>
					<% } %> <!-- 게시글 목록 출력 완료 -->
	
				<!-- 페이지 번호 출력 -->
					<tr>
						<td colspan="4" class="pageNum">
						<% if(pm.isFirst()){ %>
							<a href="?mentorId=<%=mentorId%>&page=1">[처음]</a>
						<% } %>
						
						<% if(pm.isPrev()){ %>
							<a href="?mentorId=<%=mentorId%>&page=<%=pm.getStartPage()-1%>">[이전]</a>
							 ... 
						<% } %>
						
						<% for(int i = pm.getStartPage(); i <= pm.getEndPage(); i++){ 
							String selected = (pageNum == i) ? "selected" : "";
						%>
							<a href="?mentorId=<%=mentorId%>&page=<%=i%>" class="<%=selected%>">[<%=i%>]</a>								
						<% } %>
						
						<% if(pm.isNext()){ %>
							 ... 
							<a href="?mentorId=<%=mentorId%>&page=<%=pm.getEndPage()+1%>">[다음]</a>
						<% } %>
						
						<% if(pm.isLast()){ %>
							<a href="?mentorId=<%=mentorId%>&page=<%=pm.getMaxPage()%>">[마지막]</a>
						<% } %>
						</td>	
					</tr>
			<% } %> 
		<% } %> 
	
	</table>
</section>

<%@ include file="common/footer.jsp"%>


