<!-- 민서진 -->
<%@ include file="common/header.jsp"%>
<%@ include file="checkAdmin.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, utils.*, java.sql.*, vo.*"%>

<%	

	
	// 페이징-------------------------------------
	
	// 요청 페이지 번호 기본 값 1
	int pageNum = 1;

	String strPage = request.getParameter("page");
	if(strPage != null){
		pageNum = Integer.parseInt(strPage);
	}
	
	// 한 페이지에 출력할 회원 목록 수
	int perPageNum = 15;
	
	Criteria cri = new Criteria(pageNum, perPageNum);
	int startRow = cri.getStartRow();
	
	
	// 페이징-------------------------------------

	//회원 목록 검색
	List<MemberVO> list = new ArrayList<>();

	Connection conn = DBCPUtil.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
		
		String sql = "SELECT * FROM member_table WHERE id != 'admin' ORDER BY num DESC ";
				// 페이징 처리 중: 한 페이지에 행 15개 출력되도록 쿼리 변경
			   sql+= "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
		pstmt = conn.prepareStatement(sql);
		// 페이징 처리 중: startRow 부터 perPageNum 씩 출력되도록 입력
		pstmt.setInt(1, cri.getStartRow());
		pstmt.setInt(2, cri.getPerPageNum());
		
		rs = pstmt.executeQuery();
		
		while(rs.next()){
			// 검색된 한 행의 정보가 한 회원의 정보
			MemberVO m = new MemberVO(
			rs.getInt(1),
			rs.getString(2),
			rs.getString(3),
			rs.getString(4),
			rs.getString(5),
			rs.getString(6),
			rs.getString(7),
			rs.getString(8),
			rs.getString(9)
			);		
		list.add(m); 
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBCPUtil.close(rs, pstmt, conn);
	}
	
	// 페이징 -------------------------------------
	
	PageMaker pm = null;
	int totalCount = 0;
	
	try{
		conn = DBCPUtil.getConnection();
		String sql = "SELECT count(*) FROM member_table WHERE id != 'admin'";
		pstmt = conn.prepareStatement(sql);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			totalCount = rs.getInt(1); // 회원 정보 테이블에서 관리자를 제외한 회원 수
		}
		
		// 한 페이지에 회원 15명씩, 페이지 번호는 10개씩
		pm = new PageMaker(cri, totalCount, 10);
		
	}catch(Exception e){
		e.printStackTrace();
		response.sendError(500);
		return;
	}finally{
		DBCPUtil.close(rs, pstmt, conn);
	}
	
%>

<section class="member-list">
<table border=1 class="list">
	<tr>
		<th colspan="7" class="list-title"><h1>회원 목록</h1></th>
	</tr>
	<tr>
		<th>번호</th>
		<th>아이디</th>
		<th>이름</th>
		<th>회원 구분</th>
	</tr>
	
		<%if(!list.isEmpty()){ %>
			<!-- 회원 목록 출력 -->
			<%for(MemberVO m : list){ %>
				<tr onclick="moveInfo('<%=m.getNum()%>')">
					<td><div class="member-num"><%=m.getNum()%></div></td>
					<td><div class="member-id"><%=m.getId() %></div></td>
					<td><div class="member-name"><%=m.getName() %></div></td>
					<td><div class="member-role"><%=m.getRole() %></div></td>
				</tr>
			<%} %>
			
			<!-- 페이지 번호 블럭 -->
			<tr class="page-num">
				<td colspan="7">
				<!-- 첫 페이지가 아닐 때 -->
				<% if(pm.isFirst()){ %>
					<a href="?page=1">[처음]</a>
				<% } %>
				
				<!-- 이전 페이지가 존재할 때 -->
				<% if(pm.isPrev()){ %>
					<a href="?page=<%=pm.getStartPage()-1%>">[이전]</a>
				<% } %>
				
				<!-- 페이지 번호 출력 -->
				<% for(int i = pm.getStartPage(); i <= pm.getEndPage(); i++){
					String active = pageNum == i ? "active" : "";	
				%>
					<a href="?page=<%=i%>" class="<%=active%>">[<%=i%>]</a>
				<% } %>
				
				<!-- 다음 페이지가 존재할 때 -->
				<% if(pm.isNext()){ %>
					<a href="?page=<%=pm.getEndPage()+1%>">[다음]</a>
				<% } %>
				
				<!-- 현재 페이지가 마지막 페이지가 아닐 때 -->
				<% if(pm.isLast()){ %>
					<a href="?page=<%=pm.getMaxPage()%>">[마지막]</a>
				<% } %>
				</td>
			</tr>
		
		<%}else{ %>
		<!-- 등록된 회원이 없을 시 출력 -->
	
		<tr><th colspan="7">등록된 회원이 없습니다.</th></tr>
		<%} %>
		
</table>
</section>
<script>
	function moveInfo(num){
		location.href='memberInfo.jsp?num=' + num;
	}
</script>
<%@ include file="common/footer.jsp"%>