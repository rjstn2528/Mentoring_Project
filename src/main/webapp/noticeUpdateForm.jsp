<!-- 김도은 / 관리자 전용 공지 사항 수정 폼 페이지 -->
<%@ include file="common/header.jsp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*, utils.*, java.sql.*" %>
    
<%
	

	// 공지글 번호
	String strNum = request.getParameter("num");
	int num = 0;
	if(strNum != null){
		num = Integer.parseInt(strNum);
	}
	
	// 페이지 번호
	int pageNum = 1; // 페이지 기본 값 1
	String strPageNum = request.getParameter("page");
	if(strPageNum != null){
		pageNum = Integer.parseInt(strPageNum);
	}
	
	
	if(loginMember == null || !loginMember.getId().equals("admin") ||
	   num == 0 || strPageNum == null){
		// 비로그인 상태이거나 관리자 계정이 아닌 경우, 파라미터가 하나라도 안 넘어온 경우(잘못된 경로) 접근 제한
		response.sendError(403);
		return;
	}
	
	Connection conn = DBCPUtil.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// 공지글 정보 저장
	BoardVO n = null;
	
	String sql = "SELECT * FROM master WHERE num = ?";
	
	try{
	
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, num);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			
			n = new BoardVO();
			
			n.setNum(rs.getInt(1));
			n.setTitle(rs.getString(2));
			n.setContent(rs.getString(3));
			n.setCreatedAt(rs.getDate(4));
		}
		
	}catch(Exception e){
		e.getStackTrace();
	}finally{
		DBCPUtil.close(rs, pstmt, conn);
	}
	
	// 없는 게시글 번호로 데이터 검색해서 객체 생성이 안 된 경우
	if(n == null){
		response.sendError(404);
		return;
	}
%>

<section id="main">

<h3 class="nTitle">공지 사항 수정</h3>

<hr>

<form action="noticeUpdate.jsp" method="post">
	<table border="1" id="updateN">
		<tr>
			<th>제목</th>
			<td class="title">
				<input type="text" name="title" value="<%=n.getTitle()%>" />
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<textarea rows="20" cols="66" name="content"><%=n.getContent()%></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="hidden" name="num" value="<%=n.getNum()%>" />
				<input type="hidden" name="page" value="<%=pageNum%>" />
				<button type="submit">수정하기</button>
			</td>
		</tr>
	</table>
</form>
</section>
<%@ include file="common/footer.jsp"%>