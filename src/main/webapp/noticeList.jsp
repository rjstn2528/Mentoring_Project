<!-- 김도은 / 관리자 공지사항 게시글 목록 페이지 -->
<%@ include file="common/header.jsp"%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="vo.*, utils.*, java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	

	//페이징 -----------------------------------------------------------

	int pageNum = 1; // 페이지 기본 값 1
	String strNum = request.getParameter("page");
	if(strNum != null){
		pageNum = Integer.parseInt(strNum);
	}
	
	int perPageNum = 20;	// 한 페이지에 게시물 20개씩 출력
	
	Criteria cri = new Criteria(pageNum, perPageNum);
	int startRow = cri.getStartRow();
	
	
	// 페이징 -----------------------------------------------------------



	Connection conn = DBCPUtil.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
			   	  // rownum 추가
	String sql = "SELECT ROWNUM AS rn, ms.* FROM ";			
			      // 게시글 num 오름차순으로 rownum 부여 후 rownum 내림차순으로 게시글 정렬
		   sql+= "(SELECT * FROM master ORDER BY num ASC) ms ORDER BY rn DESC ";
		   sql+= "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
		   
	// 관리자 게시글 목록 저장할 리스트
	List<BoardVO> list = new ArrayList<>();
	// 관리자 게시글 저장
	BoardVO board = null;
	
	try{
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1, cri.getStartRow());
		pstmt.setInt(2, cri.getPerPageNum());
		
		rs = pstmt.executeQuery();
		
		while(rs.next()){
			
			board = new BoardVO();
			
			board.setRn(rs.getInt(1));
			board.setNum(rs.getInt(2));
			board.setTitle(rs.getString(3));
			board.setContent(rs.getString(4));
			board.setCreatedAt(rs.getDate(5));
			
			// 리스트에 게시글 저장
			list.add(board);
		}
		
	}catch(Exception e){
		e.getStackTrace();
		response.sendError(500);
		return;
	}finally{
		DBCPUtil.close(rs, pstmt, conn);
	}
	
	// 페이징 -----------------------------------------------------------
	
	PageMaker pm = null;
	int totalCount = 0;
	
	try{
		conn = DBCPUtil.getConnection();
		sql = "SELECT count(*) FROM master";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			totalCount = rs.getInt(1); // 공지글 전체 개수
		}
		
		// 한 페이지에 게시글 10개씩, 페이지 번호 10개씩 출력
		pm = new PageMaker(cri, totalCount, 10);
		
	}catch(Exception e){
		e.getStackTrace();
	}finally{
		DBCPUtil.close(rs, pstmt, conn);
	}
	
	
%>
<section id="main">
<h3 class="nTitle">공지 사항</h3>
<hr>
<!-- loginMember가 null 이 아니고, 로그인한 사용자가 관리자일 때만 게시글 작성 버튼 노출 -->
<% if(loginMember != null && loginMember.getId().equals("admin")){ %>
	<div class="nBtn">
		<a href="noticeWrite.jsp" id="nBtn">
			<button>게시글 작성</button>
		</a>
	</div>
<% } %>
<table border="1" class="noticeList">
	
	<tr>
		<th>no.</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
	</tr>
	
	<!-- 공지 사항 게시글 목록 출력 -->
	<% if(list.isEmpty()){ %>
	<!-- 등록된 게시글이 없을 때 -->
		<tr>
			<td colspan="4">등록된 게시글이 없습니다.</td>
		</tr>
	<% }else{ %>
	<!-- 등록된 게시글이 있을 때 -->
		<% for(BoardVO b : list){ %>
		<tr>
			<td><%=b.getRn()%></td>
			<td class="title">
				<a href="noticeDetail.jsp?num=<%=b.getNum()%>&page=<%=pageNum%>"><%=b.getTitle()%></a>
			</td>
			<td>관리자</td>
			<td><%=b.getCreatedAt()%></td>
		</tr>
		<% } %> <!-- 게시글 목록 출력 완료 -->
		
		<!-- 페이지 번호 블럭 출력 -->
		<tr>
			<td colspan="4">
			<!-- 첫 페이지로 이동 -->
			<% if(pm.isFirst()){ // 현재 페이지가 첫 페이지가 아닌 경우 %>
				<a href="?page=1"> [처음] </a>
			<% } %>
			
			<!-- 이전 페이지로 이동 -->
			<% if(pm.isPrev()){ // 이전 페이지가 있을 경우 %>
				<a href="?page=<%=pm.getStartPage()-1%>"> [이전] </a>
			<% } %>
			
			
			<% for(int i = pm.getStartPage(); i <= pm.getEndPage(); i++){ 
				
				String selected = (pageNum == i) ? "selected" : "";
			%>
				<a href="?page=<%=i%>" class="<%=selected%>">[<%=i%>]</a>
			<% } %>
			
			
			<!-- 다음 페이지로 이동 -->
			<% if(pm.isNext()){ // 현재 페이지의 endPage가 maxPage가 아닌 경우 %>
				<a href="?page=<%=pm.getEndPage()+1%>"> [다음] </a>
			<% } %>
			
			<!-- 마지막 페이지로 이동 -->
			<% if(pm.isLast()){ // 현재 페이지가 마지막 페이지가 아닌 경우 %>
				<a href="?page=<%=pm.getMaxPage()%>"> [마지막] </a>
			<% } %>
			</td>
		</tr>
		
	<% } %>
</table>
</section>
<%@ include file="common/footer.jsp"%>