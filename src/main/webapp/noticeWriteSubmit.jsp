<!-- 김도은 / 공지 사항 작성 요청 처리 -->
<%@ include file="common/header.jsp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="vo.*, utils.*, java.sql.*"%>
<%
	

	String title = request.getParameter("title");
	String content = request.getParameter("content");

	if(loginMember == null || loginMember != null && !loginMember.getId().equals("admin")
	   || title == null || content == null){
		response.sendError(403);
		return;
	}
	
	
	Connection conn = DBCPUtil.getConnection();
	PreparedStatement pstmt = null;
	
	String sql = "INSERT INTO master(title, content) VALUES(?, ?)";
	
	try{
	
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		
		int result = pstmt.executeUpdate();
		
		if(result == 1){
			msg = "공지가 등록되었습니다.";
		}else{
			msg = "공지 등록에 실패하였습니다.";
		}
		
	}catch(Exception e){
		e.getStackTrace();
		response.sendError(500);
		return;
	}finally{
		DBCPUtil.close(pstmt, conn);
		session.setAttribute("msg", msg);
		response.sendRedirect("noticeList.jsp");
	}
	
%>