<!-- 김도은 / 게시글 수정 폼 -->
<%@ include file="common/header.jsp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="utils.*, vo.*, java.sql.*"%>
    
<%

	// 파라미터로 전달 받은 멘티 아이디와 게시글 번호, rn
	String menteeId = request.getParameter("menteeId");
	String strNum = request.getParameter("num");
	int num = 0;
	if(strNum != null){
		num = Integer.parseInt(strNum);
	}
	
	String strRNum = request.getParameter("rn");
	int rn = 0;
	if(strRNum != null){
		rn = Integer.parseInt(strRNum);
	}
	
	if(loginMember == null || !loginMember.getId().equals(menteeId) ||
	   menteeId == null || strNum == null || strRNum == null){
		// 비로그인 상태이거나 파라미터가 넘어오지 않은 경우
		response.sendError(403);
		return;
	}
	
	// 게시글 번호로 게시글 정보 가져오기
	Connection conn = DBCPUtil.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	BoardVO b = null;
	
	String sql = "SELECT * FROM board_table WHERE num = ?";
	
	try{
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, num);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			b = new BoardVO();
			
			b.setNum(rs.getInt(1));
			b.setMentorId(rs.getString(2));
			b.setMenteeId(rs.getString(3));
			b.setTitle(rs.getString(4));
			b.setContent(rs.getString(5));
			b.setCategory(rs.getString(6));
			b.setCreatedAt(rs.getDate(7));
		}
		
	}catch(Exception e){
		e.printStackTrace();
		response.sendError(500);
	}finally{
		DBCPUtil.close(rs, pstmt, conn);
	}

%>
<section id="main">
	<form action="boardUpdateSubmit.jsp" method="POST">
		<input type="hidden" name="num" value="<%=b.getNum()%>" />
		<input type="hidden" name="mentorId" value="<%=b.getMentorId()%>" />
		<input type="hidden" name="menteeId" value="<%=b.getMenteeId()%>" />
		<input type="hidden" name="rn" value="<%=rn%>" />
		<table border="1" id="update">
			<tr>
				<th colspan="2">게시글 수정</th>
			</tr>
			<tr>
				<td>제목</td>
				<td>
					<input type="text" name="title" value="<%=b.getTitle()%>" class="title" />
				</td>
			</tr>
			<tr>
				<td>프로그래밍 언어</td>
				<td>
					<label> <input type="radio" name="category" value="JAVA" <%=b.getCategory().equals("JAVA") ? "checked" : "" %>/>
						JAVA &nbsp;
					</label> 
					<label> <input type="radio" name="category" value="JAVASCRIPT" <%=b.getCategory().equals("JAVASCRIPT") ? "checked" : "" %>/>
						JAVASCRIPT &nbsp;
					</label> 
					<label> <input type="radio" name="category" value="C" <%=b.getCategory().equals("C") ? "checked" : "" %>/>
						C &nbsp;
					</label> 
					<label> <input type="radio" name="category" value="PYTHON" <%=b.getCategory().equals("PYTHON") ? "checked" : ""%>/>
						PYTHON &nbsp;
					</label> 
					<label> <input type="radio" name="category" value="기타" <%=b.getCategory().equals("기타") ? "checked" : ""%>/>
						기타 &nbsp;
					</label> 
				</td>
			</tr>
			<tr>
				<td colspan="2" class="btnTop">
					<textarea name="content" rows="25" cols="66"><%=b.getContent()%></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="btn">
					<button type="submit">수정 완료</button>
				</td>
			</tr>
		</table>
	</form>
</section>
<%@ include file="common/footer.jsp"%>