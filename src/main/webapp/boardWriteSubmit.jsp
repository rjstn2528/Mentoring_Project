<!-- 김도은 / 게시글 작성 요청 처리 -->
<%@ include file="common/header.jsp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.*" %>

<%
	String mentorId = request.getParameter("mentorId");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String category = request.getParameter("category");
	
	if(loginMember == null || mentorId == null || title == null || content == null || category == null){
		// 비로그인 상태이거나 파라미터가 하나라도 넘어오지 않은 경우
		response.sendError(403);
		return;
	}
	
	
	// board_table에 데이터 저장
	
	Connection conn = DBCPUtil.getConnection();
	PreparedStatement pstmt = null; 
	
	String sql = "INSERT INTO board_table(mentor_id, mentee_id, title, content, category) ";
  		   sql+= "VALUES(?, ?, ?, ?, ?)";
   
	try {
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, mentorId);
		pstmt.setString(2, loginMember.getId());
		pstmt.setString(3, title);
		pstmt.setString(4, content);
		pstmt.setString(5, category);

		int result = pstmt.executeUpdate();

		if (result == 1) {
			msg = "게시글이 등록되었습니다.";
		} else {
			msg = "게시글 등록에 실패하였습니다.";
		}

	} catch (Exception e) {
		e.printStackTrace();
		response.sendError(500);
	} finally {
		DBCPUtil.close(pstmt, conn);
		session.setAttribute("msg", msg);
		response.sendRedirect("boardList.jsp?mentorId=" + mentorId +"&page=1");
	}
%>	



