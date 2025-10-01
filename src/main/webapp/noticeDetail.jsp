<!-- 김도은 / 공지 사항 게시글 상세 페이지 -->
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
	
	
	Connection conn = DBCPUtil.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// 게시글 정보 저장
	BoardVO b = null;
	
	String sql = "SELECT * FROM master WHERE num = ?";
	
	try{
	
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, num);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			
			b = new BoardVO();
			
			b.setNum(rs.getInt(1));
			b.setTitle(rs.getString(2));
			b.setContent(rs.getString(3));
			b.setCreatedAt(rs.getDate(4));
		}
		
	}catch(Exception e){
		e.getStackTrace();
		response.sendError(500);
		return;
	}finally{
		DBCPUtil.close(rs, pstmt, conn);
	}
	

	if(b == null){
		response.sendError(404);
		return;
	}
%>

<script>
	function noticeDelete(){
		let isChecked = confirm('이 공지를 삭제하시겠습니까?');
		if(isChecked){
			location.href="noticeDelete.jsp?num=<%=b.getNum()%>&page=<%=pageNum%>";
		}
	}
</script>

<section id="main">
	<h3 class="nTitle">공지 사항</h3>
	<hr>
	<table border="1" id="nDetail">
		<tr>
			<th>제목</th>
			<td colspan="3">[공지] <%=b.getTitle()%></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>관리자</td>
			<th>작성일</th>
			<td><%=b.getCreatedAt()%></td>
		</tr>
		<tr>
			<td colspan="4">
				<pre><%=b.getContent()%></pre>
			</td>
		</tr>
	
	<!-- 로그인 멤버가 관리자일 때 수정/삭제 버튼 노출 -->
	<% if(loginMember != null && loginMember.getId().equals("admin")){ %>
		<tr>
			<td colspan="4" class="nBtn">
				<a href="noticeUpdateForm.jsp?num=<%=b.getNum()%>&page=<%=pageNum%>">
					수정
				</a> &nbsp; | &nbsp;  
				<a href="javascript:noticeDelete();">
					삭제
				</a>
			</td>	
		</tr>	
	<% } %>
	</table>
	<a href="noticeList.jsp?page=<%=pageNum%>"><button>목록으로</button></a>
</section>

<%@ include file="common/footer.jsp"%>